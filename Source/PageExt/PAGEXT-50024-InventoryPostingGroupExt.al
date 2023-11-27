pageextension 50024 "Inventory Posting Group Ext." extends "Inventory Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field("Activate Expiry Date FIFO"; Rec."Activate Expiry Date FIFO")
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