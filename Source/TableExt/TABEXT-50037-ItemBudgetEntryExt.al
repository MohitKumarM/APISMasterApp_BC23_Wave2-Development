tableextension 50037 "Item Budget Entry Ext." extends "Item Budget Entry"
{
    fields
    {
        Field(50000; "Order Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50001; "Stock Adjusted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50002; "Remaining Qty. to Produce"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50003; "Calculation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        Field(50004; "Qty. to Produce"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50005; "Prod. Order Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50006; "Packing Order Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50007; "Qty. to Pack"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50008; "Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        Field(50009; "Customer Name"; Text[50])
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