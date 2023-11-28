tableextension 50044 CustomerLedgerEntries extends "Cust. Ledger Entry"
{
    fields
    {
        field(80004; "Parent Group"; Code[20])
        {
            TableRelation = Customer."No.";
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
}