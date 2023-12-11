table 50009 "Tran. Lot Tracking"
{
    DrillDownPageID = "Cons. Lot Tracking View";
    LookupPageID = "Cons. Lot Tracking View";

    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(3; "Lot No."; Code[20]) { }
        field(4; Flora; Code[20])
        {
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
            DataClassification = ToBeClassified;
        }

        field(6; "Qty. In Packs"; Decimal)
        {
            trigger OnValidate()
            begin
                IF "Qty. In Packs" <> 0 THEN
                    "Average Qty. In Pack" := Quantity / "Qty. In Packs";
            end;
        }
        field(7; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                Rec.TESTFIELD("Qty. In Packs");
                "Average Qty. In Pack" := Quantity / "Qty. In Packs";
            end;
        }
        field(8; "Average Qty. In Pack"; Decimal)
        {
            Editable = false;
        }
        field(9; "Document No."; Code[20]) { }
        field(10; "Document Line No."; Integer) { }
        field(11; "Applied Qty."; Decimal)
        {
            CalcFormula = Sum("Tran. Lot Tracking".Quantity WHERE("Document No." = FIELD("Document No."),
                                                                   "Document Line No." = FIELD("Document Line No."),
                                                                   "Item No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Qty. To Receive"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Qty. to Receive" WHERE("Document No." = FIELD("Document No."),
                                                                       "Line No." = FIELD("Document Line No."),
                                                                       "No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(14; "Tare Weight"; Decimal) { }
        field(1000; "Document Type"; Option)
        {
            OptionCaption = 'Purch. Receipt,Consumption,Transfer';
            OptionMembers = "Purch. Receipt",Consumption,Transfer;
        }
        field(1001; "Ref. Entry No."; Integer)
        {
            TableRelation = "Lot Tracking Entry";
        }
        field(1002; "Remaining Qty. In Packs"; Decimal)
        {
            Editable = false;
        }
        field(1003; "Remaining Quantity"; Decimal)
        {
            Editable = false;
        }
        field(2004; Tin; Decimal) { }
        field(2005; Drum; Decimal) { }
        field(2006; Can; Decimal) { }
        field(2007; Bucket; Decimal) { }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Document Line No.", "Item No.", "Lot No.")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups { }

    trigger OnInsert()
    begin
        recTranLotEntry.RESET;
        IF recTranLotEntry.FINDLAST THEN
            Rec."Entry No." := recTranLotEntry."Entry No." + 1
        ELSE
            Rec."Entry No." := 1;
    end;

    var
        recTranLotEntry: Record "Tran. Lot Tracking";
}
