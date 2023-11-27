pageextension 50025 PurchaseHedaerArchive extends "Purchase Order Archive"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Short Close Comment"; Rec."Short Close Comment")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}