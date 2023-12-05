page 50153 "Item Approval List"
{
    Caption = 'Item Approval List';
    CardPageID = "Item Approval Card";
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    SourceTable = "Nonstock Item";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending)
                      WHERE("Pending Approval" = FILTER(true),
                            Approved = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(lines)
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

    trigger OnOpenPage()
    begin
        recUserSetup.GET(USERID);
        IF NOT recUserSetup."Allow Item Approval" THEN
            ERROR('You are not authorized for item approval, contact your system administrator.');
    end;

    var
        recNonStockItem: Record "Nonstock Item";
        recUserSetup: Record "User Setup";
}

