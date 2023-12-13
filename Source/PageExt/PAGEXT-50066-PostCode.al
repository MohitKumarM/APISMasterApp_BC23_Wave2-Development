pageextension 50066 PostCode extends "Post Codes"
{
    layout
    {
        addafter(City)
        {
            field(District; Rec.District)
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