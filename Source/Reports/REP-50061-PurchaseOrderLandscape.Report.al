// report 50061 "Purchase Order Landscape"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = '.\ReportLayouts\PurchaseOrderLandscape.rdl';
//     // Caption = 'Purchase Order';
//     PreviewMode = PrintLayout;
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;

//     dataset
//     {
//         dataitem(Integer; Integer)
//         {
//             DataItemTableView = SORTING(Number)
//                                 ORDER(Ascending)
//                                 WHERE(Number = FILTER(1));
//             column(PageLoop; Integer.Number)
//             {
//             }
//             column(Company; recCompanyInfo.Name)
//             {
//             }
//             column(Logo; recCompanyInfo.Picture)
//             {
//             }
//             // column(CopyHeading; txtInvoiceCopy[Integer.Number])
//             // {
//             // }
//             dataitem("Purchase Header"; "Purchase Header")
//             {
//                 DataItemTableView = SORTING("No.")
//                                     ORDER(Ascending);
//                 RequestFilterFields = "No.";
//                 column(ProdGroup; cdProdGroup)
//                 {
//                 }
//                 column(OrderStatus; txtOrderStatus)
//                 {
//                 }
//                 column(ModeOfDelivery; txtModeOfDelivery)
//                 {
//                 }
//                 column(CompanyGSTIN; recCompanyInfo."GST Registration No.")
//                 {
//                 }
//                 column(BillingLocGSTIN; recLocation."GST Registration No.")
//                 {
//                 }
//                 column(RegOffAddress; recCompanyInfo.Address)
//                 {
//                 }
//                 column(RegOffAddress1; recCompanyInfo."Address 2")
//                 {
//                 }
//                 column(RegOffCity; recCompanyInfo.City)
//                 {
//                 }
//                 column(RegOffPostCode; recCompanyInfo."Post Code")
//                 {
//                 }
//                 column(RegOffState; txtRegOffState)
//                 {
//                 }
//                 column(Product_Group_Code; "Product Group Code")
//                 {
//                 }
//                 column(RegOffCountry; txtRegOffCountry)
//                 {
//                 }
//                 column(BillingAddress; recLocation.Address)
//                 {
//                 }
//                 column(BillingAddress1; recLocation."Address 2")
//                 {
//                 }
//                 column(BillingCity; recLocation.City)
//                 {
//                 }
//                 column(BillingPostCode; recLocation."Post Code")
//                 {
//                 }
//                 column(BillingState; txtCompanyState)
//                 {
//                 }
//                 column(BillingCountry; txtCompanyCountry)
//                 {
//                 }
//                 column(LocationName; txtShippingLocationAddress[1])
//                 {
//                 }
//                 column(CompanyAddress; txtShippingLocationAddress[2])
//                 {
//                 }
//                 column(CompanyAddress1; txtShippingLocationAddress[3])
//                 {
//                 }
//                 column(CompanyCity; txtShippingLocationAddress[4])
//                 {
//                 }
//                 column(CompanyPostCode; txtShippingLocationAddress[5])
//                 {
//                 }
//                 column(CompanyState; txtShippingState)
//                 {
//                 }
//                 column(CompanyCountry; '')
//                 {
//                 }
//                 column(CompanyPhoneNo; recLocation."Phone No.")
//                 {
//                 }
//                 column(UserEmail; recCompanyInfo."E-Mail")
//                 {
//                 }
//                 column(CompanyHomePage; recCompanyInfo."Home Page")
//                 {
//                 }
//                 column(CompanyPAN; recCompanyInfo."P.A.N. No.")
//                 {
//                 }
//                 column(CompanyRegistrationNo; recCompanyInfo."GST Registration No.")
//                 {
//                 }
//                 column(ShippingGSTIN; txtShippingLocationAddress[7])
//                 {
//                 }
//                 column(InvoiceType; txtInvoiceHeading)
//                 {
//                 }
//                 column(BillToName; recCustomer.Name)
//                 {
//                 }
//                 column(BillToAddress; recCustomer.Address)
//                 {
//                 }
//                 column(BillToAddress1; recCustomer."Address 2")
//                 {
//                 }
//                 column(BillToCity; recCustomer.City)
//                 {
//                 }
//                 column(BillToPostCode; recCustomer."Post Code")
//                 {
//                 }
//                 column(BillToState; txtBillToState)
//                 {
//                 }
//                 column(BillToCountry; txtBillToCountry)
//                 {
//                 }
//                 column(BuyerTINNo; txtBuyerTINNo)
//                 {
//                 }
//                 column(CustomerPAN; recCustomer."P.A.N. No.")
//                 {
//                 }
//                 column(BuyerStateCode; txtBuyerStateCode)
//                 {
//                 }
//                 column(ShipToStateCode; txtShipToStateCode)
//                 {
//                 }
//                 column(CustCode; "Buy-from Vendor No.")
//                 {
//                 }
//                 column(FreightLiability; FORMAT("Freight Liability"))
//                 {
//                 }
//                 column(SalesPersonName; txtSalesPersonName)
//                 {
//                 }
//                 column(ReverseCharge; txtReverseCharge)
//                 {
//                 }
//                 column(SalesQuoteRefNo; "No.")
//                 {
//                 }
//                 column(QuoteDate; FORMAT("Order Date"))
//                 {
//                 }
//                 column(PaymentTerms; txtPaymentTerms)
//                 {
//                 }
//                 column(QuoteValidity; FORMAT("Valid Till"))
//                 {
//                 }
//                 column(CurrencyText; txtCurrencyText)
//                 {
//                 }
//                 column(TransporterDetails; txtShippingAgent)
//                 {
//                 }
//                 column(TransitInsurance; "Transit Insurance")
//                 {
//                 }
//                 column(TermsOfDelivery; txtShippingMethod)
//                 {
//                 }
//                 column(RoundOff; decRoundOff)
//                 {
//                 }
//                 column(Term1; Remarks1)
//                 {
//                 }
//                 column(Term2; Remarks2)
//                 {
//                 }
//                 column(Term3; "Remarks 3")
//                 {
//                 }
//                 column(AmountInWord1; NoText[1])
//                 {
//                 }
//                 column(AmountInWord2; NoText[2])
//                 {
//                 }
//                 column(PGroup; PGroup)
//                 {
//                 }

