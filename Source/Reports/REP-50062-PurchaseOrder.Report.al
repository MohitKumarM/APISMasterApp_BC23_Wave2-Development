// report 50062 "Purchase Order"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = '.\ReportLayouts\PurchaseOrder.rdl';
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;

//     dataset
//     {
//         dataitem(PurchaseHeader; "Purchase Header")
//         {
//             CalcFields = "Amount to Vendor";
//             DataItemTableView = SORTING("Document Type", "No.")
//                                 ORDER(Ascending)
//                                 WHERE("Document Type" = FILTER('Order'));
//             RequestFilterFields = "No.";
//             column(Heading; txtHeading)
//             {
//             }
//             column(ImagePath; 'file:///E:/Documents/Image/APIS.bmp')
//             {
//             }
//             column(CompanyLogo; recCompanyInfo.Picture)
//             {
//             }
//             column(RegOffAddress; recCompanyInfo.Address)
//             {
//             }
//             column(RegOffAddress1; recCompanyInfo."Address 2")
//             {
//             }
//             column(RegOffCity; recCompanyInfo.City)
//             {
//             }
//             column(RegOffPostCode; recCompanyInfo."Post Code")
//             {
//             }
//             column(RegOddPhone; recCompanyInfo."Phone No.")
//             {
//             }
//             column(RegOffState; txtRegOffStateName)
//             {
//             }
//             column(RegOffCountry; txtRegOffCountryName)
//             {
//             }
//             column(RegOffContact; recCompanyInfo."Name 2")
//             {
//             }
//             column(CompanyName; recCompanyInfo.Name)
//             {
//             }
//             column(CompanyAddress; recLocation.Address)
//             {
//             }
//             column(CompanyAddress2; recLocation."Address 2")
//             {
//             }
//             column(CompanyCity; recLocation.City)
//             {
//             }
//             column(CompanyPostCode; recLocation."Post Code")
//             {
//             }
//             column(CompanyState; txtLocationState)
//             {
//             }
//             column(CompanyCountry; txtLocationCountry)
//             {
//             }
//             column(LocationPhone; recLocation."Phone No.")
//             {
//             }
//             column(LocationContact; recLocation.Contact)
//             {
//             }
//             column(PurchOrderNo; "No.")
//             {
//             }
//             column(PurchaseOrderDate; "Order Date")
//             {
//             }
//             column(VendorName; "Buy-from Vendor Name")
//             {
//             }
//             column(VendorAddress; "Buy-from Address")
//             {
//             }
//             column(VendorAddress2; "Buy-from Address 2")
//             {
//             }
//             column(VendorCity; "Buy-from City")
//             {
//             }
//             column(VendorPostCode; "Buy-from Post Code")
//             {
//             }
//             column(VendorCountry; txtVendorCountry)
//             {
//             }
//             column(OPSNo; "Your Reference")
//             {
//             }
//             column(ShipToName; "Ship-to Name")
//             {
//             }
//             column(ShipToAddress; "Ship-to Address")
//             {
//             }
//             column(ShipToAddress2; "Ship-to Address 2")
//             {
//             }
//             column(ShipToCity; "Ship-to City")
//             {
//             }
//             column(ShipToPostCode; "Ship-to Post Code")
//             {
//             }
//             column(PayToName; "Pay-to Name")
//             {
//             }
//             column(PayToAddress; "Pay-to Address")
//             {
//             }
//             column(PayToAdrress2; "Pay-to Address 2")
//             {
//             }
//             column(PayToCity; "Pay-to City")
//             {
//             }
//             column(PayToPostCode; "Pay-to Post Code")
//             {
//             }
//             column(ShipToCountry; txtShipToCountry)
//             {
//             }
//             // column(VendorTIN; recVendor."T.I.N. No.")
//             // {
//             // }
//             column(VendorCST; recVendor."C.S.T. No.")
//             {
//             }
//             // column(BuyerTIN; recLocation."T.I.N. No.")
//             // {
//             // }
//             column(BuyerECCNo; recLocation."E.C.C. No.")
//             {
//             }
//             column(BuyerServiceTaxNo; recLocation."Service Tax Registration No.")
//             {
//             }
//             column(BuyerExciseReg; recLocation."E.C.C. No.")
//             {
//             }
//             column(CompanyPANNo; recCompanyInfo."P.A.N. No.")
//             {
//             }
//             column(CompanyEmail; recCompanyInfo."E-Mail")
//             {
//             }
//             column(PaymentTerms; txtPaymentTerm)
//             {
//             }
//             column(ShipmentMethod; recShipmentMethod.Description)
//             {
//             }
//             column(RefText; "Purchase Line"."New Product Group Code")
//             {
//             }
//             column(FormCode; txtFormCode)
//             {
//             }
//             column(Term2; '2. All disputes subject to Delhi Jurisdiction.')
//             {
//             }
//             column(Term3; '3. ' + txtFreightTerms)
//             {
//             }
//             column(Term4; '4. Quality & Analysis Certificate to be send with each consignment.')
//             {
//             }
//             column(Term5; '5. Delivery to be made at ')
//             {
//             }
//             column(Term6; '6. Copy of bill to be send to the Delhi Office at ')
//             {
//             }
//             column(Term7; '7. Please return one copy duly signed and accepted for our records.')
//             {
//             }
//             column(Term8; Remarks1)
//             {
//             }
//             column(Term9; Remarks2)
//             {
//             }
//             column(TotalTaxAmount; decTotalLineAmount)
//             {
//             }
//             column(TotalLineAmount; decTotalLineValue)
//             {
//             }
//             column(TaxName; 'GST')
//             {
//             }
//             column(TaxAmount; TotalGstAmt)
//             {
//             }
//             column(AmountInWord1; NumberText[1])
//             {
//             }
//             column(AmountInWord2; NumberText[2])
//             {
//             }
//             dataitem(PurchaseLine; "Purchase Line")
//             {
//                 DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
//                                     ORDER(Ascending);
//                 column(LineSrNo; intSrNo)
//                 {
//                 }
//                 column(PurchLineNo; "Line No.")
//                 {
//                 }
//                 column(ItemNo; "No.")
//                 {
//                 }
//                 column(ItemName; Description)
//                 {
//                 }
//                 column(Quantity; "Dispatched Qty. in Kg.")
//                 {
//                 }
//                 column(UOM; "Unit of Measure Code")
//                 {
//                 }
//                 column(UnitCost; "Direct Unit Cost")
//                 {
//                 }
//                 column(TaxPercentage; decTaxPerc)
//                 {
//                 }
//                 column(ServiceTaxPercentage; decSerTaxPerc)
//                 {
//                 }
//                 column(LineAmount; "Dispatched Qty. in Kg." * "Purchase Line"."Direct Unit Cost")
//                 {
//                 }
//                 column(PackSize; recItem."Pack Size")
//                 {
//                 }
//                 column(ItemDimension; recItem."Item Size Dimension")
//                 {
//                 }
//                 column(LineDiscPerc; "Line Discount %")
//                 {
//                 }
//                 column(LineDiscAmt; ("Dispatched Qty. in Kg." * "Direct Unit Cost") * "Line Discount %" / 100)
//                 {
//                 }
//                 column(Dispatched_Qty__in_Kg_; "Dispatched Qty. in Kg.")
//                 {
//                 }
//                 column(Direct_Unit_Cost; "Direct Unit Cost")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     lItem: Record Item;
//                 begin
//                     intSrNo += 1;

