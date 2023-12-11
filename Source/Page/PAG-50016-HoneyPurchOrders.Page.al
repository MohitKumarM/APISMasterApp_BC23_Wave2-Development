page 50016 "Honey Purch. Orders"
{
    CardPageID = "Honey Purchase Order";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Header";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Order),
                            Status = FILTER(Open),
                            "Order Type" = FILTER(Honey),
                            "Order Approval Pending" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(New)
            {
                Caption = 'New';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    recPurchSetup.GET;
                    recPurchSetup.TESTFIELD("Honey Order Nos.");

                    cdOrderCode := cuNoSeries.GetNextNo(recPurchSetup."Honey Order Nos.", TODAY, TRUE);

                    recOrder.INIT;
                    recOrder.VALIDATE("Document Type", recOrder."Document Type"::Order);
                    //recOrder.VALIDATE("No.", cdOrderCode);
                    recOrder."No." := cdOrderCode;
                    recOrder."Order Type" := recOrder."Order Type"::Honey;
                    recOrder.INSERT(TRUE);

                    recOrder.RESET;
                    recOrder.SETRANGE("Document Type", recOrder."Document Type"::Order);
                    recOrder.SETRANGE("No.", cdOrderCode);

                    CLEAR(pgHoneyOrder);
                    pgHoneyOrder.SETTABLEVIEW(recOrder);
                    pgHoneyOrder.RUN;
                end;
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(50062, TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("&Print GST")
                {
                    Caption = '&Print GST';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(50061, TRUE, TRUE, recPurchHeader);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        recUserSetup.GET(USERID);
        IF (recUserSetup."Purchaser Profile" <> recUserSetup."Purchaser Profile"::All) AND (recUserSetup."Purchaser Profile" <> recUserSetup."Purchaser Profile"::Honey) THEN
            ERROR('You are not authrozed for honey purchase orders, contact your system administrator.');
        Rec.FILTERGROUP(2);
        Rec.SetRange("Short Close", false);
        Rec.FILTERGROUP(0);
    end;

    var
        recPurchSetup: Record "Purchases & Payables Setup";
        recOrder: Record "Purchase Header";
        cdOrderCode: Code[20];
        cuNoSeries: Codeunit NoSeriesManagement;
        pgHoneyOrder: Page "Honey Purchase Order";
        recUserSetup: Record "User Setup";
}
