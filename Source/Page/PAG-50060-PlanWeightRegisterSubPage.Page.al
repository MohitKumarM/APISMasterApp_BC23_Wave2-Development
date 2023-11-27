page 50060 "Plan Weight Register Sub Page"
{
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Batch Process Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                }
                field("Packing Qauntity"; Rec."Packing Qauntity")
                {
                }
                field("Packing Type"; Rec."Packing Type")
                {
                }
                field("Plan Weight"; Rec."Plan Weight")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Tare Weight"; Rec."Tare Weight")
                {
                }
                field("Nett Weight"; Rec."Nett Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