//                     IF Quantity <> 0 THEN
//                         decTotalLineValue += "Line Amount" / Quantity * "Dispatched Qty. in Kg.";

//                     decTaxPerc := 0;
//                     IF ("Tax Amount" <> 0) AND ("Form Code" = '') THEN
//                         CalculateTax("Location Code", "Tax Group Code", PurchaseHeader."Posting Date", decTaxPerc, recVendor."State Code")
//                     ELSE
//                         IF ("Tax Amount" <> 0) AND ("Form Code" <> '') THEN
//                             decTaxPerc := "Purchase Line"."Tax %";

//                     decSerTaxPerc := 0;
//                     IF "Service Tax Amount" <> 0 THEN BEGIN
//                         decSerTaxPerc := "Service Tax Amount" + "Service Tax eCess Amount" + "Service Tax SHE Cess Amount";
//                         decSerTaxPerc := decSerTaxPerc / "Line Amount" * 100;
//                     END;

//                     IF NOT recItem.GET("No.") THEN
//                         recItem.INIT;

//                     If lItem.GET("No.") THEN BEGIN
//                         AmountExclGST := Quantity * "Direct Unit Cost";
//                         CalculateLineGST(PurchaseHeader, PurchaseLine);
//                         GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                         if GSTAmount > 0 then
//                             GST := '18%'
//                         else
//                             GST := '0%';
//                         AmountInclGst := GSTAmount + AmountExclGST;
//                     End;

