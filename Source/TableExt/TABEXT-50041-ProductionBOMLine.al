tableextension 50041 "Production Bom Line Ext" extends "Production BOM Line"
{
    fields
    {
        field(50000; "Wastage %"; Decimal)
        {

        }
        Field(50001; "FG Name"; Text[50]) { }
        Field(50002; "Product Group"; Code[20]) { }
        Field(50003; "Customer Code"; Code[20]) { }
        Field(50004; "Customer Name"; Text[50]) { }
        Field(50005; "Base Unit of Measure"; Code[10]) { }
        Field(50006; "BOM Status"; Enum "BOM Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Production BOM Header".Status WHERE("No." = FIELD("Production BOM No.")));
        }
        Field(50007; "Item Category Code"; Code[10]) { }
        Field(50008; "Product Group Code"; Code[10]) { }
        Field(50009; Blocked; Boolean) { }
        Field(50010; "Item Category Code (RM / PM)"; Code[10]) { }
        Field(50011; "Product Group Code (RM / PM)"; Code[10]) { }

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