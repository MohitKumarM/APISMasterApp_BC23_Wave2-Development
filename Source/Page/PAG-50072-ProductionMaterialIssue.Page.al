page 50072 "Production Material Issue"
{
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Production Material Issue';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released),
                            Refreshed = FILTER(True),
                            "Requested Material Issue" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    Lookup = false;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Batch No."; Rec."Batch No.")
                {
                }
                field("Production Type"; Rec."Production Type")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Search Description"; Rec."Search Description")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Image = "Order";
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("&Warehouse Entries")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Source Type" = FILTER(83 | 5407),
                                      "Source Subtype" = FILTER(3 | 4 | 5),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                }
                action("Production Job Card")
                {
                    Caption = 'Production Job Card';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        recProdOrder: Record "Production Order";
                    begin
                        recProdOrder.RESET;
                        recProdOrder.SETRANGE(Status, Rec.Status);
                        recProdOrder.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Prod. Order - Job Card", TRUE, TRUE, recProdOrder);
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                separator(Sept)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status),
                                  "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Lot Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recLotTracking: Record "Tran. Lot Tracking";
                        pgLotTracking: Page "Cons. Lot Tracking Entry";
                    begin
                        recPurchaseSetup.GET;
                        recPurchaseSetup.TESTFIELD("Raw Honey Item");

                        recLotTracking.RESET;
                        recLotTracking.FILTERGROUP(2);
                        recLotTracking.SETRANGE("Document Type", recLotTracking."Document Type"::Consumption);
                        recLotTracking.SETRANGE("Document No.", Rec."No.");
                        recLotTracking.SETRANGE("Document Line No.", 10000);
                        recLotTracking.SETRANGE("Item No.", recPurchaseSetup."Raw Honey Item");
                        recLotTracking.FILTERGROUP(0);

                        CLEAR(pgLotTracking);
                        pgLotTracking.SetDocumentNo(Rec."No.", 10000, recPurchaseSetup."Raw Honey Item", Rec.Quantity, Rec."Location Code", 1);
                        pgLotTracking.SETTABLEVIEW(recLotTracking);
                        pgLotTracking.RUN;
                    end;
                }
                action(Components)
                {
                    Caption = 'Components';
                    Image = Components;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        //Rec.TESTFIELD("Order Type", "Order Type"::Packing);

                        recProdOrderComponent.SETRANGE(Status, Rec.Status);
                        recProdOrderComponent.SETRANGE("Prod. Order No.", Rec."No.");
                        recProdOrderComponent.SETRANGE("Prod. Order Line No.", 10000);

                        CLEAR(pgComponent);
                        pgComponent.EDITABLE := FALSE;
                        pgComponent.SETTABLEVIEW(recProdOrderComponent);
                        pgComponent.RUN;

                        //PAGE.RUN(PAGE::"Prod. Order Components", recProdOrderComponent);
                    end;
                }
                action("Issue Material")
                {
                    Caption = 'Issue Material';
                    Image = ConsumptionJournal;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        IF Rec."Order Type" = Rec."Order Type"::Production THEN BEGIN
                            CLEAR(rptCalcConsumption);

                            recManufacturingSetup.GET;
                            recManufacturingSetup.TESTFIELD("Consumption Template");
                            recManufacturingSetup.TESTFIELD("Consumption Batch");

                            rptCalcConsumption.SetOrderNo(Rec."No.", 1);
                            rptCalcConsumption.SetTemplateAndBatchName(recManufacturingSetup."Consumption Template", recManufacturingSetup."Consumption Batch");
                            rptCalcConsumption.USEREQUESTPAGE(FALSE);
                            rptCalcConsumption.RUNMODAL;

                            CLEAR(pgConsumptionJournal);
                            pgConsumptionJournal.RUN;
                        END ELSE BEGIN
                            recInventorySetup.GET;
                            recInventorySetup.TESTFIELD("Material Issue Entry Template");
                            recInventorySetup.TESTFIELD("Material Issue Entry Batch");
                            intLineNo := 0;

                            recItemJournal.RESET;
                            recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."Material Issue Entry Template");
                            recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."Material Issue Entry Batch");
                            IF recItemJournal.FINDLAST THEN
                                recItemJournal.DELETEALL;

                            recReservationEntry.RESET;
                            recReservationEntry.SETRANGE("Source Type", 83);
                            recReservationEntry.SETRANGE("Source Subtype", 4);
                            IF recReservationEntry.FINDFIRST THEN
                                recReservationEntry.DELETEALL;

                            recReservationEntry.RESET;
                            IF recReservationEntry.FINDLAST THEN
                                intEntryNo := recReservationEntry."Entry No."
                            ELSE
                                intEntryNo := 0;

                            recProdOrderComponent.RESET;
                            recProdOrderComponent.SETRANGE(Status, recProdOrderComponent.Status::Released);
                            recProdOrderComponent.SETRANGE("Prod. Order No.", Rec."No.");
                            IF recProdOrderComponent.FINDFIRST THEN
                                REPEAT
                                    IF recProdOrderComponent."Store Location" = '' THEN BEGIN
                                        recProdOrderComponent."Store Location" := recProdOrderComponent."Location Code";
                                        recProdOrderComponent."Location Code" := Rec."Location Code";
                                        recProdOrderComponent.MODIFY;
                                    END;

                                    recItemJournal.INIT;
                                    recItemJournal.VALIDATE("Journal Template Name", recInventorySetup."Material Issue Entry Template");
                                    recItemJournal.VALIDATE("Journal Batch Name", recInventorySetup."Material Issue Entry Batch");
                                    intLineNo += 10000;
                                    recItemJournal.VALIDATE("Line No.", intLineNo);
                                    recItemJournal.VALIDATE("Posting Date", WORKDATE);
                                    recItemJournal.VALIDATE("Document No.", recProdOrderComponent."Prod. Order No.");
                                    recItemJournal.VALIDATE("Item No.", recProdOrderComponent."Item No.");
                                    recItemJournal.VALIDATE("Entry Type", recItemJournal."Entry Type"::Transfer);
                                    recItemJournal.VALIDATE("Location Code", recProdOrderComponent."Store Location");
                                    recItemJournal.VALIDATE("New Location Code", Rec."Location Code");
                                    recItemJournal.VALIDATE(Quantity, recProdOrderComponent."Expected Quantity");
                                    recItemJournal.VALIDATE("Shortcut Dimension 1 Code", recProdOrderComponent."Shortcut Dimension 1 Code");
                                    recItemJournal.VALIDATE("Shortcut Dimension 2 Code", recProdOrderComponent."Shortcut Dimension 2 Code");
                                    recItemJournal.VALIDATE("New Shortcut Dimension 1 Code", recProdOrderComponent."Shortcut Dimension 1 Code");
                                    recItemJournal.VALIDATE("New Shortcut Dimension 2 Code", recProdOrderComponent."Shortcut Dimension 2 Code");
                                    //    recItemJournal.VALIDATE("Applies-to Entry","Entry No.");
                                    recItemJournal.INSERT(TRUE);

                                    recReservationEntrySource.RESET;
                                    recReservationEntrySource.SETRANGE("Source Type", 5407);
                                    recReservationEntrySource.SETRANGE("Source Subtype", 3);
                                    recReservationEntrySource.SETRANGE("Source ID", recProdOrderComponent."Prod. Order No.");
                                    recReservationEntrySource.SETRANGE("Source Prod. Order Line", recProdOrderComponent."Prod. Order Line No.");
                                    recReservationEntrySource.SETRANGE("Source Ref. No.", recProdOrderComponent."Line No.");
                                    IF recReservationEntrySource.FINDFIRST THEN
                                        REPEAT
                                            recReservationEntrySource."Location Code" := Rec."Location Code";
                                            recReservationEntrySource.MODIFY;

                                            recReservationEntry.INIT;
                                            intEntryNo += 1;
                                            recReservationEntry."Entry No." := intEntryNo;
                                            recReservationEntry.Positive := FALSE;
                                            recReservationEntry."Item No." := recReservationEntrySource."Item No.";
                                            recReservationEntry."Location Code" := recProdOrderComponent."Store Location";
                                            recReservationEntry.VALIDATE("Quantity (Base)", -recProdOrderComponent."Expected Quantity");
                                            recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                                            recReservationEntry."Creation Date" := TODAY;
                                            recReservationEntry."Source Type" := 83;
                                            recReservationEntry."Source Subtype" := 4;
                                            recReservationEntry."Source ID" := recInventorySetup."Material Issue Entry Template";
                                            recReservationEntry."Source Batch Name" := recInventorySetup."Material Issue Entry Batch";
                                            recReservationEntry."Source Ref. No." := intLineNo;
                                            //recReservationEntry."Appl.-to Item Entry" := recItemLedger."Entry No.";

                                            recReservationEntry."Lot No." := recReservationEntrySource."Lot No.";
                                            recReservationEntry."New Lot No." := recReservationEntrySource."Lot No.";
                                            //recReservationEntry."New Expiration Date" := recItemLedger."Expiration Date";
                                            recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                                            recReservationEntry."Serial No." := recReservationEntrySource."Serial No.";
                                            recReservationEntry."New Serial No." := recReservationEntrySource."Serial No.";
                                            //recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Serial No.";

                                            recReservationEntry."Created By" := USERID;
                                            recReservationEntry."Qty. per Unit of Measure" := 1;
                                            recReservationEntry.Binding := recReservationEntry.Binding::" ";
                                            recReservationEntry."Suppressed Action Msg." := FALSE;
                                            recReservationEntry."Planning Flexibility" := recReservationEntry."Planning Flexibility"::Unlimited;
                                            recReservationEntry."Quantity Invoiced (Base)" := 0;
                                            recReservationEntry.Correction := FALSE;
                                            recReservationEntry.INSERT;
                                        UNTIL recReservationEntrySource.NEXT = 0;
                                UNTIL recProdOrderComponent.NEXT = 0;

                            recItemJournal.RESET;
                            recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."Material Issue Entry Template");
                            recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."Material Issue Entry Batch");
                            PAGE.RUN(Page::"Item Reclass. Journal", recItemJournal);
                            /*
                            CLEAR(pgItemTransfer);
                            pgItemTransfer.SETTABLEVIEW(recItemJournal);
                            pgItemTransfer.RUN;
                            */
                        END;

                    end;
                }
                action("Send Back")
                {
                    Caption = 'Send Back';
                    Image = SendTo;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM('Sent the production order back?', FALSE) THEN
                            EXIT;

                        Rec."Requested Material Issue" := FALSE;
                        Rec.MODIFY;

                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    var
        recProdOrderComponent: Record "Prod. Order Component";
        rptCalcConsumption: Report "Calc. Consumption";
        recManufacturingSetup: Record "Manufacturing Setup";
        pgConsumptionJournal: Page "Consumption Journal";
        recPurchaseSetup: Record "Purchases & Payables Setup";
        recItemJournal: Record "Item Journal Line";
        recInventorySetup: Record "Inventory Setup";
        intLineNo: Integer;
        recLocation: Record "Location";
        recReservationEntry: Record "Reservation Entry";
        recReservationEntrySource: Record "Reservation Entry";
        intEntryNo: Integer;
        pgComponent: Page "Prod. Order Components";
}

