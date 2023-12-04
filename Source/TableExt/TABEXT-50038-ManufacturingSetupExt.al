tableextension 50038 "Manufacturing Setup Ext." extends "Manufacturing Setup"
{
    fields
    {
        Field(50001; "Loose Honey Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        Field(50003; "Consumption Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Consumption));
        }
        Field(50004; "Consumption Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Consumption Template"));
        }
        Field(50006; "Process Add On Routing"; Code[20])
        {
            TableRelation = "Routing Header";
        }
        Field(50007; "One by One Output Explode"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        Field(50008; "Store to Prod. Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Transfer));
        }
        Field(50009; "Store to Prod. Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Store to Prod. Template"));
        }
        Field(500010; "Prod. to Store Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Transfer));
        }
        Field(50011; "Prod. to Store Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Prod. to Store Template"));
        }
        Field(50012; "Bucket Item Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        Field(50013; "Can Item Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        Field(50014; "Drum Item Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        Field(50015; "Tin Item Code"; Code[20])
        {
            TableRelation = Item."No.";
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