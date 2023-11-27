table 50001 "Deal Dispatch Details"
{
    DrillDownPageID = "Deal Dispatch List";
    LookupPageID = "Deal Dispatch List";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sauda No."; Code[20])
        {
            TableRelation = "Deal Master";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Dispatch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Dispatched Tins / Buckets"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Flora; Code[20])
        {
            Editable = false;
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
            DataClassification = ToBeClassified;
        }
        field(6; "Packing Type"; Option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
        }
        field(7; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Beekeeper Name Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Qty. in Kg."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Location Name"; Text[20])
        {
            TableRelation = State;
            DataClassification = ToBeClassified;
        }
        field(11; "GAN Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "GAN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sauda No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
