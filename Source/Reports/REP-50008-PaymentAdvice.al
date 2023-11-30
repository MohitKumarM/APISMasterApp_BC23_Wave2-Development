// report 50008 "Payment Advice"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = '.\ReportLayouts\PaymentAdvice.rdl';
//     PreviewMode = PrintLayout;
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;


//     dataset
//     {
//         dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
//         {
//             CalcFields = Amount;
//             RequestFilterFields = "Document No.";
//             DataItemTableView = sorting("Entry No.") ORDER(Ascending);
//             column(CompanyName; CompanyInfo.Name) { }
//             column(CompanyFullAddress; CompanyInfo.Address + CompanyInfo."Address 2" + ' , ' + CompanyInfo.City + ' - ' + CompanyInfo."Post Code") { }
//             column(CompanyPicture; CompanyInfo.Picture) { }
//             column(Vendor_No; RecVendor."No.") { }
//             column(VendorName; RecVendor.Name) { }
//             column(VendorAddress; RecVendor.Address + ' ' + RecVendor."Address 2") { }
//             column(VendorState; RecState.Description) { }
//             column(VendorEmail; RecVendor."E-Mail") { }
//             column(VendorContact; RecVendor.Contact) { }
//             column(DocumentType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type") { }
//             column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.") { }
//             column(Date; TODAY) { }
//             column(FinanceUser; FinanceUser) { }
//             column(External_Document_No_; "External Document No.") { }
//             column(UTR_No_; "UTR No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Amount; Amount) { }
//             column(ChequeNo; ChequeNo) { }
//             column(Document_No_; "Document No.") { }

//             dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
//             {
//                 DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
//                 DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
//                 dataitem(DetailedVendorLedgerEntry; "Detailed Vendor Ledg. Entry")
//                 {
//                     DataItemLink = "Entry No." = FIELD("Entry No.");
//                     DataItemTableView = SORTING("Entry No.") ORDER(Ascending);

