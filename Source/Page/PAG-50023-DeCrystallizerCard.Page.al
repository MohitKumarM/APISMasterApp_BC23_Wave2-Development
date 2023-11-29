page 50023 "De-Crystallizer Card"
{
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Batch Process Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Material Status"; Rec."Material Status")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Batch No."; Rec."Customer Batch No.")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            part(Line; "De-Crystallizer Batch Details")
            {
                SubPageLink = Type = FIELD(Type),
                              "Document No." = FIELD("Document No.");
                SubPageView = SORTING(Type, "Document No.", "Line No.")
                              ORDER(Ascending)
                              WHERE("Line Type" = FILTER("Batch Details"));
            }
            // part(Line_2; "De-Crystallizer Sub Page")
            // {
            //     SubPageLink = Type = FIELD(Type),
            //                   "Document No." = FIELD("Document No.");
            //     SubPageView = SORTING(Type, "Document No.", "Line No.")
            //                   ORDER(Ascending)
            //                   WHERE("Line Type" = FILTER("Line Details"));
            // }
        }
    }

    actions { }

    trigger OnOpenPage()
    begin
        recProdctonOrder.RESET;
        recProdctonOrder.SETRANGE("No.", Rec."Document No.");
        IF (recProdctonOrder.FINDFIRST) AND (recProdctonOrder.Status <> recProdctonOrder.Status::Released) THEN
            CurrPage.EDITABLE := FALSE;
    end;

    var
        recProdctonOrder: Record "Production Order";
}
