table 50019 "Material Requisition Line"
{

    fields
    {
        field(1; "Req. No."; Code[20])
        {
            TableRelation = "Material Requisition Header";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Type; Option)
        {
            OptionCaption = 'ProdOrder';
            OptionMembers = "ProdOrder";
        }
        field(4; "Document No."; Code[20])
        {
            TableRelation = IF (Type = FILTER(ProdOrder)) "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(5; "Document Line No."; Integer)
        {
            TableRelation = IF (Type = FILTER(ProdOrder)) "Prod. Order Line"."Line No." WHERE(Status = FILTER(Released),
                                                                                               "Prod. Order No." = FIELD("Document No."));
        }
        field(6; "Component Line No."; Integer)
        {
            TableRelation = IF (Type = FILTER(ProdOrder)) "Prod. Order Component"."Line No." WHERE(Status = FILTER(Released),
                                                                                                    "Prod. Order No." = FIELD("Document No."),
                                                                                                    "Prod. Order Line No." = FIELD("Document Line No."));
        }
        field(7; "Item Code"; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            var
                recItem: Record Item;
            begin
                IF recItem.GET("Item Code") THEN BEGIN
                    "Item Name" := recItem.Description;
                    "Unit of Measure" := recItem."Base Unit of Measure";
                END ELSE BEGIN
                    "Item Name" := '';
                    "Unit of Measure" := '';
                END;
            end;
        }
        field(8; "Item Name"; Text[50])
        {
        }
        field(9; "Unit of Measure"; Code[10])
        {
        }
        field(10; "Source Quantity"; Decimal)
        {
        }
        field(11; "Requested Quantity"; Decimal)
        {

            trigger OnValidate()
            begin
                /*recComponentLine.GET(recComponentLine.Status::Released, "Document No.", "Document Line No.", "Component Line No.");
                recComponentLine.CALCFIELDS("Material Issued Qty.", recComponentLine."Material To Issue Qty.");
                
                decPendingQty := recComponentLine."Remaining Quantity" - recComponentLine."Material Issued Qty." - recComponentLine."Material To Issue Qty." + xRec."Requested Quantity";
                IF decPendingQty - "Requested Quantity" < 0 THEN
                  ERROR('You can only request %1 quantity.', decPendingQty);*/

            end;
        }
        field(12; "Qty. To Issue"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Qty. To Issue" > "Requested Quantity" - "Quantity Issued" THEN
                    ERROR('Can only issue %1 quantity', "Requested Quantity" - "Quantity Issued");
            end;
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Release,Close';
            OptionMembers = Open,Release,Close;
        }
        field(14; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(15; "Quantity Issued"; Decimal)
        {
            Editable = false;
        }
        field(16; "Item Category Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE("No." = FIELD("Item Code")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category";
        }
        field(17; "Product Group Code"; Code[20])
        {
            CalcFormula = Lookup(Item."New Product Group Code" WHERE("No." = FIELD("Item Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Stock at RRK Store"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                                  "Location Code" = FILTER('RRK-ST')));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Req. No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        recUserSetup.GET(USERID);
        recUserSetup.TESTFIELD("Default Store Location");
        "Location Code" := recUserSetup."Default Store Location";
    end;

    var
        recComponentLine: Record "Prod. Order Component";
        decPendingQty: Decimal;
        recItem: Record "Item";
        recUserSetup: Record "User Setup";
}

