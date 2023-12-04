pageextension 50037 "Output Journal Ext." extends "Output Journal"
{
    layout
    {
        modify("Order Line No.")
        {
            Editable = false;
        }
        modify("Document No.")
        {
            Editable = false;
        }
        modify("Item No.")
        {
            Editable = false;
        }
        modify("Operation No.")
        {
            Editable = false;
        }
        modify(Type)
        {
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        addafter("Location Code")
        {
            field("Starting Date Time"; Rec."Starting Date Time")
            {
                ApplicationArea = all;
            }
            field("Ending Date Time"; Rec."Ending Date Time")
            {
                ApplicationArea = all;
            }

            field("Prod. Date for Expiry Calc"; Rec."Prod. Date for Expiry Calc")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify("P&osting")
        {
            Visible = false;
        }
        modify("Explode &Routing")
        {
            trigger OnAfterAction()
            var
                ItemJnlLine_Loc: Record "Item Journal Line";
                MachinCenter_Loc: Record "Machine Center";
            begin
                IF (Rec."Journal Template Name" <> '') and (Rec."Journal Batch Name" <> '') then begin
                    ItemJnlLine_Loc.Reset();
                    ItemJnlLine_Loc.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine_Loc.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnlLine_Loc.SetRange("Document No.", Rec."Document No.");
                    if ItemJnlLine_Loc.FindSet() then begin
                        repeat
                            if (ItemJnlLine_Loc.Type = ItemJnlLine_Loc.Type::"Machine Center") and (MachinCenter_Loc.Get(ItemJnlLine_Loc."No.")) then begin
                                ItemJnlLine_Loc."QC Required" := MachinCenter_Loc."QC Mandatory";
                                ItemJnlLine_Loc.Modify();
                            end;
                        until ItemJnlLine_Loc.Next() = 0;
                    end;
                end;
            end;
        }
        addafter("&Print")
        {
            action("Submit for QC")
            {
                Caption = 'Submit for QC';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Manufacturing;
                trigger OnAction()
                var
                begin

                    recItemJournalLines.RESET;
                    recItemJournalLines.SETFILTER("Journal Template Name", '<>%1', Rec."Journal Template Name");
                    recItemJournalLines.SETRANGE("Entry Type", recItemJournalLines."Entry Type"::Output);
                    recItemJournalLines.SETFILTER("Document No.", '%1', Rec."Document No.");
                    IF recItemJournalLines.FINDFIRST THEN
                        ERROR('There are output lines already submitted for QC, post the same first.');

                    TrySetApplyToEntries;
                    IF (Rec."Order Type" = Rec."Order Type"::Production) AND (Rec."Order No." <> '') THEN
                        ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");
                    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Submit Approval", Rec);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                END;
            }
            action("De-Crystlizer Details")
            {
                Caption = 'De-Crystlizer Details';
                Promoted = true;
                Image = Production;
                PromotedCategory = Process;
                ApplicationArea = Manufacturing;
                trigger OnAction()

                begin
                    Rec.TESTFIELD("Order No.");
                    Rec.TESTFIELD("No.");
                    ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");

                    recBatchProcess.RESET;
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                    recBatchProcess.SETRANGE("Document No.", ProductionOrder."No.");
                    IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                        recBatchProcess.INIT;
                        recBatchProcess.Type := recBatchProcess.Type::"De-Crystallizer";
                        recBatchProcess."Document No." := ProductionOrder."No.";
                        recBatchProcess.Date := TODAY;
                        recBatchProcess."Customer Code" := ProductionOrder."Customer Code";
                        recBatchProcess."Customer Batch No." := ProductionOrder."Batch No.";
                        recBatchProcess.INSERT;
                    END;

                    recBatchProcess.RESET;
                    recBatchProcess.FILTERGROUP(0);
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                    recBatchProcess.SETRANGE("Document No.", ProductionOrder."No.");
                    recBatchProcess.FILTERGROUP(2);

                    CLEAR(pgBatchProcess);
                    pgBatchProcess.SETTABLEVIEW(recBatchProcess);
                    pgBatchProcess.RUN;
                END;
            }
            Action("Vacuum Circulation")
            {
                Caption = 'Vacuum Circulation';
                Promoted = true;
                Image = Production;
                PromotedCategory = Process;
                ApplicationArea = Manufacturing;
                trigger OnAction()
                BEGIN
                    Rec.TESTFIELD("Order No.");
                    Rec.TESTFIELD("No.");
                    ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");

                    recBatchProcess.RESET;
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                    recBatchProcess.SETRANGE("Document No.", ProductionOrder."No.");
                    IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                        recBatchProcess.INIT;
                        recBatchProcess.Type := recBatchProcess.Type::"Vaccum Circulation";
                        recBatchProcess."Document No." := ProductionOrder."No.";
                        recBatchProcess.Date := TODAY;
                        recBatchProcess.INSERT;
                    END;

                    recBatchProcess.RESET;
                    recBatchProcess.FILTERGROUP(0);
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                    recBatchProcess.SETRANGE("Document No.", ProductionOrder."No.");
                    recBatchProcess.FILTERGROUP(2);

                    CLEAR(pgVacuumCirculation);
                    pgVacuumCirculation.SETTABLEVIEW(recBatchProcess);
                    pgVacuumCirculation.RUN;
                END;
            }
        }
    }

    procedure OpenQCInfo(DocNo: Code[20]; DocLineNo: Integer)
    VAR
        recMachineCenter: Record "Machine Center";
        recInventorySetup: Record "Inventory Setup";
        recQualityCheck: Record "Quality Header";
        cdDocNo: Code[20];
        cuNoSeries: Codeunit "NoSeriesManagement";
        intLineNo: Integer;
        recQualityMeasure: Record "Standard Task Quality Measure";
        recQualityLines: Record "Quality Line";
        pgQuality: Page "Output Quality Check Card";
        recBatchProcess: Record "Batch Process Header";
        pgBatchProcess: Page "De-Crystallizer Card";
        pgVacuumCirculation: Page "Vacuum Circulation Card";
    BEGIN
        recMachineCenter.GET(Rec."No.");
        IF recMachineCenter."QC Mandatory" THEN BEGIN
            IF recMachineCenter."QC Type" = recMachineCenter."QC Type"::Quality THEN BEGIN

                IF recMachineCenter."Quality Process" = '' THEN
                    ERROR('No quality process defined for the item no. %1', Rec."No.");

                recInventorySetup.GET;
                recInventorySetup.TESTFIELD("Quality Nos.");

                recQualityCheck.RESET;
                recQualityCheck.SETRANGE("Document Type", recQualityCheck."Document Type"::Output);
                recQualityCheck.SETRANGE("Document No.", Rec."Document No.");
                recQualityCheck.SETRANGE("Document Line No.", Rec."Order Line No.");
                recQualityCheck.SETRANGE(Posted, FALSE);
                IF NOT recQualityCheck.FINDFIRST THEN BEGIN
                    cdDocNo := cuNoSeries.GetNextNo(recInventorySetup."Quality Nos.", TODAY, TRUE);

                    recQualityCheck.INIT;
                    recQualityCheck."No." := cdDocNo;
                    recQualityCheck.Date := TODAY;
                    recQualityCheck."Document Type" := recQualityCheck."Document Type"::Output;
                    recQualityCheck."Document No." := Rec."Document No.";
                    recQualityCheck."Document Line No." := Rec."Order Line No.";
                    recQualityCheck."Document Date" := TODAY;
                    recQualityCheck.Quantity := Rec.Quantity;
                    recQualityCheck."Item Code" := Rec."Item No.";
                    recQualityCheck."Item Name" := Rec.Description;
                    recQualityCheck."Machine No." := recMachineCenter."No.";
                    recQualityCheck."Machine Name" := recMachineCenter.Name;
                    recQualityCheck.INSERT;

                    intLineNo := 0;
                    recQualityMeasure.RESET;
                    recQualityMeasure.SETRANGE("Standard Task Code", recMachineCenter."Quality Process");
                    IF recQualityMeasure.FINDFIRST THEN
                        REPEAT
                            recQualityLines.INIT;
                            recQualityLines."QC No." := cdDocNo;
                            intLineNo += 10000;
                            recQualityLines."Line No." := intLineNo;
                            recQualityLines."Lot No." := '';
                            recQualityLines."Quality Process" := recQualityMeasure."Standard Task Code";
                            recQualityLines."Quality Measure" := recQualityMeasure."Qlty Measure Code";
                            recQualityLines.Parameter := recQualityMeasure.Parameter;
                            recQualityLines.Specs := recQualityMeasure.Specs;
                            recQualityLines.Limit := recQualityMeasure.Limit;
                            recQualityLines.INSERT;
                        UNTIL recQualityMeasure.NEXT = 0;
                END ELSE
                    cdDocNo := recQualityCheck."No.";

                recQualityCheck.RESET;
                recQualityCheck.SETRANGE("No.", cdDocNo);

                CLEAR(pgQuality);
                pgQuality.SETTABLEVIEW(recQualityCheck);
                pgQuality.RUN;

            END ELSE
                IF recMachineCenter."QC Type" = recMachineCenter."QC Type"::"De-Crystlizer" THEN BEGIN

                    recBatchProcess.RESET;
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                    recBatchProcess.SETRANGE("Document No.", Rec."Order No.");
                    IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                        recBatchProcess.INIT;
                        recBatchProcess.Type := recBatchProcess.Type::"De-Crystallizer";
                        recBatchProcess."Document No." := Rec."Order No.";
                        recBatchProcess.Date := TODAY;
                        recBatchProcess.INSERT;
                    END;

                    recBatchProcess.RESET;
                    recBatchProcess.FILTERGROUP(0);
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                    recBatchProcess.SETRANGE("Document No.", Rec."Order No.");
                    recBatchProcess.FILTERGROUP(2);

                    CLEAR(pgBatchProcess);
                    pgBatchProcess.SETTABLEVIEW(recBatchProcess);
                    pgBatchProcess.RUN;
                END ELSE
                    IF recMachineCenter."QC Type" = recMachineCenter."QC Type"::Vacumm THEN BEGIN

                        recBatchProcess.RESET;
                        recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                        recBatchProcess.SETRANGE("Document No.", Rec."Order No.");
                        IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                            recBatchProcess.INIT;
                            recBatchProcess.Type := recBatchProcess.Type::"Vaccum Circulation";
                            recBatchProcess."Document No." := Rec."Order No.";
                            recBatchProcess.Date := TODAY;
                            recBatchProcess.INSERT;
                        END;

                        recBatchProcess.RESET;
                        recBatchProcess.FILTERGROUP(0);
                        recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                        recBatchProcess.SETRANGE("Document No.", Rec."Order No.");
                        recBatchProcess.FILTERGROUP(2);

                        CLEAR(pgVacuumCirculation);
                        pgVacuumCirculation.SETTABLEVIEW(recBatchProcess);
                        pgVacuumCirculation.RUN;
                    END;
        end;
    end;

    procedure FindILEFromReservation(VAr ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line"; ReservationEntry: Record "Reservation Entry"; ProductionOrderNo: Code[20]): Boolean
    var
    begin

        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive,
          "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");

        ItemLedgerEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
        ItemLedgerEntry.SETRANGE(Positive, TRUE);
        ItemLedgerEntry.SETRANGE("Location Code", ItemJnlLine."Location Code");
        ItemLedgerEntry.SETRANGE("Serial No.", ReservationEntry."Lot No.");
        ItemLedgerEntry.SETRANGE("Serial No.", ReservationEntry."Serial No.");
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);

        EXIT(ItemLedgerEntry.FINDSET);
    end;

    procedure FindReservationsReverseOutput(var ReservationEntry: Record "Reservation Entry"; ItemJnlLine: Record "Item Journal Line"): Boolean
    var
    begin

        IF ItemJnlLine.Quantity >= 0 THEN
            EXIT(FALSE);

        ReservationEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line");
        ReservationEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
        ReservationEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.SETRANGE("Source Subtype", ItemJnlLine."Entry Type");
        ReservationEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");

        ReservationEntry.SETFILTER("Serial No.", '<>%1', '');
        ReservationEntry.SETRANGE("Qty. to Handle (Base)", -1);
        ReservationEntry.SETRANGE("Appl.-to Item Entry", 0);

        EXIT(ReservationEntry.FINDSET);
    end;

    procedure TrySetApplyToEntries()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine2: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
    BEGIN

        ItemJournalLine2.COPY(Rec);
        IF ItemJournalLine2.FINDSET THEN
            REPEAT
                IF FindReservationsReverseOutput(ReservationEntry, ItemJournalLine2) THEN
                    REPEAT
                        IF FindILEFromReservation(ItemLedgerEntry, ItemJournalLine2, ReservationEntry, Rec."Order No.") THEN BEGIN
                            ReservationEntry.VALIDATE("Appl.-to Item Entry", ItemLedgerEntry."Entry No.");
                            ReservationEntry.MODIFY(TRUE);
                        END;
                    UNTIL ReservationEntry.NEXT = 0;
            UNTIL ItemJournalLine2.NEXT = 0;
    end;

    procedure ValidateOutputLines(Type: Integer)
    BEGIN
        //Iappc - Output Approval Process Begin
        recItemJournalLines.RESET;
        recItemJournalLines.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        recItemJournalLines.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        recItemJournalLines.SETFILTER("Document No.", '<>%1', Rec."Order No.");
        IF recItemJournalLines.FINDFIRST THEN
            ERROR('There are output lines of other production order, post the same first.');

        IF Type = 0 THEN BEGIN  //Submit for QC
            recItemJournalLines.RESET;
            recItemJournalLines.COPYFILTERS(Rec);
            IF recItemJournalLines.FINDFIRST THEN
                REPEAT
                    recMachineCenter.GET(recItemJournalLines."No.");
                    IF NOT recMachineCenter."QC Mandatory" THEN
                        ERROR('Quality is not mandatory for the selected routing, post the same directly.');
                UNTIL recItemJournalLines.NEXT = 0;
        END ELSE BEGIN          //Post Output
            recItemJournalLines.RESET;
            recItemJournalLines.SETFILTER("Journal Template Name", '<>%1', Rec."Journal Template Name");
            recItemJournalLines.SETFILTER("Document No.", '%1', Rec."Document No.");
            IF recItemJournalLines.FINDFIRST THEN
                ERROR('There are output lines already submitted for QC, post the same first.');

            recItemJournalLines.RESET;
            recItemJournalLines.COPYFILTERS(Rec);
            IF recItemJournalLines.FINDFIRST THEN
                REPEAT
                    recMachineCenter.GET(recItemJournalLines."No.");
                    IF (recMachineCenter."QC Mandatory") AND (recMachineCenter."QC Type" = recMachineCenter."QC Type"::Quality) THEN
                        ERROR('Quality is mandatory for the selected routing, submit for quality first.');
                UNTIL recItemJournalLines.NEXT = 0;
        END;
        //Iappc - Output Approval Process End
    END;

    var
        CurrentJnlBatchName: Code[10];
        ProductionOrder: Record "Production Order";
        recItemJournalLines: Record "Item Journal Line";
        recMachineCenter: Record "Machine Center";
        recBatchProcess: Record "Batch Process Header";
        pgBatchProcess: Page "De-Crystallizer Card";
        pgVacuumCirculation: Page "Vacuum Circulation Card";
}