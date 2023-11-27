tableextension 50036 SalesHeader extends "Sales Header"
{
    fields
    {
        field(50000; "Pending Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Shipment Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Pre-Carriage By"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        Field(50004; "Shipping Marks"; Text[50])

        {
            DataClassification = ToBeClassified;
        }
        Field(60001; "Pre-Carriage Receipt Place"; Text[30])

        {
            DataClassification = ToBeClassified;
        }
        Field(60002; "Vessel / Flight No."; Text[30])

        {
            DataClassification = ToBeClassified;
        }
        Field(60003; "Loading Port / Airport Dep."; Text[30])

        {
            DataClassification = ToBeClassified;
        }
        Field(60004; "Discharge Port / Airport"; Text[30])

        {
            DataClassification = ToBeClassified;
        }
        Field(60005; "Consignee"; Text[50])

        {
            DataClassification = ToBeClassified;
        }
        Field(60006; "Documentary Credit"; Text[150])

        {
            DataClassification = ToBeClassified;
        }
        Field(60012; "Total FCL"; Text[30])

        {
            DataClassification = ToBeClassified;
        }
        field(80005; "GST Type on Export"; Option)
        {
            OptionMembers = ,"Agst. Bond",Refund;
        }
        field(80006; "Scan Bar Code"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        Field(60007; "Notify Party Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        Field(60008; "Notify Party Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        Field(60009; "Notify Party Address 1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        Field(60010; "Notify Party Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        Field(60011; "Notify Party Tel. No."; Text[30])
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
    procedure PerformManualRelease()
    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        if Rec.Status <> Rec.Status::Released then begin
            ReleaseSalesDoc.PerformManualRelease(Rec);
            Commit();
        end;
    end;

    procedure PerformManualRelease(var SalesHeader: Record "Sales Header")
    var
        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
        NoOfSelected: Integer;
        NoOfSkipped: Integer;
    begin
        NoOfSelected := SalesHeader.Count;
        SalesHeader.SetFilter(Status, '<>%1', SalesHeader.Status::Released);
        NoOfSkipped := NoOfSelected - SalesHeader.Count;
        BatchProcessingMgt.BatchProcess(SalesHeader, Codeunit::"Sales Manual Release", "Error Handling Options"::"Show Error", NoOfSelected, NoOfSkipped);
    end;

    procedure PerformManualReopen(var SalesHeader: Record "Sales Header")
    var
        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
        NoOfSelected: Integer;
        NoOfSkipped: Integer;
    begin
        NoOfSelected := SalesHeader.Count;
        SalesHeader.SetFilter(Status, '<>%1', SalesHeader.Status::Open);
        NoOfSkipped := NoOfSelected - SalesHeader.Count;
        BatchProcessingMgt.BatchProcess(SalesHeader, Codeunit::"Sales Manual Reopen", "Error Handling Options"::"Show Error", NoOfSelected, NoOfSkipped);
    end;
}