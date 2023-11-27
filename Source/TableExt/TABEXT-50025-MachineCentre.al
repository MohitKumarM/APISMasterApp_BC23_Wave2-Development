tableextension 50025 "Machine Center Table Ext." extends "Machine Center"
{
    fields
    {
        field(50000; "QC Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Quality Process"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Task".Code;
        }
        field(50002; "QC Type"; Enum "QC Type")
        {
            DataClassification = ToBeClassified;
        }
    }
}
