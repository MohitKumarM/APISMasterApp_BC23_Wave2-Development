page 50030 "Lot Entries"
{
    //DeleteAllowed = false;
    //Editable = false;
    //InsertAllowed = false;
    LinksAllowed = false;
    //ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Lot Tracking Entry";
    SourceTableView = SORTING("Document No.", "Document Line No.", "Item No.", "Location Code", "Lot No.", Positive, "Remaining Qty.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }

                field("Qty. In Packs"; Rec."Qty. In Packs")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Average Qty. In Pack"; Rec."Average Qty. In Pack")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Remaining Qty."; Rec."Remaining Qty.")
                {
                    ApplicationArea = All;
                }
                field(Tin; Rec.Tin)
                {
                    ApplicationArea = all;
                }
                field(Drum; Rec.Drum)
                {
                    ApplicationArea = all;
                }
                field(Can; Rec.Can)
                {
                    ApplicationArea = all;
                }
                field(Bucket; Rec.Bucket)
                {
                    ApplicationArea = all;
                }

                field("Moisture (%)"; Rec."Moisture (%)")
                {
                    ApplicationArea = All;
                }
                field("Color (MM)"; Rec."Color (MM)")
                {
                    ApplicationArea = All;
                }
                field("HMF (PPM)"; Rec."HMF (PPM)")
                {
                    ApplicationArea = All;
                }
                field(TRS; Rec.TRS)
                {
                    ApplicationArea = All;
                }
                field(Sucrose; Rec.Sucrose)
                {
                    ApplicationArea = All;
                }
                field(FG; Rec.FG)
                {
                    ApplicationArea = All;
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                }
                field("Rem. Qty. In Packs"; Rec."Rem. Qty. In Packs")
                {
                    ApplicationArea = All;
                }
                field("Ref. Entry No."; Rec."Ref. Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Stock Type"; Rec."Stock Type")
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field("Applied Qty. In Packs"; Rec."Applied Qty. In Packs")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions { }

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Positive, TRUE);
        Rec.SETFILTER("Remaining Qty.", '<>%1', 0);
        Rec.FILTERGROUP(0);
    end;
}
