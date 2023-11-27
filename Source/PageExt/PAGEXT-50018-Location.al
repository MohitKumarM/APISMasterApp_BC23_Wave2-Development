pageextension 50018 Location extends "Location Card"
{
    layout
    {
        addafter(City)
        {
            field("QC Rejection Location"; Rec."QC Rejection Location")
            {
                ApplicationArea = all;
            }
            field("OK Store Location"; Rec."OK Store Location")
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