page 50067 "Material Req. SubPage"
{
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Material Requisition Line";
    SourceTableView = SORTING("Req. No.", "Line No.")
                      ORDER(Ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Item Name"; Rec."Item Name")
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                }
                field("Requested Quantity"; Rec."Requested Quantity") { }
                field("Stock at RRK Store"; Rec."Stock at RRK Store") { }
            }
        }
    }

    actions { }
}
