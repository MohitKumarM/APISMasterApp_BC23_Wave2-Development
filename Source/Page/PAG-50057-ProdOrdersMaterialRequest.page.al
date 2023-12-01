page 50057 "Prod. Orders Material Request"
{
    Caption = 'Select Honey Batch';
    CardPageID = "Released Production Order";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released), Refreshed = FILTER(true), "Order Type" = FILTER(Production), "Requested Material Issue" = FILTER(false));
    ApplicationArea = all;
    UsageCategory = Lists;

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
                field("Source No."; Rec."Source No.") { }
                field(Description; Rec.Description) { }
                field("Batch No."; Rec."Batch No.") { }
                field("Customer Code"; Rec."Customer Code") { }
                field("Customer Name"; Rec."Customer Name") { }
                field("Production Type"; Rec."Production Type") { }
                field(Quantity; Rec.Quantity) { }
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
                field(Status; Rec.Status) { }
                field(Moisture; Rec.Moisture) { }
                field(Color; Rec.Color) { }
                field(FG; Rec.FG) { }
                field(HMF; Rec.HMF) { }
            }
        }
    }

    actions
    {
        area(Creation)
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
                separator(Seprator1) { }
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

            action("De-Crystlizer Details")
            {
                ApplicationArea = All;
                Caption = 'De-Crystlizer Details';
                Image = Production;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    recBatchProcess.RESET;
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                    recBatchProcess.SETRANGE("Document No.", Rec."No.");
                    IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                        recBatchProcess.INIT;
                        recBatchProcess.Type := recBatchProcess.Type::"De-Crystallizer";
                        recBatchProcess."Document No." := Rec."No.";
                        recBatchProcess.Date := TODAY;
                        recBatchProcess."Customer Code" := Rec."Customer Code";
                        recBatchProcess."Customer Batch No." := Rec."Batch No.";
                        recBatchProcess.INSERT;
                    END;

                    recBatchProcess.RESET;
                    recBatchProcess.FILTERGROUP(0);
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                    recBatchProcess.SETRANGE("Document No.", Rec."No.");
                    recBatchProcess.FILTERGROUP(2);

                    CLEAR(pgBatchProcess);
                    pgBatchProcess.SETTABLEVIEW(recBatchProcess);
                    pgBatchProcess.RUN;
                end;
            }
            action("Vacuum Circulation")
            {
                ApplicationArea = All;
                Caption = 'Vacuum Circulation';
                Image = Production;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    recBatchProcess.RESET;
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                    recBatchProcess.SETRANGE("Document No.", Rec."No.");
                    IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                        recBatchProcess.INIT;
                        recBatchProcess.Type := recBatchProcess.Type::"Vaccum Circulation";
                        recBatchProcess."Document No." := Rec."No.";
                        recBatchProcess.Date := TODAY;
                        recBatchProcess.INSERT;
                    END;

                    recBatchProcess.RESET;
                    recBatchProcess.FILTERGROUP(0);
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                    recBatchProcess.SETRANGE("Document No.", Rec."No.");
                    recBatchProcess.FILTERGROUP(2);

                    CLEAR(pgVacuumCirculation);
                    pgVacuumCirculation.SETTABLEVIEW(recBatchProcess);
                    pgVacuumCirculation.RUN;
                end;
            }
            action("Plan Weight Register")
            {
                ApplicationArea = All;
                Caption = 'Plan Weight Register';
                Image = Production;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    recBatchProcess.RESET;
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Weighing Register");
                    recBatchProcess.SETRANGE("Document No.", Rec."No.");
                    IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                        recBatchProcess.INIT;
                        recBatchProcess.Type := recBatchProcess.Type::"Weighing Register";
                        recBatchProcess."Document No." := Rec."No.";
                        recBatchProcess.Date := TODAY;
                        recBatchProcess.INSERT;
                    END;

                    recBatchProcess.RESET;
                    recBatchProcess.FILTERGROUP(0);
                    recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Weighing Register");
                    recBatchProcess.SETRANGE("Document No.", Rec."No.");
                    recBatchProcess.FILTERGROUP(2);

                    CLEAR(pgPlanWeightRegister);
                    pgPlanWeightRegister.SETTABLEVIEW(recBatchProcess);
                    pgPlanWeightRegister.RUN;
                end;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Change &Status")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Prod. Order Status Management";
                }
                action(Components)
                {
                    ApplicationArea = All;
                    Caption = 'Components';
                    Image = Components;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        recProdOrderComponent.SETRANGE(Status, Rec.Status);
                        recProdOrderComponent.SETRANGE("Prod. Order No.", Rec."No.");
                        recProdOrderComponent.SETRANGE("Prod. Order Line No.", 10000);

                        PAGE.RUN(PAGE::"Prod. Order Components", recProdOrderComponent);
                    end;
                }
                action("Send for Material Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Send for Material Issue';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        IF NOT CONFIRM('Submit the order for material issue?', FALSE) THEN
                            EXIT;

                        recBatchProcessLine.RESET;
                        recBatchProcessLine.SETRANGE(Type, recBatchProcessLine.Type::"Weighing Register");
                        recBatchProcessLine.SETRANGE("Document No.", Rec."No.");
                        IF recBatchProcessLine.FINDLAST THEN
                            intLineNo := recBatchProcessLine."Line No."
                        ELSE
                            intLineNo := 0;

                        recPurchaseSetup.GET;
                        recPurchaseSetup.TESTFIELD("Raw Honey Item");

                        recProdOrderComponent.RESET;
                        recProdOrderComponent.SETRANGE(Status, Rec.Status);
                        recProdOrderComponent.SETRANGE("Prod. Order No.", Rec."No.");
                        recProdOrderComponent.SETFILTER("Remaining Quantity", '<>%1', 0);
                        IF NOT recProdOrderComponent.FINDFIRST THEN
                            ERROR('Nothing to issue.')
                        ELSE BEGIN
                            REPEAT
                                recBatchProcess.RESET;
                                recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Weighing Register");
                                recBatchProcess.SETRANGE("Document No.", recProdOrderComponent."Prod. Order No.");
                                IF NOT recBatchProcess.FINDFIRST THEN BEGIN
                                    recBatchProcess.INIT;
                                    recBatchProcess.Type := recBatchProcess.Type::"Weighing Register";
                                    recBatchProcess."Document No." := recProdOrderComponent."Prod. Order No.";
                                    recBatchProcess.Date := TODAY;
                                    recBatchProcess.INSERT;
                                END;
                                recProdOrderComponent.VALIDATE("Quantity per");
                                recProdOrderComponent.MODIFY;

                                recLotTracking.RESET;
                                recLotTracking.SETRANGE("Document Type", recLotTracking."Document Type"::Consumption);
                                recLotTracking.SETRANGE("Document No.", recProdOrderComponent."Prod. Order No.");
                                recLotTracking.SETRANGE("Item No.", recProdOrderComponent."Item No.");
                                recLotTracking.SETRANGE("Location Code", recProdOrderComponent."Location Code");
                                IF recLotTracking.FINDFIRST THEN
                                    REPEAT

                                        recBatchProcessLine.INIT;
                                        recBatchProcessLine.Type := recBatchProcessLine.Type::"Weighing Register";
                                        recBatchProcessLine."Document No." := recProdOrderComponent."Prod. Order No.";
                                        intLineNo += 10000;
                                        recBatchProcessLine."Line No." := intLineNo;
                                        recBatchProcessLine."Lot No." := recLotTracking."Lot No.";
                                        recBatchProcessLine."Packing Qauntity" := recLotTracking."Qty. In Packs";
                                        recBatchProcessLine."Plan Weight" := recLotTracking.Quantity;
                                        recBatchProcessLine."Packing Type" := recLotTracking."Packing Type";
                                        recBatchProcessLine."Qty. Per Pack" := recLotTracking."Average Qty. In Pack";
                                        recBatchProcessLine.INSERT;
                                    UNTIL recLotTracking.NEXT = 0;

                                recReservationEntry.RESET;
                                recReservationEntry.SETRANGE("Item No.", recProdOrderComponent."Item No.");
                                recReservationEntry.SETRANGE("Location Code", recProdOrderComponent."Location Code");
                                recReservationEntry.SETRANGE("Source Type", 5407);
                                recReservationEntry.SETRANGE("Source Subtype", 3);
                                recReservationEntry.SETRANGE("Source ID", recProdOrderComponent."Prod. Order No.");
                                recReservationEntry.SETRANGE("Source Prod. Order Line", recProdOrderComponent."Prod. Order Line No.");
                                recReservationEntry.SETRANGE("Source Ref. No.", recProdOrderComponent."Line No.");
                                IF recReservationEntry.FINDFIRST THEN
                                    REPEAT
                                        recBatchProcessLine.INIT;
                                        recBatchProcessLine.Type := recBatchProcessLine.Type::"Weighing Register";
                                        recBatchProcessLine."Document No." := recProdOrderComponent."Prod. Order No.";
                                        intLineNo += 10000;
                                        recBatchProcessLine."Line No." := intLineNo;
                                        recBatchProcessLine."Lot No." := recReservationEntry."Lot No.";
                                        recBatchProcessLine."Packing Qauntity" := recReservationEntry."Qty. in Pack";
                                        recBatchProcessLine."Plan Weight" := ABS(recReservationEntry."Quantity (Base)");
                                        recBatchProcessLine."Packing Type" := recReservationEntry."Packing Type".AsInteger();
                                        recBatchProcessLine."Qty. Per Pack" := recReservationEntry."Qty. Per Pack";
                                        recBatchProcessLine.INSERT;
                                    UNTIL recReservationEntry.NEXT = 0;
                            UNTIL recProdOrderComponent.NEXT = 0;
                        END;

                        IF NOT Rec."Start Time Initiated" THEN
                            Rec."Starting Time" := TIME + 192600000;
                        Rec."Start Time Initiated" := TRUE;
                        Rec."Requested Material Issue" := TRUE;
                        Rec.MODIFY;

                        MESSAGE('The material issue request is successfully submitted.');
                        CurrPage.UPDATE;
                    end;
                }
                action("Generate Bar Codes")
                {
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        IF NOT CONFIRM('Do you want to generage bar code for the selected production order?', FALSE) THEN
                            EXIT;

                        Rec.GenerateBarCode;
                    end;
                }
                action("Print Bar Codes")
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    var
                        rptBarCode: Report "Barcode Report 1";
                    begin

                        CLEAR(rptBarCode);
                        rptBarCode.SetRecevingNo(Rec."No.");
                        rptBarCode.RUN;
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = "Action";
                action("Print Weight Register")
                {
                    Caption = 'Print Weight Register';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        REPORT.RUN(50030, TRUE, TRUE);
                    end;
                }
                action("Print De-Crystallizer")
                {
                    Caption = 'Print De-Crystallizer';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        recBatchProcess.RESET;
                        recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"De-Crystallizer");
                        recBatchProcess.SETRANGE("Document No.", Rec."No.");

                        REPORT.RUN(50031, TRUE, TRUE, recBatchProcess);
                    end;
                }
                action("Print Vacuum Circulation")
                {
                    Caption = 'Print Vacuum Circulation';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        recBatchProcess.RESET;
                        recBatchProcess.SETRANGE(Type, recBatchProcess.Type::"Vaccum Circulation");
                        recBatchProcess.SETRANGE("Document No.", Rec."No.");

                        REPORT.RUN(50032, TRUE, TRUE, recBatchProcess);
                    end;
                }
                action("Production Job Card")
                {
                    Caption = 'Production Job Card';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        recProdOrder.RESET;
                        recProdOrder.SETRANGE(Status, Rec.Status);
                        recProdOrder.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Prod. Order - Job Card", TRUE, TRUE, recProdOrder);
                    end;
                }
            }
        }
    }

    var
        recProdOrderComponent: Record "Prod. Order Component";
        recBatchProcess: Record "Batch Process Header";
        pgBatchProcess: Page "De-Crystallizer Card";
        pgVacuumCirculation: Page "Vacuum Circulation Card";
        recReservationEntry: Record "Reservation Entry";
        recBatchProcessLine: Record "Batch Process Line";
        intLineNo: Integer;
        pgPlanWeightRegister: Page "Plan Weight Register Card";
        recPurchaseSetup: Record "Purchases & Payables Setup";
        recProdOrder: Record "Production Order";
        recLotTracking: Record "Tran. Lot Tracking";
}
