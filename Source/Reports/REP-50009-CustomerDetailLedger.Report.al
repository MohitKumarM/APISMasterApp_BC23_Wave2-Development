report 50009 "Multiple Customer Ledger"
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\ReportLayouts\CustomerDetailLedger.rdl';
    Caption = 'Customer Ledger Report';
    PreviewMode = Normal;

    dataset
    {
        dataitem(DataItem6836; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Date Filter";
            column(City_Customer; DataItem6836.City) { }
            column(TodayFormatted; FORMAT(TODAY)) { }
            column(PeriodCustDatetFilter; STRSUBSTNO(Text000, CustDateFilter)) { }
            column(CompanyName; COMPANYNAME) { }
            column(PrintAmountsInLCY; PrintAmountsInLCY) { }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly) { }
            column(CustFilterCaption; TABLECAPTION + ': ' + CustFilter) { }
            column(CustFilter; CustFilter) { }
            column(AmountCaption; AmountCaption) { }
            column(RemainingAmtCaption; RemainingAmtCaption) { }
            column(No_Cust; "No.") { }
            column(Name_Cust; Name) { }
            column(PhoneNo_Cust; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(PageGroupNo; PageGroupNo) { }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; DataItem8503."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYCustLedgEntryAmt; StartBalanceLCY + DataItem8503."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(CustDetailTrialBalCaption; CustDetailTrialBalCaptionLbl) { }
            column(PageNoCaption; PageNoCaptionLbl) { }
            column(AllAmtsLCYCaption; AllAmtsLCYCaptionLbl) { }
            column(RepInclCustsBalCptn; RepInclCustsBalCptnLbl) { }
            column(PostingDateCaption; PostingDateCaptionLbl) { }
            column(DueDateCaption; DueDateCaptionLbl) { }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl) { }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl) { }
            column(BeforePeriodCaption; BeforePeriodCaptionLbl) { }
            column(TotalCaption; TotalCaptionLbl) { }
            column(OpeningBalCaption; OpeningBalCaptionLbl) { }
            dataitem(DataItem8503; "Cust. Ledger Entry")
            {
                CalcFields = "Debit Amount (LCY)", "Debit Amount", "Credit Amount", "Credit Amount (LCY)";
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Date Filter" = FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date");
                RequestFilterFields = "Global Dimension 1 Code";
                column(NarrationDetails; NarrationDetails) { }
                column(VoucherNarration; VoucherNarration) { }
                column(SalesNarration; SalesNarration) { }
                column(CustExtDocNo; CustExtDocNo) { }
                column(ExternalDocumentNo; "External Document No.") { }
                column(Cheqdate; Cheqdate) { }
                column(CheqNo; CheqNo) { }
                column(TotalDebit; TotalDebit) { }
                column(TotalCredit; TotalCredit) { }
                column(DebitAmountLCY_CustLedgerEntry; DataItem8503."Debit Amount (LCY)") { }
                column(CreditAmountLCY_CustLedgerEntry; DataItem8503."Credit Amount (LCY)") { }
                column(PostDate_CustLedgEntry; FORMAT("Posting Date")) { }
                column(DocType_CustLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(CustAmount; CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustRemainAmount; CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate; FORMAT(CustEntryDueDate)) { }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode; CustCurrencyCode) { }
                column(CustBalanceLCY1; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(TotalDebitAmt; TotalDebitAmt) { }
                column(TotalCreaditAmt; TotalCreaditAmt) { }
                column(DebitAmount; "Debit Amount") { }
                column(CreditAmount; "Credit Amount") { }
                dataitem(DataItem6942; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Entry Type", "Posting Date")
                                        WHERE("Entry Type" = FILTER("Appln. Rounding" | "Correction of Remaining Amount"));
                    RequestFilterFields = "Initial Entry Global Dim. 1";
                    column(CustBalinDisc; CustBalinDisc) { }
                    column(DebitAmountLCY; "Debit Amount (LCY)") { }
                    column(CreditAmountLCY; "Credit Amount (LCY)") { }
                    column(EntryType_DtldCustLedgEntry; FORMAT("Entry Type")) { }
                    column(Correction; Correction)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY2; CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CASE "Entry Type" OF
                            "Entry Type"::"Appln. Rounding":
                                ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                            "Entry Type"::"Correction of Remaining Amount":
                                Correction := Correction + "Amount (LCY)";
                        END;
                        //CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";

                        IF "Entry Type" = "Entry Type"::"Payment Discount" THEN BEGIN
                            DocumentType := 'Discount';
                            CustBalinDisc := 0;
                        END
                        ELSE BEGIN
                            DocumentType := FORMAT("Document Type");
                            CustBalinDisc := CustBalanceLCY;
                        END;

                        //IF "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."Document Type"::" " THEN
                        // CustExtDocNo:="Cust. Ledger Entry"."External Document No.";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date", CustDateFilter);
                        Correction := 0;
                        ApplicationRounding := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)", "Credit Amount (LCY)", "Debit Amount (LCY)");
                    TotalCredit := 0;
                    TotalDebit := 0;
                    TotalCredit := DataItem8503."Credit Amount (LCY)";
                    TotalDebit := DataItem8503."Debit Amount (LCY)";
                    //CurrReport.CREATETOTALS(TotalCredit, TotalDebit);

                    CheqNo := '';
                    Cheqdate := 0D;
                    BankAccLedEntry.RESET;
                    BankAccLedEntry.SETRANGE("Document No.", "Document No.");
                    IF BankAccLedEntry.FINDSET THEN BEGIN
                        CheqNo := BankAccLedEntry."Cheque No.";
                        Cheqdate := BankAccLedEntry."Cheque Date";
                    END;

                    CustLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                        CustAmount := "Amount (LCY)";
                        CustRemainAmount := "Remaining Amt. (LCY)";
                        CustCurrencyCode := '';
                    END ELSE BEGIN
                        CustAmount := Amount;
                        CustRemainAmount := "Remaining Amount";
                        CustCurrencyCode := "Currency Code";
                    END;
                    CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                        CustEntryDueDate := 0D
                    ELSE
                        CustEntryDueDate := "Due Date";

                    //IF "Vendor Ledger Entry"."Document Type"="Cust. Ledger Entry"."Document Type"::Payment THEN BEGIN
                    PostedNarration.RESET;
                    PostedNarration.SETRANGE("Document No.", "Document No.");
                    IF PostedNarration.FINDSET THEN
                        VoucherNarration := PostedNarration.Narration
                    ELSE
                        VoucherNarration := '';

                    //Sales Invoice Narration
                    SalesNarration := '';
                    SalesCommentLine.RESET;
                    SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
                    SalesCommentLine.SETRANGE("No.", "Document No.");
                    IF SalesCommentLine.FINDSET THEN
                        SalesNarration := SalesCommentLine.Comment;

                    IF DataItem8503."Document Type" = DataItem8503."Document Type"::Payment THEN BEGIN
                        CustExtDocNo := DataItem8503."Document No.";
                        CustLedgerEntry2.RESET;
                        CustLedgerEntry2.SETRANGE("Document No.", "Document No.");
                        IF CustLedgerEntry2.FINDSET THEN BEGIN
                            CustPostDate := CustLedgerEntry2."Document Date";
                            //CustExtDocNo:=CustLedgerEntry2."External Document No.";
                        END;
                    END;
                    TotalCreaditAmt := 0;
                    TotalDebitAmt := 0;
                    TotalDebitAmt := TotalDebitAmt + "Debit Amount";
                    TotalCreaditAmt := TotalCreaditAmt + "Credit Amount";
                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := FALSE;
                    //CurrReport.CREATETOTALS(CustAmount, "Amount (LCY)");
                end;
            }
            dataitem(DataItem5444; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Name1_Cust; DataItem6836.Name) { }
                column(CustBalanceLCY4; CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY2; StartBalanceLCY) { }
                column(StartBalAdjLCY2; StartBalAdjLCY) { }
                column(CustBalStBalStBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT CustLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                        StartBalanceLCY := 0;
                        CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;
                CustAddress := DataItem6836.Address + ', ' + DataItem6836."Address 2" + ', ' + DataItem6836.City;
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF CustDateFilter <> '' THEN BEGIN
                    IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                        SETRANGE("Date Filter", 0D, GETRANGEMIN("Date Filter") - 1);
                        CALCFIELDS("Net Change (LCY)");
                        StartBalanceLCY := "Net Change (LCY)";
                    END;
                    //:: Added Corp
                    DtlCustLedgEntry.SETCURRENTKEY(DtlCustLedgEntry."Customer No.", DtlCustLedgEntry."Posting Date", DtlCustLedgEntry."Entry Type", DtlCustLedgEntry."Currency Code", DtlCustLedgEntry."Initial Entry Global Dim. 1");
                    DtlCustLedgEntry.SETRANGE(DtlCustLedgEntry."Customer No.", DataItem6836."No.");
                    DtlCustLedgEntry.SETRANGE(DtlCustLedgEntry."Posting Date", 0D, DateFrom - 1);

                    IF Br <> '' THEN BEGIN
                        DtlCustLedgEntry.SETRANGE(DtlCustLedgEntry."Initial Entry Global Dim. 1", Br);
                    END;

                    DtlCustLedgEntry.SETFILTER(DtlCustLedgEntry."Entry Type", '<> %1', DtlCustLedgEntry."Entry Type"::Application);
                    DtlCustLedgEntry.CALCSUMS(DtlCustLedgEntry."Amount (LCY)");
                    StartBalanceLCY := DtlCustLedgEntry."Amount (LCY)";
                    SETFILTER("Date Filter", CustDateFilter);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalAdjLCY := "Net Change (LCY)";
                    CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                    CustLedgEntry.SETRANGE("Customer No.", "No.");
                    CustLedgEntry.SETFILTER("Posting Date", CustDateFilter);
                    IF CustLedgEntry.FIND('-') THEN
                        REPEAT
                            CustLedgEntry.SETFILTER("Date Filter", CustDateFilter);
                            CustLedgEntry.CALCFIELDS("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            DataItem6942.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            DataItem6942.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            DataItem6942.SETFILTER("Entry Type", '%1|%2',
                              DataItem6942."Entry Type"::"Correction of Remaining Amount",
                              DataItem6942."Entry Type"::"Appln. Rounding");
                            DataItem6942.SETFILTER("Posting Date", CustDateFilter);
                            IF DataItem6942.FIND('-') THEN
                                REPEAT
                                    StartBalAdjLCY := StartBalAdjLCY - DataItem6942."Amount (LCY)";
                                UNTIL DataItem6942.NEXT = 0;
                            DataItem6942.RESET;
                        UNTIL CustLedgEntry.NEXT = 0;
                END;
                //CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                //CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                //CurrReport.CREATETOTALS(DataItem8503."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
                TotalCreaditAmtLCY := 0;
                TotalDebitAmtLCY := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        Caption = 'Show Amounts in LCY';
                        ApplicationArea = all;
                    }
                    field(NewPageperCustomer; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                        ApplicationArea = all;
                    }
                    field(ExcludeCustHaveaBalanceOnly; ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
                        ApplicationArea = all;
                    }
                    field("Narration Details"; NarrationDetails)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions { }
    }

    labels { }

    trigger OnPreReport()
    begin
        CustFilter := DataItem6836.GETFILTERS;
        CustDateFilter := DataItem6836.GETFILTER("Date Filter");
        IF PrintAmountsInLCY THEN BEGIN
            AmountCaption := DataItem8503.FIELDCAPTION(DataItem8503."Amount (LCY)");
            RemainingAmtCaption := DataItem8503.FIELDCAPTION(DataItem8503."Remaining Amt. (LCY)");
        END ELSE BEGIN
            AmountCaption := DataItem8503.FIELDCAPTION(DataItem8503.Amount);
            RemainingAmtCaption := DataItem8503.FIELDCAPTION(DataItem8503."Remaining Amount");
        END;

        DateFrom := DataItem6836.GETRANGEMIN("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        CustLedgEntry: Record 21;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text;
        CustDateFilter: Text[30];
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        CustDetailTrialBalCaptionLbl: Label 'Customer - Detail Trial Bal.';
        PageNoCaptionLbl: Label 'Page';
        AllAmtsLCYCaptionLbl: Label 'All amounts are in LCY';
        RepInclCustsBalCptnLbl: Label 'This report also includes customers that only have balances.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DueDateCaptionLbl: Label 'Due Date';
        BalanceLCYCaptionLbl: Label 'Balance (LCY)';
        AdjOpeningBalCaptionLbl: Label 'Adj. of Opening Balance';
        BeforePeriodCaptionLbl: Label 'Total (LCY) Before Period';
        TotalCaptionLbl: Label 'Total (LCY)';
        OpeningBalCaptionLbl: Label 'Total Adj. of Opening Balance';
        CustAddress: Text[200];
        TotalDebitAmt: Decimal;
        TotalCreaditAmt: Decimal;
        DocumentType: Text[30];
        TotalDebitAmtLCY: Decimal;
        TotalCreaditAmtLCY: Decimal;
        CustLedgerEntry2: Record 21;
        CustPostDate: Date;
        CustExtDocNo: Code[20];
        PostedNarration: Record "Posted Narration";
        VoucherNarration: Text[500];
        NarrationDetails: Boolean;
        SalesCommentLine: Record 44;
        SalesNarration: Text[200];
        Br: Code[20];
        DtlCustLedgEntry: Record 379;
        DateFrom: Date;
        CheqNo: Code[10];
        Cheqdate: Date;
        CustBalinDisc: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        BankAccLedEntry: Record 271;

    procedure InitializeRequest(ShowAmountInLCY: Boolean; SetPrintOnlyOnePerPage: Boolean; SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;
}
