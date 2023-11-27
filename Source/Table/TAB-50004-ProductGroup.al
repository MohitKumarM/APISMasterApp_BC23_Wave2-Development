table 50004 "New Product Group"
{
    Caption = 'Product Group';
    DataClassification = ToBeClassified;
    LookupPageId = "New Product Groups";
    DataPerCompany = true;
    PasteIsValid = true;

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Warehouse Class Code"; Code[10])
        {
            Caption = 'Warehouse Class Code';
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Class";
        }
        field(5; "Allow Direct Purch. Order"; Boolean)
        {
            Caption = 'Allow Direct Purch. Order';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code, "Item Category Code")
        {
            Clustered = true;
        }
    }
}
