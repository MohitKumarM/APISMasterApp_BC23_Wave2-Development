table 50002 "Quality Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "Document Type"; Option)
        {
            OptionCaption = ' ,Purchase Receipt,Output';
            OptionMembers = " ","Purchase Receipt",Output;
            DataClassification = ToBeClassified;
        }
        field(4; "Document No."; Code[20])
        {
            TableRelation = IF ("Document Type" = FILTER("Purchase Receipt")) "Purch. Rcpt. Header";
            DataClassification = ToBeClassified;
        }
        field(5; "Document Date"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Approved Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Approved Quantity" > Quantity THEN
                    ERROR('Approved quantity can not be greater than %1.', Quantity);

                "Rejected Quantity" := Quantity - "Approved Quantity";
            end;
        }
        field(9; "Rejected Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Pending for Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Machine No."; Code[20])
        {
            TableRelation = "Machine Center";
            DataClassification = ToBeClassified;
        }
        field(16; "Machine Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Output Quality Status"; Option)
        {
            OptionCaption = ' ,Passed,Rework';
            OptionMembers = " ",Passed,Rework;
            DataClassification = ToBeClassified;
        }
        field(18; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Sampled By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "QC Analytical Report No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Tested By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Document Line No.", "Item Code", "Lot No.") { }
    }

    fieldgroups { }

    trigger OnDelete()
    begin
        IF Posted THEN
            ERROR('The quality lines are already posted.');

        recQualityLines.RESET;
        recQualityLines.SETRANGE("QC No.", "No.");
        IF recQualityLines.FINDFIRST THEN
            recQualityLines.DELETEALL;
    end;

    var
        recQualityLines: Record "Quality Line";
}
