tableextension 50046 SalesCrMemoHeader extends "Sales Cr.Memo Header"
{
    fields
    {
        field(60015; "APIS_Transaction Type"; Enum "Transaction Type")
        {
            Caption = 'Transaction Type';
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

    var
        myInt: Integer;
}