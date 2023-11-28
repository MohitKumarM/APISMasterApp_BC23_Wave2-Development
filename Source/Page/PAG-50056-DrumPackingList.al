page 50056 "Drum Packing List"
{
    LinksAllowed = false;
    ShowFilter = false;
    SourceTable = "Pre Packing List";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Container No."; Rec."Container No.")
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
                field("Best Before"; Rec."Best Before")
                {
                    ApplicationArea = All;
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                }
                field("Prod. Date"; Rec."Prod. Date")
                {
                    ApplicationArea = All;
                }
                field("Product Code Text"; Rec."Product Code Text")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Drum Weight (Kg.)"; Rec."Drum Weight (Kg.)")
                {
                    ApplicationArea = All;
                }
                field("No. of Pallets"; Rec."No. of Pallets")
                {
                    ApplicationArea = All;
                }
                field("Pallet Weight (Kg.)"; Rec."Pallet Weight (Kg.)")
                {
                    ApplicationArea = All;
                }
                field("Pallet Total"; Rec."Pallet Total")
                {
                    ApplicationArea = All;
                }
                field("FCL Type"; Rec."FCL Type")
                {
                    ApplicationArea = All;
                }
                field("Pallet Serial No."; Rec."Pallet Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Cartoons Serial No."; Rec."Cartoons Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions { }
}
