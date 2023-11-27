table 50018 "Material Requisition Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(4; Type; Option)
        {
            OptionCaption = 'ProdOrder';
            OptionMembers = ProdOrder;
        }
        field(5; "Document No."; Code[20])
        {
            TableRelation = IF (Type = FILTER(ProdOrder)) "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(6; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Release,Close';
            OptionMembers = Open,Release,Close;
        }
        field(7; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(8; "Department Name"; Text[50])
        {
        }
        field(9; "Request Remarks"; Text[50])
        {
        }
        field(10; "Issue Remarks"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("No.");
        Date := TODAY;
        "User ID" := USERID;
    end;

    var
        recMaterialReq: Record "Material Requisition Header";
        recInventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        DimMgt: Codeunit "DimensionManagement";
        intSetID: Integer;


    procedure AssistEdit(OldMaterialReq: Record "Material Requisition Header"): Boolean
    begin

        recMaterialReq := Rec;
        recInventorySetup.GET;
        recInventorySetup.TESTFIELD("Requision Nos.");
        IF NoSeriesMgt.SelectSeries(recInventorySetup."Requision Nos.", OldMaterialReq."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            Rec := recMaterialReq;
            EXIT(TRUE);
        END;
    END;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, intSetID);
    end;
}

