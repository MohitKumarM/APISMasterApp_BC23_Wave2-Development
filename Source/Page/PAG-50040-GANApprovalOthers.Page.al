/* page 50040 "GAN Approval Others"
{
    CardPageID = "GAN Approval Order";
    DeleteAllowed = false;
    Caption = 'GAN Approval Others';
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
                            "GAN Approval Pending" = const(true));
    //"Order Type" = FILTER(Other));

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
        area(navigation)
        {
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
                        // DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("Print GST GAN")
                {
                    Caption = 'Print GST GAN';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        // DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt Other Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
            }
        }
    }
}
 */