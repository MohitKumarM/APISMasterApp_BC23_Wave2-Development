tableextension 50034 TrackingSpecfication extends "Tracking Specification"
{
    fields
    {
        field(50000; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50002; "Packing Type"; Option)
        {
            OptionMembers = ,Drums,Tins,Buckets,Cans;
        }
        field(50003; "Qty. in Pack"; Decimal)
        {

        }
        field(50004; "Qty. Per Pack"; Decimal)
        {

        }
        field(50005; "Original Qty. in Pack"; Decimal)
        {

        }

        field(50020; "Tin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Drum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Can"; Decimal)
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
    }

    keys
    {
        key(Key20; "ILE No.")
        {
        }
    }
}