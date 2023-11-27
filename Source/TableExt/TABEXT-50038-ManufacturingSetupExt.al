tableextension 50038 "Manufacturing Setup Ext." extends "Manufacturing Setup"
{
    fields
    {
        Field(50000; "Production Location"; Code[20])
        {
            TableRelation = Location WHERE("Use As In-Transit" = FILTER(false), "Production Unit" = filter(true));
        }
        Field(50001; "Loose Honey Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        Field(50002; "Packing Location"; Code[20])
        {
            TableRelation = Location WHERE("Use As In-Transit" = FILTER(false));
        }
        Field(50003; "Consumption Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Consumption));
        }
        Field(50004; "Consumption Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Consumption Template"));
        }
        Field(50005; "Store Location"; Code[20])
        {
            TableRelation = Location.Code;
        }
        Field(50006; "Process Add On Routing"; Code[20])
        {
            TableRelation = "Routing Header";
        }
        Field(50007; "One by One Output Explode"; Boolean)
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