table 50003 "Quality Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "QC No."; Code[20])
        {
            TableRelation = "Quality Header";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Lot No."; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Quality Process"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Quality Measure"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; Parameter; Text[50])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Min. Value"; Decimal)
        {
            Caption = 'Min. Value';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Max. Value"; Decimal)
        {
            Caption = 'Max. Value';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; "Mean Tolerance"; Decimal)
        {
            Caption = 'Mean Tolerance';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(10; Observation; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Specs; Text[10])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(12; Limit; Text[10])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(100; "Measure Type"; Enum "Measure Type")
        {
            CalcFormula = Lookup("Quality Measure"."Measure Type" WHERE(Code = FIELD("Quality Measure")));
            Editable = false;
            FieldClass = FlowField;
            // OptionCaption = ' ,Moisture,Color,HMF,TRS,Sucrose,FG,Acidity,Ash,PH,Gravity';
            // OptionMembers = " ",Moisture,Color,HMF,TRS,Sucrose,FG,Acidity,Ash,PH,Gravity;
        }
    }

    keys
    {
        key(Key1; "QC No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups { }
}
