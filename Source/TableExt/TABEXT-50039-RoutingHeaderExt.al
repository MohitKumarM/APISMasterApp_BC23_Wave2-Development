tableextension 50039 "Routing Header Ext." extends "Routing Header"
{
    fields
    {
        field(50008; "Production Type"; Option)
        {
            OptionMembers = ,"Bulk Without Filteration","Bulk With Filteration","Small Pack";
        }
        field(50009; "Auto Selection"; Boolean)
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