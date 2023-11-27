pageextension 50011 ItemN1 extends "Item Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("New Product Group Code"; Rec."New Product Group Code")
            {
                ApplicationArea = all;
            }
            field("Expiry Date Formula"; Rec."Expiry Date Formula")
            {
                ApplicationArea = all;
            }
            field("Quality Process"; Rec."Quality Process")
            {
                ApplicationArea = all;
            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}