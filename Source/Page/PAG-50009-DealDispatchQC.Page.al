page 50009 "Deal Dispatch QC"
{
    Caption = 'Deal Dispatch Qc';
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
                      ORDER(Ascending)
                      WHERE("GAN Created" = FILTER(true));

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
                field("Qty. in Kg."; Rec."Qty. in Kg.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Beekeeper Name Name"; Rec."Beekeeper Name Name")
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

    actions
    {
        area(navigation)
        {
            action(Quality)
            {
                Caption = 'Quality';
                Image = Info;
                Promoted = true;
                RunObject = Page "Quality Checks";
                RunPageLink = "Document Type" = FILTER("Purchase Receipt"),
                              "Document No." = FIELD("GAN No.");
                RunPageView = SORTING("No.")
                              ORDER(Ascending);
            }
        }
    }
}
