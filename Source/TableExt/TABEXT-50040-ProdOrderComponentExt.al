tableextension 50040 "Prod. Order Component Ext." extends "Prod. Order Component"
{
    fields
    {
        Field(50000; "Consumed Qty."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Entry Type" = FILTER(Consumption), "Order Type" = FILTER(Production), "Order No." = FIELD("Prod. Order No."), "Order Line No." = FIELD("Prod. Order Line No."), "Item No." = FIELD("Item No.")));
        }
        Field(50001; "Lot Tracking Qty."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Tran. Lot Tracking".Quantity WHERE("Document Type" = FILTER(Consumption), "Document No." = FIELD("Prod. Order No."), "Document Line No." = FIELD("Prod. Order Line No."), "Item No." = FIELD("Item No.")));
        }
        Field(50002; "Store Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50003; "Required Qty"; Decimal)
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