tableextension 50006 SalesRecivableSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Sauda Nos."; Code[10])
        {
            Caption = 'Deal No.';
            TableRelation = "No. Series";
        }
        field(50001; "Sales Export Order No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Posted Invoice Export No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "Posted Shipment Export No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}