tableextension 50032 ItemCategory extends "Item Category"
{
    fields
    {
        field(60000; "Inward QC Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Item Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(60002; "GAN Tolerance %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}