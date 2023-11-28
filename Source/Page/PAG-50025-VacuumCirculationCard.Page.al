page 50025 "Vacuum Circulation Card"
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
                field("Document No."; rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            part("Vacuum Circulation Sub Page"; "Vacuum Circulation Sub Page")
            {
                SubPageLink = Type = FIELD(Type),
                              "Document No." = FIELD("Document No.");
                SubPageView = SORTING(Type, "Document No.", "Line No.")
                              ORDER(Ascending);
            }
        }
    }

    actions { }

    trigger OnOpenPage()
    begin
        recProdctonOrder.RESET;
        recProdctonOrder.SETRANGE("No.", rec."Document No.");
        IF (recProdctonOrder.FINDFIRST) AND (recProdctonOrder.Status <> recProdctonOrder.Status::Released) THEN
            CurrPage.EDITABLE := FALSE;
    end;

    var
        recProdctonOrder: Record "Production Order";
}
