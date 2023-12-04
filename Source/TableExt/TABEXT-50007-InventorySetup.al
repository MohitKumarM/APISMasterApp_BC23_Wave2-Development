tableextension 50007 InventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "Quality Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Requision Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Material Issue Entry Template"; code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Transfer));
        }
        field(50005; "Material Issue Entry Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Material Issue Entry Template"));
        }
        field(50006; "Receive Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(60000; "QC Entry Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Transfer));
        }
        field(60001; "QC Entry Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("QC Entry Template"));
        }
        field(60003; "Auto Item Journal Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Item));
        }
        field(60004; "Auto Item Journal Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Auto Item Journal Template"));
        }
        field(60005; "Output Approval Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Output));
        }
        field(60006; "Output Approval Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Output Approval Template"));
        }
        field(60007; "Output Posting Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = FILTER(Output));
        }
        field(60008; "Output Posting Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Output Posting Template"));
        }
    }
}