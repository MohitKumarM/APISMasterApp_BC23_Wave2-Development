report 50067 "Purchase Receipt H-Pre"
{
    //     DefaultLayout = RDLC;

    //RDLCLayout = '.\ReportLayouts\PurchaseReceiptHPre.rdl';
    //     PreviewMode = PrintLayout;
    //     UsageCategory = ReportsAndAnalysis;
    //     ApplicationArea = All;
    //     Caption = 'Purchase Recipt H-Pre';

    //     dataset
    //     {
    //         dataitem("Purchase Header"; "Purchase Header")
    //         {
    //             DataItemTableView = SORTING("Document Type", "No.")
    //                                 ORDER(Ascending);
    //             RequestFilterFields = "No.";
    //             column(Logo; recCompanyInfo.Picture)
    //             {
    //             }
    //             column(CINNo; recCompanyInfo."Company Registration  No.")
    //             {
    //             }
    //             column(PANNo; recCompanyInfo."P.A.N. No.")
    //             {
    //             }
    //             column(GSTINNo; recLocation."GST Registration No.")
    //             {
    //             }
    //             // column(VendorGSTIN; recVendor."GST Registration No.")
    //             // {
    //             // }
    //             column(VendorGSTIN; VendorGSTIN) { } //Shivam
    //             column(FreightTerms; "Freight Liability")
    //             {
    //             }
    //             column(ReceiptNo; "No.")
    //             {
    //             }
    //             column(ReceiptDate; FORMAT("Posting Date"))
    //             {
    //             }
    //             column(PaymentTerm; recPaymentTerm.Description)
    //             {
    //             }
    //             column(OrderNo; "No.")
    //             {
    //             }
    //             column(OrderDate; FORMAT("Order Date"))
    //             {
    //             }
    //             column(FormCode; "Form Code")
    //             {
    //             }
    //             column(ShipToCode; "Ship-to Code")
    //             {
    //             }
    //             column(RoadPermitNo; "Waybill No.")
    //             {
    //             }
    //             column(GateEntryNo; "Gate Entry No.")
    //             {
    //             }
    //             column(VendorInvValue; "Vendor Invoice Value")
    //             {
    //             }
    //             column(GateEntryDate; FORMAT("Gate Entry Date"))
    //             {
    //             }
    //             column(ShipToName; recLocation.Name)
    //             {
    //             }
    //             column(ShipToAddress; recLocation.Address)
    //             {
    //             }
    //             column(ShipToAddress1; recLocation."Address 2")
    //             {
    //             }
    //             column(ShipToCity; recLocation.City)
    //             {
    //             }
    //             column(ShipToPostCode; recLocation."Post Code")
    //             {
    //             }
    //             column(CompanyState; txtState)
    //             {
    //             }
    //             column(CompanyCountry; txtCountry)
    //             {
    //             }
    //             column(VendorCode; "Buy-from Vendor No.")
    //             {
    //             }
    //             column(VendorName; "Buy-from Vendor Name")
    //             {
    //             }
    //             column(VendorAddress; "Buy-from Address")
    //             {
    //             }
    //             column(VendorAddress1; "Buy-from Address 2")
    //             {
    //             }
    //             column(VendorCity; "Buy-from City")
    //             {
    //             }
    //             column(VendorPostCode; "Buy-from Post Code")
    //             {
    //             }
    //             // column(VendordocumentNo; "Vendor Shipment No.")
    //             // {
    //             // }
    //             column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
    //             column(PurchaserCode; cdPurchaserCode)
    //             {
    //             }
    //             column(ShippedFrom; txtShippedFrom)
    //             {
    //             }
    //             column(PurchaserName; recPurchaser.Name)
    //             {
    //             }
    //             column(VendorInvAmt; decTotalAmount[7])
    //             {
    //             }
    //             column(VendorDocumentDate; FORMAT("Document Date"))
    //             {
    //             }
    //             column(VendorState; txtVendorState)
    //             {
    //             }
    //             column(VendorCountry; txtVendorCountry)
    //             {
    //             }
    //             // column(CompanyTIN; recLocation."T.I.N. No.")
    //             // {
    //             // }
    //             column(CompanySTRegNo; recLocation."Service Tax Registration No.")
    //             {
    //             }
    //             column(CompanyPAN; recCompanyInfo."P.A.N. No.")
    //             {
    //             }
    //             // column(VendorTIN; recVendor."T.I.N. No.")
    //             // {
    //             // }
    //             column(VendorCST; recVendor."C.S.T. No.")
    //             {
    //             }
    //             column(VendorPAN; recVendor."P.A.N. No.")
    //             {
    //             }
    //             column(CompanyLogo; recCompanyInfo.Picture)
    //             {
    //             }
    //             column(Transporter; recShippingAgent.Name)
    //             {
    //             }
    //             column(VehicleNo; "Vehicle No.")
    //             {
    //             }
    //             column(GRNo; "GR / LR No.")
    //             {
    //             }
    //             column(GRDate; FORMAT("GR / LR Date"))
    //             {
    //             }
    //             column(AmountInWords; txtAmount[1] + txtAmount[2])
    //             {
    //             }
    //             column(TotalChallan; decTotalAmount[1])
    //             {
    //             }
    //             column(TotalReceived; decTotalAmount[2])
    //             {
    //             }
    //             column(TotalTare; decTotalAmount[3])
    //             {
    //             }
    //             column(TotalBaseValue; decTotalAmount[4])
    //             {
    //             }
    //             column(TotalExcise; decTotalAmount[5])
    //             {
    //             }
    //             column(TotalTax; decTotalAmount[6])
    //             {
    //             }
    //             column(TotalNetReceived; decTotalAmount[8])
    //             {
    //             }
    //             dataitem("Purchase Line"; "Purchase Line")
    //             {
    //                 DataItemLink = "Document No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Document No.", "Line No.")
    //                                     ORDER(Ascending)
    //                                     WHERE(Quantity = FILTER(<> 0));
    //                 // column(SerialNo; intSrNo)
    //                 // {
    //                 // }
    //                 column(LineNo; "Document No." + FORMAT("Line No."))
    //                 {
    //                 }
    //                 column(ItemCode; "No.")
    //                 {
    //                 }
    //                 column(ItemDescription; Description)
    //                 {
    //                 }
    //                 column(Quantity; Quantity)
    //                 {
    //                 }
    //                 column(UnitOfMeasure; format("Unit of Measure"))
    //                 {
    //                 }
    //                 column(ChallanQty; "Billed Quantity")
    //                 {
    //                 }
    //                 column(RcvdQty; "Qty. to Receive" + decTareWeight)
    //                 {
    //                 }
    //                 column(TareWeight; decTareWeight)
    //                 {
    //                 }
    //                 column(UnitRate; "Direct Unit Cost")
    //                 {
    //                 }
    //                 column(DiscountPerc; "Line Discount %")
    //                 {
    //                 }
    //                 column(BaseAmount; "Qty. to Receive" * "Direct Unit Cost")
    //                 {
    //                 }
    //                 // column(LotQuantity; AQuantity)
    //                 // {
    //                 // }
    //                 // column(Line_Amount; "Line Amount") { }

    //                 column(HSNCode; "HSN/SAC Code")
    //                 {
    //                 }
    //                 // column(InvoicedQty; decInvQty)
    //                 // {
    //                 // }
    //                 // column(TotalValue; TotalValue) { }
    //                 // column(NetWeigt; "Qty. to Receive") { }
    //                 // column(Billed_Quantity; "Billed Quantity") { }
    //                 // column(Flora; Flora) { }
    //                 // column(ALotNo; ALotNo) { }
    //                 // column(AQuanPack; AQuanPack) { }
    //                 // column(GrossWeigth; GrossWeigth) { }
    //                 // column(AFlora; AFlora) { }
    //                 // column(Apacktype; Apacktype) { }
    //                 // column(AtareWt; AtareWt) { }
    //                 column(TotalGstPer; TotalGstPer) { }
    //                 column(TotalAmountGST; TotalAmountGST) { }
    //                 column(TotalAmountwithGST; TotalAmountwithGST) { }
    //                 // column(AEntryNo; AEntryNo) { }
    //                 dataitem("Tran. Lot Tracking"; "Tran. Lot Tracking")
    //                 {
    //                     DataItemLink = "Document No." = FIELD("Document No."),
    //                                    "Document Line No." = FIELD("Line No.");
    //                     DataItemTableView = SORTING("Document No.", "Document Line No.", "Item No.", "Lot No.")
    //                                         ORDER(Ascending);
    //                     column(SerialNo; intSrNo)
    //                     {
    //                     }
    //                     column(ItemLedgerEntryNo; "Entry No.")
    //                     {
    //                     }
    //                     column(InvoicedQty; decInvQty)
    //                     {
    //                     }
    //                     column(TaxAmt; ROUND(decTaxAmt / Quantity * Quantity, 0.01))
    //                     {
    //                     }
    //                     column(Flora; Flora)
    //                     {
    //                     }
    //                     column(LotNo; "Lot No.")
    //                     {
    //                     }
    //                     column(LotPackingTye; "Packing Type")
    //                     {
    //                     }
    //                     column(LotQtyInPack; "Qty. In Packs")
    //                     {
    //                     }
    //                     column(LotQuantity; Quantity)
    //                     {
    //                     }
    //                     column(LotTareWeight; "Tare Weight")
    //                     {
    //                     }

    //                     trigger OnAfterGetRecord()
    //                     begin
    //                         intSrNo += 1;
    //                         IF "Purchase Line"."Billed Quantity" <> 0 THEN
    //                             decInvQty := ROUND("Purchase Line"."Billed Quantity" / "Purchase Line"."Qty. to Receive" * "Tran. Lot Tracking".Quantity, 0.01)
    //                         ELSE
    //                             decInvQty := 0;

    //                         txtPackingType := '';
    //                         decPckingQty := 0;
    //                         decLineTareWeight := 0;

    //                         recLotTrackingEntry.RESET;
    //                         recLotTrackingEntry.SETRANGE("Document No.", "Tran. Lot Tracking"."Document No.");
    //                         recLotTrackingEntry.SETRANGE("Document Line No.", "Tran. Lot Tracking"."Document Line No.");
    //                         recLotTrackingEntry.SETRANGE("Location Code", "Tran. Lot Tracking"."Location Code");
    //                         recLotTrackingEntry.SETRANGE("Item No.", "Tran. Lot Tracking"."Item No.");
    //                         recLotTrackingEntry.SETRANGE("Lot No.", "Tran. Lot Tracking"."Lot No.");
    //                         // recLotTrackingEntry.SETRANGE(Positive, TRUE);
    //                         IF recLotTrackingEntry.FINDFIRST THEN BEGIN
    //                             txtPackingType := FORMAT(recLotTrackingEntry."Packing Type");
    //                             decPckingQty := recLotTrackingEntry."Qty. In Packs";
    //                             cdFlora := recLotTrackingEntry.Flora;
    //                             decLineTareWeight := recLotTrackingEntry."Tare Weight";
    //                         END;

    //                         //Shivam++ 29/06/23
    //                         Clear(RcvQty);
    //                         if "Purchase Line"."Billed Quantity" = "Purchase Line"."Net Weight" then
    //                             RcvQty := "Tran. Lot Tracking".Quantity
    //                         else
    //                             if "Purchase Line"."Billed Quantity" <> "Purchase Line"."Net Weight" then begin
    //                                 QtyPercent := ("Purchase Line"."Billed Quantity" - "Purchase Line"."Net Weight") / "Purchase Line"."Net Weight";
    //                                 RcvQty := "Tran. Lot Tracking".Quantity + ("Tran. Lot Tracking".Quantity * QtyPercent);
    //                             end;
    //                         //Shivam--

    //                     end;

    //                     trigger OnPostDataItem()
    //                     begin
    //                         intSrNo := 0;
    //                     end;
    //                 }

    //                 trigger OnAfterGetRecord()
    //                 begin
    //                     // intSrNo += 1;

    //                     IF "Purchase Line"."Billed Quantity" <> 0 THEN
    //                         decInvQty := ROUND("Purchase Line"."Billed Quantity" / "Purchase Line"."Qty. to Receive" * "Tran. Lot Tracking".Quantity, 0.01)
    //                     ELSE
    //                         decInvQty := 0;

    //                     recLotTrackingEntry.Reset();
    //                     recLotTrackingEntry.SetRange("Item No.", "Purchase Line"."No.");
    //                     recLotTrackingEntry.SETRANGE("Document No.", "Purchase Line"."Document No.");
    //                     recLotTrackingEntry.SETRANGE("Document Line No.", "Purchase Line"."Line No.");
    //                     if recLotTrackingEntry.FindFirst() then begin
    //                         repeat
    //                             AFlora := recLotTrackingEntry.Flora;
    //                             ALotNo := recLotTrackingEntry."Lot No.";
    //                             Apacktype := format(recLotTrackingEntry."Packing Type");
    //                             AtareWt := recLotTrackingEntry."Tare Weight";
    //                             AQuantity := recLotTrackingEntry.Quantity;
    //                             AQuanPack := recLotTrackingEntry."Qty. In Packs";
    //                             AEntryNo := recLotTrackingEntry."Entry No.";
    //                         until recLotTrackingEntry.Next() = 0;

    //                     end;
    //                     GrossWeigth := AtareWt + "Qty. to Receive";
    //                     TotalValue := "Direct Unit Cost" * "Qty. to Receive";

    //                     CLEAR(decGSTPerc);
    //                     CLEAR(decGSTAmt);
    //                     GSTSetup.Get();
    //                     intCounter += 1;
    //                     TaxTransValue.Reset();
    //                     TaxTransValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
    //                     TaxTransValue.SetRange("Tax Record ID", "Purchase Line".RecordId);
    //                     TaxTransValue.SetRange("Value Type", TaxTransValue."Value Type"::COMPONENT);
    //                     if TaxTransValue.FindSet() then
    //                         repeat
    //                             TaxComponentName := TaxTransValue.GetAttributeColumName();
    //                             Clear(GSTAmount_l);
    //                             case TaxComponentName of
    //                                 'IGST':
    //                                     begin
    //                                         evaluate(GSTAmount_l, TaxTransValue."Column Value");
    //                                         "VIGST%" := format(TaxTransValue.Percent);
    //                                         IGSTPer := TaxTransValue.Percent;
    //                                         VIGSTamt := GSTAmount_l;
    //                                     end;
    //                                 'CGST':
    //                                     begin
    //                                         evaluate(GSTAmount_l, TaxTransValue."Column Value");
    //                                         "vCGST%" := format(TaxTransValue.Percent);
    //                                         CGSTPer := TaxTransValue.Percent;
    //                                         vCGSTamt := GSTAmount_l;
    //                                     end;
    //                                 'SGST':
    //                                     begin
    //                                         evaluate(GSTAmount_l, TaxTransValue."Column Value");
    //                                         "vSGST%" := format(TaxTransValue.Percent);
    //                                         SGSTPer := TaxTransValue.Percent;
    //                                         vSGSTamt := GSTAmount_l;
    //                                     end;
    //                             end;
    //                         until TaxTransValue.Next() = 0;

    //                     TotalGstPer += IGSTPer + CGSTPer + SGSTPer;
    //                     TotalAmountGST += VIGSTamt + vCGSTamt + vSGSTamt;
    //                     TotalAmountwithGST += "Line Amount" + TotalAmountGST;

    //                     // decTareWeight := 0;
    //                     // recLotTrackingEntry.RESET;
    //                     // recLotTrackingEntry.SETRANGE("Document No.", "Purchase Line"."Document No.");
    //                     // recLotTrackingEntry.SETRANGE("Document Line No.", "Purchase Line"."Line No.");
    //                     // recLotTrackingEntry.SETRANGE("Location Code", "Purchase Line"."Location Code");
    //                     // recLotTrackingEntry.SETRANGE("Item No.", "Purchase Line"."No.");
    //                     // recLotTrackingEntry.SETRANGE(Positive, TRUE);
    //                     // IF recLotTrackingEntry.FINDFIRST THEN
    //                     //     REPEAT
    //                     //         decTareWeight += recLotTrackingEntry."Tare Weight";
    //                     //     UNTIL recLotTrackingEntry.NEXT = 0;
    //                     /*
    //                     recReservationEntry.RESET;
    //                     recReservationEntry.SETRANGE("Document No.", "Purchase Line"."Document No.");
    //                     recReservationEntry.SETRANGE("Document Line No.", "Purchase Line"."Line No.");
    //                     IF recReservationEntry.FINDFIRST THEN REPEAT
    //                       decTareWeight += recReservationEntry."Tare Weight";
    //                     UNTIL recReservationEntry.NEXT = 0;
    //                     */

    //                 end;
    //             }
    //             dataitem("Purch. Comment Line"; "Purch. Comment Line")
    //             {
    //                 DataItemLink = "No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
    //                                     ORDER(Ascending)
    //                                     WHERE("Document Type" = FILTER(Order));
    //                 column(CommentLine; "No." + FORMAT("Line No."))
    //                 {
    //                 }
    //                 column(CommentLineNo; intSrNo)
    //                 {
    //                 }
    //                 column(Comment; Comment)
    //                 {
    //                 }

    //                 trigger OnAfterGetRecord()
    //                 begin
    //                     intSrNo += 1;
    //                 end;
    //             }

    //             trigger OnAfterGetRecord()
    //             begin
    //                 IF recPaymentTerm.GET("Purchase Header"."Payment Terms Code") THEN
    //                     recPaymentTerm.INIT;

    //                 IF NOT recShippingAgent.GET("Purchase Header"."Shipping Agent Code") THEN
    //                     recShippingAgent.INIT;

    //                 recLocation.GET("Purchase Header"."Location Code");
    //                 recCompanyInfo.GET;
    //                 recCompanyInfo.CALCFIELDS(Picture);

    //                 txtState := '';
    //                 IF recState.GET(recLocation."State Code") THEN
    //                     txtState := recState.Description;

    //                 txtCountry := '';
    //                 IF recCountry.GET(recLocation."Country/Region Code") THEN
    //                     txtCountry := recCountry.Name;

    //                 txtVendorState := '';
    //                 IF recState.GET(State) THEN
    //                     txtVendorState := recState.Description;

    //                 txtVendorCountry := '';
    //                 IF recCountry.GET(recVendor."Country/Region Code") THEN
    //                     txtVendorCountry := recCountry.Name;

    //                 //Shivam++ 29/06/23
    //                 Clear(VendorGSTIN);
    //                 recVendor.Reset();
    //                 recVendor.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
    //                 if recVendor.FindFirst() then
    //                     VendorGSTIN := recVendor."GST Registration No.";
    //                 //Shivam--

    //                 CLEAR(decTotalAmount);
    //                 txtShippedFrom := '';
    //                 recReceiptLine.RESET;
    //                 recReceiptLine.SETRANGE("Document No.", "Purchase Header"."No.");
    //                 recReceiptLine.SETFILTER(Quantity, '<>%1', 0);
    //                 IF recReceiptLine.FINDFIRST THEN
    //                     REPEAT
    //                         cdPurchaserCode := recReceiptLine."Purchaser Code";
    //                         IF NOT recPurchaser.GET(cdPurchaserCode) THEN
    //                             recPurchaser.INIT;

    //                         IF txtShippedFrom = '' THEN BEGIN
    //                             recDealDispatch.RESET;
    //                             recDealDispatch.SETRANGE("Sauda No.", recReceiptLine."Deal No.");
    //                             recDealDispatch.SETRANGE("Line No.", recReceiptLine."Deal Line No.");
    //                             IF recDealDispatch.FINDFIRST THEN
    //                                 txtShippedFrom := recDealDispatch."Location Name";
    //                         END;

    //                         decTaxPerc := 0;
    //                         recTaxAreaLine.RESET;
    //                         recTaxAreaLine.SETRANGE("Tax Area", recReceiptLine."Tax Area Code");
    //                         IF recTaxAreaLine.FINDFIRST THEN
    //                             REPEAT
    //                                 recTaxDetails.RESET;
    //                                 recTaxDetails.SETRANGE("Tax Jurisdiction Code", recTaxAreaLine."Tax Jurisdiction Code");
    //                                 recTaxDetails.SETRANGE("Tax Group Code", recReceiptLine."Tax Group Code");
    //                                 recTaxDetails.SETRANGE("Effective Date", 0D, "Purchase Header"."Posting Date");
    //                                 IF recTaxDetails.FINDLAST THEN
    //                                     decTaxPerc += recTaxDetails."Tax Below Maximum";
    //                             UNTIL recTaxAreaLine.NEXT = 0;

    //                         decTotalAmount[1] += recReceiptLine."Billed Quantity";//Challan
    //                         decTotalAmount[2] += recReceiptLine."Tare Quantity" + recReceiptLine."Qty. to Receive";//Received
    //                         decTotalAmount[3] += recReceiptLine."Tare Quantity";//Tare
    //                         decTotalAmount[4] += recReceiptLine."Qty. to Receive" * recReceiptLine."Direct Unit Cost";//Base Value
    //                         decTotalAmount[5] += recReceiptLine."Excise Amount";//Excise
    //                         decTotalAmount[6] += ((recReceiptLine."Qty. to Receive" * recReceiptLine."Direct Unit Cost") + recReceiptLine."Excise Amount") * decTaxPerc / 100;//Tax
    //                         decTotalAmount[7] := decTotalAmount[4] + decTotalAmount[5] + decTotalAmount[6];//Total
    //                         decTotalAmount[8] += recReceiptLine."Qty. to Receive";//Net Received
    //                     UNTIL recReceiptLine.NEXT = 0;
    //                 decTotalAmount[7] := ROUND(decTotalAmount[7], 0.01);

    //                 CLEAR(rptCheck);
    //                 CLEAR(txtAmount);
    //                 rptCheck.InitTextVariable;
    //                 rptCheck.FormatNoText(txtAmount, decTotalAmount[7], "Purchase Header"."Currency Code");
    //             end;
    //         }
    //     }

    //     var
    //         TotalValue: Decimal;
    //         AQuanPack: Decimal;
    //         AEntryNo: Integer;
    //         AQuantity: Decimal;
    //         GrossWeigth: Decimal;
    //         AtareWt: Decimal;
    //         Apacktype: Text[20];
    //         ALotNo: Code[20];
    //         AFlora: Code[20];
    //         TLT: Record "Tran. Lot Tracking";
    //         TotalAmountGST: Decimal;
    //         TotalAmountwithGST: Decimal;
    //         TaxTransValue: Record "Tax Transaction Value";
    //         decGSTPerc: array[3] of Decimal;
    //         decGSTAmt: array[3] of Decimal;
    //         GSTSetup: Record "GST Setup";
    //         TaxComponentName: Text;
    //         GSTAmount_l: Decimal;
    //         intCounter: Integer;
    //         IGSTPer: Decimal;
    //         CGSTPer: Decimal;
    //         SGSTPer: Decimal;
    //         TotalGstPer: Decimal;
    //         vCGSTamt: Decimal;
    //         vSGSTamt: Decimal;
    //         VIGSTamt: Decimal;
    //         "vCGST%": Text;
    //         "vSGST%": Text;
    //         "VIGST%": Text;
    //         intSrNo: Integer;
    //         recPaymentTerm: Record "Payment Terms";
    //         recLocation: Record Location;
    //         recCompanyInfo: Record "Company Information";
    //         recVendor: Record Vendor;
    //         recState: Record State;
    //         recCountry: Record "Country/Region";
    //         txtState: Text[50];
    //         txtVendorCountry: Text[50];
    //         txtVendorState: Text[50];
    //         txtCountry: Text[50];
    //         recPurchaser: Record "Salesperson/Purchaser";
    //         recShippingAgent: Record "Shipping Agent";
    //         decExcisePerc: Decimal;
    //         decTaxAmt: Decimal;
    //         recReceiptLine: Record "Purchase Line";
    //         // rptCheck: Report 1401;
    //         rptCheck: Report "Check Report";
    //         txtAmount: array[2] of Text[80];
    //         decTotalAmount: array[10] of Decimal;
    //         txtShippedFrom: Text[50];
    //         recDealDispatch: Record "Deal Dispatch Details";
    //         cdPurchaserCode: Code[20];
    //         decTareWeight: Decimal;
    //         recReservationEntry: Record "Item Ledger Entry";
    //         recLotTrackingEntry: Record "Tran. Lot Tracking";
    //         txtPackingType: Text[30];
    //         decPckingQty: Decimal;
    //         decLineTareWeight: Decimal;
    //         cdFlora: Code[20];
    //         decTaxPerc: Decimal;
    //         recTaxAreaLine: Record "Tax Area Line";
    //         recTaxDetails: Record "Tax Detail";
    //         decInvQty: Decimal;
    //         RcvQty: Decimal;
    //         ReservationEntry: Record "Reservation Entry";
    //         QtyPercent: Decimal;
    //         VendorGSTIN: Code[20];
}
