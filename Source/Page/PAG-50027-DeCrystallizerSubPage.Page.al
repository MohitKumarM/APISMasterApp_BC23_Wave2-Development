page 50027 "De-Crystallizer Sub Page"
{
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Batch Process Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = SORTING(Type, "Document No.", "Line Type", "Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("Temp. Deg. C."; Rec."Temp. Deg. C.")
                {
                    ApplicationArea = All;
                }
                field("Water Temp. Dec. C."; Rec."Water Temp. Dec. C.")
                {
                    ApplicationArea = All;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions { }
}
