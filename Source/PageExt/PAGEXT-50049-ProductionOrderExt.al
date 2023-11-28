pageextension 50049 ProductionOrderExt extends "Released Production Order"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Customer Code"; Rec."Customer Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Creation Date"; Rec."Creation Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Production Type"; Rec."Production Type")

            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Moisture; Rec.Moisture)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Color; Rec.Color)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(FG; Rec.FG)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(HMF; Rec.HMF)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Batch No."; Rec."Batch No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}