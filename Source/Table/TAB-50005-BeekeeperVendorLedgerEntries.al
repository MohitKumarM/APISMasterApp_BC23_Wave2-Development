table 50005 "BeeKeeper VendorLedger Entries"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Vendor Code"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
        }
        field(3; "Beekeeper Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Deal No."; Code[20])
        {
            TableRelation = "Deal Master";
            DataClassification = ToBeClassified;
        }
        field(9; "Deal Dispatch No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Flora; Code[20])
        {
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
            DataClassification = ToBeClassified;
        }
        field(11; "Dispatched Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Packing Type"; Enum "Packing Type")
        {
            Editable = false;
            // OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            // OptionMembers = " ",Drums,Tins,Buckets,Cans;
            DataClassification = ToBeClassified;
        }
        field(13; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Qty. in Kg."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Invoiced Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Unit Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Beekeeper Code", "Document Date") { }
    }

    fieldgroups { }
}
