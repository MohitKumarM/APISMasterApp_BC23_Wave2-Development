page 50147 "Packing Orders Material Req."
{
    Caption = 'Prod. Orders Material Request';
    CardPageID = "Released Production Order";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released),
                            Refreshed = FILTER(true),
                            "Order Type" = FILTER(Packing),
                            "Requested Material Issue" = FILTER(false),
                            "Packing Approved" = FILTER(true));
    ApplicationArea = All;

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
                field(Description; Rec.Description)
                {
                }
                field("Source No."; Rec."Source No.")
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
                action("Change &Status")
                {
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Prod. Order Status Management";
                }

                action(Components)
                {
                    Caption = 'Components';
                    Image = Components;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recProdOrderComponent: Record "Prod. Order Component";
                    begin
                        recProdOrderComponent.SETRANGE(Status, Rec.Status);
                        recProdOrderComponent.SETRANGE("Prod. Order No.", Rec."No.");
                        recProdOrderComponent.SETRANGE("Prod. Order Line No.", 10000);

                        PAGE.RUN(PAGE::"Prod. Order Components", recProdOrderComponent);
                    end;
                }
                action("Send for Material Issue")
                {
                    Caption = 'Send for Material Issue';
                    Image = SendTo;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recProdOrderComponent: Record "Prod. Order Component";
                    begin
                        IF NOT CONFIRM('Submit the order for material issue?', FALSE) THEN
                            EXIT;

                        recProdOrderComponent.RESET;
                        recProdOrderComponent.SETRANGE(Status, Rec.Status);
                        recProdOrderComponent.SETRANGE("Prod. Order No.", Rec."No.");
                        recProdOrderComponent.SETFILTER("Remaining Quantity", '<>%1', 0);
                        IF NOT recProdOrderComponent.FINDFIRST THEN
                            ERROR('Nothing to issue.');

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

                    trigger OnAction()
                    var
                        rptBarCode: Report "Barcode Report 1";
                    begin

                        CLEAR(rptBarCode);
                        rptBarCode.SetRecevingNo(Rec."No.");
                        rptBarCode.RUN;
                    end;
                }
                // action("Show Bar Codes")
                // {
                //     Image = ListPage;
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     RunObject = Page "Bar Code List";
                //     RunPageLink = Receiving No.=FIELD(No.);
                //     RunPageView = SORTING(Receiving No.,Receiving Line No.,Line No.)
                //                   ORDER(Ascending);
                // }
            }
        }
    }

    var
        recProdOrderComponent: Record "Prod. Order Component";
}

