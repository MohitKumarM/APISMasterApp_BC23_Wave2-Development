pageextension 50063 "Prod. BOM Line Ext." extends "Production BOM Lines"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Wastage %"; Rec."Wastage %")
            {
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}