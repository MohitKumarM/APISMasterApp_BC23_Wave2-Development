tableextension 50004 PurchaseLine extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                VendorR: Record Vendor;
            begin
                IF (Type = Type::"Charge (Item)") or (Type = Type::Item) or (Type = Type::"G/L Account") THEN begin
                    IF VendorR.GET("Pay-to Vendor No.") THEN
                        "P.A.N. No." := VendorR."P.A.N. No.";
                end;

            end;
        }
        field(50001; "Deal No."; Code[20])
        {
            TableRelation = IF ("No." = filter(' ')) "Deal Master" WHERE(Status = FILTER(Release))
            else
            "Deal Master" WHERE(Status = FILTER(Release), "Item Code" = field("No."));

            trigger OnValidate()
            var
                DealMaster: Record "Deal Master";
                DealMaster2: Record "Deal Master";
            begin
                if DealMaster2.get(xRec."Deal No.") then begin
                    DealMaster2.Status := DealMaster2.Status::Release;
                    DealMaster2.Modify();
                end;
                /*   IF Rec."Deal No." = '' THEN
                      Rec.VALIDATE("Deal Line No.", 0)
                  ELSE BEGIN */

                // IF recDealDetails."Item Code" <> "No." THEN
                //     ERROR('Item code on deal and purchase line does not match.');
                //  END; // 15800 Dispatch Discontinue
                if DealMaster.Get(Rec."Deal No.") then begin
                    Rec.Validate("No.", DealMaster."Item Code");
                    rec."Deal No." := DealMaster."No.";
                    rec."Qty. in Pack" := DealMaster."Deal Qty.";
                    rec.Flora := DealMaster.Flora;
                    rec.Validate(Quantity, (DealMaster."Deal Qty." * DealMaster."Per Unit Qty. (Kg.)"));
                    rec.Validate("Dispatched Qty. in Kg.", (DealMaster."Deal Qty." * DealMaster."Per Unit Qty. (Kg.)"));
                    DealMaster.Status := DealMaster.Status::Close;
                    DealMaster.Modify();
                end;

            end;
        }
        field(50002; "Packing Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
        }
        field(50003; "Qty. in Pack"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        /* field(50004; "Deal Line No."; Integer)
        {
            TableRelation = "Deal Dispatch Details"."Line No." WHERE("Sauda No." = FIELD("Deal No."),
                                                                      "GAN Created" = const(false));

            trigger OnValidate()
            begin
                IF (xRec."Deal Line No." <> 0) AND (Rec."Deal Line No." <> xRec."Deal Line No.") THEN BEGIN
                    recDealDispatch.RESET;
                    recDealDispatch.SETRANGE("Sauda No.", xRec."Deal No.");
                    recDealDispatch.SETRANGE("Line No.", xRec."Deal Line No.");
                    recDealDispatch.SETRANGE("GAN Created", TRUE);
                    IF recDealDispatch.FINDFIRST THEN BEGIN
                        recDealDispatch."GAN Created" := FALSE;
                        recDealDispatch."GAN No." := '';
                        recDealDispatch.MODIFY;

                        Rec.VALIDATE("Qty. in Pack", 0);
                        Rec.VALIDATE("Packing Type", 0);
                        Rec.VALIDATE("Dispatched Qty. in Kg.", 0);
                        Rec.VALIDATE(Quantity, 0);
                        Rec.VALIDATE(Flora, '');
                        Rec.VALIDATE("Direct Unit Cost", 0);
                        Rec.VALIDATE("Unit Rate", 0);
                        Rec.VALIDATE("Other Charges", 0);
                        Rec.VALIDATE("Purchaser Code", '');
                    END;
                END;

                recDealDispatch.RESET;
                recDealDispatch.SETRANGE("Sauda No.", Rec."Deal No.");
                recDealDispatch.SETRANGE("Line No.", Rec."Deal Line No.");
                recDealDispatch.SETRANGE("GAN Created", FALSE);
                IF recDealDispatch.FINDFIRST THEN BEGIN
                    Rec.VALIDATE("Qty. in Pack", recDealDispatch."Dispatched Tins / Buckets");
                    Rec.VALIDATE("Packing Type", recDealDispatch."Packing Type");
                    Rec.VALIDATE("Dispatched Qty. in Kg.", recDealDispatch."Qty. in Kg.");
            
                    decTempQty := recDealDispatch."Qty. in Kg.";

                    decTempQty := ROUND(decTempQty, 1, '>');
                    Rec.VALIDATE(Quantity, decTempQty);

                    recDealMaster.GET("Deal No.");
                    Rec.VALIDATE("Direct Unit Cost", recDealMaster."Unit Rate in Kg.");
                    Rec.VALIDATE(Flora, recDealMaster.Flora);
                    Rec.VALIDATE("Unit Rate", recDealMaster."Unit Rate in Kg.");
                    Rec.VALIDATE("Other Charges", recDealMaster."Discount Rate in Kg.");
                    Rec.VALIDATE("Purchaser Code", recDealMaster."Purchaser Code");

                    recDealDispatch."GAN Created" := TRUE;
                    recDealDispatch."GAN No." := Rec."Document No.";
                    recDealDispatch.MODIFY;
                END ELSE
                    IF "Deal Line No." <> 0 THEN
                        ERROR('Deal Line no. does not exist.');

                IF (xRec."Deal Line No." <> 0) AND (Rec."Deal Line No." = 0) THEN BEGIN
                    recDealDispatch.RESET;
                    recDealDispatch.SETRANGE("Sauda No.", xRec."Deal No.");
                    recDealDispatch.SETRANGE("Line No.", xRec."Deal Line No.");
                    recDealDispatch.SETRANGE("GAN Created", TRUE);
                    IF recDealDispatch.FINDFIRST THEN BEGIN
                        recDealDispatch."GAN Created" := FALSE;
                        recDealDispatch."GAN No." := '';
                        recDealDispatch.MODIFY;

                        Rec.VALIDATE("Qty. in Pack", 0);
                        Rec.VALIDATE("Packing Type", 0);
                        Rec.VALIDATE("Dispatched Qty. in Kg.", 0);
                        Rec.VALIDATE(Quantity, 0);
                        Rec.VALIDATE(Flora, '');
                        Rec.VALIDATE("Direct Unit Cost", 0);
                        Rec.VALIDATE("Unit Rate", 0);
                        Rec.VALIDATE("Other Charges", 0);
                        Rec.VALIDATE("Purchaser Code", '');
                    END;
                END;
            end;
        } */ // 15800 Dispatch Discontinue
        field(50005; "Dispatched Qty. in Kg."; Decimal)
        {
            Editable = false;
        }
        field(50006; Flora; Code[20])
        {
            Editable = false;
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
        }
        field(50007; "Unit Rate"; Decimal) { }
        field(50008; "Purchaser Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            /*comment by amar*/
        }
        field(50009; "Other Charges"; Decimal) { }
        field(50010; "Billed Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "New Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            DataClassification = ToBeClassified;
            // TableRelation = "New Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = filter(''));
        }
        field(50020; "P.A.N. No."; Code[20])
        {
            Caption = 'P.A.N. No.';
            DataClassification = ToBeClassified;
        }
        field(50021; "New TDS Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Honey Item No."; Code[20])
        {
            TableRelation = Item where("Item Category Code" = const('PACK HONEY'));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Validate("No.", "Honey Item No.");
            end;
        }
        field(70003; "Item Tracking Quantity Honey"; Decimal)
        {
            CalcFormula = Sum("Tran. Lot Tracking".Quantity WHERE("Document No." = FIELD("Document No."),
                                                                   "Document Line No." = FIELD("Line No."),
                                                                   "Item No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70004; "Item Tracking Quantity Other"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = FILTER(39), "Source Subtype" = FILTER(1), "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.")));
        }
    }

    var
        //recDealDispatch: Record "Deal Dispatch Details"; // 15800 Dispatch Discontinue
        recDealDetails: Record "Deal Master";
        decTempQty: Decimal;
        recDealMaster: Record "Deal Master";

    procedure CalculateTDS_TradingTransForMessage(var
                                                 PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        DateFilterCalc: Codeunit "DateFilter-Calc";
        AccountingPeriodFilter: Text[30];
        AccountingPeriodFilter2: Text[30];

        PurchInvAmt_TDS: Decimal;
        PurchCrMemoAmt_TDS: Decimal;
        FinalAmt_TDS: Decimal;
        LineC: Integer;
        Team002: Label 'Previous Purchase amount of PAN %1 is %2.';
    begin
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETFILTER("No.", '<>%1', '');
        if PurchLine.Find('-') then
            repeat
                IF (PurchLine."P.A.N. No." <> '') AND (AccountingPeriodFilter = '') THEN
                    DateFilterCalc.CreateAccountingPeriodFilter(AccountingPeriodFilter, AccountingPeriodFilter2, PurchHeader."Posting Date", 0);
                PurchLine.CalculatePANWisePurchase(PurchLine, AccountingPeriodFilter, PurchLine."P.A.N. No.", PurchInvAmt_TDS, PurchCrMemoAmt_TDS);//TradingTDSCalc
                                                                                                                                                   //Message('%1|%2', PurchInvAmt_TDS, PurchCrMemoAmt_TDS);
                FinalAmt_TDS := PurchInvAmt_TDS - PurchCrMemoAmt_TDS;//TradingTDSCalc
                LineC += 1;
                IF LineC = 1 THEN
                    MESSAGE(Team002, PurchLine."P.A.N. No.", FinalAmt_TDS);
            //TradingTDSCalc
            //PurchLine.RecordId
            until PurchLine.Next() = 0;
    end;

    procedure CalculatePANWisePurchase(PurchaseLine: Record "Purchase Line"; AccPeriodFilter: Text[30]; Pay2VendPAN: Code[20]; var PrevPurchInvoiceAmount: Decimal; var PrevPurchCreditMemoAmount: Decimal)
    var
        PurchInvLineR: Record "Purch. Inv. Line";
        PurchCrMemoLineR: Record "Purch. Cr. Memo Line";
    begin
        //TradingTDSCalc
        PurchInvLineR.RESET;
        PurchInvLineR.SETCURRENTKEY("Posting Date", "P.A.N. No.", Type);
        PurchInvLineR.SetRange("Posting Date", 20230401D, 20240331D);
        PurchInvLineR.SETFILTER("P.A.N. No.", Pay2VendPAN);
        PurchInvLineR.SETFILTER(Type, '%1|%2', PurchInvLineR.Type::Item, PurchInvLineR.Type::"Charge (Item)");
        PurchInvLineR.CALCSUMS("Line Amount", "Line Discount Amount");
        PrevPurchInvoiceAmount := ABS(PurchInvLineR."Line Amount") - ABS(PurchInvLineR."Line Discount Amount");
        PurchCrMemoLineR.RESET;
        PurchCrMemoLineR.SETCURRENTKEY("Posting Date", "P.A.N. No.", Type);
        PurchCrMemoLineR.SETFILTER("Posting Date", AccPeriodFilter);
        PurchCrMemoLineR.SETFILTER("P.A.N. No.", Pay2VendPAN);
        PurchCrMemoLineR.SETFILTER(Type, '%1|%2', PurchCrMemoLineR.Type::Item, PurchCrMemoLineR.Type::"Charge (Item)");
        PurchCrMemoLineR.CALCSUMS("Line Amount", "Line Discount Amount");
        PrevPurchCreditMemoAmount := ABS(PurchCrMemoLineR."Line Amount") - ABS(PurchCrMemoLineR."Line Discount Amount");
    end;

    procedure CalculateTDS_TradingTrans(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";

        CurrPurchLine: Record "Purchase Line";
        DateFilterCalc: Codeunit "DateFilter-Calc";
        AccountingPeriodFilter: Text[30];
        AccountingPeriodFilter2: Text[30];
        CurrentPOTDSAmt: Decimal;
        CurrentPOAmount: Decimal;
        TDSBaseLCY: Decimal;

        PurchInvAmt_TDS: Decimal;
        PurchCrMemoAmt_TDS: Decimal;
        FinalAmt_TDS: Decimal;
        OrderLineNo: Integer;
        LineWiseOrderamt: Decimal;
        OrderAmtB: Decimal;
        FinalOrderAmt: Decimal;
        TDSB: Decimal;
        OverPurchase: Boolean;
        LineC: Integer;
        TaxTransValueR_ForPurchline: Record "Tax Transaction Value";
        TDSSetup_ForPurchline: Record "TDS Setup";
        Tdsamt_Currpurchline: Decimal;
        BelowThresholdlimit: Boolean;
    begin
        //040523
        // Message('%1|%2|%3|%4|%5', "Document Type", "No.", PurchHeader."Document Type", PurchHeader."No.", 'NewFunc');
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETFILTER("No.", '<>%1', '');
        if PurchLine.Find('-') then
            repeat
                IF (PurchLine."TDS Section Code" <> '') AND (AccountingPeriodFilter = '') THEN
                    DateFilterCalc.CreateAccountingPeriodFilter(AccountingPeriodFilter, AccountingPeriodFilter2, PurchHeader."Posting Date", 0);
                //DateFilterCalc.CreateTDSAccountingDateFilter(AccountingPeriodFilter, FiscalYear, PurchHeader."Posting Date", 0);
                // Message('%1|%2|%3', AccountingPeriodFilter, AccountingPeriodFilter2, 'AccDatefilter');
                CurrentPOAmount := 0;
                TDSBaseLCY := 0;
                PurchLine."New TDS Base Amount" := 0;
                Tdsamt_Currpurchline := 0;
                BelowThresholdlimit := true;
                PurchLine.CalculatePANWisePurchase(PurchLine, AccountingPeriodFilter, PurchLine."P.A.N. No.", PurchInvAmt_TDS, PurchCrMemoAmt_TDS);//TradingTDSCalc
                FinalAmt_TDS := PurchInvAmt_TDS - PurchCrMemoAmt_TDS;//TradingTDSCalc
                                                                     // Message('%1|%2', FinalAmt_TDS, 'PrvsAmt');
                OrderLineNo := 0;//TradingTDSCalc
                CurrPurchLine.RESET;
                CurrPurchLine.SETRANGE("Document Type", PurchLine."Document Type");
                CurrPurchLine.SETRANGE("Document No.", PurchLine."Document No.");
                CurrPurchLine.SETRANGE("TDS Section Code", PurchLine."TDS Section Code");
                CurrPurchLine.SETFILTER("Line No.", '<%1', PurchLine."Line No.");
                IF CurrPurchLine.FIND('-') THEN
                    REPEAT
                        LineWiseOrderamt := 0;//TradingTDSCalc
                        IF OrderLineNo <> PurchLine."Line No." THEN
                            //TradingTDSCalc
                            OrderAmtB := 0;
                        //TradingTDSCalc
                        CurrentPOAmount := CurrentPOAmount + CurrPurchLine."Line Amount" - CurrPurchLine."Inv. Discount Amount";
                        LineWiseOrderamt := CurrPurchLine."Line Amount" - CurrPurchLine."Inv. Discount Amount";//TradingTDSCalc
                        OrderAmtB += (LineWiseOrderamt / CurrPurchLine.Quantity) * CurrPurchLine."Qty. to Invoice";//TradingTDSCalc
                        OrderLineNo := PurchLine."Line No.";//TradingTDSCalc
                                                            //TDS_ForCurrPurchline_Start
                                                            //Message('%1');
                        TDSSetup_ForPurchline.Get();
                        if not (CurrPurchLine."TDS Section Code" = '') then begin
                            TaxTransValueR_ForPurchline.Reset();
                            TaxTransValueR_ForPurchline.SetRange("Tax Record ID", CurrPurchLine.RecordId);
                            TaxTransValueR_ForPurchline.SetRange("Tax Type", TDSSetup_ForPurchline."Tax Type");
                            TaxTransValueR_ForPurchline.SetRange("Value Type", TaxTransValueR_ForPurchline."Value Type"::COMPONENT);
                            TaxTransValueR_ForPurchline.SetFilter(Percent, '<>%1', 0);
                            if TaxTransValueR_ForPurchline.FindSet() then begin
                                if not TaxTransValueR_ForPurchline.IsEmpty() then begin
                                    if TaxTransValueR_ForPurchline."Value ID" = 1 then
                                        TaxTransValueR_ForPurchline.CalcSums(Amount);
                                end;
                                Tdsamt_Currpurchline := TaxTransValueR_ForPurchline.Amount;
                            end;
                        end;
                        //TDS_ForCurrPurchline_End
                        CurrentPOTDSAmt := CurrentPOTDSAmt + Tdsamt_Currpurchline;
                    UNTIL CurrPurchLine.NEXT = 0;

                TDSBaseLCY := PurchLine.Amount;
                IF NOT (PurchLine."Qty. to Invoice" = 0) THEN
                    FinalOrderAmt := OrderAmtB
                ELSE
                    FinalOrderAmt := CurrentPOAmount;
                IF PurchLine."Qty. to Invoice" <> 0 THEN
                    TDSB := (TDSBaseLCY / PurchLine.Quantity) * PurchLine."Qty. to Invoice"
                ELSE
                    TDSB := TDSBaseLCY;
                LineC += 1;

                IF (PurchHeader."Applies-to Doc. No." = '') AND (PurchHeader."Applies-to ID" = '') THEN BEGIN
                    IF (FinalAmt_TDS + FinalOrderAmt + TDSB) > 5000000 THEN BEGIN
                        //TradingTDSCalc
                        //Message('Enter1');
                        // "New TDS Base Amount" := 0;
                        BelowThresholdlimit := false;
                        OverPurchase := FALSE;
                        //TradingTDSCalc
                        IF FinalAmt_TDS > 5000000 THEN BEGIN//TradingTDSCalc
                            PurchLine."New TDS Base Amount" := TDSBaseLCY;//TradingTDSCalc
                            OverPurchase := TRUE;//TradingTDSCalc
                        END;//TradingTDSCalc
                        IF NOT OverPurchase THEN BEGIN
                            //TradingTDSCalc_Open
                            IF (FinalAmt_TDS + FinalOrderAmt + TDSB) > 5000000 THEN BEGIN
                                IF PurchLine."Qty. to Invoice" = 0 THEN BEGIN
                                    PurchLine."New TDS Base Amount" := (FinalAmt_TDS + FinalOrderAmt + TDSB - 5000000);
                                    IF PurchLine."New TDS Base Amount" > TDSB THEN
                                        PurchLine."New TDS Base Amount" := TDSB;
                                END;
                                IF NOT (PurchLine."Qty. to Invoice" = 0) THEN BEGIN
                                    IF (FinalAmt_TDS + FinalOrderAmt) > 5000000 THEN
                                        PurchLine."New TDS Base Amount" := (TDSB / PurchLine."Qty. to Invoice") * PurchLine.Quantity
                                    ELSE
                                        PurchLine."New TDS Base Amount" := ((FinalAmt_TDS + FinalOrderAmt + TDSB - 5000000) / PurchLine."Qty. to Invoice") * PurchLine.Quantity;
                                END;
                            END;
                        END;//TradingTDSCalc_Close
                        if BelowThresholdlimit then
                            PurchLine."New TDS Base Amount" := 0;
                        if (PurchLine."TDS Section Code" <> '194C') or (PurchLine."GST Group Type" <> PurchLine."GST Group Type"::Goods) then
                            PurchLine."New TDS Base Amount" := 0;
                    end;
                end;///Purchline_Close
                PurchLine.Modify();
            until PurchLine.Next() = 0;
    end;
}