//                     TotalGSTAmt += GSTAmount;
//                     Total += AmountInclGst;

//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     rptCheque.InitTextVariable;
//                     rptCheque.FormatNoText(NumberText, ROUND((decTotalLineValue + TotalGstAmt), 0.01), "Currency Code");
//                 end;
//             }
//             dataitem(PurchCommentLine; "Purch. Comment Line")
//             {
//                 DataItemLink = "Document Type" = FIELD("Document Type"),
//                                "No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
//                                     ORDER(Ascending)
//                                     WHERE("User ID" = FILTER(''));
//                 column(LineNo; "Purch. Comment Line"."Line No.")
//                 {
//                 }
//                 column(CommentLineNo; intSrNo)
//                 {
//                 }
//                 column(PurchLineComment; "Purch. Comment Line".Comment)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     intSrNo += 1;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     intSrNo := 0;
//                 end;
//             }
//             // dataitem(DataItem1000000041; 13794)
//             // {
//             //     CalcFields = Tax Amount;
//             //     DataItemLink = Document No.=FIELD(No.);
//             //     DataItemTableView = SORTING(Type, Calculation Order, Document Type, Document No., Structure Code, Tax/Charge Type, Tax/Charge Group, Tax/Charge Code, Document Line No.)
//             //                         ORDER(Ascending)
//             //                         WHERE(Type = FILTER(Purchase),
//             //                               Document Type=FILTER(Order));
//             //     column(TaxName;txtTaxName)
//             //     {
//             //     }
//             //     column(TaxAmount;decLineTaxAmount)
//             //     {
//             //     }
//             //     column(AmountInWord1;NumberText[1])
//             //     {
//             //     }
//             //     column(AmountInWord2;NumberText[2])
//             //     {
//             //     }

//             //     trigger OnAfterGetRecord()
//             //     begin
//             //         IF "Structure Order Details"."Tax/Charge Type" = "Structure Order Details"."Tax/Charge Type"::"Sales Tax" THEN BEGIN
//             //           IF STRPOS("Tax Area Code", 'VAT') = 0 THEN
//             //             txtTaxName := 'CST'
//             //           ELSE
//             //             txtTaxName := 'VAT';
//             //           IF "Purchase Line"."Dispatched Qty. in Kg." <> 0 THEN
//             //             decLineTaxAmount := "Structure Order Details"."Tax Amount" / "Purchase Line".Quantity * "Purchase Line"."Dispatched Qty. in Kg.";
//             //           decLineTaxAmount := ROUND(decLineTaxAmount, 0.01);
//             //         END ELSE IF "Structure Order Details"."Tax/Charge Type" <> "Structure Order Details"."Tax/Charge Type"::Charges THEN BEGIN
//             //           txtTaxName := FORMAT("Structure Order Details"."Tax/Charge Type");
//             //           IF "Purchase Line"."Dispatched Qty. in Kg." <> 0 THEN
//             //             decLineTaxAmount := "Structure Order Details"."Tax Amount" / "Purchase Line".Quantity * "Purchase Line"."Dispatched Qty. in Kg.";
//             //           decLineTaxAmount := ROUND(decLineTaxAmount, 0.01);
//             //         END ELSE BEGIN
//             //           IF recTaxChargeGroup.GET("Structure Order Details"."Tax/Charge Group") THEN
//             //             txtTaxName := recTaxChargeGroup.Description;
//             //           decLineTaxAmount := "Structure Order Details"."Tax Amount";
//             //           decLineTaxAmount := ROUND(decLineTaxAmount, 0.01);
//             //         END;

//             //         decTotalLineAmount += decLineTaxAmount;
//             //         rptCheque.InitTextVariable;
//             //         rptCheque.FormatNoText(NumberText,ROUND(decTotalLineAmount + decTotalLineValue, 0.01), "Currency Code");
//             //     end;
//             // }

//             trigger OnAfterGetRecord()
//             begin
//                 PurchSetup.GET;
//                 IF Status = Status::Released THEN
//                     txtHeading := 'Purchase Confirmation'
//                 ELSE
//                     txtHeading := 'Test Report';
//                 /*
//                 IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
//                   CalcInvDiscForHeader;
//                   COMMIT;
//                 END;
//                 */
//                 // IF Structure <> '' THEN BEGIN
//                 //     PurchLine.CalculateStructures("Purchase Header");
//                 //     PurchLine.AdjustStructureAmounts("Purchase Header");
//                 //     PurchLine.UpdatePurchLines("Purchase Header");
//                 //     PurchLine.CalculateTDS("Purchase Header");
//                 // END ELSE
//                 //     PurchLine.CalculateTDS("Purchase Header");
//                 //COMMIT;