//                 dataitem("Purchase Line"; "Purchase Line")
//                 {
//                     DataItemLink = "Document Type" = FIELD("Document Type"),
//                                    "Document No." = FIELD("No.");
//                     DataItemTableView = SORTING("Document No.", "Line No.")
//                                         ORDER(Ascending)
//                                         WHERE(Quantity = FILTER(<> 0));
//                     column(SalesLineNo; "Line No.")
//                     {
//                     }
//                     column(SerialNo; intSrNo)
//                     {
//                     }
//                     column(ItemName; Description)
//                     {
//                     }
//                     column(PartNo; "No.")
//                     {
//                     }
//                     column(CrossRef; '')
//                     {
//                     }
//                     column(Productgroupcode; "New Product Group Code")
//                     { }
//                     column(HSNSACCode; "HSN/SAC Code")
//                     {
//                     }
//                     column(DeliveryTime; FORMAT("Expected Receipt Date"))
//                     {
//                     }
//                     column(UOM; "Unit of Measure")
//                     {
//                     }
//                     // column(Quantity; "Dispatched Qty. in Kg.") { } //Shivam
//                     column(Quantity; Quantity) { } //Shivam 27/06/23
//                     // column(Quantity; Quantity)
//                     // {
//                     // }
//                     column(UnitPrice; "Direct Unit Cost")
//                     {
//                     }
//                     // column(LineAmount; "Dispatched Qty. in Kg." * "Direct Unit Cost") { } //Shivam 29/06/23
//                     column(LineAmount; Quantity * "Direct Unit Cost") { }
//                     // column(LineAmount; Quantity * "Direct Unit Cost")
//                     // {
//                     // }
//                     column(DisPerc; "Line Discount %")
//                     {
//                     }
//                     column(DisAmount; "Line Discount Amount" / Quantity * "Dispatched Qty. in Kg.")
//                     {
//                     }
//                     column(IGSTPerc; IGST)
//                     {
//                     }
//                     column(IGSTAmt; decGSTAmt[1])
//                     {
//                     }
//                     column(CGSTPerc; CGST)
//                     {
//                     }
//                     column(CGSTAmt; decGSTAmt[2])
//                     {
//                     }
//                     column(SGSTPerc; SGST)
//                     {
//                     }
//                     column(SGSTAmt; decGSTAmt[3])
//                     {
//                     }
//                     column(TotalGSTAmt; TotalGSTAmt)
//                     {
//                     }
//                     column(vSGSTamt; vSGSTamt) { }
//                     column(VIGSTamt; VIGSTamt) { }
//                     column(vCGSTamt; vCGSTamt) { }
//                     column("IGSTLine"; "VIGST%")
//                     {
//                     }
//                     column("CGSTLine"; "vCGST%")
//                     {
//                     }
//                     column("SGSTLine"; "vSGST%")
//                     {
//                     }
//                     column(New_Product_Group_Code; "New Product Group Code")
//                     {
//                     }
//                     column(Totalcalculatedgst; Totalcalculatedgst)
//                     { }
//                     column(ATotalamount; ATotalamount)
//                     {
//                     }
//                     column(iTEMCODE; iTEMCODE)
//                     { }
//                     trigger OnAfterGetRecord()
//                     var
//                         lItem: Record Item;
//                         LineAmtExGST: Decimal;
//                     begin
//                         IF ("Purchase Line".Type = "Purchase Line".Type::"G/L Account") AND (("Purchase Line"."No." = '41133536') OR ("Purchase Line"."No." = '41132906')) THEN
//                             CurrReport.SKIP;

