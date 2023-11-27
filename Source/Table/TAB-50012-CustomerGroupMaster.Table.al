table 50012 "Customer Group Master"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Balance LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Indentation"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Parent Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}