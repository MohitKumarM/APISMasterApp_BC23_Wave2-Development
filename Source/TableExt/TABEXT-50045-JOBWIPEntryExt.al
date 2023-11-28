tableextension 50045 JobWIPEntryExt extends "Job WIP Entry"
{
    fields
    {
        Field(50000; Template; Code[20]) { }
        Field(50001; Batch; Code[20]) { }
        Field(50002; "Line No."; Integer) { }
        Field(50003; "Lot No."; Code[20]) { }
        Field(50004; "Packing Type"; Option)
        {
            OptionMembers = ,Drums,Tins,Buckets,Cans;
        }
        Field(50005; "Tare Weight"; Decimal) { }
        Field(60000; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        Field(60001; "Account No."; Code[20]) { }
        Field(60002; "Debit Amount"; Decimal) { }
        Field(60003; "Credit Amount"; Decimal) { }
        Field(60004; "External Document No."; Code[20]) { }
        Field(60005; "Cheque No."; Code[20]) { }
        Field(60006; "Cheque Date"; Date) { }
        Field(60007; "Batch Name"; Text[50]) { }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}