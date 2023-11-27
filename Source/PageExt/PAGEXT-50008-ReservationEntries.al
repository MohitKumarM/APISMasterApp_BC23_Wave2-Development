pageextension 50008 ReservationEntry extends "Reservation Entries"
{
    layout
    {
        addafter("Package No.")
        {
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }
            field("MFG. Date"; Rec."MFG. Date")
            {
                ApplicationArea = all;
            }
            field(Tin; Rec.Tin)
            {
                ApplicationArea = all;
            }
            field(Drum; Rec.Drum)
            {
                ApplicationArea = all;
            }
            field(Bucket; Rec.Bucket)
            {
                ApplicationArea = all;
            }
            field(Can; Rec.Can)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}