page 50059 "Plan Weight Register Card"
{
    DeleteAllowed = false;
    Editable = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Batch Process Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                }
            }
            part("Plan Weight Register Sub Page"; "Plan Weight Register Sub Page")
            {
                SubPageLink = Type = FIELD(Type), "Document No." = FIELD("Document No.");
                SubPageView = SORTING(Type, "Document No.", "Line No.") ORDER(Ascending);
            }
        }
    }

    actions
    {
    }

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

