pageextension 50014 "Purch. Invoice Subform Page" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Deal Line No."; Rec."Deal Line No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Deal No."; Rec."Deal No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Flora; Rec.Flora)
            {
                ApplicationArea = All;
                Visible = false;
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
}
