table 50013 "Bar Code Lines"
{
    fields
    {
        field(1; "Receiving No."; Code[20])
        {
            TableRelation = "Material Receive Header";
        }
        field(2; "Receiving Line No."; Integer) { }
        field(3; "Line No."; Integer) { }
        field(4; "Purchase Order No."; Code[20])
        {
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(5; "Purchase Order Line No."; Integer)
        {
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                              "Document No." = FIELD("Purchase Order No."));
        }
        field(6; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(7; "Lot No."; Code[20]) { }
        field(8; "Bar Code ID"; Code[10]) { }
        field(9; "Bar Code"; Code[50]) { }
        field(10; Quantity; Decimal) { }
        field(11; "QR Code"; BLOB)
        {
            SubType = Bitmap;
        }
        field(12; "QR Code 1"; BLOB)
        {
            SubType = Bitmap;
        }
        field(13; "QR Code 2"; BLOB)
        {
            SubType = Bitmap;
        }
        field(14; "QR Code 3"; BLOB)
        {
            SubType = Bitmap;
        }
        field(15; "QR Code 4"; BLOB)
        {
            SubType = Bitmap;
        }
        field(16; "QR Code 5"; BLOB)
        {
            SubType = Bitmap;
        }
        field(17; "QR Code 6"; BLOB)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Receiving No.", "Receiving Line No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Bar Code ID") { }
    }

    fieldgroups { }
}
