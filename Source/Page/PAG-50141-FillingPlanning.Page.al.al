page 50141 "Filling Planning"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    Permissions = TableData "Item Ledger Entry" = rm;
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date") ORDER(Ascending);
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                }
                field("Output for Customer"; Rec."Output for Customer")
                {
                }
                field("Item to Produce 1"; Rec."Item to Produce 1")
                {
                }
                field("Quantity to Produce 1"; Rec."Quantity to Produce 1")
                {
                }
                field("Item to Produce 2"; Rec."Item to Produce 2")
                {
                }
                field("Quantity to Produce 2"; Rec."Quantity to Produce 2")
                {
                }
                field("Item to Produce 3"; Rec."Item to Produce 3")
                {
                }
                field("Quantity to Produce 3"; Rec."Quantity to Produce 3")
                {
                }
                field("Item to Produce 4"; Rec."Item to Produce 4")
                {
                }
                field("Quantity to Produce 4"; Rec."Quantity to Produce 4")
                {
                }
                field("Convesion Packing Type"; Rec."Convesion Packing Type")
                {
                }
                field("Customer Details"; Rec."Customer Details")
                {
                }
                field("Quantity to Move"; Rec."Quantity to Move")
                {
                }
                field("No. of Drums / Tins / Cans"; Rec."No. of Drums / Tins / Cans")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Packing Order")
            {
                Caption = 'Create Packing Order';
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Location_Loc: Record Location;
                    Location_Loc1: Record Location;
                begin
                    IF NOT CONFIRM('Want to create the packing orders?', FALSE) THEN
                        EXIT;

                    intEntryNo := 0;
                    recManufacturingSetup.GET;
                    recManufacturingSetup.TESTFIELD("Loose Honey Code");

                    recItemLedger.RESET;
                    recItemLedger.COPYFILTERS(Rec);
                    //recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Output);
                    recItemLedger.SETRANGE("Item No.", recManufacturingSetup."Loose Honey Code");
                    recItemLedger.SETFILTER("Remaining Quantity", '<>%1', 0);
                    IF recItemLedger.FINDFIRST THEN
                        REPEAT
                            recItemLedger.TESTFIELD("Output for Customer");
                            decQtyToProduce := 0;
                            IF (recItemLedger."Item to Produce 1" <> '') AND (recItemLedger."Quantity to Produce 1" <> 0) THEN BEGIN
                                recItem.GET(recItemLedger."Item to Produce 1");
                                IF recItem."Routing No." = '' THEN
                                    ERROR('Routing no. must not be blank on item no. %1', recItemLedger."Item to Produce 1");
                                recItem.TESTFIELD("Net Weight Per (Kg)");
                                decQtyToProduce := decQtyToProduce + recItemLedger."Quantity to Produce 1" * recItem."Net Weight Per (Kg)";
                            END;
                            IF (recItemLedger."Item to Produce 2" <> '') AND (recItemLedger."Quantity to Produce 2" <> 0) THEN BEGIN
                                recItem.GET(recItemLedger."Item to Produce 2");
                                IF recItem."Routing No." = '' THEN
                                    ERROR('Routing no. must not be blank on item no. %1', recItemLedger."Item to Produce 2");
                                recItem.TESTFIELD("Net Weight Per (Kg)");
                                decQtyToProduce := decQtyToProduce + recItemLedger."Quantity to Produce 2" * recItem."Net Weight Per (Kg)";
                            END;
                            IF (recItemLedger."Item to Produce 3" <> '') AND (recItemLedger."Quantity to Produce 3" <> 0) THEN BEGIN
                                recItem.GET(recItemLedger."Item to Produce 3");
                                IF recItem."Routing No." = '' THEN
                                    ERROR('Routing no. must not be blank on item no. %1', recItemLedger."Item to Produce 3");
                                recItem.TESTFIELD("Net Weight Per (Kg)");
                                decQtyToProduce := decQtyToProduce + recItemLedger."Quantity to Produce 3" * recItem."Net Weight Per (Kg)";
                            END;
                            IF (recItemLedger."Item to Produce 4" <> '') AND (recItemLedger."Quantity to Produce 4" <> 0) THEN BEGIN
                                recItem.GET(recItemLedger."Item to Produce 4");
                                IF recItem."Routing No." = '' THEN
                                    ERROR('Routing no. must not be blank on item no. %1', recItemLedger."Item to Produce 4");
                                recItem.TESTFIELD("Net Weight Per (Kg)");
                                decQtyToProduce := decQtyToProduce + recItemLedger."Quantity to Produce 4" * recItem."Net Weight Per (Kg)";
                            END;

                            IF recItemLedger."Remaining Quantity" < decQtyToProduce THEN
                                ERROR('Can not use more than %1 for from entry no. %2, the actual usage is %3', recItemLedger."Remaining Quantity", recItemLedger."Entry No.", decQtyToProduce);
                        UNTIL recItemLedger.NEXT = 0;

                    recItemLedger.RESET;
                    recItemLedger.COPYFILTERS(Rec);
                    //recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Output);
                    recItemLedger.SETRANGE("Item No.", recManufacturingSetup."Loose Honey Code");
                    recItemLedger.SETFILTER("Remaining Quantity", '<>%1', 0);
                    IF recItemLedger.FINDFIRST THEN
                        REPEAT
                            recItemLedger.TestField("Location Code");
                            Location_Loc.Get(recItemLedger."Location Code");
                            IF (Location_Loc."Associated Plant" <> Location_Loc."Associated Plant"::" ") then begin
                                Location_Loc1.Reset();
                                Location_Loc1.SetRange("Associated Plant", Location_Loc."Associated Plant");
                                Location_Loc1.SetRange("Packing Location", true);
                                if not Location_Loc1.FindFirst() then begin
                                    Location_Loc1.SetRange("Associated Plant");
                                    if not Location_Loc1.FindFirst() then
                                        Error('There is no Packing Location');
                                end;
                            end else begin
                                Location_Loc1.Reset();
                                Location_Loc1.SetRange("Packing Location", true);
                                if not Location_Loc1.FindFirst() then
                                    Error('There is no packing Location');
                            end;

                            IF (recItemLedger."Item to Produce 1" <> '') AND (recItemLedger."Quantity to Produce 1" <> 0) THEN BEGIN
                                recProductionOrder.INIT;
                                recProductionOrder.VALIDATE(Status, recProductionOrder.Status::Released);
                                recProductionOrder.VALIDATE("No.", '');
                                recProductionOrder.INSERT(TRUE);

                                recProductionOrder.VALIDATE("Source Type", recProductionOrder."Source Type"::Item);
                                recProductionOrder.VALIDATE("Source No.", recItemLedger."Item to Produce 1");
                                recProductionOrder.VALIDATE(Quantity, recItemLedger."Quantity to Produce 1");

                                recProductionOrder.VALIDATE("Location Code", Location_Loc1.Code);
                                recProductionOrder.VALIDATE("Customer Code", recItemLedger."Output for Customer");
                                recProductionOrder."Order Type" := recProductionOrder."Order Type"::Packing;
                                recProductionOrder.MODIFY(TRUE);

                                recItemLedger."Item to Produce 1" := '';
                                recItemLedger."Quantity to Produce 1" := 0;
                                intEntryNo += 1;
                            END;
                            IF (recItemLedger."Item to Produce 2" <> '') AND (recItemLedger."Quantity to Produce 2" <> 0) THEN BEGIN
                                recProductionOrder.INIT;
                                recProductionOrder.VALIDATE(Status, recProductionOrder.Status::Released);
                                recProductionOrder.VALIDATE("No.", '');
                                recProductionOrder.INSERT(TRUE);

                                recProductionOrder.VALIDATE("Source Type", recProductionOrder."Source Type"::Item);
                                recProductionOrder.VALIDATE("Source No.", recItemLedger."Item to Produce 2");
                                recProductionOrder.VALIDATE(Quantity, recItemLedger."Quantity to Produce 2");

                                recLocation.GET(recItemLedger."Location Code");
                                recLocation.TESTFIELD("Packing Location");
                                recProductionOrder.VALIDATE("Location Code", Location_Loc1.Code);
                                recProductionOrder.VALIDATE("Customer Code", recItemLedger."Output for Customer");
                                recProductionOrder."Order Type" := recProductionOrder."Order Type"::Packing;
                                recProductionOrder.MODIFY(TRUE);

                                recItemLedger."Item to Produce 2" := '';
                                recItemLedger."Quantity to Produce 2" := 0;
                                intEntryNo += 1;
                            END;
                            IF (recItemLedger."Item to Produce 3" <> '') AND (recItemLedger."Quantity to Produce 3" <> 0) THEN BEGIN
                                recProductionOrder.INIT;
                                recProductionOrder.VALIDATE(Status, recProductionOrder.Status::Released);
                                recProductionOrder.VALIDATE("No.", '');
                                recProductionOrder.INSERT(TRUE);

                                recProductionOrder.VALIDATE("Source Type", recProductionOrder."Source Type"::Item);
                                recProductionOrder.VALIDATE("Source No.", recItemLedger."Item to Produce 3");
                                recProductionOrder.VALIDATE(Quantity, recItemLedger."Quantity to Produce 3");

                                recLocation.GET(recItemLedger."Location Code");
                                recLocation.TESTFIELD("Packing Location");
                                recProductionOrder.VALIDATE("Location Code", Location_Loc1.Code);
                                recProductionOrder.VALIDATE("Customer Code", recItemLedger."Output for Customer");
                                recProductionOrder."Order Type" := recProductionOrder."Order Type"::Packing;
                                recProductionOrder.MODIFY(TRUE);

                                recItemLedger."Item to Produce 3" := '';
                                recItemLedger."Quantity to Produce 3" := 0;
                                intEntryNo += 1;
                            END;
                            IF (recItemLedger."Item to Produce 4" <> '') AND (recItemLedger."Quantity to Produce 4" <> 0) THEN BEGIN
                                recProductionOrder.INIT;
                                recProductionOrder.VALIDATE(Status, recProductionOrder.Status::Released);
                                recProductionOrder.VALIDATE("No.", '');
                                recProductionOrder.INSERT(TRUE);

                                recProductionOrder.VALIDATE("Source Type", recProductionOrder."Source Type"::Item);
                                recProductionOrder.VALIDATE("Source No.", recItemLedger."Item to Produce 4");
                                recProductionOrder.VALIDATE(Quantity, recItemLedger."Quantity to Produce 4");

                                recLocation.GET(recItemLedger."Location Code");
                                recLocation.TESTFIELD("Packing Location");
                                recProductionOrder.VALIDATE("Location Code", Location_Loc1.Code);
                                recProductionOrder.VALIDATE("Customer Code", recItemLedger."Output for Customer");
                                recProductionOrder."Order Type" := recProductionOrder."Order Type"::Packing;
                                recProductionOrder.MODIFY(TRUE);

                                recItemLedger."Item to Produce 4" := '';
                                recItemLedger."Quantity to Produce 4" := 0;
                                intEntryNo += 1;
                            END;

                            recItemLedger.MODIFY;
                        UNTIL recItemLedger.NEXT = 0;
                    COMMIT;

                    IF intEntryNo = 0 THEN
                        ERROR('Nothing is selected to create packing order.');

                    intEntryNo := 0;
                    recReservationEntry.RESET;
                    IF recReservationEntry.FINDLAST THEN
                        intEntryNo := recReservationEntry."Entry No."
                    ELSE
                        intEntryNo := 0;

                    recProductionOrder.RESET;
                    recProductionOrder.SETRANGE(Status, recProductionOrder.Status::Released);
                    recProductionOrder.SETRANGE(Refreshed, FALSE);
                    IF recProductionOrder.FINDFIRST THEN
                        REPEAT

                            recProdOrderToRefresh.RESET;
                            recProdOrderToRefresh.SETRANGE(Status, recProductionOrder.Status);
                            recProdOrderToRefresh.SETRANGE("No.", recProductionOrder."No.");
                            recProdOrderToRefresh.FINDFIRST;
                            COMMIT;

                            REPORT.RUNMODAL(Report::"Refresh Production Order", FALSE, TRUE, recProdOrderToRefresh);
                            COMMIT;
                        UNTIL recProductionOrder.NEXT = 0;
                    MESSAGE('%1 order(s) created.', intEntryNo);
                end;
            }
            action("Transfer to Store as RM")
            {
                Image = ConsumptionJournal;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Location_Loc: Record Location;
                    Location_Loc2: Record Location;
                begin
                    IF Rec."Entry No." = 0 THEN
                        EXIT;

                    IF NOT CONFIRM('Do you want to convert the selected line to RM?', FALSE) THEN
                        EXIT;

                    recInventorySetup.GET;
                    recInventorySetup.TESTFIELD("QC Entry Template");
                    recInventorySetup.TESTFIELD("QC Entry Batch");

                    recItemJournal.RESET;
                    recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                    recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                    IF recItemJournal.FIND('+') THEN
                        intLineNo := recItemJournal."Line No."
                    ELSE
                        intLineNo := 0;

                    recReservationEntry.RESET;
                    IF recReservationEntry.FIND('+') THEN
                        intEntryNo := recReservationEntry."Entry No.";

                    recPurchSetup.GET;
                    recPurchSetup.TESTFIELD("Raw Honey Item");
                    //recPurchSetup.TESTFIELD("OK Store Location");

                    IF Rec."Convesion Packing Type" = 0 THEN
                        ERROR('Selected conversion packing type.');
                    IF Rec."Customer Details" = '' THEN
                        ERROR('Enter Customer details in customer.');
                    IF Rec."No. of Drums / Tins / Cans" = 0 THEN
                        ERROR('Enter the no. of drums / tins / cans to transfer.');
                    IF Rec."Quantity to Move" = 0 THEN
                        ERROR('Enter the quantity to move to be transferred to RM Store.');

                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Entry No.", Rec."Entry No.");
                    recItemLedger.SETFILTER("Remaining Quantity", '<>%1', 0);
                    IF recItemLedger.FIND('-') THEN BEGIN
                        recItemLedger.TestField("Location Code");
                        Location_Loc.Get(recItemLedger."Location Code");
                        IF (Location_Loc."Associated Plant" <> Location_Loc."Associated Plant"::" ") then begin
                            Location_Loc2.Reset();
                            Location_Loc2.SetRange("Associated Plant", Location_Loc."Associated Plant");
                            Location_Loc2.SetRange("Store Location", true);
                            if not Location_Loc2.FindFirst() then begin
                                Location_Loc2.SetRange("Associated Plant");
                                if not Location_Loc2.FindFirst() then
                                    Error('There is no Store Location');
                            end;
                        end else begin
                            Location_Loc2.Reset();
                            Location_Loc2.SetRange("Store Location", true);
                            if not Location_Loc2.FindFirst() then
                                Error('There is no Store Location');
                        end;


                        recItemJournal.INIT;
                        recItemJournal.VALIDATE("Journal Template Name", recInventorySetup."QC Entry Template");
                        recItemJournal.VALIDATE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                        intLineNo += 10000;
                        recItemJournal.VALIDATE("Line No.", intLineNo);
                        recItemJournal.VALIDATE("Posting Date", WORKDATE);
                        recItemJournal.VALIDATE("Document No.", recItemLedger."Document No.");
                        recItemJournal.VALIDATE("Item No.", recItemLedger."Item No.");
                        recItemJournal.VALIDATE("Entry Type", recItemJournal."Entry Type"::"Negative Adjmt.");
                        recItemJournal.VALIDATE("Location Code", recItemLedger."Location Code");
                        recItemJournal.VALIDATE(Quantity, recItemLedger."Quantity to Move");
                        recItemJournal.VALIDATE("Shortcut Dimension 1 Code", recItemLedger."Global Dimension 1 Code");
                        recItemJournal.VALIDATE("Shortcut Dimension 2 Code", recItemLedger."Global Dimension 2 Code");
                        //  recItemJournal.VALIDATE("Applies-to Entry","Entry No.");
                        recItemJournal."Temp Message Control" := TRUE;
                        recItemJournal.INSERT(TRUE);

                        IF (recItemLedger."Lot No." <> '') OR (recItemLedger."Serial No." <> '') THEN BEGIN
                            recReservationEntry.INIT;
                            intEntryNo += 1;
                            recReservationEntry."Entry No." := intEntryNo;
                            recReservationEntry.Positive := FALSE;
                            recReservationEntry."Item No." := recItemLedger."Item No.";
                            recReservationEntry."Location Code" := recItemLedger."Location Code";
                            recReservationEntry.VALIDATE("Quantity (Base)", -recItemLedger."Quantity to Move");
                            recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                            recReservationEntry."Creation Date" := TODAY;
                            recReservationEntry."Source Type" := 83;
                            recReservationEntry."Source Subtype" := 3;
                            recReservationEntry."Source ID" := recInventorySetup."QC Entry Template";
                            recReservationEntry."Source Batch Name" := recInventorySetup."QC Entry Batch";
                            recReservationEntry."Source Ref. No." := intLineNo;
                            recReservationEntry."Appl.-to Item Entry" := recItemLedger."Entry No.";

                            IF recItemLedger."Lot No." <> '' THEN BEGIN
                                recReservationEntry."Lot No." := recItemLedger."Lot No.";
                                recReservationEntry."New Lot No." := recItemLedger."Lot No.";
                                recReservationEntry."New Expiration Date" := recItemLedger."Expiration Date";
                                recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                            END;
                            IF recItemLedger."Serial No." <> '' THEN BEGIN
                                recReservationEntry."Serial No." := recItemLedger."Serial No.";
                                recReservationEntry."New Serial No." := recItemLedger."Serial No.";
                                recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Serial No.";
                            END;

                            recReservationEntry."Created By" := USERID;
                            recReservationEntry."Qty. per Unit of Measure" := 1;
                            recReservationEntry.Binding := recReservationEntry.Binding::" ";
                            recReservationEntry."Suppressed Action Msg." := FALSE;
                            recReservationEntry."Planning Flexibility" := recReservationEntry."Planning Flexibility"::Unlimited;
                            recReservationEntry."Quantity Invoiced (Base)" := 0;
                            recReservationEntry.Correction := FALSE;
                            recReservationEntry.INSERT;
                        END;

                        recItemJournal.INIT;
                        recItemJournal.VALIDATE("Journal Template Name", recInventorySetup."QC Entry Template");
                        recItemJournal.VALIDATE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                        intLineNo += 10000;
                        recItemJournal.VALIDATE("Line No.", intLineNo);
                        recItemJournal.VALIDATE("Posting Date", WORKDATE);
                        recItemJournal.VALIDATE("Document No.", recItemLedger."Document No.");
                        recItemJournal.VALIDATE("Item No.", recPurchSetup."Raw Honey Item");
                        recItemJournal.VALIDATE("Entry Type", recItemJournal."Entry Type"::"Positive Adjmt.");
                        recItemJournal.VALIDATE("Location Code", Location_Loc2.Code);
                        recItemJournal.VALIDATE(Quantity, recItemLedger."Quantity to Move");
                        recItemJournal.VALIDATE("Shortcut Dimension 1 Code", recItemLedger."Global Dimension 1 Code");
                        recItemJournal.VALIDATE("Shortcut Dimension 2 Code", recItemLedger."Global Dimension 2 Code");
                        //  recItemJournal.VALIDATE("Applies-to Entry","Entry No.");
                        recItemJournal."Temp Message Control" := TRUE;
                        recItemJournal.INSERT(TRUE);

                        IF (recItemLedger."Lot No." <> '') OR (recItemLedger."Serial No." <> '') THEN BEGIN
                            recReservationEntry.INIT;
                            intEntryNo += 1;
                            recReservationEntry."Entry No." := intEntryNo;
                            recReservationEntry.Positive := TRUE;
                            recReservationEntry."Item No." := recPurchSetup."Raw Honey Item";
                            recReservationEntry."Location Code" := Location_Loc2.Code;
                            recReservationEntry.VALIDATE("Quantity (Base)", recItemLedger."Quantity to Move");
                            recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                            recReservationEntry."Creation Date" := TODAY;
                            recReservationEntry."Source Type" := 83;
                            recReservationEntry."Source Subtype" := 2;
                            recReservationEntry."Source ID" := recInventorySetup."QC Entry Template";
                            recReservationEntry."Source Batch Name" := recInventorySetup."QC Entry Batch";
                            recReservationEntry."Source Ref. No." := intLineNo;

                            IF recItemLedger."Lot No." <> '' THEN BEGIN
                                recReservationEntry."Lot No." := recItemLedger."Lot No.";
                                recReservationEntry."New Lot No." := recItemLedger."Lot No.";
                                recReservationEntry."New Expiration Date" := recItemLedger."Expiration Date";
                                recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                            END;
                            IF recItemLedger."Serial No." <> '' THEN BEGIN
                                recReservationEntry."Serial No." := recItemLedger."Serial No.";
                                recReservationEntry."New Serial No." := recItemLedger."Serial No.";
                                recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Serial No.";
                            END;

                            recReservationEntry."Created By" := USERID;
                            recReservationEntry."Qty. per Unit of Measure" := 1;
                            recReservationEntry.Binding := recReservationEntry.Binding::" ";
                            recReservationEntry."Suppressed Action Msg." := FALSE;
                            recReservationEntry."Planning Flexibility" := recReservationEntry."Planning Flexibility"::Unlimited;
                            recReservationEntry."Quantity Invoiced (Base)" := 0;
                            recReservationEntry.Correction := FALSE;
                            recReservationEntry.INSERT;
                        END;

                        recPostedTracking.RESET;
                        IF recPostedTracking.FINDLAST THEN
                            intEntryNo := recPostedTracking."Entry No."
                        ELSE
                            intEntryNo := 0;

                        recPostedTracking.INIT;
                        intEntryNo += 1;
                        recPostedTracking."Entry No." := intEntryNo;
                        recPostedTracking."Item No." := recPurchSetup."Raw Honey Item";
                        recPostedTracking."Lot No." := recItemLedger."Lot No.";
                        recPostedTracking.Flora := '';
                        //  recPostedTracking."Packing Type" := recItemLedger."Convesion Packing Type";
                        recPostedTracking.Tin := recItemLedger.Tin;
                        recPostedTracking.Drum := recItemLedger.Drum;
                        recPostedTracking.Can := recItemLedger.Can;
                        recPostedTracking.Bucket := recItemLedger.Bucket;
                        recPostedTracking."Qty. In Packs" := recItemLedger."No. of Drums / Tins / Cans";
                        recPostedTracking.Quantity := recItemLedger."Quantity to Move";
                        recPostedTracking."Average Qty. In Pack" := recItemLedger."Quantity to Move" / recPostedTracking."Qty. In Packs";
                        recPostedTracking."Document No." := recItemLedger."Document No.";
                        recPostedTracking."Document Line No." := recItemLedger."Document Line No.";
                        recPostedTracking."Location Code" := Location_Loc2.Code;
                        recPostedTracking."Tare Weight" := 0;
                        recPostedTracking."Remaining Qty." := recItemLedger."Quantity to Move";
                        recPostedTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                        recPostedTracking."Color (MM)" := recItemLedger."Color (MM)";
                        recPostedTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                        recPostedTracking.TRS := recItemLedger.TRS;
                        recPostedTracking.Sucrose := recItemLedger.Sucrose;
                        recPostedTracking.FG := recItemLedger.FG;
                        recPostedTracking.Positive := TRUE;
                        recPostedTracking."Ref. Entry No." := intEntryNo;
                        recPostedTracking."Stock Type" := recPostedTracking."Stock Type"::Pouring;
                        recPostedTracking.Customer := recItemLedger."Customer Details";
                        recPostedTracking.INSERT;

                        IF recItemLedger."Remaining Quantity" <> recItemLedger."Quantity to Move" THEN BEGIN
                            recItemLedger."Quantity to Move" := 0;
                            recItemLedger."No. of Drums / Tins / Cans" := 0;
                            recItemLedger."Convesion Packing Type" := 0;
                            recItemLedger.MODIFY;
                        END;

                        recItemJournal.RESET;
                        recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                        recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                        recItemJournal.SETRANGE("Document No.", recItemLedger."Document No.");
                        IF recItemJournal.FIND('-') THEN
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", recItemJournal);

                        MESSAGE('The selected line has been successfully converted.');
                        CurrPage.UPDATE;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        Location_Loc: Record Location;
        LocationText: Text;
    begin
        recManufacturingSetup.GET;
        recManufacturingSetup.TESTFIELD("Loose Honey Code");
        Clear(LocationText);
        Location_Loc.Reset();
        Location_Loc.SetRange("Production Location", true);
        IF Location_Loc.FindSet() then begin
            if (LocationText = '') then
                LocationText := Location_Loc.Code
            else
                LocationText += '|' + Location_Loc.Code;
        end;

        Rec.FILTERGROUP(2);
        //Rec.SetRange("Entry Type", Rec."Entry Type"::Output);
        Rec.SETRANGE("Item No.", recManufacturingSetup."Loose Honey Code");
        Rec.SetFilter("Location Code", LocationText);
        Rec.SetFilter("Remaining Quantity", '<>%1', 0);
        Rec.FILTERGROUP(0);
    end;

    var
        cuProdPlanning: Codeunit "Production Planning";
        dtFromDate: Date;
        recPlanningLines: Record "Item Budget Entry";
        recProductionOrder: Record "Production Order";
        recProdOrderToRefresh: Record "Production Order";
        recManufacturingSetup: Record "Manufacturing Setup";
        decQtyToProduce: Decimal;
        cdLocationCode: Code[20];
        dBatchNo: Code[20];
        recReservationEntry: Record "Reservation Entry";
        intEntryNo: Integer;
        cdCustomerCode: Code[20];
        cdProdOrderCode: Code[20];
        opProductionType: Option " ","Bulk Without Filteration","Bulk With Filteration","Small Pack";
        recRoutingHeader: Record "Routing Header";
        cdBulkItemNo: Code[20];
        recItem: Record "Item";
        recItemLedger: Record "Item Ledger Entry";
        recLocation: Record "Location";
        x: Integer;
        recInventorySetup: Record "Inventory Setup";
        recItemJournal: Record "Item Journal Line";
        intLineNo: Integer;
        recPurchSetup: Record "Purchases & Payables Setup";
        recPostedTracking: Record "Lot Tracking Entry";
}

