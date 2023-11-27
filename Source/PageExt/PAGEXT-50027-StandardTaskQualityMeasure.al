pageextension 50027 StandardTaskQltyMeasures extends "Standard Task Qlty Measures"
{
    Caption = 'Standard Task Qlty Measures';
    layout
    {
        addafter(Description)
        {
            field(Limit; Rec.Limit)
            {
                ApplicationArea = All;
            }
            field(Specs; Rec.Specs)
            {
                ApplicationArea = All;
            }
        }
    }
}
