tableextension 50023 ProductionOrderExt extends "Production Order"
{
    fields
    {
        Field(50000; Refreshed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        Field(50001; "Planning Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        Field(50002; "Planning Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        Field(50003; "Order Type"; Option)
        {
            OptionMembers = Production,Packing,Dates;
        }
        Field(50004; "Requested Material Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        Field(50005; "Addtional Materal Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Batch No."; Code[20]) { }
        field(50007; "Customer Code"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate();
            var
                Cust_loc: Record Customer;
            begin
                if Cust_loc.Get(Rec."Customer Code") then
                    Rec."Customer Name" := Cust_loc.Name;
            end;
        }
        Field(50008; "Production Type"; Option)
        {
            OptionMembers = ,"Bulk Without Filteration","Bulk With Filteration","Small Pack";
        }
        field(50009; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        Field(50010; "Moisture"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        Field(50011; "Color"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        Field(50012; "FG"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        Field(50013; "HMF"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        Field(50014; "Start Time Initiated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Trade Type"; Option)
        {
            OptionMembers = " ","General Trade","Modern Trade";
        }
        field(50016; "Production Sub Type"; Option)
        {
            OptionMembers = " ","FG Bulk Exp. w/o processing","FG Bulk Exp. w/o filter","FG Bulk Exp. Filtered","FG Small Exp. Filtered","FG Bulk Dom w/o filter","FG Bulk Dom Filter","FG Small Dom Filtered",Pouring;
        }
        Field(50100; "KHP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50101; "Water"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50102; "Pollen"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(50103; "Packing Approval DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        Field(50104; "Tank No. for Packing"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        Field(50105; "Packing Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        Field(50106; "Assigned Lot Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    procedure GenerateBarCode()
    var
        recBarCodeLines: Record "Bar Code Lines";
        cdLastBarCodeId: Code[10];
        recItemLedger: Record "Item Ledger Entry";
    begin
        recBarCodeLines.RESET;
        recBarCodeLines.SETCURRENTKEY("Bar Code ID");
        IF recBarCodeLines.FINDLAST THEN
            cdLastBarCodeId := recBarCodeLines."Bar Code ID"
        ELSE
            cdLastBarCodeId := '0000000000';

        recItemLedger.RESET;
        recItemLedger.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
        recItemLedger.SETRANGE("Document No.", "No.");
        recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Output);
        recItemLedger.SETRANGE("Barcode Generated", FALSE);
        IF recItemLedger.FINDSET THEN
            REPEAT
                recBarCodeLines.INIT;
                recBarCodeLines."Receiving No." := recItemLedger."Document No.";
                recBarCodeLines."Receiving Line No." := recItemLedger."Entry No.";
                recBarCodeLines."Line No." := 0;
                recBarCodeLines."Purchase Order No." := recItemLedger."Document No.";
                recBarCodeLines."Purchase Order Line No." := recItemLedger."Document Line No.";
                recBarCodeLines."Item No." := recItemLedger."Item No.";
                recBarCodeLines."Lot No." := recItemLedger."Lot No.";
                cdLastBarCodeId := INCSTR(cdLastBarCodeId);
                recBarCodeLines."Bar Code ID" := cdLastBarCodeId;
                recBarCodeLines.Quantity := recItemLedger.Quantity;
                recBarCodeLines.INSERT;

                recItemLedger."Barcode Generated" := TRUE;
                recItemLedger.MODIFY;
            UNTIL recItemLedger.NEXT = 0 ELSE
            ERROR('Nothing to generate.');

        MESSAGE('The Barcodes generated for the output entries.');
    end;
}