tableextension 50031 SalesLine extends "Sales Line"
{
    fields
    {
        /* field(50050; "TCS Nature of Collection New"; Code[10])
        {
            DataClassification = CustomerContent;
        } */
        field(50051; "TCS Nature Of Collection 2"; Code[20])
        {
            Caption = 'TCS Nature of Collection';
            DataClassification = ToBeClassified;
        }
    }
}