page 50036 "Honey GAN Creation"
{
    CardPageID = "Honey GAN Order";
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
                            "Order Approval Pending" = const(true),
                            "GAN Approval Pending" = const(false));

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
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print GAN")
                {
                    Caption = '&Print GAN';
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

                        REPORT.RUN(Report::"Purchase Receipt Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("&Print Order")
                {
                    Caption = '&Print Order';
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

                        REPORT.RUN(Report::"Purchase Order", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("&Print Order GST")
                {
                    Caption = '&Print Order GST';
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

                        // REPORT.RUN(50024, TRUE, TRUE, recPurchHeader);
                        REPORT.RUN(Report::"Purchase Order Gst", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("Print GST GAN")
                {
                    Caption = 'Print GST GAN';
                    Image = Print;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt H-Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
            }
        }
    }
}
