tableextension 50040 "Prod. Order Component Ext." extends "Prod. Order Component"
{
    fields
    {

        Field(50000; "Consumed Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50001; "Lot Tracking Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50002; "Store Location"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Required Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}