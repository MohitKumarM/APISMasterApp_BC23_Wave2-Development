table 50008 "Lot Tracking Entry"
{
    DrillDownPageID = "Lot Entries";
    LookupPageID = "Lot Entries";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = ToBeClassified;
        }
        field(3; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Flora; Code[20])
        {
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = filter(''));
            DataClassification = ToBeClassified;
        }
        field(5; "Packing Type"; Option)
        {
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
            DataClassification = ToBeClassified;
        }
        field(6; "Qty. In Packs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Remaining Qty." := Quantity;
            end;
        }
        field(8; "Average Qty. In Pack"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = ToBeClassified;
        }
        field(9; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Location Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = ToBeClassified;
        }
        field(14; "Tare Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Stock Type"; Option)
        {
            OptionCaption = 'Raw Material,Pouring,Sales Return';
            OptionMembers = "Raw Material",Pouring,"Sales Return";
            DataClassification = ToBeClassified;
        }
        field(16; Customer; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Remaining Qty."; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(101; "Moisture (%)"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Color (MM)"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "HMF (PPM)"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(104; TRS; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(105; Sucrose; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(106; FG; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(107; Positive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2000; "Rem. Qty. In Packs"; Decimal)
        {
            CalcFormula = Sum("Lot Tracking Entry"."Qty. In Packs" WHERE("Ref. Entry No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(2001; "Ref. Entry No."; Integer)
        {
            TableRelation = "Lot Tracking Entry";
            DataClassification = ToBeClassified;
        }
        field(2002; "Applied Qty. In Packs"; Decimal)
        {
            CalcFormula = Sum("Tran. Lot Tracking"."Qty. In Packs" WHERE("Ref. Entry No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(2003; "Document Date"; Date)
        {
            CalcFormula = Lookup("Item Ledger Entry"."Posting Date" WHERE("Item No." = FIELD("Item No."),
                                                                           "Lot No." = FIELD("Lot No."),
                                                                           "Positive" = FIELD("Positive"),
                                                                           "Document No." = FIELD("Document No."),
                                                                           "Location Code" = field("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Document Line No.", "Item No.", "Location Code", "Lot No.", Positive, "Remaining Qty.")
        {
            SumIndexFields = Quantity;
        }
        key(Key3; "Posting Date", "Item No.", "Lot No.", Positive) { }
    }

    fieldgroups { }
}
