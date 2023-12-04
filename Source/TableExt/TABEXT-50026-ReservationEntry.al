tableextension 50026 ReservatonEntry extends "Reservation Entry"
{
    fields
    {
        field(50000; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Packing Type"; enum "Packing Type") { }
        field(50003; "Qty. in Pack"; Decimal) { }
        field(50004; "Qty. Per Pack"; Decimal) { }
        field(50005; "Original Qty. in Pack"; Decimal) { }
        field(50006; "Tare Weight"; Decimal) { }
        field(50007; "Manufacturing Date"; Date) { }
        field(50020; "Tin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Drum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Bucket"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "MFG. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "ILE No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Can"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}