report 50086 "Bank Reconcilation"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\BankReconcilation.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Company Information"; 79)
        {
            DataItemTableView = SORTING("Primary Key");
            column(OpeningBalance; OpeningBalance)
            {
            }
            column(Name; "Company Information".Name)
            {
            }
            column(Name2; "Company Information"."Name 2")
            {
            }
            column(LocationAddress1; LocationAddress)
            {
            }
            column(LocationAddress2; LocationAddress2)
            {
            }
            column(PageNo; 'Page : ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(Caption1; 'Bank Reconciliation Statement as on ' + FORMAT(AsOnDate))
            {
            }
            column(BankFilter; 'Bank Reconciliation Statement as on ' + FORMAT(AsOnDate))
            {
            }
            column(Bankname; 'Bank : ' + BankName)
            {
            }
            column(BankAcc; BankAcc."Bank Account No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF LocationCode = '' THEN BEGIN
                    StateRec.RESET;
                    IF StateRec.GET("State Code") THEN;
                    LocationAddress := "Company Information".Address + ', ' + "Company Information"."Address 2";

                    LocationAddress2 := "Company Information".City + '-' + "Company Information"."Post Code" + ' ('
                                       + StateRec.Description
                                       + ')';
                END ELSE BEGIN
                    IF Location.GET(LocationCode) THEN
                        StateRec.RESET;

                    IF StateRec.GET(Location."State Code") THEN;
                    LocationAddress := Location.Address + ', ' + Location."Address 2";
                    LocationAddress2 := Location.City + '-' + Location."Post Code" + ' (' + StateRec.Description + ')'
                END;

                OpeningBalance := 0;
                BankAccLedgerEntry.RESET;
                BankAccLedgerEntry.SETCURRENTKEY(BankAccLedgerEntry."Bank Account No.", BankAccLedgerEntry."Posting Date");
                IF BankAccNo <> '' THEN
                    BankAccLedgerEntry.SETRANGE(BankAccLedgerEntry."Bank Account No.", BankAccNo);
                BankAccLedgerEntry.SETRANGE(BankAccLedgerEntry."Posting Date", 0D, AsOnDate);  //TRI
                                                                                               //BankAccLedgerEntry.COPYFILTERS("Bank Account Ledger Entry");
                                                                                               /* IF LocationCode <> '' THEN 15578
                                                                                                   BankAccLedgerEntry.SETFILTER(BankAccLedgerEntry."PO No.", LocationCode); // 16630 BankAccLedgerEntry."Location Code" replace by po no.
                                                                                                */
                IF BankAccLedgerEntry.FIND('-') THEN
                    REPEAT
                        OpeningBalance += BankAccLedgerEntry.Amount;
                    UNTIL BankAccLedgerEntry.NEXT = 0;

                IF BankAcc.GET(BankAccNo) THEN
                    BankName := BankAcc.Name + ' ' + BankAcc."Name 2" + ' ' + BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' +
                                BankAcc.City;
            end;
        }
        dataitem("Bank Account Ledger Entry"; 271)
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                WHERE(Amount = FILTER(< 0));
            column(TempCheck; TempCheck)
            {
            }
            column(Valuedate; '')//"Value Date"15578
            {
            }
            column(Open_BankAccountLedgerEntry; "Bank Account Ledger Entry".Open)
            {
            }
            column(Cheque_No; "Cheque No.")
            {
            }
            column(Cheque_Date; FORMAT("Cheque Date"))
            {
            }
            column(Posting_Date; FORMAT("Posting Date"))
            {
            }
            column(Party_Name; PartyName)
            {
            }
            column(AmountToShow; mAmountToShow)
            {
            }
            column(AddAmt; AddAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF BankAcc.GET("Bank Account No.") THEN
                    BankName := BankAcc.Name + ' ' + BankAcc."Name 2" + ' ' + BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' +
                                BankAcc.City;

                TempCheck := OpeningBalance;
                //MESSAGE(FORMAT(TempCheck));
                IF BankAcc.GET("Bank Account No.") THEN
                    BankName := BankAcc.Name + ' ' + BankAcc."Name 2" + ' ' + BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' +
                                BankAcc.City;

                j += 1;
                tgWin.UPDATE(1, ROUND(j / i * 10000, 1));

                PartyName := '';//vipul Tri1.0
                IF Open THEN BEGIN
                    AddAmt += "Credit Amount";
                    mAmountToShow := "Credit Amount";
                    IF "Debit Amount" < 0 THEN BEGIN
                        AddAmt += ("Debit Amount" * -1);
                        mAmountToShow := ("Debit Amount" * -1);
                    END;
                END ELSE
                    CurrReport.SKIP;

                IF "Description" <> '' THEN
                    PartyName := "Description"
                ELSE BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Document No.", "Posting Date", "Transaction No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", "Document No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Posting Date", "Posting Date");
                    IF CustLedgEntry.FIND('-') THEN
                        IF Cust.GET(CustLedgEntry."Customer No.") THEN
                            PartyName := Cust.Name;

                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Document No.", "Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Posting Date", "Posting Date");
                    IF VendLedgEntry.FIND('-') THEN
                        IF Vendor.GET(VendLedgEntry."Vendor No.") THEN
                            PartyName := Vendor.Name;
                END;

                IF PartyName = '' THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.SETRANGE(GLEntry."Document No.", "Document No.");
                    GLEntry.SETRANGE(GLEntry."Posting Date", "Posting Date");
                    IF Amount > 0 THEN
                        GLEntry.SETFILTER(GLEntry.Amount, '<%1', 0)
                    ELSE
                        GLEntry.SETFILTER(GLEntry.Amount, '>%1', 0);
                    IF GLEntry.FIND('-') THEN
                        IF GLAcc.GET(GLEntry."G/L Account No.") THEN
                            PartyName := GLAcc.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin

                //"Bank Account Ledger Entry".SETFILTER("Posting Date",'<=%1',AsOnDate);
                IF BankAccNo <> '' THEN
                    SETFILTER("Bank Account No.", BankAccNo);
                SETRANGE("Posting Date", 0D, AsOnDate);  //TRI
                IF LocationCode <> '' THEN
                    //   SETFILTER("Location Code", LocationCode);

                    //SETFILTER(Amount,'<%1',0);

                    //SETFILTER(Open,'%1',TRUE);//Vipul Tri1.0
                    i := 0;
                j := 0;
                i := COUNT;
            end;
        }
        dataitem(BALE2; 271)
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                WHERE(Amount = FILTER(< 0));
            column(TempCheck2; TempCheck)
            {
            }
            column(ValueDate2; '')// "Value Date"15578
            {
            }
            column(Open_BankAccountLedgerEntry2; "Bank Account Ledger Entry".Open)
            {
            }
            column(BankFilter2; 'Bank Reconciliation Statement as on ' + FORMAT(AsOnDate))
            {
            }
            column(Bankname2; 'Bank : ' + BankName)
            {
            }
            column(Cheque_No2; "Cheque No.")
            {
            }
            column(Cheque_Date2; FORMAT("Cheque Date"))
            {
            }
            column(Posting_Date2; FORMAT("Posting Date"))
            {
            }
            column(Party_Name2; PartyName)
            {
            }
            column(AmountToShow2; mAmountToShow)
            {
            }
            column(AddAmt2; AddAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TempCheck := OpeningBalance;
                //MESSAGE(FORMAT(TempCheck));
                IF BankAcc.GET("Bank Account No.") THEN
                    BankName := BankAcc.Name + ' ' + BankAcc."Name 2" + ' ' + BankAcc.Address + ' ' + BankAcc."Address 2" + ' ' +
                                BankAcc.City;

                j += 1;
                tgWin.UPDATE(1, ROUND(j / i * 10000, 1));

                PartyName := '';//vipul Tri1.0
                IF NOT Open THEN BEGIN
                    IF BankAccStatmentLine.GET("Bank Account No.", "Statement No.", "Statement Line No.") THEN BEGIN
                        IF BankAccStatmentLine."Value Date" > AsOnDate THEN BEGIN
                            AddAmt += "Credit Amount";
                            mAmountToShow := "Credit Amount";
                            //TRI P.G 25.05.2010 -- NEW CODE ADDED TO AFFECT REVERSAL ENTRIES
                            IF "Debit Amount" < 0 THEN BEGIN
                                AddAmt += ("Debit Amount" * -1);
                                mAmountToShow := ("Debit Amount" * -1);
                            END;
                            //TRI P.G 25.05.2010 -- NEW CODE ADDED TO AFFECT REVERSAL ENTRIES
                            //CurrReport.SHOWOUTPUT(TRUE);
                        END ELSE
                            CurrReport.SKIP;
                    END ELSE
                        CurrReport.SKIP;
                END ELSE
                    CurrReport.SKIP;

                IF "Description" <> '' THEN
                    PartyName := "Description"
                ELSE BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Document No.", "Posting Date", "Transaction No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", "Document No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Posting Date", "Posting Date");
                    IF CustLedgEntry.FIND('-') THEN
                        IF Cust.GET(CustLedgEntry."Customer No.") THEN
                            PartyName := Cust.Name;

                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Document No.", "Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Posting Date", "Posting Date");
                    IF VendLedgEntry.FIND('-') THEN
                        IF Vendor.GET(VendLedgEntry."Vendor No.") THEN
                            PartyName := Vendor.Name;
                END;

                IF PartyName = '' THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.SETRANGE(GLEntry."Document No.", "Document No.");
                    GLEntry.SETRANGE(GLEntry."Posting Date", "Posting Date");
                    IF Amount > 0 THEN
                        GLEntry.SETFILTER(GLEntry.Amount, '<%1', 0)
                    ELSE
                        GLEntry.SETFILTER(GLEntry.Amount, '>%1', 0);
                    IF GLEntry.FIND('-') THEN
                        IF GLAcc.GET(GLEntry."G/L Account No.") THEN
                            PartyName := GLAcc.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin

                //"Bank Account Ledger Entry".SETFILTER("Posting Date",'<=%1',AsOnDate);
                IF BankAccNo <> '' THEN
                    SETFILTER("Bank Account No.", BankAccNo);
                SETRANGE("Posting Date", 0D, AsOnDate);  //TRI
                IF LocationCode <> '' THEN
                    // 16630 SETFILTER("Location Code", LocationCode);

                    //SETFILTER(Amount,'<%1',0);

                    //SETFILTER(Open,'%1',TRUE);//Vipul Tri1.0
                    i := 0;
                j := 0;
                i := COUNT;
            end;
        }
        dataitem("Bank Account Ledger Entry1"; 271)
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                WHERE(Amount = FILTER(> 0));
            column(Amount_LCY; "Amount (LCY)")
            {
            }
            column(ValueDate3; '')//"Value Date"15578
            {
            }
            column(Less_Amt; LessAmt)
            {
            }
            column(RemBalance; OpeningBalance + AddAmt - LessAmt)
            {
            }
            column(ChequeNo1; "Cheque No.")
            {
            }
            column(ChequeDate1; FORMAT("Cheque Date"))
            {
            }
            column(PostingDate1; FORMAT("Posting Date"))
            {
            }
            column(PartyName1; PartyName)
            {
            }
            column(Open_BankAccountLedgerEntry1; "Bank Account Ledger Entry1".Open)
            {
            }

            trigger OnAfterGetRecord()
            begin

                j += 1;
                tgWin.UPDATE(1, ROUND(j / i * 10000, 1));

                PartyName := '';  //Vipul Tri1.0
                IF Open THEN
                    LessAmt += "Amount (LCY)"
                //CurrReport.SHOWOUTPUT(TRUE);
                ELSE
                    CurrReport.SKIP;

                //Vipul Tri1.0 Start
                //TRISC-- Field Description2 not in Bank Accont Ledger Entry.
                IF "Description" <> '' THEN
                    PartyName := "Description"
                ELSE BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Document No.", "Posting Date", "Transaction No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", "Document No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Posting Date", "Posting Date");
                    IF CustLedgEntry.FIND('-') THEN
                        IF Cust.GET(CustLedgEntry."Customer No.") THEN
                            PartyName := Cust.Name;

                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Document No.", "Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Posting Date", "Posting Date");
                    IF VendLedgEntry.FIND('-') THEN
                        IF Vendor.GET(VendLedgEntry."Vendor No.") THEN
                            PartyName := Vendor.Name;
                END;

                IF PartyName = '' THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.SETRANGE(GLEntry."Document No.", "Document No.");
                    GLEntry.SETRANGE(GLEntry."Posting Date", "Posting Date");
                    IF Amount > 0 THEN
                        GLEntry.SETFILTER(GLEntry.Amount, '<%1', 0)
                    ELSE
                        GLEntry.SETFILTER(GLEntry.Amount, '>%1', 0);
                    IF GLEntry.FIND('-') THEN
                        IF GLAcc.GET(GLEntry."G/L Account No.") THEN
                            PartyName := GLAcc.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin

                //"Bank Account Ledger Entry1".SETFILTER("Posting Date",'<=%1',AsOnDate);
                //"Bank Account Ledger Entry1".SETFILTER("Bank Account No.",BankAccNo);
                //"Bank Account Ledger Entry1".SETFILTER(Amount,'>%1',0);
                //SETFILTER(Open,'%1',TRUE);//Vipul Tri1.0
                IF BankAccNo <> '' THEN
                    SETFILTER("Bank Account No.", BankAccNo);
                SETRANGE("Posting Date", 0D, AsOnDate);  //TRI
                IF LocationCode <> '' THEN
                    // 16630 SETFILTER("Location Code", LocationCode);

                    i := 0;
                j := 0;
                i := COUNT;
            end;
        }
        dataitem("Bank Account Ledger Entry3"; 271)
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                WHERE(Amount = FILTER(> 0));
            column(Amount_LCY3; "Amount (LCY)")
            {
            }
            column(Less_Amt3; LessAmt)
            {
            }
            column(ValueDate4; '')//"Value Date"
            {
            }
            column(RemBalance3; OpeningBalance + AddAmt - LessAmt)
            {
            }
            column(ChequeNo13; "Cheque No.")
            {
            }
            column(ChequeDate13; FORMAT("Cheque Date"))
            {
            }
            column(PostingDate13; FORMAT("Posting Date"))
            {
            }
            column(PartyName13; PartyName)
            {
            }
            column(Open_BankAccountLedgerEntry13; "Bank Account Ledger Entry1".Open)
            {
            }

            trigger OnAfterGetRecord()
            begin

                j += 1;
                tgWin.UPDATE(1, ROUND(j / i * 10000, 1));

                PartyName := '';//vipul Tri1.0
                IF NOT Open THEN BEGIN
                    IF BankAccStatmentLine.GET("Bank Account No.", "Statement No.", "Statement Line No.") THEN BEGIN
                        IF BankAccStatmentLine."Value Date" > AsOnDate THEN
                            LessAmt += "Amount (LCY)"
                        ELSE
                            CurrReport.SKIP;
                    END
                    ELSE
                        CurrReport.SKIP;
                END ELSE
                    CurrReport.SKIP;
                //TRISC-- Field not in  Bank Account

                IF "Description" <> '' THEN
                    PartyName := "Description"
                ELSE BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETCURRENTKEY("Document No.", "Posting Date", "Transaction No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", "Document No.");
                    CustLedgEntry.SETRANGE(CustLedgEntry."Posting Date", "Posting Date");
                    IF CustLedgEntry.FIND('-') THEN
                        IF Cust.GET(CustLedgEntry."Customer No.") THEN
                            PartyName := Cust.Name;

                    VendLedgEntry.RESET;
                    VendLedgEntry.SETCURRENTKEY("Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Document No.", "Document No.");
                    VendLedgEntry.SETRANGE(VendLedgEntry."Posting Date", "Posting Date");
                    IF VendLedgEntry.FIND('-') THEN
                        IF Vendor.GET(VendLedgEntry."Vendor No.") THEN
                            PartyName := Vendor.Name;
                END;

                IF PartyName = '' THEN BEGIN
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.SETRANGE(GLEntry."Document No.", "Document No.");
                    GLEntry.SETRANGE(GLEntry."Posting Date", "Posting Date");
                    IF Amount > 0 THEN
                        GLEntry.SETFILTER(GLEntry.Amount, '<%1', 0)
                    ELSE
                        GLEntry.SETFILTER(GLEntry.Amount, '>%1', 0);
                    IF GLEntry.FIND('-') THEN
                        IF GLAcc.GET(GLEntry."G/L Account No.") THEN
                            PartyName := GLAcc.Name;
                END;
                //Vipul Tri1.0 End

                //Vipul Tri1.0 End
            end;

            trigger OnPreDataItem()
            begin

                //"Bank Account Ledger Entry1".SETFILTER("Posting Date",'<=%1',AsOnDate);
                //"Bank Account Ledger Entry1".SETFILTER("Bank Account No.",BankAccNo);
                //"Bank Account Ledger Entry1".SETFILTER(Amount,'>%1',0);
                //SETFILTER(Open,'%1',TRUE);//Vipul Tri1.0
                IF BankAccNo <> '' THEN
                    SETFILTER("Bank Account No.", BankAccNo);
                SETRANGE("Posting Date", 0D, AsOnDate);  //TRI
                IF LocationCode <> '' THEN
                    // 16630 SETFILTER("Location Code", LocationCode);

                    i := 0;
                j := 0;
                i := COUNT;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(group)
                {
                    field("Location Filter :"; LocationCode)
                    {
                        ApplicationArea = All;
                        // 16630  TableRelation = "Location.Code" WHERE("Main Location" = FILTER(''));
                    }
                    field("Bank Account :"; BankAccNo)
                    {
                        TableRelation = "Bank Account";
                        ApplicationArea = All;
                    }
                    field("As On Date :"; AsOnDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

        tgWin.CLOSE;
        /*IF PrintToExcel THEN BEGIN
          ExcelBuffer.CreateBook('');
          ExcelBuffer.CreateSheet('Bank Reconcillation','Bank Reconcillation',COMPANYNAME,USERID);
          ExcelBuffer.GiveUserControl;
        END;
        */
        //RepAuditMgt.CreateAudit(50086)
    end;

    trigger OnPreReport()
    begin

        IF BankAccNo = '' THEN
            ERROR('Please Enter Bank Account No.');

        IF AsOnDate = 0D THEN
            ERROR('Please Enter As On Date');

        Rowno := 0;
        IF PrintToExcel THEN
            ExcelBuffer.DELETEALL;

        tgWin.OPEN(tgText001);
    end;

    var
        OpeningBalance: Decimal;
        AsOnDate: Date;
        BankAccLedgerEntry: Record "Bank Account Ledger Entry";
        AddAmt: Decimal;
        BankAccStatmentLine: Record "Bank Account Statement Line";
        LessAmt: Decimal;
        BankName: Text[250];
        BankAcc: Record "Bank Account";
        Cust: Record Customer;
        Vendor: Record Vendor;
        PartyName: Text[200];
        BankAccNo: Code[20];
        GLAcc: Record "G/L Account";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLEntry: Record "G/L Entry";
        LocationCode: Code[20];
        LocationAddress: Text[250];
        LocationAddress2: Text[250];
        Location: Record Location;
        StateRec: Record State;
        mAmountToShow: Decimal;
        PrintToExcel: Boolean;
        tgWin: Dialog;
        i: Integer;
        j: Integer;
        ExcelBuffer: Record "Excel Buffer";
        Rowno: Integer;
        tgText001: Label 'Process @1@@@@@@@@@@@@@@@@@@@';
        TempCheck: Decimal;

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        /*
        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Row No.",RowNo);
        ExcelBuffer.VALIDATE("Column No.",ColumnNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer.Bold := Bold;
        ExcelBuffer.Underline := UnderLine;
        ExcelBuffer.INSERT;
         */
    end;
}
