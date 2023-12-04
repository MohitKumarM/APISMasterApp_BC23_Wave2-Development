tableextension 50001 ItemN1 extends Item
{
    fields
    {
        field(50000; "Quality Process"; Code[20])
        {
            TableRelation = "Standard Task";
        }
        field(50001; "Customer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        Field(50002; "Pack Size"; Text[30]) { }
        field(50003; "Net Weight Per (Kg)"; Decimal) { }
        field(50007; "Item Type"; Option)
        {
            OptionCaption = ' ,Bulk,Small';
            OptionMembers = " ",Bulk,Small;
        }
        field(50009; "Expiry Date Formula"; DateFormula) { }
        field(50015; "New Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "New Product Group" WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        Field(70000; "Opening Date Filter"; Date) { }
        Field(70001; "Opening Quantity"; Decimal) { }
        Field(70002; "Inward Quantity"; Decimal) { }
        Field(70003; "Outward Quantity"; Decimal) { }
        Field(70004; "Total Opening Quantity"; Decimal) { }
        Field(70005; "Total Inward Quantity"; Decimal) { }
        Field(70006; "Total Outward Quantity"; Decimal) { }
        Field(70007; "Total Closing Quantity"; Decimal) { }
        Field(70008; "Opening Value"; Decimal) { }
        Field(70009; "Inward Value"; Decimal) { }
        Field(70010; "Outward Value"; Decimal) { }
        Field(70011; "Closing Value"; Decimal) { }
        Field(70012; "Total Opening Value"; Decimal) { }
        Field(70013; "Total Inward Value"; Decimal) { }
        Field(70014; "Total Outward Value"; Decimal) { }
        Field(70015; "Total Closing Value"; Decimal) { }
        field(70016; "Brand"; Code[20])
        {
            TableRelation = Brand;
        }
        field(70017; "Sub Brand"; Code[20])
        {
            TableRelation = "Sub Brand";
        }
        field(70018; "Pack Size (SKU)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}