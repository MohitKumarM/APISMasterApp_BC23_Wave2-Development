pageextension 50007 PriceListline extends "Price List Lines"
{
    layout
    {
        addafter("Unit Price")
        {
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}