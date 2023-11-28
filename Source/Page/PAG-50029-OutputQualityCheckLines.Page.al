page 50029 "Output Quality Check Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Quality Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quality Process"; Rec."Quality Process")
                {
                    ApplicationArea = All;
                }
                field("Quality Measure"; Rec."Quality Measure")
                {
                    ApplicationArea = All;
                }
                field(Parameter; Rec.Parameter)
                {
                    ApplicationArea = All;
                }
                field(Specs; Rec.Specs)
                {
                    ApplicationArea = All;
                }
                field(Limit; Rec.Limit)
                {
                    ApplicationArea = All;
                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions { }
}
