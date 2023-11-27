pageextension 50022 PurchaseCrSubform extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Deal No."; Rec."Deal No.")
            {
                ApplicationArea = All;
            }

            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = All;
            }
            field("Qty. in Pack"; Rec."Qty. in Pack")
            {
                ApplicationArea = All;
            }
            field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
            {
                ApplicationArea = All;
                Caption = 'Order Quantity';
            }
            field(Flora; Rec.Flora)
            {
                ApplicationArea = All;
            }
            field("Unit Rate"; Rec."Unit Rate")
            {
                ApplicationArea = all;
            }
            field("Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = all;
            }
            field("Other Charges"; Rec."Other Charges")
            {
                ApplicationArea = all;
            }
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field("New TDS Base Amount"; Rec."New TDS Base Amount")
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