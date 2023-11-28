page 50011 "Deal Dispatch List"
{
    Caption = 'Deal Dispatch List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Deal Dispatch Details";
    SourceTableView = SORTING("Sauda No.", "Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sauda No."; Rec."Sauda No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Dispatched Tins / Buckets"; Rec."Dispatched Tins / Buckets")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Beekeeper Name Name"; Rec."Beekeeper Name Name")
                {
                    ApplicationArea = All;
                }
                field("Qty. in Kg."; Rec."Qty. in Kg.")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("GAN Created"; Rec."GAN Created")
                {
                    ApplicationArea = All;
                }
                field("GAN No."; Rec."GAN No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions { }
}
