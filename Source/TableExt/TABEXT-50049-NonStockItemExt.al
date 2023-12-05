tableextension 50049 NonStockItemExt extends "Nonstock Item"
{
    fields
    {
        field(50000; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(50001; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(50002; "Pending Approval"; Boolean)
        {
        }
        field(50003; Approved; Boolean)
        {
        }
        field(50004; "Item Tracking Code"; Code[20])
        {
            TableRelation = "Item Tracking Code";
        }
        field(50005; "Last Remark"; Text[250])
        {
            CalcFormula = Lookup("Comment Line".Comment WHERE("Table Name" = FILTER(Item),
                                                               "No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Customer Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(50007; "Pack Size"; Text[30])
        {
        }
        field(50008; "Net Weight Per (Kg)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50009; "Item Size Dimension"; Text[30])
        {
        }
        field(50010; "Gross Weight Per (Kg)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50011; "Reorder Point"; Decimal)
        {
        }
        field(50012; "No. 2"; Code[20])
        {
        }
        field(50013; "Item Type"; Option)
        {
            OptionCaption = ' ,Bulk,Small';
            OptionMembers = " ",Bulk,Small;
        }
        field(50014; "Pcs. Per Cartoon"; Integer)
        {
        }

        field(50016; "GST Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(50017; "HSN Code"; Code[20])
        {
            TableRelation = "Tariff Number";
        }
        field(50018; Length; Decimal)
        {
        }
        field(50019; Width; Decimal)
        {
        }
        field(50020; Height; Decimal)
        {
        }
        field(50021; "Extended Description"; Text[50])
        {
        }
        field(50022; "Barcode No."; Text[25])
        {
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

    var
        myInt: Integer;
}