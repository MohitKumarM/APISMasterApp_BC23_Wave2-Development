table 50007 "Batch Process Header"
{
    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'De-Crystallizer,Vaccum Circulation,Weighing Register';
            OptionMembers = "De-Crystallizer","Vaccum Circulation","Weighing Register";
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Material Status"; Option)
        {
            OptionCaption = ' ,Liquid,Semi Liquid,Hard';
            OptionMembers = " ",Liquid,"Semi Liquid",Hard;
            DataClassification = ToBeClassified;
        }
        field(5; "Oven No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Customer Code"; Code[20])
        {
            Editable = false;
            TableRelation = Customer;
            DataClassification = ToBeClassified;
        }
        field(10; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Customer Batch No."; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups { }
}
