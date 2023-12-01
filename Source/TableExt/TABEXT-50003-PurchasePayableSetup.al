tableextension 50003 PurchPayableSetup extends "Purchases & Payables Setup"
{
    fields
    {
        field(50002; "Raw Honey Item"; Code[20])
        {
            TableRelation = Item;
        }
        field(50003; "Honey Order Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50004; "PO Terms & Conditions"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Tin Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(50006; "Drum Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(50007; "Bucket Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(50009; "CAN Item"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(70001; "Deal Tolerance"; Decimal) { }
    }
}