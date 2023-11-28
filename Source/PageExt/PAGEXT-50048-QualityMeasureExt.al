pageextension 50048 QualityMeasureExt extends "Quality Measures"
{
    layout
    {
        addafter(Description)
        {
            field("Measure Type"; Rec."Measure Type")
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