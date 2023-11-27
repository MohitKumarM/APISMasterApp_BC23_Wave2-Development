report 50066 "Purchase Receipt Pre"
{
    //     DefaultLayout = RDLC;
    //
    //RDLCLayout = '.\ReportLayouts\PurchaseReceiptPre.rdl';
    //     UsageCategory = ReportsAndAnalysis;
    //     ApplicationArea = All;

    //     dataset
    //     {
    //         dataitem("Purchase Header"; "Purchase Header")
    //         {
    //             DataItemTableView = SORTING("Document Type", "No.")
    //                                 ORDER(Ascending);
    //             RequestFilterFields = "No.";
    //             column(ReceiptNo; 'Test Report')
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
    //             column(GateEntryDate; FORMAT("Gate Entry Date"))
    //             {
    //             }
    //             column(VendorInvoiceValue; "Vendor Invoice Value")
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
    //             dataitem("Purchase Line"; "Purchase Line")
    //             {
    //                 DataItemLink = "Document No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Document No.", "Line No.")
    //                                     ORDER(Ascending)
    //                                     WHERE("Qty. to Receive" = FILTER(<> 0));
    //                 column(SerialNo; intSrNo)
    //                 {
    //                 }
    //                 column(LineNo; "Document No." + FORMAT("Line No."))
    //                 {
    //                 }
    //                 column(ItemCode; "No.")
    //                 {
    //                 }
    //                 column(ItemDescription; Description)
    //                 {
    //                 }
    //                 column(Quantity; "Qty. to Receive")
    //                 {
    //                 }
    //                 column(UnitOfMeasure; "Unit of Measure")
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
    //                 column(ExcisePerc; decExcisePerc)
    //                 {
    //                 }
    //                 column(ExciseAmt; decExciseAmt)
    //                 {
    //                 }
    //                 column(LineDisAmt; decLineDisAmt)
    //                 {
    //                 }
    //                 column(TaxPerc; decTaxPerc)
    //                 {
    //                 }
    //                 column(TaxAmt; decTaxAmt)
    //                 {
    //                 }
    //                 column(LineAmount; ("Qty. to Receive" * "Direct Unit Cost") + decExciseAmt + decTaxAmt - decLineDisAmt)
    //                 {
    //                 }
    //                 dataitem("Reservation Entry"; "Reservation Entry")
    //                 {
    //                     DataItemLink = "Source ID" = FIELD("Document No."),
    //                                    "Source Ref. No." = FIELD("Line No.");
    //                     DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
    //                                         ORDER(Ascending);
    //                     column(ItemLedgerEntryNo; "Entry No.")
    //                     {
    //                     }
    //                     column(Flora; "Purchase Line".Flora)
    //                     {
    //                     }
    //                     column(LotNo; "Lot No.")
    //                     {
    //                     }
    //                     column(PackingTye; "Packing Type")
    //                     {
    //                     }
    //                     column(QtyInPack; "Qty. in Pack")
    //                     {
    //                     }
    //                     column(LotQuantity; Quantity)
    //                     {
    //                     }
    //                     column(LotTareWeight; "Tare Weight")
    //                     {
    //                     }
    //                 }

    //                 trigger OnAfterGetRecord()
    //                 begin
    //                     intSrNo += 1;
    //                     decExcisePerc := 0;
    //                     IF "Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost" <> 0 THEN
    //                         decExcisePerc := ("Purchase Line"."Excise Amount") / ("Purchase Line".Quantity * "Purchase Line"."Direct Unit Cost") * 100;

    //                     decExciseAmt := "Purchase Line"."Excise Amount" / "Purchase Line".Quantity * "Purchase Line"."Qty. to Receive";
    //                     decExciseAmt := ROUND(decExciseAmt, 0.01);
    //                     decLineDisAmt := ("Purchase Line"."Qty. to Receive" * "Purchase Line"."Direct Unit Cost") * "Purchase Line"."Line Discount %" / 100;
    //                     decLineDisAmt := ROUND(decLineDisAmt, 0.01);

    //                     decTaxPerc := 0;
    //                     IF "Purchase Line"."Tax Amount" = 0 THEN
    //                         decTaxPerc := 0
    //                     ELSE BEGIN
    //                         recTaxAreaLine.RESET;
    //                         recTaxAreaLine.SETRANGE("Tax Area", "Purchase Line"."Tax Area Code");
    //                         IF recTaxAreaLine.FINDFIRST THEN
    //                             REPEAT
    //                                 recTaxDetails.RESET;
    //                                 recTaxDetails.SETRANGE("Tax Jurisdiction Code", recTaxAreaLine."Tax Jurisdiction Code");
    //                                 recTaxDetails.SETRANGE("Tax Group Code", "Purchase Line"."Tax Group Code");
    //                                 recTaxDetails.SETRANGE("Effective Date", 0D, dtPostingDate);
    //                                 IF recTaxDetails.FINDLAST THEN
    //                                     decTaxPerc += recTaxDetails."Tax Below Maximum";
    //                             UNTIL recTaxAreaLine.NEXT = 0;
    //                     END;

    //                     decTaxAmt := ("Purchase Line"."Qty. to Receive" * "Purchase Line"."Direct Unit Cost") + decExciseAmt - decLineDisAmt;
    //                     decTaxAmt := decTaxAmt * decTaxPerc / 100;
    //                     decTaxAmt := ROUND(decTaxAmt, 0.01);

    //                     decTareWeight := 0;
    //                     recReservationEntry.RESET;
    //                     recReservationEntry.SETRANGE("Source Type", 39);
    //                     recReservationEntry.SETRANGE("Source Subtype", 1);
    //                     recReservationEntry.SETRANGE("Source ID", "Purchase Line"."Document No.");
    //                     recReservationEntry.SETRANGE("Source Ref. No.", "Purchase Line"."Line No.");
    //                     IF recReservationEntry.FINDFIRST THEN
    //                         REPEAT
    //                             decTareWeight += recReservationEntry."Tare Weight";
    //                         UNTIL recReservationEntry.NEXT = 0;
    //                 end;

    //                 trigger OnPostDataItem()
    //                 begin
    //                     intSrNo := 0;
    //                 end;

    //                 trigger OnPreDataItem()
    //                 begin
    //                     intSrNo := 0;
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
    //                 dtPostingDate := "Purchase Header"."Posting Date";

    //                 // recLocation.GET("Purchase Header"."Location Code");
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

    //                 CLEAR(decTotalAmount);
    //                 txtShippedFrom := '';
    //                 recReceiptLine.RESET;
    //                 recReceiptLine.SETRANGE("Document No.", "Purchase Header"."No.");
    //                 recReceiptLine.SETFILTER("Qty. to Receive", '<>%1', 0);
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
    //                         IF recReceiptLine."Tax Amount" = 0 THEN
    //                             decTaxPerc := 0
    //                         ELSE BEGIN
    //                             recTaxAreaLine.RESET;
    //                             recTaxAreaLine.SETRANGE("Tax Area", recReceiptLine."Tax Area Code");
    //                             IF recTaxAreaLine.FINDFIRST THEN
    //                                 REPEAT
    //                                     recTaxDetails.RESET;
    //                                     recTaxDetails.SETRANGE("Tax Jurisdiction Code", recTaxAreaLine."Tax Jurisdiction Code");
    //                                     recTaxDetails.SETRANGE("Tax Group Code", recReceiptLine."Tax Group Code");
    //                                     recTaxDetails.SETRANGE("Effective Date", 0D, dtPostingDate);
    //                                     IF recTaxDetails.FINDLAST THEN
    //                                         decTaxPerc += recTaxDetails."Tax Below Maximum";
    //                                 UNTIL recTaxAreaLine.NEXT = 0;
    //                         END;

    //                         decTotalAmount[10] := recReceiptLine."Qty. to Receive" * recReceiptLine."Direct Unit Cost";
    //                         decTotalAmount[10] := decTotalAmount[10] - ROUND((decTotalAmount[10] * recReceiptLine."Line Discount %" / 100), 0.01);

    //                         decTotalAmount[1] += recReceiptLine."Billed Quantity";//Challan
    //                         decTotalAmount[2] += recReceiptLine."Tare Quantity" + recReceiptLine."Qty. to Receive";//Received
    //                         decTotalAmount[3] += recReceiptLine."Tare Quantity";//Tare
    //                         decTotalAmount[4] += decTotalAmount[10];//Base Value
    //                         decTotalAmount[5] += ROUND((recReceiptLine."Excise Amount" / recReceiptLine.Quantity * recReceiptLine."Qty. to Receive"), 0.01);//Excise
    //                         decTotalAmount[6] += decTotalAmount[10] * decTaxPerc / 100;//Tax
    //                         decTotalAmount[7] := decTotalAmount[4] + decTotalAmount[5] + decTotalAmount[6];//Total
    //                         decTotalAmount[8] += recReceiptLine."Qty. to Receive";//Net Received
    //                     UNTIL recReceiptLine.NEXT = 0;
    //                 decTotalAmount[7] := ROUND(decTotalAmount[7], 0.01);

    //                 CLEAR(rptCheck);
    //                 CLEAR(txtAmount);
    //                 // rptCheck.InitTextVariable;
    //                 // rptCheck.FormatNoText(txtAmount, decTotalAmount[7], "Purchase Header"."Currency Code");
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
    //         rptCheck: Report Check;
    //         txtAmount: array[2] of Text[80];
    //         decTotalAmount: array[10] of Decimal;
    //         txtShippedFrom: Text[50];
    //         recDealDispatch: Record "Deal Dispatch Details";
    //         cdPurchaserCode: Code[20];
    //         decTareWeight: Decimal;
    //         recReservationEntry: Record "Reservation Entry";
    //         decExciseAmt: Decimal;
    //         decTaxPerc: Decimal;
    //         recTaxAreaLine: Record "Tax Area Line";
    //         recTaxDetails: Record "Tax Detail";
    //         dtPostingDate: Date;
    //         decLineDisAmt: Decimal;
    //     // "Purch. Comment Line": Record "Purch. Comment Line";
}
