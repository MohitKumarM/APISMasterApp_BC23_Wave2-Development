tableextension 50017 PurchaseHeader extends "Purchase Header"
{
    fields
    {
        field(50000; "Order Type"; Option)
        {
            OptionCaption = ' ,Honey,Packing Material,Other';
            OptionMembers = " ",Honey,"Packing Material",Other;
        }
        field(50001; "Invoice Type Old"; Option)
        {
            OptionCaption = 'Trading';
            OptionMembers = Trading;
        }
        field(50002; "Short Close Comment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Order Approval Pending"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Gate Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Freight Liability"; Option)
        {
            OptionCaption = ' ,Supplier,Buyer';
            OptionMembers = " ",Supplier,Buyer;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(50006; "Waybill No."; Code[20])
        {
            Caption = 'E-Way Bill';
        }
        field(50007; "GAN Approval Pending"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "GR / LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "GR / LR Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Gate Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Vendor Invoice Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Shipping Vendor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50017; "Transit Insurance"; Option)
        {
            OptionCaption = ' ,Buyer Scope,Supplier Scope';
            OptionMembers = " ","Buyer Scope","Supplier Scope";
        }
        field(50018; "Valid Till"; Date) { }
        field(50019; "Creation Tin&Drum&Bucket Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80002; "GST Dependency Type"; Option)
        {
            OptionMembers = " ","Buy-from Address","Order Address","Location Address";
            // ValuesAllowed = " ";
            // "Buy-from Address";

            trigger OnValidate()
            begin
                //TaxAreaUpdate;
            end;
        }
        field(90001; "Scan Bar Code"; code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                cdBarCodeID: code[50];
                recBarCodeLines: Record "Bar Code Lines";
                recReservationEntry: Record "Reservation Entry";
                intEntryNo: Integer;
                decQuantity: Decimal;
            begin

                IF "Scan Bar Code" <> '' THEN BEGIN
                    //cdBarCodeID := COPYSTR("Scan Bar Code", STRPOS("Scan Bar Code", '/')+1);
                    cdBarCodeID := COPYSTR("Scan Bar Code", 1, 10);

                    recBarCodeLines.RESET;
                    recBarCodeLines.SETCURRENTKEY("Bar Code ID");
                    recBarCodeLines.SETRANGE("Bar Code ID", cdBarCodeID);
                    recBarCodeLines.FINDFIRST;
                    IF recBarCodeLines."Purchase Order No." <> "No." THEN BEGIN
                        "Scan Bar Code" := '';
                        ERROR('The selected bar code does not belong to the selected purchase order.');
                    END;

                    PurchLine.RESET;
                    PurchLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchLine.SETRANGE("Document No.", recBarCodeLines."Purchase Order No.");
                    PurchLine.SETRANGE("Line No.", recBarCodeLines."Purchase Order Line No.");
                    PurchLine.FINDFIRST;
                    PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
                    PurchLine.TESTFIELD("No.", recBarCodeLines."Item No.");

                    recReservationEntry.RESET;
                    IF recReservationEntry.FINDLAST THEN
                        intEntryNo := recReservationEntry."Entry No."
                    ELSE
                        intEntryNo := 0;

                    recReservationEntry.RESET;
                    recReservationEntry.SETRANGE("Source Type", 39);
                    recReservationEntry.SETRANGE("Source Subtype", PurchLine."Document Type");
                    recReservationEntry.SETRANGE("Source ID", PurchLine."Document No.");
                    recReservationEntry.SETRANGE("Source Ref. No.", PurchLine."Line No.");
                    recReservationEntry.SETRANGE("Lot No.", recBarCodeLines."Lot No.");
                    IF recReservationEntry.FINDFIRST THEN BEGIN
                        decQuantity := recReservationEntry."Quantity (Base)" + 1;
                        recReservationEntry.VALIDATE("Quantity (Base)", decQuantity);
                        recReservationEntry.MODIFY;
                    END ELSE BEGIN
                        recReservationEntry.INIT;
                        intEntryNo += 1;
                        recReservationEntry."Entry No." := intEntryNo;
                        recReservationEntry.Positive := TRUE;
                        recReservationEntry."Item No." := PurchLine."No.";
                        recReservationEntry."Location Code" := PurchLine."Location Code";
                        recReservationEntry.VALIDATE("Quantity (Base)", 1);
                        recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                        recReservationEntry."Creation Date" := TODAY;
                        recReservationEntry."Source Type" := 39;
                        recReservationEntry."Source Subtype" := PurchLine."Document Type".AsInteger();
                        recReservationEntry."Source ID" := PurchLine."Document No.";
                        recReservationEntry."Source Batch Name" := '';
                        recReservationEntry."Source Ref. No." := PurchLine."Line No.";
                        recReservationEntry."Shipment Date" := TODAY;
                        recReservationEntry."Created By" := USERID;
                        recReservationEntry."Expiration Date" := 0D;
                        recReservationEntry."Lot No." := recBarCodeLines."Lot No.";
                        recReservationEntry."Variant Code" := '';
                        recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                        recReservationEntry.INSERT;
                    END;
                    "Scan Bar Code" := '';
                END;
            end;
        }
        field(90002; "Product Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "New Product Group".Code;
        }
        field(90003; "Short Close"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    procedure CallnewTdsfunctionsForMessage()
    var
        PurchlineforTds: Record "Purchase Line";
    begin
        PurchlineforTds.Reset();
        PurchlineforTds.SetRange("Document Type", "Document Type");
        PurchlineforTds.SetRange("Document No.", "No.");
        PurchlineforTds.CalculateTDS_TradingTransForMessage(Rec);
    end;

    procedure CallnewTdsfunctions()
    var
        PurchlineforTds: Record "Purchase Line";
    begin
        PurchlineforTds.Reset();
        PurchlineforTds.SetRange("Document Type", "Document Type");
        PurchlineforTds.SetRange("Document No.", "No.");
        PurchlineforTds.CalculateTDS_TradingTrans(Rec);
    end;

    trigger OnAfterInsert()
    begin
        Rec."Invoice Type Old" := Rec."Invoice Type Old"::Trading;
    end;
}