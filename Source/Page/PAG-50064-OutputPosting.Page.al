page 50064 "Output Posting"
{
    AutoSplitKey = true;
    Caption = 'Output Posting';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = card;
    SaveValues = true;
    SourceTable = "Item Journal Line";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(CurrentJnlBatchName; CurrentJnlBatchName)
                {
                    Caption = 'Batch Name';
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CurrPage.SAVERECORD;
                        ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                        CurrPage.UPDATE(FALSE);
                        ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    end;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                        CurrentJnlBatchNameOnAfterVali;
                    end;
                }
            }
            repeater(Group2)
            {
                field("Posting Date"; Rec."Posting Date") { }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetOutput(Rec, ProdOrderDescription, OperationName);
                    end;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupItemNo;
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetOutput(Rec, ProdOrderDescription, OperationName);
                    end;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Output Quantity"; Rec."Output Quantity") { }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("ByProduct Item Code"; Rec."ByProduct Item Code")
                {
                    Editable = false;
                }
                field("ByProduct Qty."; Rec."ByProduct Qty.")
                {
                    Editable = false;
                }
                field("Prod. Date for Expiry Calc"; Rec."Prod. Date for Expiry Calc") { }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[35])
                {
                    CaptionClass = '1,2,5';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
            group(Operations)
            {
                group("Prod. Order Name")
                {
                    Caption = 'Prod. Order Name';
                    field(ProdOrderDescription; ProdOrderDescription)
                    {
                        Editable = false;
                    }
                }
                group(Operation)
                {
                    Caption = 'Operation';
                    field(OperationName; OperationName)
                    {
                        Caption = 'Operation';
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Container Information")
            {
                Image = Order;
                Caption = 'Container Information';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ContainerStoreToProd: page "Container- Prod. to Scrap";
                    ItemjournalLine: Record "Item Journal Line";
                    ManufacSetup: Record "Manufacturing Setup";
                begin
                    ManufacSetup.Get();
                    ManufacSetup.TestField("Prod. to Store Template");
                    ManufacSetup.TestField("Prod. to Store Batch");

                    ItemjournalLine.Reset();
                    ItemjournalLine.SetRange("Journal Template Name", ManufacSetup."Prod. to Store Template");
                    ItemjournalLine.SetRange("Journal Batch Name", ManufacSetup."Prod. to Store Batch");
                    ItemjournalLine.SetRange("Document No.", Rec."Document No.");
                    ContainerStoreToProd.SetTableView(ItemjournalLine);
                    ContainerStoreToProd.SetDocNo(Rec."Document No.");
                    ContainerStoreToProd.Run();
                end;
            }
        }
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(FALSE);
                    end;
                }
                action("Bin Contents")
                {
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Bin Code", "Item No.", "Variant Code");
                }
            }
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Image = "Order";
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Released Production Order";
                    RunPageLink = "No." = FIELD("Order No.");
                    ShortCutKey = 'Shift+F7';
                }
                group("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("Order No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        Promoted = false;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("Order No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("Order No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Quality)
                {
                    Caption = 'Quality';
                    Image = TestReport;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        OpenQCInfo(Rec."Document No.", Rec."Line No.");
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
            }
            action(Post)
            {
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    ManfactSetup: Record "Manufacturing Setup";
                    ItemLedgerEntries: Record "Item Ledger Entry";
                begin

                    ManfactSetup.Get();
                    ManfactSetup.TestField("Scrap Location");
                    ManfactSetup.TestField("Reject Location");

                    ItemLedgerEntries.Reset();
                    ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                    ItemLedgerEntries.SetFilter("Location Code", '%1|%2', ManfactSetup."Scrap Location", ManfactSetup."Reject Location");
                    ItemLedgerEntries.SetRange("Document No.", Rec."Document No.");
                    ItemLedgerEntries.SetRange("Container Trasfer Stage", ItemLedgerEntries."Container Trasfer Stage"::"RM Consumed");
                    if not ItemLedgerEntries.FindFirst() then
                        Error('Plesae Fill and Post Container Information before posting Output.');

                    recItemJournalLines.RESET;
                    recItemJournalLines.COPYFILTERS(Rec);
                    recItemJournalLines.SETFILTER("No.", '<>%1', '');
                    IF recItemJournalLines.FINDFIRST THEN
                        REPEAT
                            recMachineCenter.GET(recItemJournalLines."No.");
                            recRoutingHeader.GET(recItemJournalLines."Routing No.");
                            IF (recMachineCenter."QC Mandatory") AND (recMachineCenter."QC Type" = recMachineCenter."QC Type"::Quality) THEN BEGIN
                                recQualityProcess.RESET;
                                recQualityProcess.SETRANGE("Document Type", recQualityProcess."Document Type"::Output);
                                recQualityProcess.SETRANGE("Document No.", recItemJournalLines."Document No.");
                                recQualityProcess.SETRANGE("Document Line No.", recItemJournalLines."Order Line No.");
                                recQualityProcess.SETRANGE("Machine No.", recMachineCenter."No.");
                                recQualityProcess.SETRANGE(Posted, FALSE);
                                IF NOT recQualityProcess.FINDFIRST THEN
                                    ERROR('No Quality information is available for %1', recMachineCenter.Name)
                                ELSE
                                    IF recQualityProcess."Output Quality Status" = recQualityProcess."Output Quality Status"::" " THEN
                                        ERROR('Output Quality Status must not be blank ofr %1', recMachineCenter.Name)
                                    ELSE
                                        IF recQualityProcess."Output Quality Status" = recQualityProcess."Output Quality Status"::Rework THEN BEGIN
                                            recProdOrderRoutingLines.RESET;
                                            recProdOrderRoutingLines.SETRANGE(Status, recProdOrderRoutingLines.Status::Released);
                                            recProdOrderRoutingLines.SETRANGE("Prod. Order No.", recItemJournalLines."Order No.");
                                            recProdOrderRoutingLines.SETFILTER("Operation No.", '<>%1', '999999');
                                            IF recProdOrderRoutingLines.FINDLAST THEN BEGIN
                                                recManufacturingSetup.GET;
                                                recManufacturingSetup.TESTFIELD("Process Add On Routing");
                                                intCounter := 0;

                                                recRoutingLines.RESET;
                                                recRoutingLines.SETRANGE("Routing No.", recManufacturingSetup."Process Add On Routing");
                                                IF recRoutingLines.FINDFIRST THEN BEGIN
                                                    recProdOrderRoutingLines."Next Operation No." := recRoutingLines."Operation No.";
                                                    recProdOrderRoutingLines.MODIFY;
                                                    REPEAT
                                                        recProdOrderRoutingLinesInsert.INIT;
                                                        recProdOrderRoutingLinesInsert.TRANSFERFIELDS(recProdOrderRoutingLines);
                                                        recProdOrderRoutingLinesInsert."Operation No." := recRoutingLines."Operation No.";
                                                        IF intCounter = 0 THEN
                                                            recProdOrderRoutingLinesInsert."Previous Operation No." := recProdOrderRoutingLines."Operation No."
                                                        ELSE
                                                            recProdOrderRoutingLinesInsert."Previous Operation No." := recRoutingLines."Previous Operation No.";
                                                        /*
                                                        IF recRoutingLines."Next Operation No." = '' THEN
                                                          recProdOrderRoutingLinesInsert."Next Operation No." := '999999'
                                                        ELSE
                                                          recProdOrderRoutingLinesInsert."Next Operation No." := recRoutingLines."Next Operation No.";
                                                        */
                                                        IF recRoutingLines."Next Operation No." <> '' THEN
                                                            recProdOrderRoutingLinesInsert."Next Operation No." := recRoutingLines."Next Operation No.";

                                                        recProdOrderRoutingLinesInsert."No." := recRoutingLines."No.";
                                                        recProdOrderRoutingLinesInsert.Description := recRoutingLines.Description;
                                                        recProdOrderRoutingLinesInsert."Sequence No. (Forward)" := recProdOrderRoutingLines."Sequence No. (Forward)" + 1 + intCounter;
                                                        recProdOrderRoutingLinesInsert.INSERT;
                                                        intCounter += 1;
                                                    UNTIL recRoutingLines.NEXT = 0;
                                                END;
                                            END;
                                        END;
                            END ELSE
                                IF (recMachineCenter."QC Mandatory") AND (recMachineCenter."QC Type" = recMachineCenter."QC Type"::"Final QC") THEN BEGIN
                                    recQualityProcess.RESET;
                                    recQualityProcess.SETRANGE("Document Type", recQualityProcess."Document Type"::Output);
                                    recQualityProcess.SETRANGE("Document No.", recItemJournalLines."Document No.");
                                    recQualityProcess.SETRANGE("Document Line No.", recItemJournalLines."Order Line No.");
                                    recQualityProcess.SETRANGE(Posted, FALSE);
                                    recQualityProcess.SETRANGE("Machine No.", recMachineCenter."No.");
                                    IF NOT recQualityProcess.FINDFIRST THEN
                                        ERROR('No Quality information is available for %1', recMachineCenter.Name)
                                    ELSE
                                        IF recQualityProcess."Output Quality Status" = recQualityProcess."Output Quality Status"::" " THEN
                                            ERROR('Output Quality Status must not be blank ofr %1', recMachineCenter.Name)
                                        ELSE
                                            IF recQualityProcess."Output Quality Status" = recQualityProcess."Output Quality Status"::Rework THEN
                                                ERROR('Can not post rework status of Final QC.');
                                END;
                        UNTIL recItemJournalLines.NEXT = 0;

                    recUserSetup.GET(USERID);
                    recUserSetup."Post ByProduct Entry" := TRUE;
                    recUserSetup.MODIFY;

                    TrySetApplyToEntries;
                    IF (Rec."Order Type" = Rec."Order Type"::Production) AND (Rec."Order No." <> '') THEN
                        ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");
                    Rec.PostingItemJnlFromProduction(FALSE);
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);

                    recUserSetup.GET(USERID);
                    recUserSetup."Post ByProduct Entry" := FALSE;
                    recUserSetup.MODIFY;
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
    }

    var
        ItemJnlMgt: Codeunit "ItemJnlManagement";
        ReportPrint: Codeunit "Test Report-Print";
        ProdOrderDescription: Text[50];
        OperationName: Text[50];
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;
        ProductionOrder: Record "Production Order";
        recItemJournalLines: Record "Item Journal Line";
        recMachineCenter: Record "Machine Center";
        recQualityProcess: Record "Quality Header";
        recProdOrderRoutingLines: Record "Prod. Order Routing Line";
        recManufacturingSetup: Record "Manufacturing Setup";
        recRoutingLines: Record "Routing Line";
        recProdOrderRoutingLinesInsert: Record "Prod. Order Routing Line";
        intCounter: Integer;
        recRoutingHeader: Record "Routing Header";
        recUserSetup: Record "User Setup";

    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetOutput(Rec, ProdOrderDescription, OperationName);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        COMMIT;
        IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec);
        Rec.VALIDATE("Entry Type", Rec."Entry Type"::Output);
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        OpenedFromBatch := (Rec."Journal Batch Name" <> '') AND (Rec."Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := Rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        ItemJnlMgt.TemplateSelection(PAGE::"Output Posting", 5, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    procedure TrySetApplyToEntries()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine2: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
    begin
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

    local procedure FindReservationsReverseOutput(var ReservationEntry: Record "Reservation Entry"; ItemJnlLine: Record "Item Journal Line"): Boolean
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

    local procedure FindILEFromReservation(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line"; ReservationEntry: Record "Reservation Entry"; ProductionOrderNo: Code[20]): Boolean
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

    procedure OpenQCInfo(DocNo: Code[20]; DocLineNo: Integer)
    var
        recMachineCenter: Record "Machine Center";
        recInventorySetup: Record "Inventory Setup";
        recQualityCheck: Record "Quality Header";
        cdDocNo: Code[20];
        cuNoSeries: Codeunit "NoSeriesManagement";
        intLineNo: Integer;
        recQualityMeasure: Record "Standard Task Quality Measure";
        recQualityLines: Record "Quality Line";
        pgQuality: Page "Output Quality Check Card";
        recCustomer: Record "Customer";
    begin
        recMachineCenter.GET(Rec."No.");
        IF recMachineCenter."QC Mandatory" THEN BEGIN
            IF (recMachineCenter."QC Type" = recMachineCenter."QC Type"::Quality) OR (recMachineCenter."QC Type" = recMachineCenter."QC Type"::"Final QC") THEN BEGIN

                ProductionOrder.GET(ProductionOrder.Status::Released, Rec."Order No.");
                ProductionOrder.TESTFIELD("Customer Code");
                recCustomer.GET(ProductionOrder."Customer Code");
                IF recCustomer."Quality Process" = '' THEN
                    ERROR('No quality process defined for the customer %1', ProductionOrder."Customer Code");

                recInventorySetup.GET;
                recInventorySetup.TESTFIELD("Quality Nos.");

                recQualityCheck.RESET;
                recQualityCheck.SETRANGE("Document Type", recQualityCheck."Document Type"::Output);
                recQualityCheck.SETRANGE("Document No.", Rec."Document No.");
                recQualityCheck.SETRANGE("Document Line No.", Rec."Order Line No.");
                recQualityCheck.SETRANGE(Posted, FALSE);
                recQualityCheck.SETRANGE("Machine No.", recMachineCenter."No.");
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
                    recQualityMeasure.SETRANGE("Standard Task Code", recCustomer."Quality Process");
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
            END;
        END;
    end;
}