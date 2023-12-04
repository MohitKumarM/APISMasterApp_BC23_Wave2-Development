tableextension 50030 SalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(60015; "APIS_Transaction Type"; Enum "Transaction Type")
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(60016; NSM; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60017; ZSM; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60018; RSM; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60019; ASM; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60020; TSM; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60021; SO; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
    }
}