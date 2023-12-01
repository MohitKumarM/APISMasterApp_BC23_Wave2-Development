tableextension 50010 Locations extends Location
{
    fields
    {
        field(50103; "Scrap Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Associated Plant"; Option)
        {
            OptionMembers = " ","Unit 1","Unit 2","Unit 3";
        }
        field(50105; "Production Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Store Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Reject Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Packing Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "QC Rejection Location"; Code[20])
        {
            TableRelation = Location WHERE("Use As In-Transit" = FILTER(false));
        }
        field(60001; "OK Store Location"; Code[20])
        {
            TableRelation = Location;
        }
    }
}