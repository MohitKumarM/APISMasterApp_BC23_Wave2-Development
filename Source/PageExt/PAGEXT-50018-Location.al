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
        addafter("Use As In-Transit")
        {
            field("Associated Plant"; Rec."Associated Plant")
            {
                ApplicationArea = all;
            }
            field("Production Location"; Rec."Production Location")
            {
                ApplicationArea = all;
            }
            field("Store Location"; Rec."Store Location")
            {
                ApplicationArea = all;
            }

            field("Scrap Unit"; Rec."Scrap Location")
            {
                ApplicationArea = all;
            }
            field("Reject Location"; Rec."Reject Location")
            {
                ApplicationArea = all;
            }
            field("Packing Location"; Rec."Packing Location")
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