//                         intSrNo += 1;

//                         LineAmtExGST := ("Dispatched Qty. in Kg." * "Direct Unit Cost");

//                         CLEAR(decGSTPerc);
//                         CLEAR(decGSTAmt);
//                         Clear(GSTPer);
//                         Clear(VIGSTamt);
//                         Clear(vCGSTamt);
//                         Clear(vSGSTamt);
//                         Clear(ATotalamount);

//                         GSTSetup.Get();
//                         intCounter += 1;
//                         TaxTransValue.Reset();
//                         TaxTransValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//                         TaxTransValue.SetRange("Tax Record ID", "Purchase Line".RecordId);
//                         TaxTransValue.SetRange("Value Type", TaxTransValue."Value Type"::COMPONENT);
//                         if TaxTransValue.FindSet() then
//                             repeat
//                                 TaxComponentName := TaxTransValue.GetAttributeColumName();
//                                 Clear(GSTAmount_l);
//                                 case TaxComponentName of
//                                     'IGST':
//                                         begin
//                                             evaluate(GSTAmount_l, TaxTransValue."Column Value");
//                                             "VIGST%" := format(TaxTransValue.Percent);
//                                             GSTPer := TaxTransValue.Percent;
//                                             //VIGSTamt += GSTAmount_l;
//                                             VIGSTamt := (LineAmtExGST * GSTPer) / 100;
//                                         end;
//                                     'CGST':
//                                         begin
//                                             evaluate(GSTAmount_l, TaxTransValue."Column Value");
//                                             "vCGST%" := format(TaxTransValue.Percent);
//                                             GSTPer := TaxTransValue.Percent;
//                                             //vCGSTamt += GSTAmount_l;
//                                             vCGSTamt := (LineAmtExGST * GSTPer) / 100;
//                                         end;
//                                     'SGST':
//                                         begin
//                                             evaluate(GSTAmount_l, TaxTransValue."Column Value");
//                                             "vSGST%" := format(TaxTransValue.Percent);
//                                             GSTPer := TaxTransValue.Percent;
//                                             //vSGSTamt += GSTAmount_l;
//                                             vSGSTamt := (LineAmtExGST * GSTPer) / 100;
//                                         end;
//                                 end;
//                             until TaxTransValue.Next() = 0;

