tableextension 50010 Locations extends Location
{
    fields
    {
        field(50101; "Production Unit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Reject Unit"; Boolean)
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