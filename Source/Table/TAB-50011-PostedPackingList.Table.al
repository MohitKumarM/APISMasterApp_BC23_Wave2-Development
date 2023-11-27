table 50011 "Posted Packing List"
{
    fields
    {
        field(1; "Order No."; Code[20])
        {
        }
        field(2; "Order Line No."; Integer)
        {
        }
        field(3; "Item Code"; Code[20])
        {
        }
        field(4; "Line No."; Integer)
        {
            Editable = false;
        }
        field(5; "Container No."; Code[20])
        {
        }
        field(6; "Batch No."; Code[20])
        {
            trigger OnLookup()
            begin
                recItemLedger.RESET;
                recItemLedger.SETRANGE("Order Type", recItemLedger."Order Type"::Production);
                recItemLedger.SETRANGE("Item No.", Rec."Item Code");
                recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Output);
                IF PAGE.RUNMODAL(0, recItemLedger) = ACTION::LookupOK THEN BEGIN
                    "Batch No." := recItemLedger."Lot No.";
                END;
            end;
        }
        field(7; "No. of Pallets"; Integer)
        {
        }
        field(8; Quantity; Decimal)
        {
        }
        field(9; "Drum Weight (Kg.)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(10; "Best Before"; Text[30])
        {
        }
        field(11; "Meilleur Avant"; Text[100])
        {
        }
        field(12; "Factory Code"; Code[10])
        {
        }
        field(13; "Product Code"; Code[10])
        {
        }
        field(14; "Product Code Text"; Text[100])
        {
        }
        field(15; "Pallet Weight (Kg.)"; Decimal)
        {
        }
        field(16; "Item Description"; Text[250])
        {
        }
        field(17; "Pallet Total"; Decimal)
        {
        }
        field(18; "FCL Type"; Option)
        {
            OptionCaption = ' ,20,40,LCL';
            OptionMembers = " ","20","40",LCL;
        }
        field(19; "Prod. Date"; Date)
        {
        }
        field(20; "Expiry Date"; Date)
        {
        }
        field(21; "Pallet Serial No."; Text[30])
        {
        }
        field(22; "Cartoons Serial No."; Text[30])
        {
        }
        field(23; "Packing Size"; Code[25])
        {
        }
        field(24; Packing; Code[25])
        {
        }
        field(25; "Quantity In Case Of Drum"; Decimal)
        {
        }
        field(26; "Per Pallet Weight"; Decimal)
        {
        }
        field(27; "Total Pallet Weight Kg"; Decimal)
        {
        }
        field(28; "Net Weight In Kg"; Decimal)
        {
        }
        field(29; "Tare Weight"; Decimal)
        {
        }
        field(30; "Gross Weight In Kg"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Order No.", "Order Line No.", "Item Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        recPackingList.RESET;
        recPackingList.SETRANGE("Order No.", Rec."Order No.");
        recPackingList.SETRANGE("Order Line No.", Rec."Order Line No.");
        recPackingList.SETRANGE("Item Code", Rec."Item Code");
        IF recPackingList.FINDLAST THEN
            "Line No." := recPackingList."Line No." + 10000
        ELSE
            "Line No." := 10000;
    end;

    var
        recPackingList: Record "Pre Packing List";
        recItemLedger: Record "Item Ledger Entry";
}