//                         Totalcalculatedgst += VIGSTamt + vCGSTamt + vSGSTamt;
//                         ATotalamount += "Line Amount" + VIGSTamt + vCGSTamt + vSGSTamt;//Shivam 29/06/23
//                         // ATotalamount := LineAmtExGST + VIGSTamt + vCGSTamt + vSGSTamt;
//                         //GrandTotal += Amount + VIGSTamt + vCGSTamt + vSGSTamt;
//                         GrandTotal += ATotalamount;

//                         iTEM.Reset();
//                         iTEM.SetRange("No.", "Purchase Line"."No.");
//                         IF iTEM.FindFirst() then begin
//                             iTEMCODE := iTEM."New Product Group Code";
//                         end;

//                         if "Purchase Header"."Currency Code" = '' then
//                             repcheck.FormatNoText(NoText, ROUND(GrandTotal, 0.01), '')//GLSetup."LCY Code")
//                         else
//                             repcheck.FormatNoText(NoText, ROUND(GrandTotal, 0.01), "Purchase Header"."Currency Code");
//                         txtInvoiceHeading := 'Purchase Order No. ' + "Purchase Header"."No.";

//                     end;
//                 }
//                 dataitem("Sales Comment Line"; "Purch. Comment Line")
//                 {
//                     DataItemLink = "Document Type" = FIELD("Document Type"),
//                                    "No." = FIELD("No.");
//                     DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
//                                         ORDER(Ascending)
//                                         WHERE("User ID" = FILTER(''),
//                                               Comment = FILTER(<> ''));
//                     column(CommentSrNo; intSrNo)
//                     {
//                     }
//                     column(CommentLineNo; "Line No.")
//                     {
//                     }
//                     column(LineComment; Comment)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         intSrNo += 1;
//                     end;

//                     trigger OnPreDataItem()
//                     begin
//                         intSrNo := 0;
//                     end;
//                 }
//                 dataitem(BlankLines; 2000000026)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         ORDER(Ascending);
//                     column(BlankNo; BlankLines.Number)
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         IF intCounter > 1 THEN
//                             CurrReport.BREAK
//                         ELSE
//                             intCounter += 1;
//                     end;
//                 }
//                 trigger OnAfterGetRecord()
//                 var
//                 begin
//                     //     "Purchase Header".CalcFields(Amount);
//                     //     RepCheck.InitTextVariable();
//                     //     RepCheck.FormatNoText(NoText, Round("Purchase Header".Amount, 0.01),
//                     //    "Purchase Header"."Currency Code");
//                     //     AmountInWords := CurrencyCode + ' ' + DelChr(NoText[1], '=', '*');

//                     CalcFields(Amount);
//                     repcheck.InitTextVariable;

//                     IF "Purchase Header".Status <> "Purchase Header".Status::Released THEN
//                         txtOrderStatus := 'Draft';

//                     IF recTransportMethod.GET("Purchase Header"."Transport Method") THEN
//                         txtModeOfDelivery := recTransportMethod.Description;

//                     IF recShippingAgent.GET("Purchase Header"."Shipping Agent Code") THEN
//                         txtShippingAgent := recShippingAgent.Name;

//                     recLocation.GET("Purchase Header"."Location Code");
//                     txtCompanyState := '';
//                     IF recState.GET(recLocation."State Code") THEN BEGIN
//                         txtCompanyState := recState.Description;
//                         // txtBuyerStateCode := recState."State Code for TIN";
//                     END;

