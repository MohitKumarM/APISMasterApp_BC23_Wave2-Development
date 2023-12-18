table 50000 "Deal Master"
{
    DrillDownPageID = "Sauda List Released";
    LookupPageID = "Sauda List Released";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            Editable = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Purchaser Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                IF recSalesPerson.GET("Purchaser Code") THEN
                    "Purchaser Name" := recSalesPerson.Name
                ELSE
                    "Purchaser Name" := '';
            end;
        }
        field(4; "Purchaser Name"; Text[50])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; Flora; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
            TableRelation = "New Product Group".Code;
        }
        field(6; "Packing Type"; Option)
        {
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
            DataClassification = ToBeClassified;
        }
        field(7; "Deal Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Rate in Kg."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Release,Close';
            OptionMembers = Open,Release,Close;
        }
        /*  field(10; "Dispatched Qty."; Decimal)
         {
             CalcFormula = Sum("Deal Dispatch Details"."Dispatched Tins / Buckets" WHERE("Sauda No." = FIELD("No.")));
             Editable = false;
             FieldClass = FlowField;
         } */ // 15800 Dispatch Discontinue
        field(11; "Pending Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Discount Rate in Kg."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Per Unit Qty. (Kg.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        /* field(16; "Dispatched Qty. (Kg.)"; Decimal)
        {
            CalcFormula = Sum("Deal Dispatch Details"."Qty. in Kg." WHERE("Sauda No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        } */ // 15800 Dispatch Discontinue
        field(17; "Item Code"; Code[20])
        {
            TableRelation = Item."No." where("Item Category Code" = const('PACK HONEY'));
            DataClassification = ToBeClassified;

        }
        field(50000; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            DataClassification = ToBeClassified;
        }
        field(50001; "Dispatch Schedule"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Freight Liability"; Option)
        {
            OptionCaption = ' ,Supplier,Buyer';
            OptionMembers = " ",Supplier,Buyer;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(50006; "Quality Instruction 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Quality Instruction 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Quality Instruction 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Quality Instruction 4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Quality Instruction 5"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Quality Instruction 6"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Payment Terms"; Text[50])
        {
            TableRelation = "Payment Terms";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Rec_PaymentTerms: Record "Payment Terms";
            begin
                if Rec_PaymentTerms.Get(Rec."Payment Terms") then
                    Rec."Payment Terms" := Rec_PaymentTerms.Description;
            end;
        }
        field(50013; "Special Instruction"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Comment; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Approver ID"; Code[50])
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
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Date, "Purchaser Name", Flora, "Packing Type") { }
    }

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created At" := CURRENTDATETIME;
    end;

    var
        recSalesPerson: Record "Salesperson/Purchaser";
}
