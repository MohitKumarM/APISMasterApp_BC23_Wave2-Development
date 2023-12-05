page 50159 "Nonstock Item List"
{
    Caption = 'Item List';
    //CardPageID = "Nonstock Item Card";
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    SourceTable = "Nonstock Item";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending)
                      WHERE("Pending Approval" = FILTER(false),
                            Approved = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field(Description; Rec.Description)
                {
                }
                field("Extended Description"; Rec."Extended Description")
                {
                }
                field("Barcode No."; Rec."Barcode No.")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        recNonStockItem: Record "Nonstock Item";
}

