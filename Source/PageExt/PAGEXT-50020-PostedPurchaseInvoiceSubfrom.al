pageextension 50020 PostedPurchaseInvoiceSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Deal No."; Rec."Deal No.")
            {
                ApplicationArea = all;
            }
            field("Deal Line No."; Rec."Deal Line No.")
            {
                ApplicationArea = All;
            }
            field(Flora; Rec.Flora)
            {
                ApplicationArea = All;
            }
            field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
            {
                ApplicationArea = All;
            }
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = all;
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