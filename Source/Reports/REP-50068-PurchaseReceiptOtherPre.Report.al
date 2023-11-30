report 50068 "Purchase Receipt Other Pre"
{
    //     DefaultLayout = RDLC;
    //
    //RDLCLayout = '.\ReportLayouts\PurchaseReceiptOtherPre.rdl';
    //     PreviewMode = PrintLayout;
    //     UsageCategory = ReportsAndAnalysis;
    //     ApplicationArea = All;

    //     dataset
    //     {
    //         dataitem("Purchase Header"; "Purchase Header")
    //         {
    //             DataItemTableView = SORTING("No.")
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
    //             column(VendorGSTIN; VendorGSTIN) { }
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
    //             // column(TotalGStCalculationasperQtytoReceive; TotalGStCalculationasperQtytoReceive)
    //             // { }
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
    //             column(VendordocumentNo; "Vendor Invoice No.")
    //             {
    //             }
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
    //             // column(TotalCostAmount; TotalCostAmount) { }
    //             // column(AmountSum; AmountSum) { }
    //             column(TotalGstpercent; TotalGstpercent) { }
    //             // column(TotalGSTPer; TotalGSTPer) { }
    //             column(TotalGst; TotalGst) { }
    //             // dataitem("Purchase Line"; "Purchase Line")
    //             // {
    //             //     DataItemLink = "Document No." = FIELD("No.");
    //             //     DataItemTableView = SORTING("Document No.", "Line No.")
    //             //                         ORDER(Ascending)
    //             //                         WHERE("Qty. to Receive" = FILTER(<> 0));
    //             //     column(LineSrNo; intLineSrNo)
    //             //     {
    //             //     }
    //             //     // column(SerialNo; intSrNo) { }
    //             //     column(LineNo; "Document No." + FORMAT("Line No."))
    //             //     {
    //             //     }
    //             //     column(ItemCode; "No.")
    //             //     {
    //             //     }
    //             //     column(ItemDescription; Description)
    //             //     {
    //             //     }
    //             //     column(Quantity; "Qty. to Receive")
    //             //     {
    //             //     }
    //             //     column(UnitOfMeasure; "Unit of Measure")
    //             //     {
    //             //     }
    //             //     column(ChallanQty; "Billed Quantity")
    //             //     {
    //             //     }
    //             //     column(RcvdQty; "Qty. to Receive" + decTareWeight)
    //             //     {
    //             //     }
    //             //     column(TareWeight; decTareWeight)
    //             //     {
    //             //     }
    //             //     column(UnitRate; "Direct Unit Cost")
    //             //     {
    //             //     }
    //             //     column(DiscountPerc; "Line Discount %")
    //             //     {
    //             //     }
    //             //     column(BaseAmount; "Qty. to Receive" * "Direct Unit Cost")
    //             //     {
    //             //     }
    //             //     column(ExcisePerc; decExcisePerc)
    //             //     {
    //             //     }
    //             //     column(NewGStCalculationasperQtytoReceive; NewGStCalculationasperQtytoReceive)
    //             //     { }
    //             //     column(TotalGStCalculationasperQtytoReceive; TotalGStCalculationasperQtytoReceive)
    //             //     { }
    //             //     column(ExciseAmt; "Excise Amount")
    //             //     {
    //             //     }
    //             //     column(LineDisAmt; decLineDisAmt)
    //             //     {
    //             //     }
    //             //     column(TaxPerc; decTaxPerc)
    //             //     {
    //             //     }
    //             //     column(LineTaxAmt; decTaxAmt)
    //             //     {
    //             //     }
    //             //     // column(TotalGSTPer; TotalGSTPer)
    //             //     // {
    //             //     // }
    //             //     // column(TotalGstwithAmount; TotalGstwithAmount)
    //             //     // {
    //             //     // }
    //             //     // column(TotalGst; TotalGst) { }
    //             //     column(LineAmount; ("Qty. to Receive" * "Direct Unit Cost") + "Excise Amount" + decTaxAmt)
    //             //     {
    //             //     }
    //             //     column(HSNCode; "HSN/SAC Code")
    //             //     {
    //             //     }
    //             //     column(Totalgstcalulated; Totalgstcalulated)
    //             //     { }
    //             //     column(TotalGSTPer; TotalGSTPer)
    //             //     { }
    //             //     column(TotalGst; TotalGst)
    //             //     { }
    //             //     column(TotalGstwithAmount; TotalGstwithAmount)
    //             //     {
    //             //     }
    //             //     column(TotalResQty; TotalResQty) { }
    //             //     Column(GSTComponentCode1; GSTComponentCode[1]) { }
    //             //     column(GSTComponentCode2; GSTComponentCode[2]) { }
    //             //     column(GSTComponentCode3; GSTComponentCode[3]) { }
    //             //     column(GSTComponentCode4; GSTComponentCode[4]) { }
    //             //     //Shivam++ 12-07-23
    //             //     // column(ItemLedgerEntryNo; ItemLedgerEntryNo) { }
    //             //     // column(InvoicedQty; decInvQty) { }
    //             //     // column(LotQtyInPack; decPckingQty) { }
    //             //     // column(LineDiscount; decLineDiscount) { }
    //             //     // column(LotQuantity; ReservationEntry.Quantity) { }
    //             //     // column(LotTareWeight; decLineTareWeight) { }
    //             //     // column(LotNo; LotNo) { }
    //             //     // column(TaxAmt; TaxAmt) { }
    //             //     // column(Flora; cdFlora) { }
    //             //     // column(LotPackingTye; txtPackingType) { }
    //             //     // column(txtAmount; txtAmount[1]) { }
    //             //     // // column(notext1; notext1[1] + ' ' + notext1[2]) { }
    //             //     // column(NewGStCalculationasperQtytoReceive2; NewGStCalculationasperQtytoReceive2) { }
    //             //     // column(TotalGStCalculationasperQtytoReceive2; TotalGStCalculationasperQtytoReceive2) { }
    //             //     // column(RcvQty; RcvQty) { }
    //             //     // column(notext1; notext1[1] + ' ' + notext1[2]) { }
    //             //     //Shivam--

    //             //     // column(Totalgstcalulated; Totalgstcalulated)
    //             //     // { }

    //             //     dataitem("Item Ledger Entry"; "Reservation Entry")
    //             //     {
    //             //         DataItemLink = "Source ID" = FIELD("Document No."),
    //             //                        "Source Ref. No." = FIELD("Line No.");
    //             //         DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
    //             //                             ORDER(Ascending);
    //             //         column(SerialNo; intSrNo)
    //             //         {
    //             //         }
    //             //         column(ItemLedgerEntryNo; "Item Ledger Entry"."Entry No.")
    //             //         {
    //             //         }
    //             //         column(InvoicedQty; decInvQty)
    //             //         {
    //             //         }
    //             //         column(TaxAmt; ROUND(decTaxAmt / "Purchase Line"."Qty. to Receive" * "Item Ledger Entry".Quantity, 0.01))
    //             //         {
    //             //         }
    //             //         column(Flora; cdFlora)
    //             //         {
    //             //         }
    //             //         column(LotNo; "Item Ledger Entry"."Lot No.")
    //             //         {
    //             //         }
    //             //         column(LotPackingTye; txtPackingType)
    //             //         {
    //             //         }
    //             //         column(LotQtyInPack; decPckingQty)
    //             //         {
    //             //         }
    //             //         column(LineDiscount; decLineDiscount)
    //             //         {
    //             //         }
    //             //         column(LotQuantity; "Item Ledger Entry".Quantity)
    //             //         {
    //             //         }
    //             //         column(LotTareWeight; decLineTareWeight)
    //             //         {
    //             //         }
    //             //         column(txtAmount; txtAmount[1])
    //             //         { }
    //             //         column(notext1; notext1[1] + ' ' + notext1[2]) { }
    //             //         column(NewGStCalculationasperQtytoReceive2; NewGStCalculationasperQtytoReceive2)
    //             //         { }
    //             //         column(TotalGStCalculationasperQtytoReceive2; TotalGStCalculationasperQtytoReceive2)
    //             //         { }
    //             //         column(RcvQty; RcvQty) { }

    //             //         trigger OnAfterGetRecord()
    //             //         begin
    //             //             intSrNo += 1;
    //             //             IF "Purchase Line"."Billed Quantity" <> 0 THEN
    //             //                 decInvQty := ROUND("Purchase Line"."Billed Quantity" / "Purchase Line"."Qty. to Receive" * "Item Ledger Entry".Quantity, 0.01)
    //             //             ELSE
    //             //                 decInvQty := 0;

    //             //             txtPackingType := '';
    //             //             decPckingQty := 0;
    //             //             decLineTareWeight := 0;
    //             //             decLineDiscount := decLineDisAmt / "Purchase Line".Quantity * "Item Ledger Entry".Quantity;

    //             //             /*
    //             //             recLotTrackingEntry.RESET;
    //             //             recLotTrackingEntry.SETRANGE("Document No.", "Item Ledger Entry"."Document No.");
    //             //             recLotTrackingEntry.SETRANGE("Document Line No.", "Item Ledger Entry"."Document Line No.");
    //             //             recLotTrackingEntry.SETRANGE("Location Code", "Item Ledger Entry"."Location Code");
    //             //             recLotTrackingEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
    //             //             recLotTrackingEntry.SETRANGE("Lot No.", "Item Ledger Entry"."Lot No.");
    //             //             recLotTrackingEntry.SETRANGE(Positive, TRUE);
    //             //             IF recLotTrackingEntry.FINDFIRST THEN BEGIN
    //             //               txtPackingType := FORMAT(recLotTrackingEntry."Packing Type");
    //             //               decPckingQty := recLotTrackingEntry."Qty. In Packs";
    //             //               cdFlora := recLotTrackingEntry.Flora;
    //             //               decLineTareWeight := recLotTrackingEntry."Tare Weight";
    //             //             END;
    //             //             */

    //             //             // Message(Format(Totalgstcalulated));
    //             //             NewGStCalculationasperQtytoReceive2 := 0;
    //             //             NewGStCalculationasperQtytoReceive2 := Totalgstcalulated * ("Item Ledger Entry".Quantity * NewUnitCost);

    //             //             TotalGStCalculationasperQtytoReceive2 := 0;
    //             //             TotalGStCalculationasperQtytoReceive2 := NewGStCalculationasperQtytoReceive + ("Item Ledger Entry".Quantity * NewUnitCost);

    //             //             //Shivam++ 27/06/23
    //             //             Clear(RcvQty);
    //             //             if "Purchase Line"."Billed Quantity" = "Purchase Line"."Qty. to Receive" then
    //             //                 RcvQty := "Item Ledger Entry".Quantity
    //             //             else
    //             //                 if "Purchase Line"."Billed Quantity" <> "Purchase Line"."Qty. to Receive" then begin
    //             //                     QtyPercent := ("Purchase Line"."Billed Quantity" - "Purchase Line"."Qty. to Receive") / "Purchase Line"."Qty. to Receive";
    //             //                     RcvQty := "Item Ledger Entry".Quantity + ("Item Ledger Entry".Quantity * QtyPercent);
    //             //                 end;
    //             //             //Shivam--
    //             //         end;

    //             //     }
    //             //     // column(TotalGst; TotalGst)
    //             //     // { }
    //             //     trigger OnPreDataItem()
    //             //     begin
    //             //         intSrNo := 0;
    //             //     end;

    //             //     trigger OnAfterGetRecord()
    //             //     begin
    //             //         // GenerateData("Purchase Line");
    //             //         decExcisePerc := 0;
    //             //         intLineSrNo += 1;

    //             //         // intSrNo += 1;
    //             //         // IF "Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost" <> 0 THEN
    //             //         //     decExcisePerc := ("Purchase Line"."Excise Amount") / ("Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost") * 100;

    //             //         // //Shivam++ 11-07-23
    //             //         // Clear(LotNo);
    //             //         // Clear(ItemLedgerEntryNo);
    //             //         // Clear(LotQtyInPack);
    //             //         // Clear(LineDiscount);
    //             //         // Clear(LotQuantity);
    //             //         // Clear(LotTareWeight);
    //             //         // ReservationEntry.Reset();
    //             //         // ReservationEntry.SetRange("Source ID", "Purchase Line"."Document No.");
    //             //         // ReservationEntry.SetRange("Source Ref. No.", "Purchase Line"."Line No.");
    //             //         // if ReservationEntry.FindSet() then begin
    //             //         //     if ReservationEntry."Lot No." <> '' then begin
    //             //         //         LotNo := ReservationEntry."Lot No.";
    //             //         //         ItemLedgerEntryNo := ReservationEntry."Entry No.";
    //             //         //         LotQtyInPack := decPckingQty;
    //             //         //         LineDiscount := decLineDiscount;
    //             //         //         LotQuantity := ReservationEntry.Quantity;
    //             //         //         LotTareWeight := decLineTareWeight;
    //             //         //         TaxAmt := ROUND(decTaxAmt / "Qty. to Receive" * ReservationEntry.Quantity, 0.01);
    //             //         //         Flora := cdFlora;
    //             //         //         LotPackingTye := txtPackingType;
    //             //         //         // txtAmount := txtAmount[1];
    //             //         //         NewGStCalculationasperQtytoReceive2 := NewGStCalculationasperQtytoReceive2;
    //             //         //         TotalGStCalculationasperQtytoReceive2 := TotalGStCalculationasperQtytoReceive2;

    //             //         //         IF "Purchase Line"."Billed Quantity" <> 0 THEN
    //             //         //             decInvQty := ROUND("Purchase Line"."Billed Quantity" / "Purchase Line"."Qty. to Receive" * ReservationEntry.Quantity, 0.01)
    //             //         //         ELSE
    //             //         //             decInvQty := 0;

    //             //         //         txtPackingType := '';
    //             //         //         decPckingQty := 0;
    //             //         //         decLineTareWeight := 0;
    //             //         //         decLineDiscount := decLineDisAmt / "Purchase Line".Quantity * ReservationEntry.Quantity;

    //             //         //         NewGStCalculationasperQtytoReceive2 := 0;
    //             //         //         NewGStCalculationasperQtytoReceive2 := Totalgstcalulated * (ReservationEntry.Quantity * NewUnitCost);

    //             //         //         TotalGStCalculationasperQtytoReceive2 := 0;
    //             //         //         TotalGStCalculationasperQtytoReceive2 := NewGStCalculationasperQtytoReceive + (ReservationEntry.Quantity * NewUnitCost);

    //             //         //         //Shivam++ 27/06/23
    //             //         //         Clear(RcvQty);
    //             //         //         if "Purchase Line"."Billed Quantity" = "Purchase Line"."Qty. to Receive" then
    //             //         //             RcvQty := ReservationEntry.Quantity
    //             //         //         else
    //             //         //             if "Purchase Line"."Billed Quantity" <> "Purchase Line"."Qty. to Receive" then begin
    //             //         //                 QtyPercent := ("Purchase Line"."Billed Quantity" - "Purchase Line"."Qty. to Receive") / "Purchase Line"."Qty. to Receive";
    //             //         //                 RcvQty := ReservationEntry.Quantity + (ReservationEntry.Quantity * QtyPercent);
    //             //         //             end;
    //             //         //         //Shivam--
    //             //         //     end;

    //             //         // end;

    //             //         //Shivam--

    //             //         decTaxPerc := 0;
    //             //         recTaxAreaLine.RESET;
    //             //         recTaxAreaLine.SETRANGE("Tax Area", "Purchase Line"."Tax Area Code");
    //             //         IF recTaxAreaLine.FINDFIRST THEN
    //             //             REPEAT
    //             //                 recTaxDetails.RESET;
    //             //                 recTaxDetails.SETRANGE("Tax Jurisdiction Code", recTaxAreaLine."Tax Jurisdiction Code");
    //             //                 recTaxDetails.SETRANGE("Tax Group Code", recReceiptLine."Tax Group Code");
    //             //                 recTaxDetails.SETRANGE("Effective Date", 0D, "Purchase Header"."Posting Date");
    //             //                 IF recTaxDetails.FINDLAST THEN
    //             //                     decTaxPerc += recTaxDetails."Tax Below Maximum";
    //             //             UNTIL recTaxAreaLine.NEXT = 0;

    //             //         decLineDisAmt := ("Purchase Line"."Qty. to Receive" * "Purchase Line"."Direct Unit Cost") * "Purchase Line"."Line Discount %" / 100;
    //             //         decLineDisAmt := ROUND(decLineDisAmt, 0.01);

    //             //         decTaxAmt := ("Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost") + ("Purchase Line"."Excise Amount") - decLineDisAmt;
    //             //         decTaxAmt := decTaxAmt * decTaxPerc / 100;
    //             //         decTaxAmt := decTaxAmt / "Purchase Line".Quantity * "Purchase Line"."Qty. to Receive";
    //             //         // Message(Format(decTaxAmt));
    //             //         decTaxAmt := ROUND(decTaxAmt, 0.01);

    //             //         decTareWeight := 0;
    //             //         recLotTrackingEntry.RESET;
    //             //         recLotTrackingEntry.SETRANGE("Document No.", "Purchase Line"."Document No.");
    //             //         recLotTrackingEntry.SETRANGE("Document Line No.", "Purchase Line"."Line No.");
    //             //         recLotTrackingEntry.SETRANGE("Location Code", "Purchase Line"."Location Code");
    //             //         recLotTrackingEntry.SETRANGE("Item No.", "Purchase Line"."No.");
    //             //         recLotTrackingEntry.SETRANGE(Positive, TRUE);
    //             //         IF recLotTrackingEntry.FINDFIRST THEN
    //             //             REPEAT
    //             //                 decTareWeight += recLotTrackingEntry."Tare Weight";
    //             //             UNTIL recLotTrackingEntry.NEXT = 0;

    //             //         CLEAR(decGSTPerc);
    //             //         CLEAR(decGSTAmt);
    //             //         VIGSTamt := 0;
    //             //         vCGSTamt := 0;
    //             //         vSGSTamt := 0;
    //             //         GSTSetup.Get();
    //             //         TaxTransValue.Reset();
    //             //         TaxTransValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
    //             //         TaxTransValue.SetRange("Tax Record ID", "Purchase Line".RecordId());
    //             //         TaxTransValue.SetRange("Value Type", TaxTransValue."Value Type"::COMPONENT);
    //             //         if TaxTransValue.FindSet() then
    //             //             repeat
    //             //                 TaxComponentName := TaxTransValue.GetAttributeColumName();
    //             //                 Clear(GSTAmount_l);
    //             //                 case TaxComponentName of
    //             //                     'IGST':
    //             //                         begin
    //             //                             evaluate(GSTAmount_l, TaxTransValue."Column Value");
    //             //                             "VIGST%" := format(TaxTransValue.Percent);
    //             //                             GSTPer1 := TaxTransValue.Percent;
    //             //                             VIGSTamt := GSTAmount_l;
    //             //                         end;
    //             //                     'CGST':
    //             //                         begin
    //             //                             evaluate(GSTAmount_l, TaxTransValue."Column Value");
    //             //                             "vCGST%" := format(TaxTransValue.Percent);
    //             //                             GSTPer2 := TaxTransValue.Percent;
    //             //                             vCGSTamt := GSTAmount_l;
    //             //                         end;
    //             //                     'SGST':
    //             //                         begin
    //             //                             evaluate(GSTAmount_l, TaxTransValue."Column Value");
    //             //                             "vSGST%" := format(TaxTransValue.Percent);
    //             //                             GSTPer3 := TaxTransValue.Percent;
    //             //                             vSGSTamt := GSTAmount_l;

    //             //                         end;
    //             //                 end;
    //             //             until TaxTransValue.Next() = 0;

    //             //         TotalGst := 0;
    //             //         TotalGst := vSGSTamt + vCGSTamt + VIGSTamt;

    //             //         TotalGstwithAmount := 0;
    //             //         TotalGstwithAmount := "Line Amount" + TotalGst;

    //             //         TotalGstPer := 0;
    //             //         TotalGstPer := GSTPer1 + GSTPer2 + GSTPer3;

    //             //         QtytoReceive := 0;
    //             //         QtytoReceive := "Purchase Line"."Qty. to Receive";

    //             //         NewUnitCost := 0;
    //             //         NewUnitCost := "Purchase Line"."Unit Cost";

    //             //         Totalgstcalulated := 0;
    //             //         Totalgstcalulated := ((GSTPer1 + GSTPer2 + GSTPer3) * 1 / 100);

    //             //         NewGStCalculationasperQtytoReceive := 0;
    //             //         NewGStCalculationasperQtytoReceive := Totalgstcalulated * (QtytoReceive * NewUnitCost);

    //             //         TotalGStCalculationasperQtytoReceive := 0;
    //             //         TotalGStCalculationasperQtytoReceive := NewGStCalculationasperQtytoReceive + (QtytoReceive * NewUnitCost);

    //             //         // repcheck.InitTextVariable;
    //             //         // repcheck.FormatNoText(notext1, Round(TotalGStCalculationasperQtytoReceive, 0.01), "Purchase Header"."Currency Code");

    //             //     end;

    //             // }
    //             dataitem("Purch. Comment Line"; "Purch. Comment Line")
    //             {
    //                 DataItemLink = "No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
    //                                     ORDER(descending)
    //                                     WHERE("Document Type" = FILTER(Order));
    //                 column(CommentLine;
    //                 "No." + FORMAT("Line No."))
    //                 {
    //                 }
    //                 column(CommentLineNo; intSrNo2)
    //                 {
    //                 }
    //                 column(Comment; Comment)
    //                 {
    //                 }

    //                 trigger OnAfterGetRecord()
    //                 begin
    //                     intSrNo2 += 1;
    //                 end;

    //                 trigger OnPreDataItem()
    //                 var
    //                     myInt: Integer;
    //                 begin
    //                     intSrNo2 := 0;
    //                 end;
    //             }

    //             trigger OnPreDataItem()
    //             begin
    //                 Clear(GSTComponentCode);
    //                 Clear(GSTCompAmount);

    //             end;

    //             trigger OnAfterGetRecord()
    //             begin
    //                 //Shivam++ 29/06/23
    //                 GenerateData("Purchase Header");
    //                 GetAmount("Purchase Header");
    //                 GetGSTAmounts("Purchase Header");
    //                 // TotalCostAmount += TotalAMt;
    //                 // TotalGstpercent := TotalAMt * (GSTCompRate[1] + GSTCompRate[2] + GSTCompRate[3]) / 100;
    //                 // TotalGStAmt += TotalAMt + TotalGstpercent;
    //                 // AmountSum += TotalGStAmt;
    //                 //Shivam

    //                 IF recPaymentTerm.GET("Purchase Header"."Payment Terms Code") THEN
    //                     recPaymentTerm.INIT;

    //                 IF NOT recShippingAgent.GET("Purchase Header"."Shipping Agent Code") THEN
    //                     recShippingAgent.INIT;

    //                 recLocation.GET("Purchase Header"."Location Code");
    //                 recCompanyInfo.GET;
    //                 recCompanyInfo.CALCFIELDS(Picture);

    //                 //Shivam++ 29/06/23
    //                 Clear(VendorGSTIN);
    //                 recVendor.Reset();
    //                 recVendor.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
    //                 if recVendor.FindFirst() then
    //                     VendorGSTIN := recVendor."GST Registration No.";
    //                 //Shivam--

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

    //                         decTotalAmount[10] := recReceiptLine."Qty. to Receive" * recReceiptLine."Direct Unit Cost";
    //                         decTotalAmount[10] := decTotalAmount[10] - ROUND((decTotalAmount[10] * recReceiptLine."Line Discount %" / 100), 0.01);

    //                         decTotalAmount[1] += recReceiptLine."Billed Quantity";//Challan
    //                         decTotalAmount[2] += recReceiptLine."Tare Quantity" + recReceiptLine."Qty. to Receive";//Received
    //                         decTotalAmount[3] += recReceiptLine."Tare Quantity";//Tare
    //                         decTotalAmount[4] += decTotalAmount[10];//Base Value
    //                         decTotalAmount[5] += recReceiptLine."Excise Amount";//Excise
    //                         decTotalAmount[6] += decTotalAmount[10] * decTaxPerc / 100;//Tax
    //                         decTotalAmount[7] := decTotalAmount[4] + decTotalAmount[5] + decTotalAmount[6];//Total
    //                         decTotalAmount[8] += recReceiptLine."Qty. to Receive";//Net Received
    //                     UNTIL recReceiptLine.NEXT = 0;
    //                 decTotalAmount[7] := ROUND(decTotalAmount[7], 0.01);

    //                 //Shivam++ 29/06/23
    //                 // repcheck.InitTextVariable;
    //                 // repcheck.FormatNoText(notext1, Round(AmountSum, 0.01), "Purchase Header"."Currency Code");
    //                 //Shivam
    //             end;
    //         }
    //         //Shivam++ 12-07-23
    //         dataitem("Buffer Table"; "Buffer Table")
    //         {
    //             column(SerialNo; intSrNo) { }
    //             column(Item_Code; "Item Code") { }
    //             column(Item_Description; "Item Description") { }
    //             column(HSN_SAC; "HSN/SAC") { }
    //             column(Lot_No_; "Lot No.") { }
    //             column(UOM; UOM) { }
    //             column(Invoice_Qty; "Invoice Qty") { }
    //             column(Received_Qty; "Received Qty") { }
    //             column(Unit_Rate; "Unit Rate") { }
    //             column(Total_Value; "Total Value") { }
    //             column(NewGStCalculationasperQtytoReceive2; NewGStCalculationasperQtytoReceive2) { }
    //             column(TotalGSTPer; TotalGSTPer) { }
    //             column(TotalGStAmt; TotalGStAmt) { }
    //             column(AmountSum; AmountSum) { }
    //             column(TotalCostAmount; TotalCostAmount) { }
    //             column(notext1; notext1[1] + ' ' + notext1[2]) { }
    //             trigger OnPreDataItem()
    //             var
    //                 myInt: Integer;
    //             begin
    //                 Clear(TotalGStAmt);
    //                 Clear(AmountSum);
    //                 Clear(TotalCostAmount);
    //             end;

    //             trigger OnAfterGetRecord()
    //             var
    //                 myInt: Integer;
    //             begin
    //                 Clear(TotalCostAmount);
    //                 intSrNo += 1;
    //                 NewGStCalculationasperQtytoReceive2 := 0;
    //                 NewGStCalculationasperQtytoReceive2 := "Total Value" * TotalGSTPer / 100;

    //                 TotalGStAmt += "Total Value" * TotalGSTPer / 100;

    //                 AmountSum += "Total Value";
    //                 TotalCostAmount += TotalGStAmt + AmountSum;

    //                 repcheck.InitTextVariable;
    //                 repcheck.FormatNoText(notext1, Round(TotalCostAmount, 0.01), "Purchase Header"."Currency Code");
    //             end;
    //         }
    //         //Shivam--
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
    //         notext1: array[2] of Text[80];
    //         repcheck: Report CheckReport;
    //         Totalgstcalulated: Decimal;
    //         TotalGStCalculationasperQtytoReceive: Decimal;
    //         TotalGStCalculationasperQtytoReceive2: Decimal;
    //         NewUnitCost: Decimal;
    //         TotalGst: Decimal;
    //         QtytoReceive: Decimal;
    //         NewGStCalculationasperQtytoReceive: Decimal;
    //         NewGStCalculationasperQtytoReceive2: Decimal;
    //         TotalGstwithAmount: Decimal;
    //         TaxTransValue: Record "Tax Transaction Value";
    //         decGSTPerc: array[3] of Decimal;
    //         decGSTAmt: array[3] of Decimal;
    //         GSTSetup: Record "GST Setup";
    //         TaxComponentName: Text;
    //         GSTAmount_l: Decimal;
    //         intCounter: Integer;
    //         GSTPer1: Decimal;
    //         GSTPer2: Decimal;
    //         GSTPer3: Decimal;
    //         vCGSTamt: Decimal;
    //         vSGSTamt: Decimal;
    //         VIGSTamt: Decimal;
    //         "vCGST%": Text;
    //         "vSGST%": Text;
    //         TotalGSTPer: Decimal;

    //         "VIGST%": Text;
    //         intSrNo: Integer;
    //         intSrNo2: Integer;
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
    //         rptCheck: Report check report;
    //         txtAmount: array[2] of Text[80];
    //         decTotalAmount: array[10] of Decimal;
    //         txtShippedFrom: Text[50];
    //         recDealDispatch: Record "Deal Dispatch Details";
    //         cdPurchaserCode: Code[20];
    //         decTareWeight: Decimal;
    //         recReservationEntry: Record "Item Ledger Entry";
    //         recLotTrackingEntry: Record "Lot Tracking Entry";
    //         txtPackingType: Text[30];
    //         decPckingQty: Decimal;
    //         decLineTareWeight: Decimal;
    //         cdFlora: Code[20];
    //         decTaxPerc: Decimal;
    //         recTaxAreaLine: Record "Tax Area Line";
    //         recTaxDetails: Record "Tax Detail";
    //         decInvQty: Decimal;
    //         intLineSrNo: Integer;
    //         decLineDisAmt: Decimal;
    //         decLineDiscount: Decimal;
    //         PurchaseLine: Record "Purchase Line";
    //         RcvQty: Decimal;
    //         ReservationEntry: Record "Reservation Entry";
    //         QtyPercent: Decimal;
    //         VendorGSTIN: Code[20];
    //         ResQty: Decimal;
    //         TotalResQty: Decimal;
    //         TotalAMt: Decimal;
    //         TotalPurLineAMt: Decimal;
    //         TotalCostAmount: Decimal;
    //         AmountSum: Decimal;
    //         GSTComponentCode: array[20] of Code[10];
    //         GSTCompAmount: array[20] of Decimal;
    //         GSTCompRate: array[20] of Decimal;
    //         TotalGStAmt: Decimal;
    //         TotalGstpercent: Decimal;
    //         ItemLedgerEntryNo: Integer;
    //         LotQtyInPack: Decimal;
    //         LineDiscount: Decimal;
    //         LotQuantity: Decimal;
    //         LotTareWeight: Decimal;
    //         LotNo: Code[50];
    //         TaxAmt: Decimal;
    //         Flora: Code[20];
    //         LotPackingTye: Text[30];
    //         BufferData: Record "Buffer Table";
    //     // NewGStCalculationasperQtytoReceive2: Decimal;
    //     // TotalGStCalculationasperQtytoReceive2: Decimal;
    //     // "Purch. Comment Line": Record "Purch. Comment Line";

    //     //Shivam++ 13/07/23
    //     local procedure GetAmount(var PurHdr: Record "Purchase Header")
    //     var
    //         PurLIne: Record "Purchase Line";
    //         REsEntry: Record "Reservation Entry";
    //     begin
    //         Clear(TotalAMt);
    //         PurLIne.Reset();
    //         PurLIne.SetRange("Document No.", PurHdr."No.");
    //         if PurLIne.FindSet() then begin
    //             repeat
    //                 Clear(TotalPurLineAMt);
    //                 Clear(TotalResQty);
    //                 // TotalCostAmount += TotalAMt;
    //                 TotalPurLineAMt += PurLIne."Direct Unit Cost";
    //                 REsEntry.Reset();
    //                 REsEntry.SetRange("Source ID", PurLIne."Document No.");
    //                 REsEntry.SetRange("Source Ref. No.", PurLIne."Line No.");
    //                 if REsEntry.FindSet() then
    //                     repeat
    //                         TotalResQty += REsEntry.Quantity;
    //                     until REsEntry.Next() = 0;
    //                 TotalAMt += TotalPurLineAMt * TotalResQty;
    //             until PurLIne.Next() = 0;
    //         end;
    //     end;

    //     local procedure GetGSTAmounts(PurchhHdr: record "Purchase Header")
    //     var
    //         TaxTransactionValue: Record "Tax Transaction Value";
    //         GSTSetup: Record "GST Setup";
    //         PurchaseLine: record "Purchase Line";
    //     begin
    //         if not GSTSetup.Get() then
    //             exit;

    //         Clear(TotalGSTPer);
    //         Clear(TotalGst);
    //         PurchaseLine.Reset();
    //         PurchaseLine.SetRange("Document No.", PurchhHdr."No.");
    //         if PurchaseLine.FindSet() then
    //             repeat
    //                 TaxTransactionValue.Reset();
    //                 TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
    //                 TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
    //                 TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
    //                 TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
    //                 if TaxTransactionValue.FindSet() then
    //                     repeat
    //                         case TaxTransactionValue."Value ID" of
    //                             6:
    //                                 begin
    //                                     GSTCompAmount[1] += TaxTransactionValue.Amount;
    //                                     if GSTComponentCode[1] = '' then
    //                                         GSTComponentCode[1] := 'SGST';
    //                                     GSTCompRate[1] := TaxTransactionValue.Percent;
    //                                 end;
    //                             2:
    //                                 begin
    //                                     GSTCompAmount[2] += TaxTransactionValue.Amount;
    //                                     if GSTComponentCode[2] = '' then
    //                                         GSTComponentCode[2] := 'CGST';
    //                                     GSTCompRate[2] := TaxTransactionValue.Percent;
    //                                 end;
    //                             3:
    //                                 begin
    //                                     GSTCompAmount[3] += TaxTransactionValue.Amount;
    //                                     if GSTComponentCode[3] = '' then
    //                                         GSTComponentCode[3] := 'IGST';
    //                                     GSTCompRate[3] := TaxTransactionValue.Percent;
    //                                 end;
    //                         end;
    //                     until TaxTransactionValue.Next() = 0;
    //                 TotalGSTPer := GSTCompRate[1] + GSTCompRate[2] + GSTCompRate[3];
    //                 TotalGst := GSTCompAmount[1] + GSTCompAmount[2] + GSTCompAmount[3];
    //             until PurchaseLine.Next() = 0;
    //     end;

    //     trigger OnPreReport()
    //     var
    //         myInt: Integer;
    //     begin
    //         BufferData.DeleteAll();
    //     end;

    //     local procedure GenerateData(PurchHeader: Record "Purchase Header")
    //     var
    //         ReservEnrty: Record "Reservation Entry";
    //         PurchLine: Record "Purchase Line";
    //     begin
    //         Clear(QtyPercent);
    //         Clear(RcvQty);
    //         PurchLine.Reset();
    //         PurchLine.SetRange("Document No.", PurchHeader."No.");
    //         if PurchLine.FindFirst() then begin
    //             repeat
    //                 ReservEnrty.Reset();
    //                 ReservEnrty.SetRange("Source ID", PurchLine."Document No.");
    //                 ReservEnrty.SetRange("Source Ref. No.", PurchLine."Line No.");
    //                 if ReservEnrty.FindFirst() then begin
    //                     repeat
    //                         BufferData.Init();
    //                         BufferData.ID += 1;
    //                         BufferData."Item Code" := PurchLine."No.";
    //                         BufferData."Item Description" := PurchLine.Description;
    //                         BufferData."HSN/SAC" := PurchLine."HSN/SAC Code";
    //                         BufferData."Lot No." := ReservEnrty."Lot No.";
    //                         BufferData.UOM := PurchLine."Unit of Measure";
    //                         BufferData."Received Qty" := ReservEnrty.Quantity;
    //                         BufferData."Unit Rate" := PurchLine."Unit Cost";
    //                         BufferData."Total Value" := BufferData."Unit Rate" * BufferData."Received Qty";
    //                         if PurchLine."Billed Quantity" = PurchLine."Qty. to Receive" then
    //                             BufferData."Invoice Qty" := ReservEnrty.Quantity
    //                         else
    //                             if PurchLine."Billed Quantity" <> PurchLine."Qty. to Receive" then begin
    //                                 QtyPercent := (PurchLine."Billed Quantity" - PurchLine."Qty. to Receive") / PurchLine."Qty. to Receive";
    //                                 BufferData."Invoice Qty" := ReservEnrty.Quantity + (ReservEnrty.Quantity * QtyPercent);
    //                             end;
    //                         GetGSTAmounts(PurchHeader);
    //                         BufferData.Insert();
    //                     until ReservEnrty.Next() = 0;
    //                 end
    //                 else begin
    //                     BufferData.Init();
    //                     BufferData.ID += 1;
    //                     BufferData."Item Code" := PurchLine."No.";
    //                     BufferData."Item Description" := PurchLine.Description;
    //                     BufferData."HSN/SAC" := PurchLine."HSN/SAC Code";
    //                     BufferData."Lot No." := ReservEnrty."Lot No.";
    //                     BufferData.UOM := PurchLine."Unit of Measure";
    //                     BufferData."Invoice Qty" := PurchLine."Billed Quantity";
    //                     BufferData."Received Qty" := PurchLine."Qty. to Receive";
    //                     BufferData."Unit Rate" := PurchLine."Unit Cost";
    //                     BufferData."Total Value" := PurchLine."Direct Unit Cost" * PurchLine."Qty. to Receive";
    //                     GetGSTAmounts(PurchHeader);
    //                     BufferData.Insert();
    //                 end;
    //             until PurchLine.Next() = 0;
    //         end;
    //     end;
    //     //Shivam--
}
