table 50006 "Batch Process Line"
{
    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'De-Crystalizer,Vaccum Circulation,Weighing Register';
            OptionMembers = "De-Crystalizer","Vaccum Circulation","Weighing Register";
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(4; Time; Time)
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;
        }
        field(5; "Temp. Deg. C."; Decimal)
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;
        }
        field(6; "Water Temp. Dec. C."; Decimal)
        {
            Description = 'De-Crystalizer / Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(7; "Checked By"; Text[50])
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Text[250])
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;
        }
        field(9; "Plan Quantity"; Decimal)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(10; "Initial Moisture"; Decimal)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(11; "In Time"; Time)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(12; "Vacuum Presure"; Decimal)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(13; "Out Time"; Time)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(14; "Honey Temp."; Decimal)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(15; "Out Moisture"; Decimal)
        {
            Description = 'Vacuum Circulation';
            DataClassification = ToBeClassified;
        }
        field(16; "Line Type"; Option)
        {
            OptionCaption = 'Batch Details,Line Details';
            OptionMembers = "Batch Details","Line Details";
            DataClassification = ToBeClassified;
        }
        field(20; "Lot No."; Code[20])
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(21; "Packing Qauntity"; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(22; "Gross Weight"; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(23; "Tare Weight"; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(24; "Nett Weight"; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(25; "Plan Weight"; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(26; "Packing Type"; Option)
        {
            Description = 'Weighing Register';
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
            DataClassification = ToBeClassified;
        }
        field(27; "Qty. Per Pack"; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(28; "Oven No."; Integer)
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;
        }
        field(29; "Batch No."; Code[20])
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                recItemLedger.RESET;
                recItemLedger.SETRANGE("Order Type", recItemLedger."Order Type"::Production);
                recItemLedger.SETRANGE("Order No.", Rec."Document No.");
                recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Consumption);
                IF PAGE.RUNMODAL(0, recItemLedger) = ACTION::LookupOK THEN BEGIN
                    "Batch No." := recItemLedger."Lot No.";
                END;
            end;
        }
        field(30; Quantity; Decimal)
        {
            Description = 'De-Crystalizer';
            DataClassification = ToBeClassified;
        }
        field(31; "Excess / Shortage Qty."; Decimal)
        {
            Description = 'Weighing Register';
            DataClassification = ToBeClassified;
        }
        field(2004; Tin; Decimal) { }
        field(2005; Drum; Decimal) { }
        field(2006; Can; Decimal) { }
        field(2007; Bucket; Decimal) { }
    }

    keys
    {
        key(Key1; Type, "Document No.", "Line Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups { }

    var
        recItemLedger: Record "Item Ledger Entry";
}