//                     txtCompanyCountry := '';
//                     IF recCountry.GET(recLocation."Country/Region Code") THEN
//                         txtCompanyCountry := recCountry.Name;

//                     IF recShippingAddress.GET("Purchase Header"."Shipping Vendor") THEN BEGIN
//                         txtShippingLocationAddress[1] := recShippingAddress.Name;
//                         txtShippingLocationAddress[2] := recShippingAddress.Address;
//                         txtShippingLocationAddress[3] := recShippingAddress."Address 2";
//                         txtShippingLocationAddress[4] := recShippingAddress.City;
//                         txtShippingLocationAddress[5] := recShippingAddress."Post Code";
//                         txtShippingLocationAddress[7] := recShippingAddress."GST Registration No.";
//                         IF recState.GET(recShippingAddress."State Code") THEN
//                             txtShippingState := recState.Description;
//                     END ELSE BEGIN
//                         txtShippingLocationAddress[1] := recCompanyInfo.Name;
//                         txtShippingLocationAddress[2] := recLocation.Address;
//                         txtShippingLocationAddress[3] := recLocation."Address 2";
//                         txtShippingLocationAddress[4] := recLocation.City;
//                         txtShippingLocationAddress[5] := recLocation."Post Code";
//                         txtShippingLocationAddress[6] := txtCompanyState;
//                         txtShippingLocationAddress[7] := recLocation."GST Registration No.";
//                     END;

//                     recCustomer.GET("Purchase Header"."Buy-from Vendor No.");
//                     txtBuyerTINNo := recCustomer."GST Registration No.";
//                     txtBillToState := '';
//                     IF recState.GET("Purchase Header".State) THEN
//                         txtBillToState := recState.Description;

//                     IF recCustomer."GST Vendor Type" = recCustomer."GST Vendor Type"::Unregistered THEN
//                         txtReverseCharge := 'Yes'
//                     ELSE
//                         txtReverseCharge := 'No';

//                     txtBillToCountry := '';
//                     IF recCountry.GET("Purchase Header"."Buy-from Country/Region Code") THEN
//                         txtBillToCountry := recCountry.Name;

//                     txtShippingMethod := '';
//                     IF recShippingMethod.GET("Purchase Header"."Shipment Method Code") THEN
//                         txtShippingMethod := recShippingMethod.Description;

//                     IF recSalesPerson.GET("Purchase Header"."Purchaser Code") THEN
//                         txtSalesPersonName := recSalesPerson.Name
//                     ELSE
//                         txtSalesPersonName := '';

//                     txtPaymentTerms := '';
//                     IF recPaymentTerms.GET("Purchase Header"."Payment Terms Code") THEN
//                         txtPaymentTerms := recPaymentTerms.Description;

//                     IF "Purchase Header"."Currency Code" = '' THEN
//                         txtCurrencyText := 'Amount in INR'
//                     ELSE
//                         txtCurrencyText := 'Amount in ' + "Purchase Header"."Currency Code";

//                     intSrNo := 0;
//                     recTaxJurisdiction.RESET;
//                     // recTaxJurisdiction.FINDFIRST;
//                     recTaxJurisdiction.MODIFYALL("GST Amount", 0);

//                     // recTaxJurisdiction.FINDFIRST;
//                     REPEAT
//                         recTaxJurisdictionToCalc.INIT;
//                         recTaxJurisdictionToCalc.TRANSFERFIELDS(recTaxJurisdiction);
//                     // recTaxJurisdictionToCalc.INSERT;
//                     UNTIL recTaxJurisdiction.NEXT = 0;

//                     decTotalOrderValue := 0;
//                     CLEAR(decGSTPerc);
//                     CLEAR(decGSTAmt);
//                     recPurchLine.RESET;
//                     recPurchLine.SETRANGE("Document Type", "Purchase Header"."Document Type");
//                     recPurchLine.SETRANGE("Document No.", "Purchase Header"."No.");
//                     IF recPurchLine.FINDFIRST THEN
//                         REPEAT
//                             cdProdGroup := recPurchLine."New Product Group Code";
//                             CLEAR(decGSTAmt);

