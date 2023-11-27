page 50005 "Quality Check Lines"
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
                field("Quality Process"; rec."Quality Process")
                {
                    ApplicationArea = All;
                }
                field("Quality Measure"; rec."Quality Measure")
                {
                    ApplicationArea = All;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = All;
                }
                field(Specs; rec.Specs)
                {
                    ApplicationArea = All;
                }
                field(Limit; rec.Limit)
                {
                    ApplicationArea = All;
                }
                field(Observation; rec.Observation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