//                 recCompanyInfo.GET;
//                 recCompanyInfo.CALCFIELDS(Picture);
//                 recVendor.GET("Buy-from Vendor No.");
//                 recLocation.GET("Location Code");

//                 txtCompanyCountry := '';
//                 IF recCountry.GET(recCompanyInfo."Country/Region Code") THEN
//                     txtCompanyCountry := recCountry.Name;

//                 txtVendorCountry := '';
//                 IF recCountry.GET("Buy-from Country/Region Code") THEN
//                     txtVendorCountry := recCountry.Name;

//                 txtLocationState := '';
//                 IF recState.GET(recLocation."State Code") THEN
//                     txtLocationState := recState.Description;

//                 txtLocationCountry := '';
//                 IF recCountry.GET(recLocation."Country/Region Code") THEN
//                     txtLocationCountry := recCountry.Name;

//                 IF recPaymentTerms.GET("Payment Terms Code") THEN
//                     txtPaymentTerm := 'Payment Term : ' + recPaymentTerms.Description
//                 ELSE
//                     txtPaymentTerm := 'Payment Term';

//                 txtFreightTerms := '';
//                 IF "Freight Liability" = "Freight Liability"::Supplier THEN
//                     txtFreightTerms := 'Freight will be Paid by ' + recVendor.Name
//                 ELSE
//                     txtFreightTerms := 'Freight will be Paid by ' + recCompanyInfo.Name;

//                 IF recShipmentMethod.GET("Shipment Method Code") THEN;

//                 decTotalLineAmount := 0;
//                 decTotalLineValue := 0;
//                 intSrNo := 0;

//                 IF "Form Code" <> '' THEN
//                     txtFormCode := 'Central Form if any : ' + "Form Code"
//                 ELSE
//                     txtFormCode := '';

//                 // recPurchaseLine.RESET;
//                 // recPurchaseLine.SETRANGE("Document Type", "Document Type");
//                 // recPurchaseLine.SETRANGE("Document No.", "No.");
//                 // IF recPurchaseLine.FIND('-') THEN
//                 //     REPEAT
//                 //         IF recPurchaseLine.Quantity <> 0 THEN
//                 //             decTotalLineValue += recPurchaseLine."Line Amount" / recPurchaseLine.Quantity * recPurchaseLine."Dispatched Qty. in Kg.";
//                 //     UNTIL recPurchaseLine.NEXT = 0;
//                 // recPurchaseLine.FINDFIRST;

//                 /*
//                 recStructureLines.RESET;
//                 recStructureLines.SETRANGE(Type, recStructureLines.Type::Purchase);
//                 recStructureLines.SETRANGE("Document Type", recStructureLines."Document Type"::Order);
//                 recStructureLines.SETRANGE("Document No.", "No.");
//                 IF recStructureLines.FIND('-') THEN REPEAT
//                   recPurchaseLine.RESET;
//                   recPurchaseLine.SETRANGE("Document Type", "Document Type");
//                   recPurchaseLine.SETRANGE("Document No.", "No.");
//                   recPurchaseLine.SETRANGE("Line No.", recStructureLines."Document Line No.");
//                   recPurchaseLine.FINDFIRST;

//                   recStructureLines.CALCFIELDS("Tax Amount");
//                   IF recStructureLines."Tax/Charge Type" <> recStructureLines."Tax/Charge Type"::Charges THEN
//                     IF recPurchaseLine.Quantity <> 0 THEN
//                       decTotalLineAmount += recStructureLines."Tax Amount" / recPurchaseLine.Quantity * recPurchaseLine."Dispatched Qty. in Kg."
//                   ELSE
//                     decTotalLineAmount += recStructureLines."Tax Amount";
//                 UNTIL recStructureLines.NEXT = 0;
//                 */

