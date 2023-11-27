page 50010 "Deal History List"
{
    Caption = 'Close Deal';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Deal Master";
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Close));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Name"; Rec."Purchaser Name")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Deal Qty."; Rec."Deal Qty.")
                {
                    ApplicationArea = All;
                }
                field("Unit Rate in Kg."; Rec."Unit Rate in Kg.")
                {
                    ApplicationArea = All;
                }
                field("Dispatched Qty."; Rec."Dispatched Qty.")
                {
                    ApplicationArea = All;
                }
                field(decRemQuantity; decRemQuantity)
                {
                    Caption = 'Remaining Qty.';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Line; "Deal Dispatch Subform")
            {
                SubPageLink = "Sauda No." = FIELD("No.");
                SubPageView = SORTING("Sauda No.", "Line No.")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Dispatched Qty.");

        decRemQuantity := Rec."Deal Qty." - Rec."Dispatched Qty.";
    end;

    var
        decRemQuantity: Decimal;
}
