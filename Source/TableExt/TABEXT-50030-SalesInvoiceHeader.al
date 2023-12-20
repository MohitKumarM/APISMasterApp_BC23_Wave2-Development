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
        field(80007; "Transporter Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80008; "Vehichle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80009; "Driver Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80010; "Driver Mob No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80011; "Driver Adhar No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80012; "Loading Start Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(80013; "Loading End Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(80014; "Stock In Hand"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(80015; "Quantity Loaded"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}