//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     local procedure CalculateLineGST(pPurchHdr: Record "Purchase Header"; pPurchLine: Record "Purchase Line")
//     var
//         recTaxRates: Record "Tax Rate";
//         recTaxConfig: Record "Tax Rate Value";
//         recTaxComponent: Record "Tax Component";
//         TaxRates: Page "Tax Rates";
//         intCGST: Integer;
//         intIGST: Integer;
//         intSGST: Integer;
//         TaxRateID: Text;
//         ConfigID: Text;
//     Begin
//         intCGST := 0;
//         intSGST := 0;
//         intIGST := 0;

//         recTaxComponent.Reset();
//         recTaxComponent.SetRange("Tax Type", 'GST');
//         recTaxComponent.FindSet();
//         repeat
//             case recTaxComponent.Name of
//                 'IGST':
//                     intIGST := recTaxComponent.ID;
//                 'CGST':
//                     intCGST := recTaxComponent.ID;
//                 'SGST':
//                     intSGST := recTaxComponent.ID;
//             end;
//         until recTaxComponent.Next() = 0;

//         ConfigID := StrSubstNo('%1|%2|%3', intIGST, intCGST, intSGST);
//         GetLineGSTAmount(pPurchLine, ConfigID, intIGST, intCGST, intSGST);
//     End;

//     local procedure GetLineGSTAmount(pPurchLine: Record "Purchase Line"; FilterID: Text; IGSTID: Integer; CGSTID: Integer; SGSTID: Integer)
//     var
//         lPurchaseLine: Record "Purchase Line";
//         TaxTransactionValue: Record "Tax Transaction Value";
//         GSTSetup: Record "GST Setup";
//         decTotTaxAmt: Decimal;
//     begin
//         lPurchaseLine.Get(pPurchLine."Document Type", pPurchLine."Document No.", pPurchLine."Line No.");
//         decTotTaxAmt := 0;
//         if not GSTSetup.Get() then
//             exit;

//         TaxTransactionValue.SetRange("Tax Record ID", lPurchaseLine.RecordId);
//         TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//         if GSTSetup."Cess Tax Type" <> '' then
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
//         else
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//         TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//         TaxTransactionValue.SetFilter("Value ID", FilterID);
//         // if not TaxTransactionValue.IsEmpty() then
//         //     TaxTransactionValue.CalcSums(Amount);

//         if TaxTransactionValue.FindSet() then
//             repeat
//                 case TaxTransactionValue."Value ID" of
//                     IGSTID:
//                         begin
//                             IGST := Format(TaxTransactionValue.Percent) + '%';
//                             IGSTamount := TaxTransactionValue.Amount;
//                         end;
//                     CGSTID:
//                         begin
//                             CGST := Format(TaxTransactionValue.Percent) + '%';
//                             CGSTamount := TaxTransactionValue.Amount;
//                         end;
//                     SGSTID:
//                         begin
//                             SGST := Format(TaxTransactionValue.Percent) + '%';
//                             SGSTamount := TaxTransactionValue.Amount;
//                         end;
//                 end;
//                 decTotTaxAmt += TaxTransactionValue.Amount;
//             until TaxTransactionValue.Next() = 0;
//         // exit(TaxTransactionValue.Amount);
//         //exit(decTotTaxAmt);
//     end;

//     var
//         "Purchase Line": Record "Purchase Line";
//         "Purchase Header": Record "Purchase Header";
//         "Purch. Comment Line": Record "Purch. Comment Line";
//         recCompanyInfo: Record 79;
//         recCountry: Record 9;
//         txtCompanyCountry: Text[50];
//         txtVendorCountry: Text[50];
//         txtShipToCountry: Text[50];
//         recVendor: Record 23;
//         recLocation: Record 14;
//         recPaymentTerms: Record 3;
//         decTotalLineAmount: Decimal;
//         intSrNo: Integer;
//         rptCheque: Report 1401;
//         NumberText: array[2] of Text[80];
//         txtTaxName: Text[50];
//         // recTaxChargeGroup: Record 13790;
//         recPurchaseLine: Record 39;
//         // recStructureLines: Record 13794;
//         decTotalLineValue: Decimal;
//         recShipmentMethod: Record 10;
//         decTaxPerc: Decimal;
//         decSerTaxPerc: Decimal;
//         txtRegOffStateName: Text[50];
//         txtRegOffCountryName: Text[50];
//         txtFormCode: Text[50];
//         txtPaymentTerm: Text[50];
//         txtFreightTerms: Text[100];
//         recItem: Record 27;
//         txtLocationState: Text[50];
//         txtLocationCountry: Text[50];
//         recState: Record State;
//         PurchSetup: Record 312;
//         PurchLine: Record 39;
//         decLineTaxAmount: Decimal;
//         txtHeading: Text[50];
//         GST: text[50];
//         IGST: Text;
//         SGST: Text;
//         CGST: Text;
//         Total: Decimal;
//         AmountInclGst: Decimal;
//         AmountExclGST: Decimal;
//         GSTAmount: Decimal;
//         IGSTamount: Decimal;
//         SGSTAmount: Decimal;
//         CGSTamount: Decimal;
//         TotalGstAmt: Decimal;

