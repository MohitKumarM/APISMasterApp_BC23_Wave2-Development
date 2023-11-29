page 50026 "De-Crystallizer Batch Details"
{
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Batch Process Line";
    SourceTableView = SORTING(Type, "Document No.", "Line Type", "Line No.")
                      ORDER(Ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

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
                field("Oven No."; Rec."Oven No.")
                {
                    ApplicationArea = All;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
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