//                             // cuGSTCalculation.ComputeUnPostedTaxComponent(recPurchLine."Document No.", recPurchLine."Line No.", recTaxJurisdictionToCalc);
//                             recTaxJurisdictionToCalc.RESET;
//                             recTaxJurisdictionToCalc.SETFILTER("GST Amount", '<>%1', 0);
//                             IF recTaxJurisdictionToCalc.FINDFIRST THEN
//                                 REPEAT
//                                     IF recTaxJurisdictionToCalc.Type = recTaxJurisdictionToCalc.Type::IGST THEN BEGIN
//                                         decGSTAmt[1] := recTaxJurisdictionToCalc."GST Amount";
//                                     END ELSE
//                                         IF recTaxJurisdictionToCalc.Type = recTaxJurisdictionToCalc.Type::CGST THEN BEGIN
//                                             decGSTAmt[2] := recTaxJurisdictionToCalc."GST Amount";
//                                         END ELSE
//                                             IF recTaxJurisdictionToCalc.Type = recTaxJurisdictionToCalc.Type::SGST THEN BEGIN
//                                                 decGSTAmt[3] := recTaxJurisdictionToCalc."GST Amount";
//                                             END;
//                                 UNTIL recTaxJurisdictionToCalc.NEXT = 0;
//                         // decGSTAmt[1] := ROUND(decGSTAmt[1] / recPurchLine.Quantity * recPurchLine."Dispatched Qty. in Kg.", 0.01);
//                         // decGSTAmt[2] := ROUND(decGSTAmt[2] / recPurchLine.Quantity * recPurchLine."Dispatched Qty. in Kg.", 0.01);
//                         // decGSTAmt[3] := ROUND(decGSTAmt[3] / recPurchLine.Quantity * recPurchLine."Dispatched Qty. in Kg.", 0.01);

//                         // decTotalOrderValue += (recPurchLine."Dispatched Qty. in Kg." * recPurchLine."Direct Unit Cost") +
//                         //                       decGSTAmt[1] + decGSTAmt[2] + decGSTAmt[3] - recPurchLine."Line Discount Amount" +
//                         //                       ROUND(recPurchLine."Charges To Vendor" / recPurchLine.Quantity * recPurchLine."Dispatched Qty. in Kg.", 0.01);
//                         UNTIL recPurchLine.NEXT = 0;

//                     rptCheque.InitTextVariable;
//                     rptCheque.FormatNoText(NumberText, ROUND(decTotalOrderValue, 0.01), "Purchase Header"."Currency Code");
//                 end;

//             }

//             trigger OnAfterGetRecord()
//             begin
//                 intCounter := 0;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 recCompanyInfo.GET;
//                 recCompanyInfo.CALCFIELDS(Picture);
//                 CLEAR(txtInvoiceCopy);
//                 txtInvoiceCopy[1] := 'Original for Buyer';
//                 txtInvoiceCopy[2] := 'Transporter Copy';
//                 txtInvoiceCopy[3] := 'Supplier Copy';
//                 txtInvoiceCopy[4] := 'Record Copy';
//                 txtInvoiceCopy[5] := 'Original for Buyer';
//                 recSalesSetup.GET;
//                 IF recState.GET(recCompanyInfo."State Code") THEN
//                     txtRegOffState := recState.Description;
//                 IF recCountry.GET(recCompanyInfo."Country/Region Code") THEN
//                     txtRegOffCountry := recCountry.Name;
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

//     var
//         GrandTotal: Decimal;
//         iTEMCODE: Code[20];
//         iTEM: Record 27;
//         Totalcalculatedgst: Decimal;
//         TaxComponentName: Text;
//         GSTAmount_l: Decimal;
//         GSTAmount: Decimal;

//         GSTPer: Decimal;

//         vCGSTamt: Decimal;

//         vSGSTamt: Decimal;

