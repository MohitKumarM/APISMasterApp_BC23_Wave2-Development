tableextension 50027 Customer extends Customer
{
    fields
    {
        field(50000; "Quality Process"; Code[20])
        {
            TableRelation = "Standard Task";
        }
        field(50001; "Skip TCS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Authorized person"; Text[50])
        {
        }
        field(50003; "RSM Name"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(50004; "Security Cheque No"; Text[10])
        {
        }
        field(50005; "MSME No."; Text[20])
        {
        }
        field(50006; "FASSAI No."; Code[20])
        {
        }
        field(80002; "Print Name"; Text[100])
        {
        }
        field(80003; "Address 3"; Text[50])
        {
        }
        field(80004; "Parent Group"; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Rec_Customer: Record Customer;
            begin

                /* Rec_Customer.SetFilter("Parent Group", '<>%1', '');
                if Rec_Customer.FindSet() then
                    repeat
                        if Rec_Customer."Parent Group" = Rec."No." then
                            Error('You Cannot Select Because he is already define  Parent Customer');
                    until Rec_Customer.Next() = 0; */
            end;
        }
        field(80005; "Child Group"; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.TestField("Parent Group", '');
            end;
        }
        field(80006; "Total Group Wise Amount"; Decimal)
        {
        }
        field(50101; "Customer Type"; Enum "Customer Type")
        {

        }
    }
    keys
    {
        key(Key25; "Parent Group", "Child Group")
        {
        }
    }

    trigger OnAfterInsert()
    begin
        Rec.Blocked := Rec.Blocked::All;
    end;

    trigger OnAfterModify()

    begin
        Rec.Blocked := Rec.Blocked::All;
    end;
}