//     [Scope('Internal')]
//     procedure CalculateTax(cdLocation: Code[20]; cdTaxGroupCode: Code[20]; dtPostingDate: Date; var decNetTaxPerc: Decimal; cdVendorState: Code[20])
//     var
//         recLocation: Record 14;
//         // recTaxAreaLocation: Record 13761;
//         recTaxArea: Record 319;
//         recTaxDetails: Record 322;
//         decTaxAmount: Decimal;
//         recTaxArea1: Record 319;
//         recTaxDetails1: Record 322;
//         intCalOrder: Integer;
//         decTempAmount: Decimal;
//         decTaxPerc: Decimal;
//         decTempAmount1: Decimal;
//     begin
//         recLocation.GET(cdLocation);
//         recLocation.TESTFIELD("State Code");

//         // recTaxAreaLocation.RESET;
//         // recTaxAreaLocation.SETRANGE(Type, recTaxAreaLocation.Type::Vendor);
//         // recTaxAreaLocation.SETRANGE("Dispatch / Receiving Location", cdLocation);
//         // recTaxAreaLocation.SETRANGE("Customer / Vendor Location", cdVendorState);
//         // recTaxAreaLocation.FIND('-');
//         // recTaxAreaLocation.TESTFIELD("Tax Area Code");

//         decTaxAmount := 0;
//         decTaxPerc := 0;
//         recTaxArea.RESET;
//         recTaxArea.SETCURRENTKEY("Tax Area", "Calculation Order");
//         // recTaxArea.SETRANGE("Tax Area", recTaxAreaLocation."Tax Area Code");
//         recTaxArea.FIND('-');
//         REPEAT
//             recTaxDetails.RESET;
//             recTaxDetails.SETRANGE("Tax Jurisdiction Code", recTaxArea."Tax Jurisdiction Code");
//             recTaxDetails.SETRANGE("Tax Group Code", cdTaxGroupCode);
//             recTaxDetails.SETFILTER("Effective Date", '<=%1', dtPostingDate);
//             recTaxDetails.SETRANGE("Form Code", '');
//             IF recTaxDetails.FIND('+') THEN BEGIN
//                 // IF recTaxArea."Include Tax Base" THEN BEGIN
//                 decTaxPerc += recTaxDetails."Tax Below Maximum";
//             END ELSE BEGIN
//                 // IF recTaxArea.Formula <> '' THEN BEGIN
//                 // EVALUATE(intCalOrder, recTaxArea.Formula);
//                 recTaxArea1.RESET;
//                 recTaxArea1.SETCURRENTKEY("Tax Area", "Calculation Order");
//                 // recTaxArea1.SETRANGE("Tax Area", recTaxAreaLocation."Tax Area Code");
//                 recTaxArea1.SETRANGE("Calculation Order", intCalOrder);
//                 recTaxArea1.FIND('-');

//                 recTaxDetails1.RESET;
//                 recTaxDetails1.SETRANGE("Tax Jurisdiction Code", recTaxArea1."Tax Jurisdiction Code");
//                 recTaxDetails1.SETRANGE("Tax Group Code", cdTaxGroupCode);
//                 recTaxDetails1.SETFILTER("Effective Date", '<=%1', dtPostingDate);
//                 recTaxDetails1.SETRANGE("Form Code", '');
//                 IF recTaxDetails1.FIND('+') THEN BEGIN
//                     decTempAmount1 := ROUND((decTempAmount / (100 + recTaxDetails."Tax Below Maximum") * 100), 0.01);
//                     decTaxAmount += ROUND(decTempAmount - decTempAmount1, 0.01);
//                     decTaxPerc += ROUND((recTaxDetails1."Tax Below Maximum" * recTaxDetails."Tax Below Maximum" / 100), 0.01);
//                 END;
//             END;
//         //END;
//         //END;
//         UNTIL recTaxArea.NEXT = 0;

//         decNetTaxPerc := decTaxPerc;
//     end;
// }