//                     trigger OnPreDataItem()
//                     var
//                         DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
//                     begin
//                         IF "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No." = "Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No." THEN BEGIN
//                             DtldVendLedgEntry2.INIT;
//                             DtldVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
//                             DtldVendLedgEntry2.SETRANGE("Applied Vend. Ledger Entry No.", "Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.");
//                             DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
//                             DtldVendLedgEntry2.SETRANGE(Unapplied, FALSE);
//                             IF DtldVendLedgEntry2.FINDSET THEN
//                                 REPEAT
//                                     IF DtldVendLedgEntry2."Vendor Ledger Entry No." <> DtldVendLedgEntry2."Applied Vend. Ledger Entry No." THEN BEGIN
//                                         GetAppliedLE(DtldVendLedgEntry2."Vendor Ledger Entry No.", VendorLedgerEntry, DtldVendLedgEntry2);
//                                     END;
//                                 UNTIL DtldVendLedgEntry2.NEXT = 0;
//                         END ELSE BEGIN
//                             GetAppliedLE("Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.", VendorLedgerEntry, "Detailed Vendor Ledg. Entry");
//                         END;
//                     end;
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     SETRANGE("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 PurchInvHeader: Record "Purch. Inv. Header";
//                 RecCheckLedgerEntry: Record "Check Ledger Entry";
//             begin
//                 CLEAR(FinanceUser);
//                 IF RecVendor.GET("Vendor Ledger Entry"."Vendor No.") THEN;

//                 if RecState.Get(RecVendor."State Code") then;

//                 FinanceUser := "Vendor Ledger Entry"."User ID";

//                 if "Vendor Ledger Entry"."UTR No." = '' then begin
//                     Clear(ChequeNo);
//                     RecCheckLedgerEntry.Reset;
//                     RecCheckLedgerEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
//                     if RecCheckLedgerEntry.FindFirst then
//                         if RecCheckLedgerEntry."UTR No." <> '' then
//                             ChequeNo := RecCheckLedgerEntry."UTR No."
//                         else
//                             ChequeNo := RecCheckLedgerEntry."Check No.";
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 IF DoctNo <> '' THEN
//                     "Vendor Ledger Entry".SETRANGE("Document No.", DoctNo);

//                 IF EntryNumber <> 0 THEN
//                     "Vendor Ledger Entry".SETRANGE("Entry No.", EntryNumber);
//             end;
//         }
//         dataitem(Integer; Integer)
//         {
//             DataItemTableView = SORTING(Number) ORDER(Ascending);

//             column(BillNo; BillNo) { }
//             column(IntegerDocType; RecVenLedEntry."Document Type") { }
//             column(BillAdvAmount; ABS(BillAdvAmount)) { }
//             column(Remarks; Remarks) { }
//             column(TDSAmt; ABS(TDSAmt)) { }
//             column(PaymentDate; PaymentDate) { }
//             column(UTRNo; UTRNo) { }
//             column(Amount_Paid; ABS(AmountPaid)) { }
//             column(TotalNetAmt; TotalNetAmt) { }
//             column(AppliedDetails; AppliedDetails) { }

//             trigger OnAfterGetRecord()
//             var
//                 PurchInvLine: Record 123;
//                 RecTDSEntry: Record "TDS Entry";
//                 RecPIComment: Record "Purch. Comment Line";
//                 RecVendorLedgerEntry: Record "Vendor Ledger Entry";
//                 RecPostedNarration: Record "Posted Narration";
//                 RecPurchInvHeader: Record "Purch. Inv. Header";
//                 RecVendor1: Record Vendor;
//                 RecVendorOrderAddress: Record "Order Address";
//                 RecBankAccountLedEntry: Record "Bank Account Ledger Entry";
//             begin
//                 if not AppliedDetails then
//                     IF NOT FindNextRecord(RecVenLedEntry, Number) THEN
//                         CurrReport.BREAK;

//                 //=IIF(IsDate(Fields!PaymentDate.Value),true,false)

//                 IF "Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Payment THEN BEGIN
//                     CLEAR(Remarks);
//                     CLEAR(TDSAmt);
//                     Clear(UTRNo);
//                     Clear(BillAdvAmount);

//                     UTRNo := "Vendor Ledger Entry"."UTR No.";
//                     PaymentDate := "Vendor Ledger Entry"."Posting Date";
//                     AmountPaid := "Vendor Ledger Entry".Amount;

//                     if AppliedDetails then begin
//                         BillAdvAmount := AmountPaid;

//                         RecPostedNarration.Reset;
//                         RecPostedNarration.SetRange("Transaction No.", "Vendor Ledger Entry"."Transaction No.");
//                         if RecPostedNarration.FindFirst then begin
//                             repeat
//                                 Remarks += ' ' + RecPostedNarration.Narration;
//                             until RecPostedNarration.Next = 0
//                         end else
//                             Remarks := 'Balance Payment';

//                         RecTDSEntry.Reset;
//                         RecTDSEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
//                         if RecTDSEntry.FindSet then begin
//                             RecTDSEntry.CalcSums("TDS Amount");
//                             TDSAmt := RecTDSEntry."TDS Amount";
//                         end;
//                     end;
//                 END;

//                 IF RecVenLedEntry."Document Type" = RecVenLedEntry."Document Type"::Invoice THEN BEGIN
//                     CLEAR(Remarks);
//                     CLEAR(TDSAmt);
//                     Clear(BillNo);
//                     Clear(BillAdvAmount);

//                     BillNo := RecVenLedEntry."External Document No.";
//                     BillAdvAmount := RecVenLedEntry."Purchase (LCY)";

//                     RecVendorLedgerEntry.Reset;
//                     RecVendorLedgerEntry.SetRange("Document No.", RecVenLedEntry."Document No.");
//                     RecVendorLedgerEntry.SetRange("Document Type", RecVendorLedgerEntry."Document Type"::Invoice);
//                     if RecVendorLedgerEntry.FindFirst then
//                         BillNo := RecVendorLedgerEntry."External Document No.";

//                     PurchInvLine.RESET;
//                     PurchInvLine.SETRANGE("Document No.", RecVenLedEntry."Document No.");
//                     IF PurchInvLine.FINDFIRST THEN BEGIN
//                         RecTDSEntry.Reset;
//                         RecTDSEntry.SetRange("Document No.", PurchInvLine."Document No.");
//                         if RecTDSEntry.FindSet then begin
//                             RecTDSEntry.CalcSums("TDS Amount");
//                             TDSAmt := RecTDSEntry."TDS Amount";
//                         end;
//                     END;

//                     RecPIComment.Reset;
//                     RecPIComment.SetRange("No.", RecVenLedEntry."Document No.");
//                     RecPIComment.SetRange("User Type", RecPIComment."User Type"::Finance);
//                     if RecPIComment.FindFirst then
//                         Remarks := RecPIComment.Comment
//                     else
//                         Remarks := 'Balance Payment';
//                 END;

//                 IF RecVenLedEntry."Document Type" = RecVenLedEntry."Document Type"::Payment THEN BEGIN
//                     Clear(UTRNo);
//                     Clear(BillAdvAmount);
//                     Clear(Remarks);
//                     Clear(TDSAmt);

//                     UTRNo := RecVenLedEntry."UTR No.";
//                     AmountPaid := RecVenLedEntry."Purchase (LCY)";
//                     //PaymentDate := RecVenLedEntry."Posting Date";

//                     if AppliedDetails then begin
//                         BillAdvAmount := AmountPaid;

//                         RecPostedNarration.Reset;
//                         RecPostedNarration.SetRange("Transaction No.", "Vendor Ledger Entry"."Transaction No.");
//                         if RecPostedNarration.FindFirst then begin
//                             repeat
//                                 Remarks += ' ' + RecPostedNarration.Narration;
//                             until RecPostedNarration.Next = 0
//                         end else
//                             Remarks := 'Balance Payment';

//                         RecTDSEntry.Reset;
//                         RecTDSEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
//                         if RecTDSEntry.FindSet then begin
//                             RecTDSEntry.CalcSums("TDS Amount");
//                             TDSAmt := RecTDSEntry."TDS Amount";
//                         end;
//                     end;
//                 END;

//                 IF "Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Invoice THEN BEGIN
//                     Clear(BillNo);
//                     Clear(BillAdvAmount);
//                     Clear(TDSAmt);

//                     BillNo := "Vendor Ledger Entry"."External Document No.";
//                     BillAdvAmount := "Vendor Ledger Entry".Amount;

//                     PurchInvLine.RESET;
//                     PurchInvLine.SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
//                     IF PurchInvLine.FINDFIRST THEN BEGIN
//                         RecTDSEntry.Reset;
//                         RecTDSEntry.SetRange("Document No.", PurchInvLine."Document No.");
//                         if RecTDSEntry.FindSet then begin
//                             RecTDSEntry.CalcSums("TDS Amount");
//                             TDSAmt := RecTDSEntry."TDS Amount";
//                         end;
//                     END;
//                 END;

//                 //Get Email ID
//                 /* if BillNo <> '' then begin
//                     RecPaymentAdviceLog1.Reset;
//                     RecPaymentAdviceLog1.SetRange("Vendor No", Vendor_No);
//                     RecPaymentAdviceLog1.SetRange("VLE Entry No.", EntryNumber);
//                     RecPaymentAdviceLog1.SetRange("VLE Document No.", DoctNo);
//                     if RecPaymentAdviceLog1.FindFirst then begin
//                         //if RecPaymentAdviceLog1."Email ID" = '' then begin //TEAM 14763 14-09-23
//                         RecPurchInvHeader.Reset;
//                         RecPurchInvHeader.SetRange("Buy-from Vendor No.", Vendor_No);
//                         RecPurchInvHeader.SetRange("Vendor Invoice No.", BillNo);
//                         if RecPurchInvHeader.FindFirst then begin
//                             if RecPurchInvHeader."Order Address GST Reg. No." <> '' then begin
//                                 RecVendorOrderAddress.Reset;
//                                 RecVendorOrderAddress.SetRange("Vendor No.", RecPurchInvHeader."Buy-from Vendor No.");
//                                 RecVendorOrderAddress.SetRange("GST Registration No.", RecPurchInvHeader."Order Address GST Reg. No.");
//                                 if RecVendorOrderAddress.FindFirst then begin
//                                     if RecVendorOrderAddress."E-Mail" <> '' then begin
//                                         RecPaymentAdviceLog1."Email ID" := RecVendorOrderAddress."E-Mail";
//                                         RecPaymentAdviceLog1.Modify;
//                                     end else begin
//                                         RecVendor1.GET(Vendor_No);
//                                         if RecVendor1."E-Mail" <> '' then
//                                             RecPaymentAdviceLog1."Email ID" := RecVendor1."E-Mail";
//                                         RecPaymentAdviceLog1.Modify;
//                                     end;
//                                 end;
//                             end else begin
//                                 RecVendor1.GET(RecPurchInvHeader."Buy-from Vendor No.");
//                                 if RecVendor1."E-Mail" <> '' then
//                                     RecPaymentAdviceLog1."Email ID" := RecVendor1."E-Mail";
//                                 RecPaymentAdviceLog1.Modify;
//                             end;
//                         end;
//                         //end; //TEAM 14763 14-09-23
//                     end;
//                 end else begin
//                     //Email Alert for Advance Payment -> As per requirement
//                     RecPaymentAdviceLog1.Reset;
//                     RecPaymentAdviceLog1.SetRange("Vendor No", Vendor_No);
//                     RecPaymentAdviceLog1.SetRange("VLE Entry No.", EntryNumber);
//                     RecPaymentAdviceLog1.SetRange("VLE Document No.", DoctNo);
//                     if RecPaymentAdviceLog1.FindFirst then begin
//                         RecVendor1.GET(Vendor_No);
//                         if RecVendor1."E-Mail" <> '' then begin
//                             RecPaymentAdviceLog1."Email ID" := RecVendor1."E-Mail";
//                             RecPaymentAdviceLog1.Modify;
//                         end;
//                     end;
//                     //Email Alert for Advance Payment -> As per requirement
//                 end; *///15578
//                 //Get Email ID

//                 if UTRNo = '' then begin
//                     RecBankAccountLedEntry.Reset;
//                     RecBankAccountLedEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
//                     if RecBankAccountLedEntry.FindFirst then
//                         if RecBankAccountLedEntry."Payment Type" = RecBankAccountLedEntry."Payment Type"::Cheque then
//                             UTRNo := RecBankAccountLedEntry."Cheque No.";
//                 end;

//                 if Counter = 0 then begin
//                     Counter += 1;
//                     TotalNetAmt += ABS(BillAdvAmount) - ABS(TDSAmt);
//                 end else
//                     TotalNetAmt += BillAdvAmount;
//                 TotalNetAmt := Abs(TotalNetAmt);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Clear(TotalNetAmt);
//                 Clear(AppliedDetails);

//                 if RecVenLedEntry.FINDSET then
//                     SETRANGE(Integer.Number, 1, RecVenLedEntry.COUNT)
//                 else begin
//                     AppliedDetails := true;
//                     SETRANGE(Integer.Number, 1, 1);
//                 end;
//             end;
//         }
//     }

//     trigger OnPreReport()
//     begin
//         Clear(AppliedDetails);

//         CompanyInfo.GET;
//         CompanyInfo.CALCFIELDS(Picture);
//     end;

//     var
//         DoctNo, BillNo, UTRNo, ChequeNo : Code[50];
//         Vendor_No: Code[20];
//         CompanyInfo: Record "Company Information";
//         RecVendor: Record Vendor;
//         BillAdvAmount, TDSAmt, AmountPaid, TotalNetAmt : Decimal;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         FinanceUser, Remarks, Entry_No : Text;
//         EntryNumber, Counter : Integer;
//         PaymentDate: Date;
//         RecVenLedEntry: Record "Vendor Ledger Entry" temporary;
//         RecState: Record State;
//         AppliedDetails: Boolean;
//         RecepientEmail: List OF [Text];
//     //15578  RecPaymentAdviceLog1: Record "Payment Advice Log";

//     procedure GetPaymentNo(DocumentNo: Code[20]; EntryNo: Integer; VendorNo: Code[20])
//     begin
//         CLEAR(DoctNo);
//         CLEAR(EntryNumber);
//         Clear(Vendor_No);

//         DoctNo := DocumentNo;
//         EntryNumber := EntryNo;
//         Vendor_No := VendorNo;
//     end;

//     procedure GetAppliedLE(EntryNo: Integer; RecVendorLedgerEntry: Record "Vendor Ledger Entry"; DetVendorLedgEntry: Record "Detailed Vendor Ledg. Entry")
//     var
//         VenLedEntry: Record "Vendor Ledger Entry";
//     begin
//         IF EntryNo <> 0 THEN BEGIN
//             IF STRPOS(Entry_No, FORMAT(EntryNo)) = 0 THEN BEGIN
//                 Entry_No := Entry_No + '|' + FORMAT(EntryNo);

//                 VenLedEntry.RESET;
//                 VenLedEntry.SETRANGE("Entry No.", EntryNo);
//                 IF VenLedEntry.FINDFIRST THEN BEGIN
//                     RecVenLedEntry.INIT;
//                     RecVenLedEntry."Entry No." := EntryNo;
//                     RecVenLedEntry."Document No." := VenLedEntry."Document No.";
//                     RecVenLedEntry."Document Type" := VenLedEntry."Document Type";
//                     RecVenLedEntry."Purchase (LCY)" := DetVendorLedgEntry.Amount;

//                     IF "Vendor Ledger Entry"."Document Type" <> "Vendor Ledger Entry"."Document Type"::Payment THEN BEGIN
//                         RecVenLedEntry."UTR No." := VenLedEntry."UTR No."; //UTR No
//                         RecVenLedEntry."Posting Date" := VenLedEntry."Posting Date"; //Payment Date
//                         RecVenLedEntry."External Document No." := RecVendorLedgerEntry."External Document No.";
//                     END;
//                     RecVenLedEntry.INSERT;
//                 END;
//             END;
//         END;
//     end;

//     local procedure FindNextRecord(var VendorLedgerEntry: Record "Vendor Ledger Entry"; Position: Integer): Boolean
//     begin
//         IF Position = 1 THEN
//             EXIT(VendorLedgerEntry.FINDSET);
//         EXIT(VendorLedgerEntry.NEXT <> 0);
//     end;
// }