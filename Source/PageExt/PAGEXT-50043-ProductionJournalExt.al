pageextension 50043 ProductionournalExt extends "Production Journal"
{
    layout
    {
        addafter(Description)
        {
            field("Prod. Date for Expiry Calc"; Rec."Prod. Date for Expiry Calc")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}