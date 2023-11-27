codeunit 50000 Tble83
{
    trigger OnRun()
    begin
    end;
    // Table83 Start

    var
        MRPPrice: Decimal;
        ModifyRun: Boolean;
        MFGDate: Date;
        Tin: Decimal;
        Drum: Decimal;
        Bucket: Decimal;
        ILENo: Integer;
        Can: Decimal;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    var
        recDeal: Record "Deal Dispatch Details";
        recSalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        //Iappc - 16 Jan 16 - Deals Details Begin
        ItemJnlLine."Deal No." := PurchLine."Deal No.";
        ItemJnlLine."Deal Line No." := PurchLine."Deal Line No.";
        ItemJnlLine."Packing Type" := PurchLine."Packing Type";
        ItemJnlLine."Qty. in Pack" := PurchLine."Qty. in Pack";
        ItemJnlLine."Dispatched Qty. in Kg." := PurchLine."Dispatched Qty. in Kg.";
        ItemJnlLine.Flora := PurchLine.Flora;
        ItemJnlLine."New Product Group Code" := PurchLine."New Product Group Code";

        IF recDeal.GET(PurchLine."Deal No.", PurchLine."Deal Line No.") THEN
            ItemJnlLine."Vehicle No." := recDeal."Vehicle No.";
        ItemJnlLine."Purchaser Code" := PurchLine."Purchaser Code";
        IF recSalespersonPurchaser.GET(PurchLine."Purchaser Code") THEN
            ItemJnlLine."Purchaser Name" := recSalespersonPurchaser.Name;
        //Iappc - 16 Jan 16 - Deals Details End
    end;

    // Table83 End

    // Codeunit22 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        recItemCategory: Record "Item Category";
        recQualityChecks: Record "Quality Header";
        recLotInfo: Record "Lot No. Information";
        recItemLedgerEntry: Record "Item Ledger Entry";
        recItem: Record Item;
        recInventoryPostingGroup: Record "Inventory Posting Group";
        recLotTracking: Record "Tran. Lot Tracking";
        recPostedLotTracking: Record "Lot Tracking Entry";
        intEntryNo: Integer;
        decQtyInPacks: Decimal;
        recSourceLotEntry: Record "Lot Tracking Entry";
        recPurchaseSetup: Record "Purchases & Payables Setup";
        dtExpiryDate: Date;
        Fromlocation: record Location;
        Tolocation: Record Location;
        ItemLedgerEntry: Record "Item Ledger Entry";


    begin
        NewItemLedgEntry."Deal No." := ItemJournalLine."Deal No.";
        NewItemLedgEntry."Deal Line No." := ItemJournalLine."Deal Line No.";
        NewItemLedgEntry."Dispatched Qty. in Kg." := ItemJournalLine."Dispatched Qty. in Kg.";
        NewItemLedgEntry.Flora := ItemJournalLine.Flora;
        NewItemLedgEntry."Vehicle No." := ItemJournalLine."Vehicle No.";
        NewItemLedgEntry."Purchaser Code" := ItemJournalLine."Purchaser Code";
        NewItemLedgEntry."Purchaser Name" := ItemJournalLine."Purchaser Name";
        NewItemLedgEntry."MRP Price" := ItemJournalLine."MRP Price"; //
        NewItemLedgEntry."MFG. Date" := ItemJournalLine."MFG. Date";
        NewItemLedgEntry.Tin := ItemJournalLine.Tin;
        NewItemLedgEntry.Drum := ItemJournalLine.Drum;
        NewItemLedgEntry.Bucket := ItemJournalLine.Bucket;
        NewItemLedgEntry.Can := ItemJournalLine.Can;

        //>>

        IF NewItemLedgEntry."Document Type" = NewItemLedgEntry."Document Type"::"Purchase Receipt" THEN BEGIN
            IF (recItemCategory.GET(NewItemLedgEntry."Item Category Code")) AND (recItemCategory."Inward QC Required" = FALSE) THEN BEGIN
                NewItemLedgEntry."Quality Checked" := TRUE;
                NewItemLedgEntry."Approved Quantity" := NewItemLedgEntry.Quantity;
            END;
        END;

        NewItemLedgEntry."Inventory Posting Group" := recItem."Inventory Posting Group";

        NewItemLedgEntry."ByProduct Entry" := ItemJournalLine."ByProduct Entry";
        NewItemLedgEntry."Prod. Order Line No." := ItemJournalLine."Prod. Order Line No.";
        NewItemLedgEntry."Machine Center No." := ItemJournalLine."Machine Center No.";
        NewItemLedgEntry."Starting Date Time" := ItemJournalLine."Starting Date Time";
        NewItemLedgEntry."Ending Date Time" := ItemJournalLine."Ending Date Time";

        //Expiry Date
        IF NewItemLedgEntry.Quantity > 0 THEN BEGIN
            IF NewItemLedgEntry."Entry Type" = NewItemLedgEntry."Entry Type"::Output THEN BEGIN
                ItemJournalLine.TESTFIELD("Prod. Date for Expiry Calc");
                recItem.GET(NewItemLedgEntry."Item No.");
                IF FORMAT(recItem."Expiry Date Formula") <> '' THEN BEGIN
                    NewItemLedgEntry."Expiration Date" := CALCDATE(recItem."Expiry Date Formula", ItemJournalLine."Prod. Date for Expiry Calc");
                END;
            END ELSE
                IF NewItemLedgEntry."Lot No." <> '' THEN BEGIN
                    recItem.GET(NewItemLedgEntry."Item No.");
                    recInventoryPostingGroup.GET(recItem."Inventory Posting Group");
                    IF (recInventoryPostingGroup."Activate Expiry Date FIFO") AND (NewItemLedgEntry."Expiration Date" = 0D) THEN
                        ERROR('Expiry must not be blank on lot no. %1', NewItemLedgEntry."Lot No.");
                END;
        END ELSE
            IF (NewItemLedgEntry."Lot No." <> '') AND (NewItemLedgEntry.Quantity < 0) AND (NewItemLedgEntry."Entry Type" <> NewItemLedgEntry."Entry Type"::Transfer) THEN BEGIN
                recItem.GET(NewItemLedgEntry."Item No.");
                recInventoryPostingGroup.GET(recItem."Inventory Posting Group");
                IF recInventoryPostingGroup."Activate Expiry Date FIFO" THEN BEGIN
                    recItemLedgerEntry.RESET;
                    recItemLedgerEntry.SETRANGE("Item No.", NewItemLedgEntry."Item No.");
                    recItemLedgerEntry.SETRANGE("Lot No.", NewItemLedgEntry."Lot No.");
                    recItemLedgerEntry.SETRANGE("Location Code", NewItemLedgEntry."Location Code");
                    recItemLedgerEntry.SETRANGE("Expiration Date", 0D);
                    recItemLedgerEntry.SETRANGE(Open, TRUE);
                    IF NOT recItemLedgerEntry.FINDFIRST THEN BEGIN
                        recItemLedgerEntry.RESET;
                        recItemLedgerEntry.SETRANGE("Item No.", NewItemLedgEntry."Item No.");
                        recItemLedgerEntry.SETRANGE("Lot No.", NewItemLedgEntry."Lot No.");
                        recItemLedgerEntry.SETRANGE("Location Code", NewItemLedgEntry."Location Code");
                        recItemLedgerEntry.SETFILTER("Expiration Date", '<>%1', 0D);
                        recItemLedgerEntry.SETRANGE(Open, TRUE);
                        recItemLedgerEntry.FINDFIRST;
                        dtExpiryDate := recItemLedgerEntry."Expiration Date";

                        recItemLedgerEntry.RESET;
                        recItemLedgerEntry.SETRANGE("Item No.", NewItemLedgEntry."Item No.");
                        recItemLedgerEntry.SETFILTER("Lot No.", '<>%1', NewItemLedgEntry."Lot No.");
                        recItemLedgerEntry.SETRANGE("Location Code", NewItemLedgEntry."Location Code");
                        recItemLedgerEntry.SETFILTER("Expiration Date", '<%1', dtExpiryDate);
                        recItemLedgerEntry.SETRANGE(Open, TRUE);
                        IF recItemLedgerEntry.FINDFIRST THEN
                            ERROR('The stock is available with earlier expiry date, select the same first.', recItemLedgerEntry."Lot No.");
                    END;
                END;
            END;
        // - Expiry Date

        //- RM Lot Tracking
        IF NewItemLedgEntry."Document Type" IN [NewItemLedgEntry."Document Type"::"Sales Return Receipt", NewItemLedgEntry."Document Type"::"Sales Credit Memo"] THEN BEGIN
            recPostedLotTracking.RESET;
            IF recPostedLotTracking.FINDLAST THEN
                intEntryNo := recPostedLotTracking."Entry No."
            ELSE
                intEntryNo := 0;

            recPurchaseSetup.GET;
            recPurchaseSetup.TESTFIELD("Raw Honey Item");
            IF recPurchaseSetup."Raw Honey Item" = NewItemLedgEntry."Item No." THEN BEGIN
                recPostedLotTracking.INIT;
                intEntryNo += 1;
                recPostedLotTracking."Entry No." := intEntryNo;
                recPostedLotTracking."Item No." := recPurchaseSetup."Raw Honey Item";
                recPostedLotTracking."Lot No." := NewItemLedgEntry."Lot No.";
                recPostedLotTracking.Flora := '';

                ItemJournalLine.TESTFIELD("Packing Type");
                ItemJournalLine.TESTFIELD("Qty. in Pack");
                ItemJournalLine.TESTFIELD("Customer Code");

                recPostedLotTracking."Packing Type" := ItemJournalLine."Packing Type";
                recPostedLotTracking."Qty. In Packs" := ItemJournalLine."Qty. in Pack";
                recPostedLotTracking.Customer := ItemJournalLine."Customer Code";
                recPostedLotTracking.Quantity := NewItemLedgEntry.Quantity;
                recPostedLotTracking."Average Qty. In Pack" := recPostedLotTracking.Quantity / recPostedLotTracking."Qty. In Packs";
                recPostedLotTracking."Document No." := NewItemLedgEntry."Document No.";
                recPostedLotTracking."Document Line No." := NewItemLedgEntry."Document Line No.";
                recPostedLotTracking."Location Code" := recPurchaseSetup."OK Store Location";
                recPostedLotTracking."Tare Weight" := 0;
                recPostedLotTracking."Remaining Qty." := NewItemLedgEntry.Quantity;
                recPostedLotTracking."Moisture (%)" := NewItemLedgEntry."Moisture (%)";
                recPostedLotTracking."Color (MM)" := NewItemLedgEntry."Color (MM)";
                recPostedLotTracking."HMF (PPM)" := NewItemLedgEntry."HMF (PPM)";
                recPostedLotTracking.TRS := NewItemLedgEntry.TRS;
                recPostedLotTracking.Sucrose := NewItemLedgEntry.Sucrose;
                recPostedLotTracking.FG := NewItemLedgEntry.FG;
                recPostedLotTracking.Positive := TRUE;
                recPostedLotTracking."Ref. Entry No." := intEntryNo;
                recPostedLotTracking."Stock Type" := recPostedLotTracking."Stock Type"::"Sales Return";
                recPostedLotTracking."Posting Date" := NewItemLedgEntry."Posting Date";
                recPostedLotTracking.INSERT;
            END;
        END;
        //RM Lot Tracking

        IF (NewItemLedgEntry."Entry Type" = NewItemLedgEntry."Entry Type"::Consumption) THEN BEGIN
            recPostedLotTracking.RESET;
            IF recPostedLotTracking.FINDLAST THEN
                intEntryNo := recPostedLotTracking."Entry No."
            ELSE
                intEntryNo := 0;

            recLotTracking.RESET;
            recLotTracking.SETCURRENTKEY("Document No.", "Document Line No.", "Item No.", "Lot No.");
            recLotTracking.SETRANGE("Document Type", recLotTracking."Document Type"::Consumption);
            recLotTracking.SETRANGE("Document No.", NewItemLedgEntry."Document No.");
            recLotTracking.SETRANGE("Document Line No.", NewItemLedgEntry."Order Line No.");
            recLotTracking.SETRANGE("Item No.", NewItemLedgEntry."Item No.");
            recLotTracking.SETRANGE("Lot No.", NewItemLedgEntry."Lot No.");
            IF recLotTracking.FINDFIRST THEN
                REPEAT
                    recSourceLotEntry.GET(recLotTracking."Ref. Entry No.");
                    recSourceLotEntry."Remaining Qty." := recSourceLotEntry."Remaining Qty." - recLotTracking.Quantity;
                    recSourceLotEntry.MODIFY;

                    recPostedLotTracking.INIT;
                    intEntryNo += 1;
                    recPostedLotTracking."Entry No." := intEntryNo;
                    recPostedLotTracking."Item No." := recLotTracking."Item No.";
                    recPostedLotTracking."Lot No." := recLotTracking."Lot No.";
                    recPostedLotTracking.Flora := recLotTracking.Flora;
                    recPostedLotTracking."Packing Type" := recLotTracking."Packing Type";
                    recPostedLotTracking."Qty. In Packs" := -recLotTracking."Qty. In Packs";
                    recPostedLotTracking.Quantity := -recLotTracking.Quantity;
                    recPostedLotTracking."Average Qty. In Pack" := recLotTracking."Average Qty. In Pack";
                    recPostedLotTracking."Document No." := recLotTracking."Document No.";
                    recPostedLotTracking."Document Line No." := recLotTracking."Document Line No.";
                    recPostedLotTracking."Location Code" := recLotTracking."Location Code";
                    recPostedLotTracking."Remaining Qty." := 0;
                    recPostedLotTracking."Moisture (%)" := recSourceLotEntry."Moisture (%)";
                    recPostedLotTracking."Color (MM)" := recSourceLotEntry."Color (MM)";
                    recPostedLotTracking."HMF (PPM)" := recSourceLotEntry."HMF (PPM)";
                    recPostedLotTracking.TRS := recSourceLotEntry.TRS;
                    recPostedLotTracking.Sucrose := recSourceLotEntry.Sucrose;
                    recPostedLotTracking.FG := recSourceLotEntry.FG;
                    recPostedLotTracking.Positive := FALSE;
                    recPostedLotTracking."Ref. Entry No." := recSourceLotEntry."Entry No.";
                    recPostedLotTracking."Posting Date" := NewItemLedgEntry."Posting Date";
                    recPostedLotTracking.INSERT;

                    recLotTracking.DELETE;
                UNTIL recLotTracking.NEXT = 0;
        END ELSE
            IF (NewItemLedgEntry."Entry Type" = NewItemLedgEntry."Entry Type"::Transfer) AND (NewItemLedgEntry."Order No." = '') THEN BEGIN
                recPostedLotTracking.RESET;
                IF recPostedLotTracking.FINDLAST THEN
                    intEntryNo := recPostedLotTracking."Entry No."
                ELSE
                    intEntryNo := 0;

                recLotTracking.RESET;
                recLotTracking.SETCURRENTKEY("Document No.", "Document Line No.", "Item No.", "Lot No.");
                recLotTracking.SETRANGE("Document Type", recLotTracking."Document Type"::Transfer);
                recLotTracking.SETRANGE("Document No.", NewItemLedgEntry."Document No.");
                //recLotTracking.SETRANGE("Document Line No.", NewItemLedgEntry."Order Line No.");
                recLotTracking.SETRANGE("Item No.", NewItemLedgEntry."Item No.");
                recLotTracking.SETRANGE("Lot No.", NewItemLedgEntry."Lot No.");
                IF recLotTracking.FINDFIRST THEN
                    REPEAT
                        recSourceLotEntry.GET(recLotTracking."Ref. Entry No.");
                        recSourceLotEntry."Remaining Qty." := recSourceLotEntry."Remaining Qty." - recLotTracking.Quantity;
                        recSourceLotEntry.MODIFY;

                        recPostedLotTracking.INIT;
                        intEntryNo += 1;
                        recPostedLotTracking."Entry No." := intEntryNo;
                        recPostedLotTracking."Item No." := recLotTracking."Item No.";
                        recPostedLotTracking."Lot No." := recLotTracking."Lot No.";
                        recPostedLotTracking.Flora := recLotTracking.Flora;
                        recPostedLotTracking."Packing Type" := recLotTracking."Packing Type";
                        recPostedLotTracking."Qty. In Packs" := -recLotTracking."Qty. In Packs";
                        recPostedLotTracking.Quantity := -recLotTracking.Quantity;
                        recPostedLotTracking."Average Qty. In Pack" := recLotTracking."Average Qty. In Pack";
                        recPostedLotTracking."Document No." := recLotTracking."Document No.";
                        recPostedLotTracking."Document Line No." := recLotTracking."Document Line No.";
                        recPostedLotTracking."Location Code" := recLotTracking."Location Code";
                        recPostedLotTracking."Remaining Qty." := 0;
                        recPostedLotTracking."Moisture (%)" := recSourceLotEntry."Moisture (%)";
                        recPostedLotTracking."Color (MM)" := recSourceLotEntry."Color (MM)";
                        recPostedLotTracking."HMF (PPM)" := recSourceLotEntry."HMF (PPM)";
                        recPostedLotTracking.TRS := recSourceLotEntry.TRS;
                        recPostedLotTracking.Sucrose := recSourceLotEntry.Sucrose;
                        recPostedLotTracking.FG := recSourceLotEntry.FG;
                        recPostedLotTracking.Positive := FALSE;
                        recPostedLotTracking."Ref. Entry No." := recSourceLotEntry."Entry No.";
                        recPostedLotTracking."Posting Date" := NewItemLedgEntry."Posting Date";
                        recPostedLotTracking.INSERT;

                        recPostedLotTracking.INIT;
                        intEntryNo += 1;
                        recPostedLotTracking."Entry No." := intEntryNo;
                        recPostedLotTracking."Item No." := recLotTracking."Item No.";
                        recPostedLotTracking."Lot No." := recLotTracking."Lot No.";
                        recPostedLotTracking.Flora := recLotTracking.Flora;
                        recPostedLotTracking."Packing Type" := recLotTracking."Packing Type";
                        recPostedLotTracking."Qty. In Packs" := recLotTracking."Qty. In Packs";
                        recPostedLotTracking.Quantity := recLotTracking.Quantity;
                        recPostedLotTracking."Average Qty. In Pack" := recLotTracking."Average Qty. In Pack";
                        recPostedLotTracking."Document No." := recLotTracking."Document No.";
                        recPostedLotTracking."Document Line No." := recLotTracking."Document Line No.";
                        recPostedLotTracking."Location Code" := ItemJournalLine."New Location Code";
                        recPostedLotTracking."Remaining Qty." := recLotTracking.Quantity;
                        recPostedLotTracking."Moisture (%)" := recSourceLotEntry."Moisture (%)";
                        recPostedLotTracking."Color (MM)" := recSourceLotEntry."Color (MM)";
                        recPostedLotTracking."HMF (PPM)" := recSourceLotEntry."HMF (PPM)";
                        recPostedLotTracking.TRS := recSourceLotEntry.TRS;
                        recPostedLotTracking.Sucrose := recSourceLotEntry.Sucrose;
                        recPostedLotTracking.FG := recSourceLotEntry.FG;
                        recPostedLotTracking.Positive := TRUE;
                        recPostedLotTracking."Ref. Entry No." := intEntryNo;
                        recPostedLotTracking."Posting Date" := NewItemLedgEntry."Posting Date";
                        recPostedLotTracking.INSERT;

                        recLotTracking.DELETE;
                    UNTIL recLotTracking.NEXT = 0;
            END;

        NewItemLedgEntry."Output for Customer" := ItemJournalLine."Output for Customer";

        //Iappc - 16 Jan 16 - Deals Details Begin
        NewItemLedgEntry."Deal No." := ItemJournalLine."Deal No.";
        NewItemLedgEntry."Deal Line No." := ItemJournalLine."Deal Line No.";
        NewItemLedgEntry."Dispatched Qty. in Kg." := ItemJournalLine."Dispatched Qty. in Kg.";
        NewItemLedgEntry.Flora := ItemJournalLine.Flora;
        NewItemLedgEntry."Moisture (%)" := ItemJournalLine."Moisture (%)";
        NewItemLedgEntry."Color (MM)" := ItemJournalLine."Color (MM)";
        NewItemLedgEntry."HMF (PPM)" := ItemJournalLine."HMF (PPM)";
        NewItemLedgEntry.TRS := ItemJournalLine.TRS;
        NewItemLedgEntry.Sucrose := ItemJournalLine.Sucrose;
        NewItemLedgEntry.FG := ItemJournalLine.FG;
        NewItemLedgEntry."Vehicle No." := ItemJournalLine."Vehicle No.";
        NewItemLedgEntry."Purchaser Code" := ItemJournalLine."Purchaser Code";
        NewItemLedgEntry."Purchaser Name" := ItemJournalLine."Purchaser Name";
        //Iappc - 16 Jan 16 - Deals Details End
        //<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure OnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempItemJournalLine: Record "Item Journal Line" temporary; var PostItemJnlLine: Boolean; var ItemJournalLine2: Record "Item Journal Line"; SignFactor: Integer; FloatingFactor: Decimal)
    begin
        TempItemJournalLine."MRP Price" := TempTrackingSpecification."MRP Price";
        TempItemJournalLine."MFG. Date" := TempTrackingSpecification."MFG. Date";
        TempItemJournalLine.Tin := TempTrackingSpecification.Tin;
        TempItemJournalLine.Drum := TempTrackingSpecification.Drum;
        TempItemJournalLine.Bucket := TempTrackingSpecification.Bucket;
        TempItemJournalLine.Can := TempTrackingSpecification.Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertTransferEntryOnTransferValues', '', false, false)]
    local procedure OnInsertTransferEntryOnTransferValues(var NewItemLedgerEntry: Record "Item Ledger Entry"; OldItemLedgerEntry: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var TempItemEntryRelation: Record "Item Entry Relation"; var IsHandled: Boolean)
    begin
        IF NewItemLedgerEntry.Quantity < 0 THEN
            NewItemLedgerEntry."Qty. in Pack" := -ABS(NewItemLedgerEntry."Qty. in Pack")
        ELSE
            NewItemLedgerEntry."Qty. in Pack" := ABS(NewItemLedgerEntry."Qty. in Pack");
    end;



    // Codeunit22 End

    //Codeunit23

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnAfterPostJnlLines', '', false, false)]
    local procedure OnAfterPostJnlLines(var ItemJournalBatch: Record "Item Journal Batch"; var ItemJournalLine: Record "Item Journal Line"; ItemRegNo: Integer; WhseRegNo: Integer; var WindowIsOpen: Boolean)
    var
        recItemJournal: Record "Item Journal Line";
        InvtSetup: Record "Inventory Setup";
    begin
        recItemJournal.RESET;
        recItemJournal.SETRANGE("Journal Template Name", InvtSetup."Auto Item Journal Template");
        recItemJournal.SETRANGE("Journal Batch Name", InvtSetup."Auto Item Journal Batch");
        recItemJournal.SETRANGE("ByProduct Entry", TRUE);
        IF recItemJournal.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", recItemJournal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnPostLinesOnBeforePostLine', '', false, false)]
    local procedure OnPostLinesOnBeforePostLine(var ItemJournalLine: Record "Item Journal Line"; var SuppressCommit: Boolean; var WindowIsOpen: Boolean)
    var
        recUserSetup: Record "User Setup";
        TempTrackingSpecification: Record "Tracking Specification";
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
        recConsumptionDetails: Record "Job WIP Entry";
        recBatchProcessLines: Record "Batch Process Line";
        recReservationEntry: Record "Reservation Entry";
        intLineNo: Integer;
    begin
        recUserSetup.GET(USERID);
        //Scrap Generation Process
        IF (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output) AND (ItemJournalLine."ByProduct Item Code" <> '') AND
                                                                             (ItemJournalLine."ByProduct Qty." <> 0) AND (recUserSetup."Post ByProduct Entry" = TRUE) THEN
            GenerateScrapEntry(ItemJournalLine."Document No.", ItemJournalLine."Posting Date", ItemJournalLine."ByProduct Item Code", ItemJournalLine."Location Code", ItemJournalLine."Shortcut Dimension 1 Code",
                               ItemJournalLine."Shortcut Dimension 2 Code", ItemJournalLine."Dimension Set ID", ItemJournalLine."ByProduct Qty.", ItemJournalLine."Order Line No.", ItemJournalLine."No.");
        //Scrap Generation Process

        //Plan Weight Register Begin
        IF (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption) THEN BEGIN
            //Consumption Details Begin
            recConsumptionDetails.RESET;
            recConsumptionDetails.SETRANGE(Template, ItemJournalLine."Journal Template Name");
            recConsumptionDetails.SETRANGE(Batch, ItemJournalLine."Journal Batch Name");
            recConsumptionDetails.SETRANGE("Line No.", ItemJournalLine."Line No.");
            IF recConsumptionDetails.FINDFIRST THEN begin
                REPEAT
                    recConsumptionDetails."Document No." := ItemJournalLine."Document No.";
                    recConsumptionDetails.MODIFY;
                UNTIL recConsumptionDetails.NEXT = 0;
            end;
            //Consumption Details End

            recBatchProcessLines.RESET;
            recBatchProcessLines.SETRANGE(Type, recBatchProcessLines.Type::"Weighing Register");
            recBatchProcessLines.SETRANGE("Document No.", ItemJournalLine."Document No.");
            IF recBatchProcessLines.FINDLAST THEN
                intLineNo := recBatchProcessLines."Line No."
            ELSE
                intLineNo := 0;

            recReservationEntry.RESET;
            recReservationEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
            recReservationEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
            recReservationEntry.SETRANGE("Source Type", 83);
            recReservationEntry.SETRANGE("Source Subtype", 5);
            recReservationEntry.SETRANGE("Source ID", ItemJournalLine."Journal Template Name");
            recReservationEntry.SETRANGE("Source Batch Name", ItemJournalLine."Journal Batch Name");
            recReservationEntry.SETRANGE("Source Ref. No.", ItemJournalLine."Line No.");
            IF recReservationEntry.FINDFIRST THEN
                REPEAT
                    recBatchProcessLines.RESET;
                    recBatchProcessLines.SETRANGE(Type, recBatchProcessLines.Type::"Weighing Register");
                    recBatchProcessLines.SETRANGE("Document No.", ItemJournalLine."Document No.");
                    recBatchProcessLines.SETRANGE("Lot No.", recReservationEntry."Lot No.");
                    IF recBatchProcessLines.FINDFIRST THEN BEGIN
                        recBatchProcessLines."Tare Weight" += recReservationEntry."Tare Weight";
                        recBatchProcessLines."Nett Weight" += ABS(recReservationEntry."Quantity (Base)");
                        recBatchProcessLines."Gross Weight" := recBatchProcessLines."Tare Weight" + recBatchProcessLines."Nett Weight";
                        recBatchProcessLines.MODIFY;
                    END ELSE BEGIN
                        recBatchProcessLines.INIT;
                        recBatchProcessLines.Type := recBatchProcessLines.Type::"Weighing Register";
                        recBatchProcessLines."Document No." := ItemJournalLine."Document No.";
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
        //Plan Weight Register End
    end;



    local procedure GenerateScrapEntry(DocumentNo: Code[20]; PostingDate: Date; ScrapItem: Code[20]; ScrapLocation: Code[20]; GD1: Code[20]; GD2: Code[20]; DimSetID: Integer; ScrapQty: Decimal; ProdOrderLineNo: Integer; MachineCenterNo: Code[20])
    var
        recShipmentLines: Record "Sales Shipment Line";
        recItemJournal: Record "Item Journal Line";
        intLineNo: Integer;
        InvtSetup: Record "Inventory Setup";
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
    //Codeunit23

    // Codeunit90 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvLineInsert', '', false, false)]
    local procedure OnAfterPurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSupressed: Boolean; PurchHeader: Record "Purchase Header"; PurchRcptHeader: Record "Purch. Rcpt. Header"; TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        BeekeeperLedgerEntries: Record "BeeKeeper VendorLedger Entries";
        BeekeeperEntryNo: Integer;
    begin
        //Iappc - 20 Mar 15 - Purchase Report Update end

        //Iappc - 23 Jan 16 - Beekeeper Accounting Begin
        IF (PurchInvLine."Deal No." <> '') THEN BEGIN
            BeekeeperLedgerEntries.RESET;
            IF BeekeeperLedgerEntries.FINDLAST THEN
                BeekeeperEntryNo := BeekeeperLedgerEntries."Entry No."
            ELSE
                BeekeeperEntryNo := 0;

            BeekeeperLedgerEntries.INIT;
            BeekeeperEntryNo += 1;
            BeekeeperLedgerEntries."Entry No." := BeekeeperEntryNo;
            BeekeeperLedgerEntries."Vendor Code" := PurchInvHeader."Buy-from Vendor No.";
            BeekeeperLedgerEntries."Beekeeper Code" := PurchInvLine."Purchaser Code";
            BeekeeperLedgerEntries."Document No." := PurchInvLine."Document No.";
            BeekeeperLedgerEntries."Document Line No." := PurchInvLine."Line No.";
            BeekeeperLedgerEntries."Document Date" := PurchInvLine."Posting Date";
            BeekeeperLedgerEntries."External Document No." := PurchInvHeader."Vendor Invoice No.";
            BeekeeperLedgerEntries."Deal No." := PurchInvLine."Deal No.";
            BeekeeperLedgerEntries."Deal Dispatch No." := PurchInvLine."Deal Line No.";
            BeekeeperLedgerEntries.Flora := PurchInvLine.Flora;
            BeekeeperLedgerEntries."Dispatched Qty." := PurchInvLine."Qty. in Pack";
            BeekeeperLedgerEntries."Packing Type" := PurchInvLine."Packing Type";
            BeekeeperLedgerEntries."Vehicle No." := '';
            BeekeeperLedgerEntries."Qty. in Kg." := PurchInvLine."Dispatched Qty. in Kg.";
            BeekeeperLedgerEntries."Invoiced Qty." := PurchInvLine.Quantity;
            BeekeeperLedgerEntries."Unit Rate" := PurchInvLine."Unit Rate";
            BeekeeperLedgerEntries.Discount := PurchInvLine."Other Charges";
            BeekeeperLedgerEntries."Line Amount" := PurchInvLine."Line Amount";
            BeekeeperLedgerEntries."User Id" := USERID;
            BeekeeperLedgerEntries."Debit Amount" := 0;
            IF PurchInvLine."Dispatched Qty. in Kg." < PurchInvLine.Quantity THEN
                BeekeeperLedgerEntries."Credit Amount" := PurchInvLine."Dispatched Qty. in Kg." * (PurchInvLine."Unit Rate" - PurchInvLine."Other Charges")
            ELSE
                BeekeeperLedgerEntries."Credit Amount" := PurchInvLine.Quantity * (PurchInvLine."Unit Rate" - PurchInvLine."Other Charges");
            BeekeeperLedgerEntries.Amount := -BeekeeperLedgerEntries."Credit Amount";
            BeekeeperLedgerEntries.INSERT;
        END;
        //Iappc - 23 Jan 16 - Beekeeper Accounting End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchCrMemoLineInsert', '', false, false)]
    local procedure OnAfterPurchCrMemoLineInsert(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        BeekeeperLedgerEntries: Record "BeeKeeper VendorLedger Entries";
        BeekeeperEntryNo: Integer;
    begin

        //Iappc - 20 Mar 15 - Purchase Report Update begin

        //Iappc - 23 Jan 16 - Beekeeper Accounting Begin
        IF (PurchCrMemoLine."Deal No." <> '') THEN BEGIN
            BeekeeperLedgerEntries.RESET;
            IF BeekeeperLedgerEntries.FINDLAST THEN
                BeekeeperEntryNo := BeekeeperLedgerEntries."Entry No."
            ELSE
                BeekeeperEntryNo := 0;

            BeekeeperLedgerEntries.INIT;
            BeekeeperEntryNo += 1;
            BeekeeperLedgerEntries."Entry No." := BeekeeperEntryNo;
            BeekeeperLedgerEntries."Vendor Code" := PurchCrMemoHdr."Buy-from Vendor No.";
            BeekeeperLedgerEntries."Beekeeper Code" := PurchCrMemoLine."Purchaser Code";
            BeekeeperLedgerEntries."Document No." := PurchCrMemoLine."Document No.";
            BeekeeperLedgerEntries."Document Line No." := PurchCrMemoLine."Line No.";
            BeekeeperLedgerEntries."Document Date" := PurchCrMemoLine."Posting Date";
            BeekeeperLedgerEntries."External Document No." := PurchCrMemoHdr."Vendor Cr. Memo No.";
            BeekeeperLedgerEntries."Deal No." := PurchCrMemoLine."Deal No.";
            BeekeeperLedgerEntries."Deal Dispatch No." := PurchCrMemoLine."Deal Line No.";
            BeekeeperLedgerEntries.Flora := PurchCrMemoLine.Flora;
            BeekeeperLedgerEntries."Dispatched Qty." := PurchCrMemoLine."Qty. in Pack";
            BeekeeperLedgerEntries."Packing Type" := PurchCrMemoLine."Packing Type";
            BeekeeperLedgerEntries."Vehicle No." := '';
            BeekeeperLedgerEntries."Qty. in Kg." := PurchCrMemoLine."Dispatched Qty. in Kg.";
            BeekeeperLedgerEntries."Invoiced Qty." := PurchCrMemoLine.Quantity;
            BeekeeperLedgerEntries."Unit Rate" := PurchCrMemoLine."Unit Rate";
            BeekeeperLedgerEntries.Discount := PurchCrMemoLine."Other Charges";
            BeekeeperLedgerEntries."Line Amount" := PurchCrMemoLine."Line Amount";
            BeekeeperLedgerEntries."User Id" := USERID;
            BeekeeperLedgerEntries."Debit Amount" := PurchCrMemoLine.Quantity * (PurchCrMemoLine."Unit Rate" - PurchCrMemoLine."Other Charges");
            BeekeeperLedgerEntries."Credit Amount" := 0;
            BeekeeperLedgerEntries.Amount := BeekeeperLedgerEntries."Debit Amount";
            BeekeeperLedgerEntries.INSERT;
        END;
        //Iappc - 23 Jan 16 - Beekeeper Accounting End
    end;

    // Codeunit90 End

    // Codeunit91 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost_Purch(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    var
        Rec_PurchLine: Record "Purchase Line";
    begin
        //Iappc - GAN Validation Begin
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND (PurchaseHeader."Order Type" = PurchaseHeader."Order Type"::Honey) THEN BEGIN
            Rec_PurchLine.RESET;
            Rec_PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            Rec_PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            IF Rec_PurchLine.FINDFIRST THEN
                REPEAT
                    Rec_PurchLine.TESTFIELD(Type, Rec_PurchLine.Type::Item);
                    Rec_PurchLine.TESTFIELD("No.");
                    Rec_PurchLine.TESTFIELD("Location Code");
                    Rec_PurchLine.TESTFIELD(Quantity);
                    Rec_PurchLine.TESTFIELD("Deal No.");
                    Rec_PurchLine.TESTFIELD("Packing Type");
                    Rec_PurchLine.TESTFIELD("Qty. in Pack");
                UNTIL Rec_PurchLine.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure OnAfterConfirmPost(var PurchaseHeader: Record "Purchase Header")
    var
        Rec_UserSetup: Record "User Setup";
        Rec_PurchLine: Record "Purchase Line";
        Rec_PurchaseSetup: Record "Purchases & Payables Setup";
        Rec_DealDispatch: Record "Deal Dispatch Details";
        Rec_DealCard: Record "Deal Master";
    begin
        Rec_UserSetup.GET(USERID);
        IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] THEN BEGIN
            IF NOT Rec_UserSetup."Allow Purchase Invoice" THEN
                ERROR('You are not authorise to post invoice.');
        END ELSE BEGIN
            IF (PurchaseHeader.Receive) AND (NOT Rec_UserSetup."Allow Receipt") THEN
                ERROR('You are not authorise to post receipt.');
            IF (PurchaseHeader.Invoice) AND (NOT Rec_UserSetup."Allow Purchase Invoice") THEN
                ERROR('You are not authorise to post invoice.');
        END;
        //Iappc - 12 Jan 16 - Honey Price Validation Begin
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) THEN BEGIN//AND (PurchHeader."Order Type" = PurchHeader."Order Type"::Honey) THEN BEGIN
            Rec_PurchaseSetup.GET;
            Rec_PurchaseSetup.TESTFIELD("Raw Honey Item");

            Rec_PurchLine.RESET;
            Rec_PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            Rec_PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            Rec_PurchLine.SETRANGE(Type, Rec_PurchLine.Type::Item);
            Rec_PurchLine.SETFILTER("No.", '%1', Rec_PurchaseSetup."Raw Honey Item");
            IF Rec_PurchLine.FINDFIRST THEN
                REPEAT
                    Rec_DealDispatch.RESET;
                    Rec_DealDispatch.SETRANGE("Sauda No.", Rec_PurchLine."Deal No.");
                    Rec_DealDispatch.SETRANGE("Line No.", Rec_PurchLine."Deal Line No.");
                    Rec_DealDispatch.FINDFIRST;

                    Rec_DealCard.GET(Rec_PurchLine."Deal No.");

                    IF Rec_PurchLine.Quantity <= Rec_DealDispatch."Qty. in Kg." THEN BEGIN
                        IF Rec_PurchLine."Line Amount" <> (Rec_PurchLine.Quantity * Rec_DealCard."Unit Rate in Kg.") THEN
                            ERROR('Line amount must be %1 for line no. %2', (Rec_PurchLine.Quantity * Rec_DealCard."Unit Rate in Kg."), Rec_PurchLine."Line No.");
                    END ELSE BEGIN
                        IF Rec_PurchLine."Line Amount" <> (Rec_DealDispatch."Qty. in Kg." * Rec_DealCard."Unit Rate in Kg.") THEN
                            ERROR('Line amount must be %1 for line no. %2', (Rec_DealDispatch."Qty. in Kg." * Rec_DealCard."Unit Rate in Kg."), Rec_PurchLine."Line No.");
                    END;
                UNTIL Rec_PurchLine.NEXT = 0;
        END;
        //Iappc - 12 Jan 16 - Honey Price Validation End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure OnBeforeSelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        Selection: Integer;
    begin
        IsHandled := true;
        //Selection := StrMenu(ReceiveInvoiceOptionsQst, DefaultOption);
        Selection := 1;
        if Selection = 0 then
            Result := false;
        PurchaseHeader.Receive := Selection in [1, 3];
        if Selection <> 0 then
            Result := true;
    end;

    // Codeunit91 End


    //Codeunit241

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        recUserSetup: Record "User Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        TempJnlBatchName: Code[10];
        recItemJournal: Record "Item Journal Line";
        recProdOrderComponent: Record "Prod. Order Component";
        decOutputQty: Decimal;
        blnFirstLine: Boolean;
        recProdOrderLine: Record "Prod. Order Line";
        recProductionOrder: Record "Production Order";
        recReservationEntry: Record "Reservation Entry";
        intEntryNo: Integer;
        recLotTracking: Record "Tran. Lot Tracking";
        decTotalQty: Decimal;

    begin
        //User Permission Management
        recUserSetup.GET(USERID);
        IF NOT recUserSetup."Allow Item Journal Posting" THEN
            ERROR('You are not authorized to post item journal voucher.');
        // - User Permission Management

        //Iappc - Output Validation begin
        recItemJournal.COPY(ItemJournalLine);
        IF recItemJournal.FINDFIRST THEN
            REPEAT
                IF recItemJournal."Entry Type" = recItemJournal."Entry Type"::Output THEN BEGIN
                    recProdOrderComponent.RESET;
                    recProdOrderComponent.SETRANGE(Status, recProdOrderComponent.Status::Released);
                    recProdOrderComponent.SETRANGE("Prod. Order No.", recItemJournal."Order No.");
                    recProdOrderComponent.SETRANGE("Prod. Order Line No.", recItemJournal."Order Line No.");
                    IF recProdOrderComponent.FINDFIRST THEN BEGIN
                        decOutputQty := 0;
                        blnFirstLine := FALSE;
                        REPEAT
                            recProdOrderComponent.CALCFIELDS("Consumed Qty.");
                            recProductionOrder.GET(recProdOrderComponent.Status, recProdOrderComponent."Prod. Order No.");
                            IF recProductionOrder."Order Type" = recProductionOrder."Order Type"::Packing THEN BEGIN
                                IF NOT blnFirstLine THEN
                                    decOutputQty := ROUND(recProdOrderComponent."Consumed Qty." / recProdOrderComponent."Quantity per", 0.01)
                                ELSE
                                    IF decOutputQty > ROUND(recProdOrderComponent."Consumed Qty." / recProdOrderComponent."Quantity per", 0.01) THEN
                                        decOutputQty := ROUND(recProdOrderComponent."Consumed Qty." / recProdOrderComponent."Quantity per", 0.01);

                            END ELSE BEGIN
                                decOutputQty += ROUND(recProdOrderComponent."Consumed Qty." / recProdOrderComponent."Quantity per", 0.01);
                            END;

                            blnFirstLine := TRUE;
                        UNTIL recProdOrderComponent.NEXT = 0;
                    END ELSE
                        ERROR('There is no component lines for the production order.');

                    recProdOrderLine.GET(recProdOrderLine.Status::Released, recItemJournal."Order No.", recItemJournal."Order Line No.");
                    decOutputQty := decOutputQty - recProdOrderLine."Finished Quantity";
                    IF recItemJournal."Output Quantity" > decOutputQty THEN
                        ERROR('Can not post more than %1 output, due to consumption shortage.', decOutputQty);
                END ELSE
                    IF recItemJournal."Entry Type" = recItemJournal."Entry Type"::Transfer THEN BEGIN
                        recItemJournal.TESTFIELD("Item No.");
                        recItemJournal.TESTFIELD(Quantity);

                        recReservationEntry.RESET;
                        IF recReservationEntry.FINDLAST THEN
                            intEntryNo := recReservationEntry."Entry No."
                        ELSE
                            intEntryNo := 0;

                        decTotalQty := recItemJournal.Quantity;
                        recLotTracking.RESET;
                        recLotTracking.SETRANGE("Document No.", recItemJournal."Document No.");
                        recLotTracking.SETRANGE("Document Line No.", recItemJournal."Line No.");
                        recLotTracking.SETRANGE("Item No.", recItemJournal."Item No.");
                        IF recLotTracking.FINDFIRST THEN BEGIN
                            recReservationEntry.RESET;
                            recReservationEntry.SETRANGE("Source Type", 83);
                            recReservationEntry.SETRANGE("Source Subtype", 4);
                            recReservationEntry.SETRANGE("Source ID", recItemJournal."Journal Template Name");
                            recReservationEntry.SETRANGE("Source Batch Name", recItemJournal."Journal Batch Name");
                            recReservationEntry.SETRANGE("Source Ref. No.", recItemJournal."Line No.");
                            recReservationEntry.SETRANGE("Lot No.", recLotTracking."Lot No.");
                            IF recReservationEntry.FINDFIRST THEN
                                recReservationEntry.DELETEALL;

                            REPEAT
                                decTotalQty := decTotalQty - recLotTracking.Quantity;
                                recReservationEntry.INIT;
                                intEntryNo += 1;
                                recReservationEntry."Entry No." := intEntryNo;
                                recReservationEntry.Positive := FALSE;
                                recReservationEntry."Item No." := recItemJournal."Item No.";
                                recReservationEntry."Location Code" := recItemJournal."Location Code";
                                recReservationEntry.VALIDATE("Quantity (Base)", -recLotTracking.Quantity);
                                recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                                recReservationEntry."Creation Date" := TODAY;
                                recReservationEntry."Source Type" := 83;
                                recReservationEntry."Source Subtype" := 4;
                                recReservationEntry."Source ID" := recItemJournal."Journal Template Name";
                                recReservationEntry."Source Batch Name" := recItemJournal."Journal Batch Name";
                                recReservationEntry."Source Ref. No." := recItemJournal."Line No.";
                                //recReservationEntry."Appl.-to Item Entry" := recItemLedger."Entry No.";
                                recReservationEntry."Lot No." := recLotTracking."Lot No.";
                                recReservationEntry."New Lot No." := recLotTracking."Lot No.";
                                recReservationEntry."New Expiration Date" := TODAY;
                                recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                                recReservationEntry."Created By" := USERID;
                                recReservationEntry."Qty. per Unit of Measure" := 1;
                                recReservationEntry.Binding := recReservationEntry.Binding::" ";
                                recReservationEntry."Suppressed Action Msg." := FALSE;
                                recReservationEntry."Planning Flexibility" := recReservationEntry."Planning Flexibility"::Unlimited;
                                recReservationEntry."Quantity Invoiced (Base)" := 0;
                                recReservationEntry.Correction := FALSE;
                                recReservationEntry.INSERT;
                            UNTIL recLotTracking.NEXT = 0;
                            IF decTotalQty <> 0 THEN
                                ERROR('In-sufficient lot tracking defined for item no. %1', recItemJournal."Item No.");
                        END;
                        //Create ItemTracking
                    END;
            UNTIL recItemJournal.NEXT = 0;
        //Output Validation End

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnCodeOnAfterItemJnlPostBatchRun', '', false, false)]
    local procedure OnCodeOnAfterItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; SuppressCommit: Boolean)
    var
        recItemLedger: Record "Item Ledger Entry";
        intEntryNoToStart: Integer;
        intNoEntryNoManage: Integer;
        recItemApplication: Record "Item Application Entry";
        recSourceItemLedger: Record "Item Ledger Entry";
        decQtyInPack: Decimal;
    begin

        intNoEntryNoManage := 20;

        recItemLedger.RESET;
        IF recItemLedger.FINDLAST THEN BEGIN
            intEntryNoToStart := recItemLedger."Entry No." - intNoEntryNoManage;

            recItemLedger.RESET;
            recItemLedger.SETRANGE("Entry No.", intEntryNoToStart, intEntryNoToStart + intNoEntryNoManage);
            recItemLedger.FINDFIRST;
            REPEAT
                IF (recItemLedger."Packing Type" = 0) AND (recItemLedger."Entry Type" = recItemLedger."Entry Type"::Transfer) AND (recItemLedger."Order No." = '') THEN BEGIN
                    IF recItemLedger.Positive THEN BEGIN
                        recItemApplication.RESET;
                        recItemApplication.SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
                        recItemApplication.SETRANGE("Inbound Item Entry No.", recItemLedger."Entry No.");
                        recItemApplication.SETRANGE("Item Ledger Entry No.", recItemLedger."Entry No.");
                        recItemApplication.FINDFIRST;
                        recSourceItemLedger.GET(recItemApplication."Transferred-from Entry No.");
                        recItemLedger."Packing Type" := recSourceItemLedger."Packing Type";

                        decQtyInPack := ROUND(recSourceItemLedger."Qty. in Pack" / recSourceItemLedger.Quantity * recItemLedger.Quantity, 1);
                        recItemLedger."Qty. in Pack" := ABS(decQtyInPack);

                        recItemLedger.Flora := recSourceItemLedger.Flora;
                        recItemLedger."Tare Weight" := recSourceItemLedger."Tare Weight";
                        recItemLedger.MODIFY;
                    END ELSE BEGIN
                        recItemApplication.RESET;
                        recItemApplication.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
                        recItemApplication.SETRANGE("Outbound Item Entry No.", recItemLedger."Entry No.");
                        recItemApplication.SETRANGE("Item Ledger Entry No.", recItemLedger."Entry No.");
                        recItemApplication.FINDFIRST;
                        recSourceItemLedger.GET(recItemApplication."Inbound Item Entry No.");
                        recItemLedger."Packing Type" := recSourceItemLedger."Packing Type";

                        decQtyInPack := ROUND(recSourceItemLedger."Qty. in Pack" / recSourceItemLedger.Quantity * recItemLedger.Quantity, 1);
                        recItemLedger."Qty. in Pack" := -ABS(decQtyInPack);

                        recItemLedger.Flora := recSourceItemLedger.Flora;
                        recItemLedger."Tare Weight" := recSourceItemLedger."Tare Weight";
                        recItemLedger.MODIFY;
                    END;
                END;
            UNTIL recItemLedger.NEXT = 0;
        END;
    end;
    //Codeunit241

    //Codeunit5407

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnAfterChangeStatusOnProdOrder', '', false, false)]
    local procedure OnAfterChangeStatusOnProdOrder(var ProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; NewPostingDate: Date; NewUpdateUnitCost: Boolean; var SuppressCommit: Boolean)
    var
        recTranLotEntry: Record "Tran. Lot Tracking";
    begin
        //Unposted Lot Entry Deleteion
        recTranLotEntry.RESET;
        recTranLotEntry.SETRANGE("Document No.", ProdOrder."No.");
        recTranLotEntry.SETRANGE("Document Type", recTranLotEntry."Document Type"::Consumption);
        IF recTranLotEntry.FINDFIRST THEN
            recTranLotEntry.DELETEALL;
        //Unposted Lot Entry Deleteion
    end;
    //Codeunit5407

    //Codeunit6501

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterAssistEditTrackingNo', '', false, false)]
    local procedure OnAfterAssistEditTrackingNo_(var TrackingSpecification: Record "Tracking Specification"; var TempGlobalEntrySummary: Record "Entry Summary" temporary; CurrentSignFactor: Integer; MaxQuantity: Decimal; var TempGlobalReservationEntry: Record "Reservation Entry" temporary; LookupMode: Enum "Item Tracking Type")
    var
        recItemLedger: Record "Item Ledger Entry";
    begin

        //Packing Update Begin
        recItemLedger.RESET;
        recItemLedger.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
        //recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Purchase);
        //recItemLedger.SETRANGE("Document Type", recItemLedger."Document Type"::"Purchase Receipt");
        recItemLedger.SETRANGE("Item No.", TrackingSpecification."Item No.");
        recItemLedger.SETRANGE("Lot No.", TrackingSpecification."Lot No.");
        recItemLedger.SETRANGE(Positive, TRUE);
        recItemLedger.SETRANGE(Open, TRUE);
        IF recItemLedger.FINDFIRST THEN BEGIN
            IF recItemLedger."Qty. in Pack" <> 0 THEN BEGIN
                TrackingSpecification."Qty. in Pack" := ROUND(TrackingSpecification."Quantity (Base)" / (recItemLedger.Quantity / recItemLedger."Qty. in Pack"), 1);
                TrackingSpecification."Original Qty. in Pack" := TrackingSpecification."Qty. in Pack";
                TrackingSpecification."Packing Type" := recItemLedger."Packing Type";
                TrackingSpecification."Qty. Per Pack" := ROUND(recItemLedger.Quantity / recItemLedger."Qty. in Pack", 1);
            END;
        END;
        //Packing Update End
    end;
    //Codeunit6501

    // Table39 Start
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateNoOnCopyFromTempPurchLine', '', false, false)]
    local procedure OnValidateNoOnCopyFromTempPurchLine(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary; xPurchLine: Record "Purchase Line")
    begin
        PurchLine."Honey Item No." := TempPurchaseLine."Honey Item No.";
    end;

    /// Quantiy To receive as per the GAN condition

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateQuantityOnBeforeDropShptCheck', '', true, true)]
    local procedure "Purchase Line_OnValidateQuantityOnBeforeDropShptCheck"
    (
        var PurchaseLine: Record "Purchase Line";
        xPurchaseLine: Record "Purchase Line";
        CallingFieldNo: Integer;
        var IsHandled: Boolean
    )
    var
        decTempQty: Decimal;
        Item: Record Item;
        recItemCategory: Record "Item Category";
    begin
        //Uncomment by Shivam 11-07-23
        //Iappc - Gan Tolarance Adjustment
        IF (PurchaseLine.Type = PurchaseLine.Type::Item) AND (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order) THEN BEGIN
            PurchaseLine."Dispatched Qty. in Kg." := PurchaseLine.Quantity;
            Item.GET(PurchaseLine."No.");
            IF recItemCategory.GET(Item."Item Category Code") THEN
                decTempQty := PurchaseLine.Quantity + (PurchaseLine.Quantity * recItemCategory."GAN Tolerance %" / 100)
            ELSE
                decTempQty := PurchaseLine.Quantity;
        END ELSE BEGIN
            decTempQty := PurchaseLine.Quantity;
            PurchaseLine."Dispatched Qty. in Kg." := PurchaseLine.Quantity;
        END;

        IF (PurchaseLine.Type = PurchaseLine.Type::Item) AND (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::"Credit Memo") THEN
            PurchaseLine.Quantity := ROUND(decTempQty, 1, '<');
        //Iappc - Gan Tolarance Adjustment
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateOverReceiptQuantity', '', true, true)]
    local procedure OnValidateOverReceiptQuantity(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CalledByFieldNo: Integer; var Handled: Boolean)
    begin
        Handled := true;
    end;

    // Table39 End

    // Page6510 Start
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAssistEditLotNoOnBeforeCurrPageUdate', '', false, false)]
    local procedure OnAssistEditLotNoOnBeforeCurrPageUdate(var TrackingSpecification: Record "Tracking Specification"; xTrackingSpecification: Record "Tracking Specification")
    begin

        /* if TrackingSpecification."MRP Price" <> xTrackingSpecification."MRP Price" then
            Error('MRP Price Should Be Same for Same Tracking Line'); */
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry(var TrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; FormRunMode: Option)
    begin
        ModifyRun := false;
        MRPPrice := NewTrackingSpecification."MRP Price";
        MFGDate := NewTrackingSpecification."MFG. Date";
        Tin := NewTrackingSpecification.Tin;
        Drum := NewTrackingSpecification.Drum;
        Bucket := NewTrackingSpecification.Bucket;
        ILENo := NewTrackingSpecification."ILE No.";
        Can := NewTrackingSpecification.Can;
    end;

    // Page6510 End
    // Codeunit99000830 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterSetDates', '', false, false)]
    local procedure OnAfterSetDates(var ReservationEntry: Record "Reservation Entry")
    begin
        ReservationEntry."MRP Price" := MRPPrice;
        ReservationEntry."MFG. Date" := MFGDate;
        ReservationEntry.Tin := Tin;
        ReservationEntry.Drum := Drum;
        ReservationEntry.Bucket := Bucket;
        ReservationEntry."ILE No." := ILENo;
        ReservationEntry.Can := Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure OnCreateReservEntryExtraFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification")
    begin
        InsertReservEntry."MRP Price" := NewTrackingSpecification."MRP Price";
        InsertReservEntry."MFG. Date" := NewTrackingSpecification."MFG. Date";
        InsertReservEntry.Tin := NewTrackingSpecification.Tin;
        InsertReservEntry.Drum := NewTrackingSpecification.Drum;
        InsertReservEntry.Bucket := NewTrackingSpecification.Bucket;
        InsertReservEntry."ILE No." := NewTrackingSpecification."ILE No.";
        InsertReservEntry.Can := NewTrackingSpecification.Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterCopyFromInsertReservEntry', '', false, false)]
    local procedure OnAfterCopyFromInsertReservEntry(var InsertReservEntry: Record "Reservation Entry"; var ReservEntry: Record "Reservation Entry"; FromReservEntry: Record "Reservation Entry"; Status: Enum "Reservation Status"; QtyToHandleAndInvoiceIsSet: Boolean)
    var
        R_ReservEntry: Record "Reservation Entry";
    begin

        IF ReservEntry."Transferred from Entry No." <> 0 THEN BEGIN
            IF R_ReservEntry.GET(ReservEntry."Transferred from Entry No.") THEN BEGIN
                ReservEntry."MRP Price" := R_ReservEntry."MRP Price";
                ReservEntry."MFG. Date" := R_ReservEntry."MFG. Date";
                ReservEntry.Tin := R_ReservEntry.Tin;
                ReservEntry.Drum := R_ReservEntry.Drum;
                ReservEntry.Bucket := R_ReservEntry.Bucket;
                ReservEntry."ILE No." := R_ReservEntry."ILE No.";
                ReservEntry.Can := R_ReservEntry.Can;
            END;
        END;
    end;

    // Codeunit99000830 End

    // Page6510 Start
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    begin
        IdenticalArray[2] := ((ReservEntry1."MRP Price" = ReservEntry2."MRP Price") and (ReservEntry1."MFG. Date" = ReservEntry2."MFG. Date") and (ReservEntry1.Tin = ReservEntry2.Tin) and (ReservEntry1.Drum = ReservEntry2.Drum)
            and (ReservEntry1.Bucket = ReservEntry2.Bucket) and (ReservEntry1."ILE No." = ReservEntry2."ILE No.") and (ReservEntry1.Can = ReservEntry2.Can));

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    begin
        if ModifyRun = false then begin
            SourceTrackingSpec."MRP Price" := DestTrkgSpec."MRP Price";
            SourceTrackingSpec."MFG. Date" := DestTrkgSpec."MFG. Date";
            SourceTrackingSpec.Tin := DestTrkgSpec.Tin;
            SourceTrackingSpec.Drum := DestTrkgSpec.Drum;
            SourceTrackingSpec.Bucket := DestTrkgSpec.Bucket;
            SourceTrackingSpec."ILE No." := DestTrkgSpec."ILE No.";
            SourceTrackingSpec.Can := DestTrkgSpec.Can;
        end else begin
            DestTrkgSpec."MRP Price" := SourceTrackingSpec."MRP Price";
            DestTrkgSpec."MFG. Date" := SourceTrackingSpec."MFG. Date";
            DestTrkgSpec.Tin := SourceTrackingSpec.Tin;
            DestTrkgSpec.Drum := SourceTrackingSpec.Drum;
            DestTrkgSpec.Bucket := SourceTrackingSpec.Bucket;
            DestTrkgSpec."ILE No." := SourceTrackingSpec."ILE No.";
            DestTrkgSpec.Can := SourceTrackingSpec.Can;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry."MRP Price" := TrkgSpec."MRP Price";
        ReservEntry."MFG. Date" := TrkgSpec."MFG. Date";
        ReservEntry.Tin := TrkgSpec.Tin;
        ReservEntry.Drum := TrkgSpec.Drum;
        ReservEntry.Bucket := TrkgSpec.Bucket;
        ReservEntry."ILE No." := TrkgSpec."ILE No.";
        ReservEntry.Can := TrkgSpec.Can;
    end;
    // Page6510 End

    // Codeunit99000831 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Engine Mgt.", 'OnBeforeUpdateItemTracking', '', false, false)]
    local procedure OnBeforeUpdateItemTracking(var ReservEntry: Record "Reservation Entry"; var TrackingSpecification: Record "Tracking Specification")
    begin

        ReservEntry."MRP Price" := TrackingSpecification."MRP Price";
        ReservEntry."MFG. Date" := TrackingSpecification."MFG. Date";
        ReservEntry.Tin := TrackingSpecification.Tin;
        ReservEntry.Drum := TrackingSpecification.Drum;
        ReservEntry.Bucket := TrackingSpecification.Bucket;
        ReservEntry."ILE No." := TrackingSpecification."ILE No.";
        ReservEntry.Can := TrackingSpecification.Can;
    end;
    // Codeunit99000831 End

    // Codeunit6500 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnAfterInitReservEntry', '', false, false)]
    local procedure OnAfterInitReservEntry(var ReservEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry");
    begin

        ReservEntry."MRP Price" := ItemLedgerEntry."MRP Price";
        ReservEntry."MFG. Date" := ItemLedgerEntry."MFG. Date";
        ReservEntry.Tin := ItemLedgerEntry.Tin;
        ReservEntry.Drum := ItemLedgerEntry.Drum;
        ReservEntry.Bucket := ItemLedgerEntry.Bucket;
        ReservEntry."ILE No." := ItemLedgerEntry."Entry No.";
        ReservEntry.Can := ItemLedgerEntry.Can;
    end;
    // Codeunit6500 End

    // Codeunit6501 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterAssistEditTrackingNo', '', false, false)]
    local procedure OnAfterAssistEditTrackingNo(var TrackingSpecification: Record "Tracking Specification"; var TempGlobalEntrySummary: Record "Entry Summary" temporary; CurrentSignFactor: Integer; MaxQuantity: Decimal)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        QtyResereve: Decimal;
        ItemLedgeEntry2: Record "Item Ledger Entry";
        QtyResereve2: Decimal;
        QtyTracking: Decimal;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
    begin
        TrackingSpecification."MRP Price" := TempGlobalEntrySummary."MRP Price";
        TrackingSpecification."MFG. Date" := TempGlobalEntrySummary."MFG. Date";
        TrackingSpecification.Tin := TempGlobalEntrySummary.Tin;
        TrackingSpecification.Drum := TempGlobalEntrySummary.Drum;
        TrackingSpecification.Bucket := TempGlobalEntrySummary.Bucket;
        TrackingSpecification."ILE No." := TempGlobalEntrySummary."ILE No.";
        TrackingSpecification.Can := TempGlobalEntrySummary.Can;

        if (TrackingSpecification."Source Type" = 37) then begin
            if (TempGlobalEntrySummary."Total Available Quantity" <= 0) or ((TempGlobalEntrySummary."Current Pending Quantity" < 0)) then
                Error('In this Lot No. Total Available Quantity is 0.');

            ItemLedgerEntry.SetCurrentKey("Entry No.");
            ItemLedgerEntry.SetRange("Item No.", TrackingSpecification."Item No.");
            ItemLedgerEntry.SetRange("Location Code", TrackingSpecification."Location Code");
            ItemLedgerEntry.SetRange(Open, true);
            if ItemLedgerEntry.FindFirst() then begin
                TempTrackingSpecification.Init();
                TempTrackingSpecification := (TrackingSpecification);
                TempTrackingSpecification.Insert();
                repeat
                    ItemLedgeEntry2.Reset();
                    ItemLedgeEntry2.SetRange("Item No.", ItemLedgerEntry."Item No.");
                    ItemLedgeEntry2.SetRange("Location Code", ItemLedgerEntry."Location Code");
                    ItemLedgeEntry2.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                    ItemLedgeEntry2.SetRange(Open, true);
                    ItemLedgeEntry2.CalcSums("Remaining Quantity");
                    // if ItemLedgerEntry."Remaining Quantity" <> TempGlobalEntrySummary."Total Requested Quantity" then
                    if (ItemLedgerEntry."Lot No." <> TrackingSpecification."Lot No.") then begin

                        ReservationEntry.SetRange("Item No.", ItemLedgerEntry."Item No.");
                        ReservationEntry.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                        ReservationEntry.SetRange("Location Code", ItemLedgerEntry."Location Code");
                        ReservationEntry.SetFilter("Source ID", '<>%1', TrackingSpecification."Source ID");
                        //ReservationEntry.SetFilter("Source Ref. No.", '<>%1', TrackingSpecification."Source Ref. No.");
                        ReservationEntry.CalcSums(Quantity);
                        QtyResereve2 := abs(ReservationEntry.Quantity);

                        ReservationEntry2.Reset();
                        ReservationEntry2.SetRange("Item No.", ItemLedgerEntry."Item No.");
                        ReservationEntry2.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                        ReservationEntry2.SetRange("Location Code", ItemLedgerEntry."Location Code");
                        ReservationEntry2.SetFilter("Source ID", TrackingSpecification."Source ID");
                        //ReservationEntry2.SetFilter("Source Ref. No.", '<>%1', TrackingSpecification."Source Ref. No.");
                        ReservationEntry2.CalcSums(Quantity);
                        QtyResereve := abs(ReservationEntry2.Quantity);

                        if ItemLedgeEntry2."Remaining Quantity" <> (QtyResereve2 + QtyResereve) then begin
                            TrackingSpecification.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                            TrackingSpecification.SetRange("Location Code", ItemLedgerEntry."Location Code");
                            TrackingSpecification.SetRange("Item No.", ItemLedgerEntry."Item No.");
                            TrackingSpecification.SetRange("Source ID", TrackingSpecification."Source ID");
                            TrackingSpecification.CalcSums("Quantity (Base)");
                            QtyTracking := Abs(TrackingSpecification."Quantity (Base)");
                            if ItemLedgeEntry2."Remaining Quantity" <> (QtyTracking + QtyResereve2 + QtyResereve) then
                                Error('Please Select the Lot No On FIFO basis.')
                            else begin
                                TrackingSpecification.SetCurrentKey("Entry No.");
                                if TrackingSpecification.FindFirst() then
                                    if TrackingSpecification."MRP Price" <> 0 then begin
                                        if ItemLedgerEntry."MRP Price" <> TrackingSpecification."MRP Price" then
                                            Error('MRP Price Should be Same As in First Line in Tracking Specification');
                                    end;
                                TrackingSpecification.SetRange("Lot No.");
                                TrackingSpecification.TransferFields(TempTrackingSpecification);
                            end;
                        end;
                    end else begin
                        TrackingSpecification.SetCurrentKey("Entry No.");
                        if TrackingSpecification.FindFirst() then
                            if TrackingSpecification."MRP Price" <> 0 then begin
                                if ItemLedgerEntry."MRP Price" <> TrackingSpecification."MRP Price" then
                                    Error('MRP Price Should be Same As in First Line in Tracking Specification');
                            end;
                        TrackingSpecification.SetRange("Lot No.");
                        TrackingSpecification.TransferFields(TempTrackingSpecification);
                        exit;
                    end;
                until ItemLedgerEntry.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnTransferItemLedgToTempRecOnBeforeInsert', '', false, false)]
    local procedure OnTransferItemLedgToTempRecOnBeforeInsert(var TempGlobalReservEntry: Record "Reservation Entry" temporary; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    begin

        TempGlobalReservEntry."MRP Price" := ItemLedgerEntry."MRP Price";
        TempGlobalReservEntry."MFG. Date" := ItemLedgerEntry."MFG. Date";
        TempGlobalReservEntry.Tin := ItemLedgerEntry.Tin;
        TempGlobalReservEntry.Drum := ItemLedgerEntry.Drum;
        TempGlobalReservEntry.Bucket := ItemLedgerEntry.Bucket;
        TempGlobalReservEntry."ILE No." := ItemLedgerEntry."Entry No.";
        TempGlobalReservEntry.Can := ItemLedgerEntry.Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnCreateEntrySummary2OnAfterAssignTrackingFromReservEntry', '', false, false)]
    local procedure OnCreateEntrySummary2OnAfterAssignTrackingFromReservEntry(var TempGlobalEntrySummary: Record "Entry Summary" temporary; TempReservEntry: Record "Reservation Entry" temporary);
    begin
        TempGlobalEntrySummary."MRP Price" := TempReservEntry."MRP Price";
        TempGlobalEntrySummary."MFG. Date" := TempReservEntry."MFG. Date";
        TempGlobalEntrySummary.Tin := TempReservEntry.Tin;
        TempGlobalEntrySummary.Drum := TempReservEntry.Drum;
        TempGlobalEntrySummary.Bucket := TempReservEntry.Bucket;
        TempGlobalEntrySummary."ILE No." := TempReservEntry."ILE No.";
        TempGlobalEntrySummary.Can := TempReservEntry.Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2', '', false, false)]
    local procedure OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2(var TrackingSpecification: Record "Tracking Specification"; TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        //TEAM::3333
        TrackingSpecification."MRP Price" := TempTrackingSpecification."MRP Price";
        TrackingSpecification."MFG. Date" := TempTrackingSpecification."MFG. Date";
        TrackingSpecification.Tin := TempTrackingSpecification.Tin;
        TrackingSpecification.Drum := TempTrackingSpecification.Drum;
        TrackingSpecification.Bucket := TempTrackingSpecification.Bucket;
        TrackingSpecification."ILE No." := TempTrackingSpecification."ILE No.";
        TrackingSpecification.Can := TempTrackingSpecification.Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnBeforeTempTrackingSpecificationInsert', '', false, false)]
    local procedure OnBeforeTempTrackingSpecificationInsert(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempEntrySummary: Record "Entry Summary" temporary)
    begin
        TempTrackingSpecification."MRP Price" := TempEntrySummary."MRP Price";
        TempTrackingSpecification."MFG. Date" := TempEntrySummary."MFG. Date";
        TempTrackingSpecification.Tin := TempEntrySummary.Tin;
        TempTrackingSpecification.Drum := TempEntrySummary.Drum;
        TempTrackingSpecification.Bucket := TempEntrySummary.Bucket;
        TempTrackingSpecification."ILE No." := TempEntrySummary."ILE No.";
        TempTrackingSpecification.Can := TempEntrySummary.Can;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterTransferReservEntryToTempRec', '', false, false)]
    local procedure OnAfterTransferReservEntryToTempRec(var GlobalReservEntry: Record "Reservation Entry"; ReservEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    begin

        GlobalReservEntry."ILE No." := ReservEntry."ILE No."
    end;
    // Codeunit6501 End

    //Codeunit80 Start

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    var
        PrePackingList: Record "Pre Packing List";
        PostedPackigList: Record "Posted Packing List";
    begin
        //Iappc - Packing List Posting Begin
        PrePackingList.Reset();
        PrePackingList.SetRange("Order No.", SalesLine."Document No.");
        PrePackingList.SetRange("Order Line No.", SalesLine."Line No.");
        if PrePackingList.FindSet() then
            repeat
                PostedPackigList.Init();
                PostedPackigList.TransferFields(PrePackingList);
                PostedPackigList."Order No." := SalesInvHeader."No.";
                PostedPackigList.Insert();
                PrePackingList.Delete();
            until PrePackingList.Next() = 0;
    end;
    //Codeunit80 End

    //Codeunit1535 Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Customer_Approval: Record Customer;
        Recref: RecordRef;
    begin
        if ApprovalEntry."Table ID" = Database::Customer then begin
            Recref.Get(ApprovalEntry."Record ID to Approve");
            case
                Recref.Number of
                Database::Customer:
                    begin
                        Recref.SetTable(Customer_Approval);
                        Recref.Field(Customer_Approval.FieldNo(Blocked)).Value := Customer_Approval.Blocked::" ";
                        Recref.Modify();
                    end;
            end;
        end;
    end;
    //Codeunit1535 End

    //Table36 Start
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    local procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    begin
        SalesReceivablesSetup.TestField("Sales Export Order No.");
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::Export) then
            NoSeriesCode := SalesReceivablesSetup."Sales Export Order No.";
    end;

    // Page50052 Start
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Export", 'OnBeforePostSalesOrder', '', false, false)]
    local procedure OnBeforePostSalesOrder(var SalesHeader: Record "Sales Header"; PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesReceivableSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivableSetup.Get();
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::Export) then begin
            SalesReceivableSetup.TestField("Posted Invoice Export No.");
            SalesReceivableSetup.TestField("Posted Shipment Export No.");
            SalesHeader."Posting No. Series" := SalesReceivableSetup."Posted Invoice Export No.";
            SalesHeader."Shipping No. Series" := SalesReceivableSetup."Posted Shipment Export No.";
            SalesHeader.Modify();
        end;
    end;
    // Page50052 End

    /*  [EventSubscriber(ObjectType::Table, 36, 'OnAfterOnInsert', '', false, false)]
     local procedure OnAfterOnInsert(var SalesHeader: Record "Sales Header")
     var
         SalesRecviableSetup: Record "Sales & Receivables Setup";
     begin
         SalesRecviableSetup.Get();
         if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::Export) then begin
             SalesRecviableSetup.TestField("Posted Invoice Export No.");
             SalesRecviableSetup.TestField("Posted Invoice Export No.");
             SalesHeader."Posting No. Series" := SalesRecviableSetup."Posted Invoice Export No.";
             SalesHeader."Shipping No. Series" := SalesRecviableSetup."Posted Shipment Export No.";
         end;
     end;
  */

    //Table36 End

    //Codeunit825 Start
    [EventSubscriber(ObjectType::Codeunit, 825, 'OnPostLedgerEntryOnBeforeGenJnlPostLine', '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        Rec_Customer: Record Customer;
    begin
        if Rec_Customer.get(SalesHeader."Sell-to Customer No.") then;
        GenJnlLine."Parent Group" := Rec_Customer."Parent Group";
    end;
    //Codeunit825 End
    //Table81 Start
    [EventSubscriber(ObjectType::Table, 81, 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
        Rec_Customer: Record Customer;
    begin
        if Rec_Customer.get(SalesHeader."Sell-to Customer No.") then;
        GenJournalLine."Parent Group" := Rec_Customer."Parent Group";
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetCustomerAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetCustomerAccount(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; CallingFieldNo: Integer)
    begin
        GenJournalLine."Parent Group" := Customer."Parent Group";
    end;



    //Table81 End

    //Codeunit12 Start
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnAfterInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; var GLRegister: Record "G/L Register")
    begin
        CustLedgerEntry."Parent Group" := GenJournalLine."Parent Group";
    end;
    //Codeunit12 End
}