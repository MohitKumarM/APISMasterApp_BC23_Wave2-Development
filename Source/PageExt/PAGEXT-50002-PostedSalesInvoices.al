pageextension 50002 PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        addafter(Amount)
        {
            field("Amount to Customer"; AmountToCustomer)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        AmountToCustomer: Decimal;

    trigger OnAfterGetRecord()
    var
        LCustomerLedger: Record "Cust. Ledger Entry";
    begin
        Clear(AmountToCustomer);
        LCustomerLedger.Reset();
        LCustomerLedger.SetRange("Document No.", Rec."No.");
        LCustomerLedger.SetRange("Posting Date", Rec."Posting Date");
        LCustomerLedger.SetAutoCalcFields("Amount (LCY)");
        if LCustomerLedger.FindFirst() then
            AmountToCustomer := LCustomerLedger."Amount (LCY)";
    end;

    trigger OnOpenPage()
    begin
    end;
}