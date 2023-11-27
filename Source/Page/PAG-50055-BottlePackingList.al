page 50055 "Bottling Packing List"
{
    Caption = 'Bottling Packing List';
    DelayedInsert = true;
    LinksAllowed = false;
    ShowFilter = false;
    SourceTable = "Pre Packing List";
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Container No."; Rec."Container No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("FCL Type"; Rec."FCL Type")
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
                field("Pallet Serial No."; Rec."Pallet Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Cartoons Serial No."; Rec."Cartoons Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Prod. Date"; Rec."Prod. Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Best Before"; Rec."Best Before")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Meilleur Avant"; Rec."Meilleur Avant")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Factory Code"; Rec."Factory Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Product Code"; Rec."Product Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Product Code Text"; Rec."Product Code Text")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pallet Total"; Rec."Pallet Total")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

