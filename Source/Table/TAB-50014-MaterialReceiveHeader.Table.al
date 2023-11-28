table 50014 "Material Receive Header"
{
    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Date; Date)
        {
            Editable = false;
        }
        field(3; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin

                recReceiveLine.RESET;
                recReceiveLine.SETRANGE("Document No.", Rec."No.");
                IF recReceiveLine.FINDSET THEN
                    ERROR('Lines has already been generated, hence can not change the vendor.');

                "Vendor Name" := '';
                IF "Vendor No." <> '' THEN BEGIN
                    recVendor.GET("Vendor No.");
                    "Vendor Name" := recVendor.Name;
                END;
            end;
        }
        field(4; "Purchase Order No."; Code[20])
        {
            TableRelation = "Purchase Header";
        }
        field(5; "EXternal Document No."; Code[20]) { }
        field(6; "Document Date"; Date) { }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,BarCode Generated,Closed';
            OptionMembers = Open,"BarCode Generated",Closed;
        }
        field(8; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(10; "Created Date"; Date) { }
        field(11; "Vendor Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups { }

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);
    end;

    trigger OnInsert()
    begin
        TESTFIELD("No.");
        Date := TODAY;
        "User ID" := USERID;
    end;

    trigger OnModify()
    begin

        TESTFIELD(Status, Status::Open);
    end;

    var
        recMaterialRec: Record "Material Receive Header";
        recInventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recVendor: Record Vendor;
        recReceiveLine: Record "Material Receive Line";

    procedure AssistEdit(OldMaterialRec: Record "Material Receive Header"): Boolean
    begin
        recMaterialRec := Rec;
        recInventorySetup.GET;
        recInventorySetup.TESTFIELD(recInventorySetup."Receive Nos.");
        IF NoSeriesMgt.SelectSeries(recInventorySetup."Receive Nos.", OldMaterialRec."No. Series", recMaterialRec."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(recMaterialRec."No.");
            Rec := recMaterialRec;
            EXIT(TRUE);
        END;
    end;

    procedure GenerateLines()
    var
        recMatRecLine: Record "Material Receive Line";
        intLineNo: Integer;
        recPOLine: Record "Purchase Line";
    begin

        recMatRecLine.RESET;
        recMatRecLine.SETRANGE("Document No.", Rec."No.");
        recMatRecLine.SETRANGE("Purchase Order No.", Rec."Purchase Order No.");
        IF recMatRecLine.FINDSET THEN
            IF CONFIRM('Do you want to delete the existing line of this PO?') THEN BEGIN
                recMatRecLine.DELETEALL;
            END ELSE
                ERROR('The lines for the selected order is already generated.');

        recMatRecLine.RESET;
        recMatRecLine.SETRANGE("Document No.", "No.");
        IF recMatRecLine.FINDLAST THEN
            intLineNo := recMatRecLine."Line No."
        ELSE
            intLineNo := 0;

        recPOLine.RESET;
        recPOLine.SETRANGE(recPOLine."Document No.", "Purchase Order No.");
        recPOLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        //recPOLine.SETRANGE(recPOLine."Document No.",'HPO/1718/00495');
        IF recPOLine.FINDFIRST THEN
            REPEAT
                intLineNo := intLineNo + 1;
                recMatRecLine.INIT;
                recMatRecLine."Document No." := "No.";
                recMatRecLine."Line No." := intLineNo;
                recMatRecLine."Item No." := recPOLine."No.";
                recMatRecLine."Item Name" := recPOLine.Description;
                recMatRecLine."Unit of Measure" := recPOLine."Unit of Measure";
                recMatRecLine."Purchase Order No." := recPOLine."Document No.";
                recMatRecLine."Purchase Order Qty" := recPOLine.Quantity;
                recMatRecLine."Remaining Qty" := recPOLine."Outstanding Quantity";
                recMatRecLine."Location Code" := recPOLine."Location Code";
                recMatRecLine."Purchase Order Line No." := recPOLine."Line No.";
                recMatRecLine.INSERT;
            UNTIL recPOLine.NEXT = 0 ELSE
            ERROR('Nothing to generate.');
        MESSAGE('Generated the pending lines for the selected purchase order.');
    end;

    procedure GenerateBarCodes()
    var
        recReservationEntry: Record "Reservation Entry";
        recBarCodeLines: Record "Bar Code Lines";
        cdLastBarCodeId: Code[10];
        intLineNo: Integer;
    begin

        recBarCodeLines.RESET;
        recBarCodeLines.SETCURRENTKEY("Bar Code ID");
        IF recBarCodeLines.FINDLAST THEN
            cdLastBarCodeId := recBarCodeLines."Bar Code ID"
        ELSE
            cdLastBarCodeId := '0000000000';

        recReceiveLine.RESET;
        recReceiveLine.SETRANGE("Document No.", Rec."No.");
        recReceiveLine.FINDFIRST;
        REPEAT
            recReceiveLine.TESTFIELD("Receive Qty");
            recReceiveLine.CALCFIELDS("Total Tracking Quantity");

            IF recReceiveLine."Total Tracking Quantity" <> recReceiveLine."Receive Qty" THEN
                ERROR('The tracking quantity and receive quantity does not match for the line no. %1', recReceiveLine."Line No.");

            intLineNo := 0;
            recReservationEntry.RESET;
            recReservationEntry.SETRANGE("Source Type", 50018);
            recReservationEntry.SETRANGE("Source Subtype", 0);
            recReservationEntry.SETRANGE("Source ID", recReceiveLine."Document No.");
            recReservationEntry.SETRANGE("Source Ref. No.", recReceiveLine."Line No.");
            recReservationEntry.FINDFIRST;
            REPEAT
                recBarCodeLines.INIT;
                recBarCodeLines."Receiving No." := recReceiveLine."Document No.";
                recBarCodeLines."Receiving Line No." := recReceiveLine."Line No.";
                intLineNo += 1;
                recBarCodeLines."Line No." := intLineNo;
                recBarCodeLines."Purchase Order No." := recReceiveLine."Purchase Order No.";
                recBarCodeLines."Purchase Order Line No." := recReceiveLine."Purchase Order Line No.";
                recBarCodeLines."Item No." := recReceiveLine."Item No.";
                recBarCodeLines."Lot No." := recReservationEntry."Lot No.";
                cdLastBarCodeId := INCSTR(cdLastBarCodeId);
                recBarCodeLines."Bar Code ID" := cdLastBarCodeId;
                recBarCodeLines.Quantity := recReservationEntry."Quantity (Base)";
                recBarCodeLines.INSERT;
            UNTIL recReservationEntry.NEXT = 0;
        UNTIL recReceiveLine.NEXT = 0;

        Status := Status::"BarCode Generated";
        MODIFY;
        MESSAGE('The Barcodes generated for the selected purchase order lines.');
    end;
}
