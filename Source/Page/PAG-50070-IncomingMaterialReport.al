page 50070 "Incoming Material Report"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = ORDER(Ascending)
                      WHERE("Entry Type" = FILTER('Purchase'),
                            "Document Type" = FILTER('Purchase Receipt'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Lot No."; Rec."Lot No.")
                {
                }
                field(Flora; Rec.Flora)
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                }
                field("Purchaser Name"; Rec."Purchaser Name")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Packing Type"; Rec."Packing Type")
                {
                }
                field("Qty. in Pack"; Rec."Qty. in Pack")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Moisture (%)"; Rec."Moisture (%)")
                {
                }
                field("Color (MM)"; Rec."Color (MM)")
                {
                }
                field("HMF (PPM)"; Rec."HMF (PPM)")
                {
                }
                field(TRS; Rec.TRS)
                {
                }
                field(Sucrose; Rec.Sucrose)
                {
                }
                field(FG; Rec.FG)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        recPurchaserSetup.GET;
        Rec.FILTERGROUP(0);
        Rec.SETRANGE("Item No.", recPurchaserSetup."Raw Honey Item");
        Rec.FILTERGROUP(2);
    end;

    var
        recPurchaserSetup: Record "Purchases & Payables Setup";
}

