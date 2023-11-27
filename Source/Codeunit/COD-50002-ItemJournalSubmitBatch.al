codeunit 50002 "Item Jnl.-Submit Batch"
{
    Permissions = TableData "Item Journal Batch" = imd,
                  TableData "Warehouse Register" = r;
    TableNo = "Item Journal Line";

    trigger OnRun()
    begin
        ItemJnlLine.COPY(Rec);
        Code;
        Rec := ItemJnlLine;
    end;

    var
        Text000: Label 'cannot exceed %1 characters';
        Text001: Label 'Journal Batch Name    #1##########\\';
        Text002: Label 'Checking lines        #2######\';
        Text003: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@\';
        Text004: Label 'Updating lines        #5###### @6@@@@@@@@@@@@@';
        Text005: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text007: Label '<Month Text>';
        Text008: Label 'There are new postings made in the period you want to revalue item no. %1.\';
        Text009: Label 'You must calculate the inventory value again.';
        Text010: Label 'One or more reservation entries exist for the item with %1 = %2, %3 = %4, %5 = %6 which may be disrupted if you post this negative adjustment. Do you want to continue?', Comment = 'One or more reservation entries exist for the item with Item No. = 1000, Location Code = BLUE, Variant Code = NEW which may be disrupted if you post this negative adjustment. Do you want to continue?';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        WhseEntry: Record "Warehouse Entry";
        ItemReg: Record "Item Register";
        WhseReg: Record "Warehouse Register";
        GLSetup: Record "General Ledger Setup";
        InvtSetup: Record "Inventory Setup";
        AccountingPeriod: Record "Accounting Period";
        NoSeries: Record "No. Series" temporary;
        Location: Record Location;
        ItemJnlCheckLine: Codeunit "Item Jnl.-Check Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        // NoSeriesMgt: Codeunit 396;
        // NoSeriesMgt2: array[10] of Codeunit 396;
        WMSMgmt: Codeunit "WMS Management";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        Window: Dialog;
        ItemRegNo: Integer;
        WhseRegNo: Integer;
        StartLineNo: Integer;
        Day: Integer;
        Week: Integer;
        Month: Integer;
        MonthText: Text[30];
        NoOfRecords: Integer;
        LineCount: Integer;
        LastDocNo: Code[20];
        LastDocNo2: Code[20];
        LastPostedDocNo: Code[20];
        NoOfPostingNoSeries: Integer;
        PostingNoSeriesNo: Integer;
        WhseTransaction: Boolean;
        PhysInvtCount: Boolean;
        recItemJournal: Record "Item Journal Line";
        recReservationEntry: Record "Reservation Entry";
        recBatchProcessLines: Record "Batch Process Line";
        intLineNo: Integer;

    local procedure "Code"()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
        OldEntryType: Enum "Item Ledger Entry Type";
    begin
        ItemJnlLine.LOCKTABLE;
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", ItemJnlLine."Journal Batch Name");

        ItemJnlTemplate.GET(ItemJnlLine."Journal Template Name");
        ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        IF STRLEN(INCSTR(ItemJnlBatch.Name)) > MAXSTRLEN(ItemJnlBatch.Name) THEN
            ItemJnlBatch.FIELDERROR(
              Name,
              STRSUBSTNO(
                Text000,
                MAXSTRLEN(ItemJnlBatch.Name)));

        IF ItemJnlTemplate.Recurring THEN BEGIN
            ItemJnlLine.SETRANGE(ItemJnlLine."Posting Date", 0D, WORKDATE);
            ItemJnlLine.SETFILTER(ItemJnlLine."Expiration Date", '%1 | %2..', 0D, WORKDATE);
        END;

        IF NOT ItemJnlLine.FIND('=><') THEN BEGIN
            ItemJnlLine."Line No." := 0;
            COMMIT;
            EXIT;
        END;

        CheckItemAvailability(ItemJnlLine);

        IF ItemJnlTemplate.Recurring THEN
            Window.OPEN(
              Text001 +
              Text002 +
              Text003 +
              Text004)
        ELSE
            Window.OPEN(
              Text001 +
              Text002 +
              Text005);

        Window.UPDATE(1, ItemJnlLine."Journal Batch Name");

        CheckLines(ItemJnlLine);
        // Find next register no.
        ItemLedgEntry.LOCKTABLE;
        IF ItemLedgEntry.FINDLAST THEN;
        IF WhseTransaction THEN BEGIN
            WhseEntry.LOCKTABLE;
            IF WhseEntry.FINDLAST THEN;
        END;

        ItemReg.LOCKTABLE;
        IF ItemReg.FINDLAST THEN
            ItemRegNo := ItemReg."No." + 1
        ELSE
            ItemRegNo := 1;

        WhseReg.LOCKTABLE;
        IF WhseReg.FINDLAST THEN
            WhseRegNo := WhseReg."No." + 1
        ELSE
            WhseRegNo := 1;

        GLSetup.GET;
        PhysInvtCount := FALSE;
        // Post lines
        LineCount := 0;
        OldEntryType := ItemJnlLine."Entry Type";
        PostLines(ItemJnlLine, PhysInvtCountMgt);
        // Copy register no. and current journal batch name to item journal
        IF NOT ItemReg.FINDLAST OR (ItemReg."No." <> ItemRegNo) THEN
            ItemRegNo := 0;
        IF NOT WhseReg.FINDLAST OR (WhseReg."No." <> WhseRegNo) THEN
            WhseRegNo := 0;

        ItemJnlLine.INIT;

        ItemJnlLine."Line No." := ItemRegNo;
        IF ItemJnlLine."Line No." = 0 THEN
            ItemJnlLine."Line No." := WhseRegNo;

        InvtSetup.GET;
        IF InvtSetup."Automatic Cost Adjustment" <>
           InvtSetup."Automatic Cost Adjustment"::Never
        THEN BEGIN
            InvtAdjmt.SetProperties(TRUE, InvtSetup."Automatic Cost Posting");
            InvtAdjmt.MakeMultiLevelAdjmt;
        END;
        // Update/delete lines
        IF ItemJnlLine."Line No." <> 0 THEN BEGIN
            IF ItemJnlTemplate.Recurring THEN BEGIN
                HandleRecurringLine(ItemJnlLine);
            END ELSE
                HandleNonRecurringLine(ItemJnlLine, OldEntryType);
            IF ItemJnlBatch."No. Series" <> '' THEN
                // NoSeriesMgt.SaveNoSeries;
                IF NoSeries.FINDSET THEN
                    REPEAT
                        EVALUATE(PostingNoSeriesNo, NoSeries.Description);
                    // NoSeriesMgt2[PostingNoSeriesNo].SaveNoSeries;
                    UNTIL NoSeries.NEXT = 0;
        END;

        IF PhysInvtCount THEN
            PhysInvtCountMgt.UpdateItemSKUListPhysInvtCount;
        //Scrap Generation Process - Iappc - 20 Nov 15 Begin
        recItemJournal.RESET;
        recItemJournal.SETRANGE("Journal Template Name", InvtSetup."Auto Item Journal Template");
        recItemJournal.SETRANGE("Journal Batch Name", InvtSetup."Auto Item Journal Batch");
        recItemJournal.SETRANGE("ByProduct Entry", TRUE);
        IF recItemJournal.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", recItemJournal);
        //Scrap Generation Process - Iappc - 20 Nov 15 End
        Window.CLOSE;
        COMMIT;
        CLEAR(ItemJnlCheckLine);
        CLEAR(ItemJnlPostLine);
        CLEAR(WhseJnlPostLine);
        CLEAR(InvtAdjmt);
        UpdateAnalysisView.UpdateAll(0, TRUE);
        UpdateItemAnalysisView.UpdateAll(0, TRUE);
        COMMIT;
    end;

    procedure CheckLines(var ItemJnlLine: Record "Item Journal Line")
    begin
        LineCount := 0;
        StartLineNo := ItemJnlLine."Line No.";
        REPEAT
            LineCount := LineCount + 1;
            Window.UPDATE(2, LineCount);
            CheckRecurringLine(ItemJnlLine);

            IF ((ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::"Direct Cost") AND (ItemJnlLine."Item Charge No." = '')) OR
               ((ItemJnlLine."Invoiced Quantity" <> 0) AND (ItemJnlLine.Amount <> 0))
            THEN BEGIN
                ItemJnlCheckLine.RunCheck(ItemJnlLine);

                IF (ItemJnlLine.Quantity <> 0) AND
                   (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::"Direct Cost") AND
                   (ItemJnlLine."Item Charge No." = '')
                THEN
                    CheckWMSBin(ItemJnlLine);

                IF (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::Revaluation) AND
                   (ItemJnlLine."Inventory Value Per" = ItemJnlLine."Inventory Value Per"::" ") AND
                   ItemJnlLine."Partial Revaluation"
                THEN
                    CheckRemainingQty;
            END;

            IF ItemJnlLine.NEXT = 0 THEN
                ItemJnlLine.FINDFIRST;
        UNTIL ItemJnlLine."Line No." = StartLineNo;
        NoOfRecords := LineCount;
    end;

    procedure PostLines(var ItemJnlLine: Record "Item Journal Line"; var PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management")
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
    begin
        LastDocNo := '';
        LastDocNo2 := '';
        LastPostedDocNo := '';
        ItemJnlLine.FINDSET;
        REPEAT
            /*
            //Scrap Generation Process - Iappc - 20 Nov 15 Begin
            IF (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Output) AND (ItemJnlLine."ByProduct Item Code" <> '') AND (ItemJnlLine."ByProduct Qty." <> 0) THEN
              GenerateScrapEntry(ItemJnlLine."Document No.", ItemJnlLine."Posting Date", ItemJnlLine."ByProduct Item Code", ItemJnlLine."Location Code", ItemJnlLine."Shortcut Dimension 1 Code",
                                 ItemJnlLine."Shortcut Dimension 2 Code", ItemJnlLine."Dimension Set ID", ItemJnlLine."ByProduct Qty.", ItemJnlLine."Order Line No.", ItemJnlLine."No.");
            //Scrap Generation Process - Iappc - 20 Nov 15 End
            */
            //Iappc - Plan Weight Register Begin
            IF (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Consumption) THEN BEGIN
                recBatchProcessLines.RESET;
                recBatchProcessLines.SETRANGE(Type, recBatchProcessLines.Type::"Weighing Register");
                recBatchProcessLines.SETRANGE("Document No.", recReservationEntry."Source ID");
                IF recBatchProcessLines.FINDLAST THEN
                    intLineNo := recBatchProcessLines."Line No."
                ELSE
                    intLineNo := 0;

                recReservationEntry.RESET;
                recReservationEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
                recReservationEntry.SETRANGE("Location Code", ItemJnlLine."Location Code");
                recReservationEntry.SETRANGE("Source Type", 83);
                recReservationEntry.SETRANGE("Source Subtype", 5);
                recReservationEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
                recReservationEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");
                recReservationEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");
                IF recReservationEntry.FINDFIRST THEN
                    REPEAT
                        recBatchProcessLines.RESET;
                        recBatchProcessLines.SETRANGE(Type, recBatchProcessLines.Type::"Weighing Register");
                        recBatchProcessLines.SETRANGE("Document No.", ItemJnlLine."Document No.");
                        recBatchProcessLines.SETRANGE("Lot No.", recReservationEntry."Lot No.");
                        IF recBatchProcessLines.FINDFIRST THEN BEGIN
                            recBatchProcessLines."Tare Weight" += recReservationEntry."Tare Weight";
                            recBatchProcessLines."Nett Weight" += ABS(recReservationEntry."Quantity (Base)");
                            recBatchProcessLines."Gross Weight" := recBatchProcessLines."Tare Weight" + recBatchProcessLines."Nett Weight";
                            recBatchProcessLines.MODIFY;
                        END ELSE BEGIN
                            recBatchProcessLines.INIT;
                            recBatchProcessLines.Type := recBatchProcessLines.Type::"Weighing Register";
                            recBatchProcessLines."Document No." := ItemJnlLine."Document No.";
                            intLineNo += 10000;
                            recBatchProcessLines."Line No." := intLineNo;
                            recBatchProcessLines."Lot No." := recReservationEntry."Lot No.";
                            recBatchProcessLines."Packing Qauntity" := recReservationEntry."Qty. in Pack";
                            recBatchProcessLines."Tare Weight" := recReservationEntry."Tare Weight";
                            recBatchProcessLines."Nett Weight" := ABS(recReservationEntry."Quantity (Base)");
                            recBatchProcessLines."Packing Type" := recReservationEntry."Packing Type".AsInteger();
                            recBatchProcessLines."Qty. Per Pack" := recReservationEntry."Qty. Per Pack";
                            recBatchProcessLines."Gross Weight" := recBatchProcessLines."Tare Weight" + recBatchProcessLines."Nett Weight";
                            recBatchProcessLines.INSERT;
                        END;
                    UNTIL recReservationEntry.NEXT = 0;
            END;
            //Iappc - Plan Weight Register End
            IF NOT ItemJnlLine.EmptyLine AND
               (ItemJnlBatch."No. Series" <> '') AND
               (ItemJnlLine."Document No." <> LastDocNo2)
            THEN
                // TESTFIELD("Document No.", NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", "Posting Date", FALSE));
                IF NOT ItemJnlLine.EmptyLine THEN
                    LastDocNo2 := ItemJnlLine."Document No.";
            MakeRecurringTexts(ItemJnlLine);
            ConstructPostingNumber(ItemJnlLine);

            IF ItemJnlLine."Inventory Value Per" <> ItemJnlLine."Inventory Value Per"::" " THEN
                ItemJnlPostSumLine(ItemJnlLine)
            ELSE
                IF ((ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::"Direct Cost") AND (ItemJnlLine."Item Charge No." = '')) OR
                   ((ItemJnlLine."Invoiced Quantity" <> 0) AND (ItemJnlLine.Amount <> 0))
                THEN BEGIN
                    LineCount := LineCount + 1;
                    Window.UPDATE(3, LineCount);
                    Window.UPDATE(4, ROUND(LineCount / NoOfRecords * 10000, 1));
                    OriginalQuantity := ItemJnlLine.Quantity;
                    OriginalQuantityBase := ItemJnlLine."Quantity (Base)";
                    //ItemJnlPostLine.RunWithCheck(ItemJnlLine);
                    //IF NOT ItemJnlPostLine.GetPostItemJnlLine THEN
                    //  ItemJnlPostLine.CheckItemTracking;
                    IF ItemJnlLine."Value Entry Type" <> ItemJnlLine."Value Entry Type"::Revaluation THEN BEGIN
                        ItemJnlPostLine.CollectTrackingSpecification(TempTrackingSpecification);
                        //PostWhseJnlLine(ItemJnlLine,OriginalQuantity,OriginalQuantityBase,TempTrackingSpecification);
                    END;
                END;

            IF IsPhysInvtCount(ItemJnlTemplate, ItemJnlLine."Phys Invt Counting Period Code", ItemJnlLine."Phys Invt Counting Period Type") THEN BEGIN
                IF NOT PhysInvtCount THEN BEGIN
                    PhysInvtCountMgt.InitTempItemSKUList;
                    PhysInvtCount := TRUE;
                END;
                PhysInvtCountMgt.AddToTempItemSKUList(ItemJnlLine."Item No.", ItemJnlLine."Location Code", ItemJnlLine."Variant Code", ItemJnlLine."Phys Invt Counting Period Type");
            END;
        UNTIL ItemJnlLine.NEXT = 0;
    end;

    procedure HandleRecurringLine(var ItemJnlLine: Record "Item Journal Line")
    var
        ItemJnlLine2: Record "Item Journal Line";
    begin
        LineCount := 0;
        ItemJnlLine2.COPYFILTERS(ItemJnlLine);
        ItemJnlLine2.FINDSET;
        REPEAT
            LineCount := LineCount + 1;
            Window.UPDATE(5, LineCount);
            Window.UPDATE(6, ROUND(LineCount / NoOfRecords * 10000, 1));
            IF ItemJnlLine2."Posting Date" <> 0D THEN
                ItemJnlLine2.VALIDATE("Posting Date", CALCDATE(ItemJnlLine2."Recurring Frequency", ItemJnlLine2."Posting Date"));
            IF (ItemJnlLine2."Recurring Method" = ItemJnlLine2."Recurring Method"::Variable) AND
               (ItemJnlLine2."Item No." <> '')
            THEN BEGIN
                ItemJnlLine2.Quantity := 0;
                ItemJnlLine2."Invoiced Quantity" := 0;
                ItemJnlLine2.Amount := 0;
            END;
            ItemJnlLine2.MODIFY;
        UNTIL ItemJnlLine2.NEXT = 0;
    end;

    procedure HandleNonRecurringLine(var ItemJnlLine: Record "Item Journal Line"; OldEntryType: enum "Item Ledger Entry Type")
    var
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
    begin
        ItemJnlLine2.COPYFILTERS(ItemJnlLine);
        ItemJnlLine2.SETFILTER("Item No.", '<>%1', '');
        IF ItemJnlLine2.FINDLAST THEN;
        // Remember the last line
        ItemJnlLine2."Entry Type" := OldEntryType;

        ItemJnlLine3.COPY(ItemJnlLine);
        ItemJnlLine3.DELETEALL;
        ItemJnlLine3.RESET;
        ItemJnlLine3.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJnlLine3.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        IF NOT ItemJnlLine3.FINDLAST THEN
            IF INCSTR(ItemJnlLine."Journal Batch Name") <> '' THEN BEGIN
                ItemJnlBatch.DELETE;
                ItemJnlBatch.Name := INCSTR(ItemJnlLine."Journal Batch Name");
                IF ItemJnlBatch.INSERT THEN;
                ItemJnlLine."Journal Batch Name" := ItemJnlBatch.Name;
            END;

        ItemJnlLine3.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        IF (ItemJnlBatch."No. Series" = '') AND NOT ItemJnlLine3.FINDLAST AND
           NOT (ItemJnlLine2."Entry Type" IN [ItemJnlLine2."Entry Type"::Consumption, ItemJnlLine2."Entry Type"::Output])
        THEN BEGIN
            ItemJnlLine3.INIT;
            ItemJnlLine3."Journal Template Name" := ItemJnlLine."Journal Template Name";
            ItemJnlLine3."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
            ItemJnlLine3."Line No." := 10000;
            ItemJnlLine3.INSERT;
            ItemJnlLine3.SetUpNewLine(ItemJnlLine2);
            ItemJnlLine3.MODIFY;
        END;
    end;

    procedure ConstructPostingNumber(var ItemJnlLine: Record "Item Journal Line")
    begin
        IF ItemJnlLine."Posting No. Series" = '' THEN
            ItemJnlLine."Posting No. Series" := ItemJnlBatch."No. Series"
        ELSE
            IF NOT ItemJnlLine.EmptyLine THEN
                IF ItemJnlLine."Document No." = LastDocNo THEN
                    ItemJnlLine."Document No." := LastPostedDocNo
                ELSE BEGIN
                    IF NOT NoSeries.GET(ItemJnlLine."Posting No. Series") THEN BEGIN
                        NoOfPostingNoSeries := NoOfPostingNoSeries + 1;
                        // IF NoOfPostingNoSeries > ARRAYLEN(NoSeriesMgt2) THEN
                        //     ERROR(
                        //       Text006,
                        //       ARRAYLEN(NoSeriesMgt2));
                        NoSeries.Code := ItemJnlLine."Posting No. Series";
                        NoSeries.Description := FORMAT(NoOfPostingNoSeries);
                        NoSeries.INSERT;
                    END;
                    LastDocNo := ItemJnlLine."Document No.";
                    EVALUATE(PostingNoSeriesNo, NoSeries.Description);
                    // "Document No." := NoSeriesMgt2[PostingNoSeriesNo].GetNextNo("Posting No. Series", "Posting Date", FALSE);
                    LastPostedDocNo := ItemJnlLine."Document No.";
                END;
    end;

    local procedure CheckRecurringLine(var ItemJnlLine2: Record "Item Journal Line")
    var
        NULDF: DateFormula;
    begin
        IF ItemJnlLine2."Item No." <> '' THEN
            IF ItemJnlTemplate.Recurring THEN BEGIN
                ItemJnlLine2.TESTFIELD(ItemJnlLine2."Recurring Method");
                ItemJnlLine2.TESTFIELD(ItemJnlLine2."Recurring Frequency");
                IF ItemJnlLine2."Recurring Method" = ItemJnlLine2."Recurring Method"::Variable THEN
                    ItemJnlLine2.TESTFIELD(ItemJnlLine2.Quantity);
            END ELSE BEGIN
                CLEAR(NULDF);
                ItemJnlLine2.TESTFIELD(ItemJnlLine2."Recurring Method", 0);
                ItemJnlLine2.TESTFIELD(ItemJnlLine2."Recurring Frequency", NULDF);
            END;
    end;

    local procedure MakeRecurringTexts(var ItemJnlLine2: Record "Item Journal Line")
    begin
        IF (ItemJnlLine2."Item No." <> '') AND (ItemJnlLine2."Recurring Method" <> 0) THEN BEGIN
            // Not recurring
            Day := DATE2DMY(ItemJnlLine2."Posting Date", 1);
            Week := DATE2DWY(ItemJnlLine2."Posting Date", 2);
            Month := DATE2DMY(ItemJnlLine2."Posting Date", 2);
            MonthText := FORMAT(ItemJnlLine2."Posting Date", 0, Text007);
            AccountingPeriod.SETRANGE("Starting Date", 0D, ItemJnlLine2."Posting Date");
            IF NOT AccountingPeriod.FINDLAST THEN
                AccountingPeriod.Name := '';
            ItemJnlLine2."Document No." :=
              DELCHR(
                PADSTR(
                  STRSUBSTNO(ItemJnlLine2."Document No.", Day, Week, Month, MonthText, AccountingPeriod.Name),
                  MAXSTRLEN(ItemJnlLine2."Document No.")),
                '>');
            ItemJnlLine2.Description :=
              DELCHR(
                PADSTR(
                  STRSUBSTNO(ItemJnlLine2.Description, Day, Week, Month, MonthText, AccountingPeriod.Name),
                  MAXSTRLEN(ItemJnlLine2.Description)),
                '>');
        END;
    end;

    local procedure ItemJnlPostSumLine(ItemJnlLine4: Record "Item Journal Line")
    var
        Item: Record Item;
        ItemLedgEntry4: Record "Item Ledger Entry";
        ItemLedgEntry5: Record "Item Ledger Entry";
        Remainder: Decimal;
        RemAmountToDistribute: Decimal;
        RemQuantity: Decimal;
        DistributeCosts: Boolean;
        IncludeExpectedCost: Boolean;
        PostingDate: Date;
        IsLastEntry: Boolean;
    begin
        DistributeCosts := TRUE;
        RemAmountToDistribute := ItemJnlLine.Amount;
        RemQuantity := ItemJnlLine.Quantity;
        IF ItemJnlLine.Amount <> 0 THEN BEGIN
            LineCount := LineCount + 1;
            Window.UPDATE(3, LineCount);
            Window.UPDATE(4, ROUND(LineCount / NoOfRecords * 10000, 1));
            Item.GET(ItemJnlLine4."Item No.");
            IncludeExpectedCost := (Item."Costing Method" = Item."Costing Method"::Standard) AND
              (ItemJnlLine4."Inventory Value Per" <> ItemJnlLine4."Inventory Value Per"::" ");
            ItemLedgEntry4.RESET;
            ItemLedgEntry4.SETCURRENTKEY(ItemLedgEntry4."Item No.", ItemLedgEntry4.Positive, ItemLedgEntry4."Location Code", ItemLedgEntry4."Variant Code");
            ItemLedgEntry4.SETRANGE(ItemLedgEntry4."Item No.", ItemJnlLine."Item No.");
            ItemLedgEntry4.SETRANGE(ItemLedgEntry4.Positive, TRUE);
            PostingDate := ItemJnlLine."Posting Date";

            IF (ItemJnlLine4."Location Code" <> '') OR
               (ItemJnlLine4."Inventory Value Per" IN
                [ItemJnlLine."Inventory Value Per"::Location,
                 ItemJnlLine4."Inventory Value Per"::"Location and Variant"])
            THEN
                ItemLedgEntry4.SETRANGE(ItemLedgEntry4."Location Code", ItemJnlLine."Location Code");
            IF (ItemJnlLine."Variant Code" <> '') OR
               (ItemJnlLine4."Inventory Value Per" IN
                [ItemJnlLine."Inventory Value Per"::Variant,
                 ItemJnlLine4."Inventory Value Per"::"Location and Variant"])
            THEN
                ItemLedgEntry4.SETRANGE(ItemLedgEntry4."Variant Code", ItemJnlLine."Variant Code");
            IF ItemLedgEntry4.FINDSET THEN
                REPEAT
                    IF IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) THEN BEGIN
                        ItemLedgEntry5 := ItemLedgEntry4;

                        ItemJnlLine4."Entry Type" := ItemLedgEntry4."Entry Type";
                        IF ItemLedgEntry4."Remaining Quantity" <> ItemLedgEntry4.Quantity THEN
                            ItemJnlLine4.Quantity :=
                              ItemLedgEntry4.CalculateRemQuantity(ItemLedgEntry4."Entry No.", ItemJnlLine."Posting Date")
                        ELSE
                            ItemJnlLine4.Quantity := ItemLedgEntry4.Quantity;

                        ItemJnlLine4."Quantity (Base)" := ItemJnlLine4.Quantity;
                        ItemJnlLine4."Invoiced Quantity" := ItemJnlLine4.Quantity;
                        ItemJnlLine4."Invoiced Qty. (Base)" := ItemJnlLine4.Quantity;
                        ItemJnlLine4."Location Code" := ItemLedgEntry4."Location Code";
                        ItemJnlLine4."Variant Code" := ItemLedgEntry4."Variant Code";
                        ItemJnlLine4."Applies-to Entry" := ItemLedgEntry4."Entry No.";
                        ItemJnlLine4."Source No." := ItemLedgEntry4."Source No.";
                        ItemJnlLine4."Order Type" := ItemLedgEntry4."Order Type";
                        ItemJnlLine4."Order No." := ItemLedgEntry4."Order No.";
                        ItemJnlLine4."Order Line No." := ItemLedgEntry4."Order Line No.";

                        IF ItemJnlLine4.Quantity <> 0 THEN BEGIN
                            IF (Item."Costing Method" = Item."Costing Method"::Average) AND
                               (ItemJnlLine."Applied Amount" <> 0)
                            THEN
                                ItemJnlLine4.Amount :=
                                  ROUND(
                                    ItemLedgEntry4.CalculateRemInventoryValue(
                                      ItemLedgEntry4."Entry No.", ItemLedgEntry4.Quantity, ItemJnlLine4.Quantity, FALSE, PostingDate),
                                    GLSetup."Amount Rounding Precision") *
                                  ItemJnlLine.Amount / ABS(ItemJnlLine."Applied Amount") + Remainder
                            ELSE
                                ItemJnlLine4.Amount :=
                                  ItemJnlLine."Inventory Value (Revalued)" * ItemJnlLine4.Quantity /
                                  ItemJnlLine.Quantity -
                                  ROUND(
                                    ItemLedgEntry4.CalculateRemInventoryValue(
                                      ItemLedgEntry4."Entry No.", ItemLedgEntry4.Quantity, ItemJnlLine4.Quantity,
                                      IncludeExpectedCost AND NOT ItemLedgEntry4."Completely Invoiced", PostingDate),
                                    GLSetup."Amount Rounding Precision") + Remainder;

                            RemQuantity := RemQuantity - ItemJnlLine4.Quantity;

                            IF RemQuantity = 0 THEN BEGIN
                                IF ItemLedgEntry4.NEXT > 0 THEN
                                    REPEAT
                                        IF IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) THEN BEGIN
                                            RemQuantity := ItemLedgEntry4.CalculateRemQuantity(ItemLedgEntry4."Entry No.", ItemJnlLine."Posting Date");
                                            IF RemQuantity > 0 THEN
                                                ERROR(Text008 + Text009, ItemJnlLine4."Item No.");
                                        END;
                                    UNTIL ItemLedgEntry4.NEXT = 0;

                                ItemJnlLine4.Amount := RemAmountToDistribute;
                                DistributeCosts := FALSE;
                            END ELSE BEGIN
                                REPEAT
                                    IsLastEntry := ItemLedgEntry4.NEXT = 0;
                                UNTIL IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) OR IsLastEntry;
                                IF IsLastEntry OR (RemQuantity < 0) THEN
                                    ERROR(Text008 + Text009, ItemJnlLine4."Item No.");
                                Remainder := ItemJnlLine4.Amount - ROUND(ItemJnlLine4.Amount, GLSetup."Amount Rounding Precision");
                                ItemJnlLine4.Amount := ROUND(ItemJnlLine4.Amount, GLSetup."Amount Rounding Precision");
                                RemAmountToDistribute := RemAmountToDistribute - ItemJnlLine4.Amount;
                            END;
                            ItemJnlLine4."Unit Cost" := ItemJnlLine4.Amount / ItemJnlLine4.Quantity;

                            IF ItemJnlLine4.Amount <> 0 THEN BEGIN
                                IF IncludeExpectedCost AND NOT ItemLedgEntry5."Completely Invoiced" THEN BEGIN
                                    ItemJnlLine4."Applied Amount" := ROUND(
                                        ItemJnlLine4.Amount * (ItemLedgEntry5.Quantity - ItemLedgEntry5."Invoiced Quantity") /
                                        ItemLedgEntry5.Quantity,
                                        GLSetup."Amount Rounding Precision");
                                END ELSE
                                    ItemJnlLine4."Applied Amount" := 0;
                                //ItemJnlPostLine.RunWithCheck(ItemJnlLine4);
                            END;
                        END ELSE BEGIN
                            REPEAT
                                IsLastEntry := ItemLedgEntry4.NEXT = 0;
                            UNTIL IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) OR IsLastEntry;
                            IF IsLastEntry THEN
                                ERROR(Text008 + Text009, ItemJnlLine4."Item No.");
                        END;
                    END ELSE
                        DistributeCosts := ItemLedgEntry4.NEXT <> 0;
                UNTIL NOT DistributeCosts;

            IF ItemJnlLine."Update Standard Cost" THEN
                UpdateStdCost;
        END;
    end;

    local procedure IncludeEntryInCalc(ItemLedgEntry: Record "Item Ledger Entry"; PostingDate: Date; IncludeExpectedCost: Boolean): Boolean
    begin
        IF IncludeExpectedCost THEN
            EXIT(ItemLedgEntry."Posting Date" IN [0D .. PostingDate]);
        EXIT(ItemLedgEntry."Completely Invoiced" AND (ItemLedgEntry."Last Invoice Date" IN [0D .. PostingDate]));
    end;

    local procedure UpdateStdCost()
    var
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
    begin
        IF SKU.GET(ItemJnlLine."Location Code", ItemJnlLine."Item No.", ItemJnlLine."Variant Code") THEN BEGIN
            SKU.VALIDATE("Standard Cost", ItemJnlLine."Unit Cost (Revalued)");
            SKU.MODIFY;
        END ELSE BEGIN
            Item.GET(ItemJnlLine."Item No.");
            Item.VALIDATE("Standard Cost", ItemJnlLine."Unit Cost (Revalued)");
            Item."Single-Level Material Cost" := ItemJnlLine."Single-Level Material Cost";
            Item."Single-Level Capacity Cost" := ItemJnlLine."Single-Level Capacity Cost";
            Item."Single-Level Subcontrd. Cost" := ItemJnlLine."Single-Level Subcontrd. Cost";
            Item."Single-Level Cap. Ovhd Cost" := ItemJnlLine."Single-Level Cap. Ovhd Cost";
            Item."Single-Level Mfg. Ovhd Cost" := ItemJnlLine."Single-Level Mfg. Ovhd Cost";
            Item."Rolled-up Material Cost" := ItemJnlLine."Rolled-up Material Cost";
            Item."Rolled-up Capacity Cost" := ItemJnlLine."Rolled-up Capacity Cost";
            Item."Rolled-up Subcontracted Cost" := ItemJnlLine."Rolled-up Subcontracted Cost";
            Item."Rolled-up Mfg. Ovhd Cost" := ItemJnlLine."Rolled-up Mfg. Ovhd Cost";
            Item."Rolled-up Cap. Overhead Cost" := ItemJnlLine."Rolled-up Cap. Overhead Cost";
            Item."Last Unit Cost Calc. Date" := ItemJnlLine."Posting Date";
            Item.MODIFY;
        END;
    end;

    local procedure CheckRemainingQty()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        RemainingQty: Decimal;
    begin
        RemainingQty := ItemLedgerEntry.CalculateRemQuantity(
            ItemJnlLine."Applies-to Entry", ItemJnlLine."Posting Date");

        IF RemainingQty <> ItemJnlLine.Quantity THEN
            ERROR(Text008 + Text009, ItemJnlLine."Item No.");
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line"; OriginalQuantity: Decimal; OriginalQuantityBase: Decimal; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
    begin
        ItemJnlLine.Quantity := OriginalQuantity;
        ItemJnlLine."Quantity (Base)" := OriginalQuantityBase;
        GetLocation(ItemJnlLine."Location Code");
        IF NOT (ItemJnlLine."Entry Type" IN [ItemJnlLine."Entry Type"::Consumption, ItemJnlLine."Entry Type"::Output]) THEN
            IF Location."Bin Mandatory" THEN
                IF WMSMgmt.CreateWhseJnlLine(ItemJnlLine, ItemJnlTemplate.Type.AsInteger(), WhseJnlLine, FALSE) THEN BEGIN
                    // ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, FALSE);
                    IF TempWhseJnlLine2.FINDSET THEN
                        REPEAT
                            WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, FALSE);
                            WhseJnlPostLine.RUN(TempWhseJnlLine2);
                        UNTIL TempWhseJnlLine2.NEXT = 0;
                END;

        IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer THEN BEGIN
            GetLocation(ItemJnlLine."New Location Code");
            IF Location."Bin Mandatory" THEN
                IF WMSMgmt.CreateWhseJnlLine(ItemJnlLine, ItemJnlTemplate.Type.AsInteger(), WhseJnlLine, TRUE) THEN BEGIN
                    // ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempTrackingSpecification, TRUE);
                    IF TempWhseJnlLine2.FINDSET THEN
                        REPEAT
                            WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, TRUE);
                            WhseJnlPostLine.RUN(TempWhseJnlLine2);
                        UNTIL TempWhseJnlLine2.NEXT = 0;
                END;
        END;
    end;

    procedure CheckWMSBin(ItemJnlLine: Record "Item Journal Line")
    begin
        GetLocation(ItemJnlLine."Location Code");
        IF Location."Bin Mandatory" THEN
            WhseTransaction := TRUE;
        CASE ItemJnlLine."Entry Type" OF
            ItemJnlLine."Entry Type"::Purchase, ItemJnlLine."Entry Type"::Sale,
            ItemJnlLine."Entry Type"::"Positive Adjmt.", ItemJnlLine."Entry Type"::"Negative Adjmt.":
                BEGIN
                    IF Location."Directed Put-away and Pick" THEN
                        WMSMgmt.CheckAdjmtBin(
                          Location, ItemJnlLine.Quantity,
                          (ItemJnlLine."Entry Type" IN
                           [ItemJnlLine."Entry Type"::Purchase,
                            ItemJnlLine."Entry Type"::"Positive Adjmt."]));
                END;
            ItemJnlLine."Entry Type"::Transfer:
                BEGIN
                    IF Location."Directed Put-away and Pick" THEN
                        WMSMgmt.CheckAdjmtBin(Location, -ItemJnlLine.Quantity, FALSE);
                    GetLocation(ItemJnlLine."New Location Code");
                    IF Location."Directed Put-away and Pick" THEN
                        WMSMgmt.CheckAdjmtBin(Location, ItemJnlLine.Quantity, TRUE);
                    IF Location."Bin Mandatory" THEN
                        WhseTransaction := TRUE;
                END;
        END;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    procedure GetWhseRegNo(): Integer
    begin
        EXIT(WhseRegNo);
    end;

    procedure GetItemRegNo(): Integer
    begin
        EXIT(ItemRegNo);
    end;

    local procedure IsPhysInvtCount(ItemJnlTemplate2: Record "Item Journal Template"; PhysInvtCountingPeriodCode: Code[10]; PhysInvtCountingPeriodType: Option " ",Item,SKU): Boolean
    begin
        EXIT(
          (ItemJnlTemplate2.Type = ItemJnlTemplate2.Type::"Phys. Inventory") AND
          (PhysInvtCountingPeriodType <> PhysInvtCountingPeriodType::" ") AND
          (PhysInvtCountingPeriodCode <> ''));
    end;

    local procedure CheckItemAvailability(var ItemJnlLine: Record "Item Journal Line")
    var
        Item: Record Item;
        TempSKU: Record "Stockkeeping Unit" temporary;
        ItemJnlLine2: Record "Item Journal Line";
        QtyinItemJnlLine: Decimal;
        AvailableQty: Decimal;
    begin
        ItemJnlLine2.COPYFILTERS(ItemJnlLine);
        IF ItemJnlLine2.FINDSET THEN
            REPEAT
                IF NOT TempSKU.GET(ItemJnlLine2."Location Code", ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code") THEN
                    InsertTempSKU(TempSKU, ItemJnlLine2);
            UNTIL ItemJnlLine2.NEXT = 0;

        IF TempSKU.FINDSET THEN
            REPEAT
                QtyinItemJnlLine := CalcRequiredQty(TempSKU, ItemJnlLine2);
                IF QtyinItemJnlLine < 0 THEN BEGIN
                    Item.GET(TempSKU."Item No.");
                    Item.SETFILTER("Location Filter", TempSKU."Location Code");
                    Item.SETFILTER("Variant Filter", TempSKU."Variant Code");
                    Item.CALCFIELDS("Reserved Qty. on Inventory", "Net Change");
                    AvailableQty := Item."Net Change" - Item."Reserved Qty. on Inventory";

                    IF (Item."Reserved Qty. on Inventory" > 0) AND (AvailableQty < ABS(QtyinItemJnlLine)) THEN
                        IF NOT CONFIRM(
                             Text010, FALSE, TempSKU.FIELDCAPTION("Item No."), TempSKU."Item No.", TempSKU.FIELDCAPTION("Location Code"),
                             TempSKU."Location Code", TempSKU.FIELDCAPTION("Variant Code"), TempSKU."Variant Code")
                        THEN
                            ERROR('');
                END;
            UNTIL TempSKU.NEXT = 0;
    end;

    local procedure InsertTempSKU(var TempSKU: Record "Stockkeeping Unit" temporary; ItemJnlLine: Record "Item Journal Line")
    begin
        TempSKU.INIT;
        TempSKU."Location Code" := ItemJnlLine."Location Code";
        TempSKU."Item No." := ItemJnlLine."Item No.";
        TempSKU."Variant Code" := ItemJnlLine."Variant Code";
        TempSKU.INSERT;
    end;

    local procedure CalcRequiredQty(TempSKU: Record "Stockkeeping Unit" temporary; var ItemJnlLine: Record "Item Journal Line"): Decimal
    var
        SignFactor: Integer;
        QtyinItemJnlLine: Decimal;
    begin
        QtyinItemJnlLine := 0;
        ItemJnlLine.SETRANGE("Item No.", TempSKU."Item No.");
        ItemJnlLine.SETRANGE("Location Code", TempSKU."Location Code");
        ItemJnlLine.SETRANGE("Variant Code", TempSKU."Variant Code");
        ItemJnlLine.FINDSET;
        REPEAT
            IF (ItemJnlLine."Entry Type" IN
                [ItemJnlLine."Entry Type"::Sale,
                 ItemJnlLine."Entry Type"::"Negative Adjmt.",
                 ItemJnlLine."Entry Type"::Consumption]) OR
               (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer)
            THEN
                SignFactor := -1
            ELSE
                SignFactor := 1;
            QtyinItemJnlLine += ItemJnlLine."Quantity (Base)" * SignFactor;
        UNTIL ItemJnlLine.NEXT = 0;
        EXIT(QtyinItemJnlLine);
    end;

    procedure GenerateScrapEntry(DocumentNo: Code[20]; PostingDate: Date; ScrapItem: Code[20]; ScrapLocation: Code[20]; GD1: Code[20]; GD2: Code[20]; DimSetID: Integer; ScrapQty: Decimal; ProdOrderLineNo: Integer; MachineCenterNo: Code[20])
    var
        recItemJournal: Record "Item Journal Line";
        intLineNo: Integer;
    begin
        InvtSetup.GET;
        InvtSetup.TESTFIELD("Auto Item Journal Template");
        InvtSetup.TESTFIELD("Auto Item Journal Batch");

        recItemJournal.RESET;
        recItemJournal.SETRANGE("Journal Template Name", InvtSetup."Auto Item Journal Template");
        recItemJournal.SETRANGE("Journal Batch Name", InvtSetup."Auto Item Journal Batch");
        IF recItemJournal.FINDLAST THEN
            intLineNo := recItemJournal."Line No.";

        recItemJournal.INIT;
        recItemJournal.VALIDATE("Journal Template Name", InvtSetup."Auto Item Journal Template");
        recItemJournal.VALIDATE("Journal Batch Name", InvtSetup."Auto Item Journal Batch");
        intLineNo += 10000;
        recItemJournal.VALIDATE("Line No.", intLineNo);
        recItemJournal.VALIDATE("Entry Type", recItemJournal."Entry Type"::"Positive Adjmt.");
        recItemJournal.VALIDATE("Document No.", DocumentNo);
        recItemJournal.VALIDATE("Posting Date", PostingDate);
        recItemJournal.VALIDATE("Item No.", ScrapItem);
        recItemJournal.VALIDATE("Location Code", ScrapLocation);
        recItemJournal.VALIDATE("Shortcut Dimension 1 Code", GD1);
        recItemJournal.VALIDATE("Shortcut Dimension 2 Code", GD2);
        recItemJournal.VALIDATE(Quantity, ScrapQty);
        recItemJournal."Dimension Set ID" := DimSetID;
        recItemJournal."Temp Message Control" := TRUE;
        recItemJournal."ByProduct Entry" := TRUE;
        recItemJournal."Prod. Order Line No." := ProdOrderLineNo;
        recItemJournal."Machine Center No." := MachineCenterNo;
        recItemJournal.INSERT(TRUE);
    end;
}
