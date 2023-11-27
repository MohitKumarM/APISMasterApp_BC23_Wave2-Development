pageextension 50038 "SalesOrder" extends "Sales Order"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()

            begin
                if rec."GST Customer Type" = Rec."GST Customer Type"::Export then
                    Error('Export Orders Can be Create Only Export Page.');
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}