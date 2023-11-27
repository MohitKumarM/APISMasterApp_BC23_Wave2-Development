page 50028 "Vacuum Circulation Sub Page"
{
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Batch Process Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No."; rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Initial Moisture"; rec."Initial Moisture")
                {
                    ApplicationArea = All;
                }
                field("In Time"; rec."In Time")
                {
                    ApplicationArea = All;
                }
                field("Vacuum Presure"; rec."Vacuum Presure")
                {
                    ApplicationArea = All;
                }
                field("Water Temp. Dec. C."; rec."Water Temp. Dec. C.")
                {
                    Caption = 'Hot Water Temp.';
                    ApplicationArea = All;
                }
                field("Out Time"; rec."Out Time")
                {
                    ApplicationArea = All;
                }
                field("Honey Temp."; rec."Honey Temp.")
                {
                    ApplicationArea = All;
                }
                field("Out Moisture"; rec."Out Moisture")
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
