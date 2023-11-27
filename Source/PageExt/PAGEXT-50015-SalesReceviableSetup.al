pageextension 50015 SalesRecivalbeSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Credit Memo Nos.")
        {
            field("Sauda Nos."; Rec."Sauda Nos.")
            {
                ApplicationArea = all;
            }
            field("Sales Export Order No."; Rec."Sales Export Order No.")
            {
                ApplicationArea = all;
            }
            field("Posted Invoice Export No."; Rec."Posted Invoice Export No.")
            {
                ApplicationArea = all;
            }
            field("Posted Shipment Export No."; Rec."Posted Shipment Export No.")
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