//         VIGSTamt: Decimal;

//         "vCGST%": Text;

//         "vSGST%": Text;

//         "VIGST%": Text;
//         GSTSetup: Record "GST Setup";
//         TaxTransValue: Record "Tax Transaction Value";
//         CurrencyCode: Record "Currency Amount";
//         AmountInWords: Decimal;
//         NoText: array[2] of Text[10];
//         RepCheck: Report "Check Report";
//         recVendor: Record 23;
//         recItem: Record 27;
//         // Integer: Record Integer;
//         recCompanyInfo: Record 79;
//         txtInvoiceCopy: array[5] of Text[50];
//         txtInvoiceHeading: Text[100];
//         recLocation: Record 14;
//         recState: Record State;
//         recCountry: Record 9;
//         txtCompanyState: Text[50];
//         txtCompanyCountry: Text[50];
//         recSalesPerson: Record 13;
//         txtSalesPersonName: Text[50];
//         recPaymentTerms: Record 3;
//         txtPaymentTerms: Text[50];
//         txtBillToState: Text[50];
//         txtBillToCountry: Text[50];
//         recCustomer: Record 23;
//         txtBuyerTINNo: Text[20];
//         intSrNo: Integer;
//         txtTaxName: Text[50];
//         // recTaxChargeGroup: Record 13790;
//         rptCheque: Report 1401;
//         NumberText: array[2] of Text[80];
//         txtCurrencyText: Text[50];
//         txtReportHeading: Text[50];
//         decRoundOff: Decimal;
//         intCounter: Integer;
//         recShippingMethod: Record 10;
//         txtShippingMethod: Text[50];
//         recTaxJurisdictionToCalc: Record 320 temporary;
//         recTaxJurisdiction: Record 320;
//         cuGSTCalculation: Codeunit 50008;
//         decGSTPerc: array[3] of Decimal;
//         decGSTAmt: array[3] of Decimal;
//         recSalesSetup: Record 311;
//         txtBuyerStateCode: Code[2];
//         txtShipToStateCode: Code[2];
//         txtReverseCharge: Text[10];
//         txtRegOffState: Text[50];
//         txtRegOffCountry: Text[50];
//         recShippingAddress: Record 23;
//         txtShippingState: Text[50];
//         txtShippingCountry: Text[50];
//         txtModeOfDelivery: Text[50];
//         recTransportMethod: Record 259;
//         txtShippingAgent: Text[50];
//         ProductGroup: Record "New Product Group";
//         PGroup: Code[20];
//         recShippingAgent: Record 291;
//         txtOrderStatus: Text[50];
//         decTotalOrderValue: Decimal;
//         recPurchLine: Record 39;
//         cdProdGroup: Code[20];
//         txtShippingLocationAddress: array[7] of Text[50];
//         GST: text[50];
//         IGST: Text;
//         SGST: Text;
//         CGST: Text;
//         Total: Decimal;
//         AmountInclGst: Decimal;
//         AmountExclGST: Decimal;
//         IGSTamount: Decimal;
//         SGSTAmount: Decimal;
//         CGSTamount: Decimal;
//         TotalGstAmt: Decimal;
//         ATotalamount: Decimal;

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
//                             decGSTAmt[1] := TaxTransactionValue.Amount;
//                         end;
//                     CGSTID:
//                         begin
//                             CGST := Format(TaxTransactionValue.Percent) + '%';
//                             decGSTAmt[2] := TaxTransactionValue.Amount;
//                         end;
//                     SGSTID:
//                         begin
//                             SGST := Format(TaxTransactionValue.Percent) + '%';
//                             decGSTAmt[3] := TaxTransactionValue.Amount;
//                         end;
//                 end;
//                 decTotTaxAmt += TaxTransactionValue.Amount;
//             until TaxTransactionValue.Next() = 0;
//         // exit(TaxTransactionValue.Amount);
//         //exit(decTotTaxAmt);
//     end;
// }
