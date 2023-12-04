tableextension 50030 SalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(60015; "APIS_Transaction Type"; Enum "Transaction Type")
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
        }
    }
}