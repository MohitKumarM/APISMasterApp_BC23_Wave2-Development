tableextension 50042 ProductionOrderLineExt extends "Prod. Order Line"
{
    fields
    {
        field(50001; "Planning Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Planning Entry No."; Integer)
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
}