report 50006 "Purchase Voucher"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseVoucher.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(CompanyName; recCompInfo.Name) { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Date; "Document Date") { }
            column(Due_Date; "Due Date") { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.") { }
            column(Your_Reference; "Your Reference") { }
            column(Payment_Terms; '') { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Location_GST_Reg__No_; "Location GST Reg. No.") { }
            column(Bal__Account_No_; "Bal. Account No.") { }
            column(Home_Page; recCompInfo."Home Page") { }
            column(Email; recCompInfo."E-Mail") { }
            column(Location1; txtLocation[1]) { }
            column(Location2; txtLocation[2] + ' ' + txtLocation[3]) { }
            column(Location3; txtLocation[4] + ' ' + txtLocation[5]) { }
            column(Location4; txtLocation[6]) { }//phone no
            column(Location5; txtLocation[7]) { }// home page
            column(Location6; txtLocation[8]) { }//email
            column(txt_Vendor1; txt_Vendor[1]) { }
            column(txt_Vendor2; txt_Vendor[2]) { }
            column(txt_Vendor3; txt_Vendor[3]) { }
            column(txt_Vendor4; txt_Vendor[4]) { }
            column(txt_Vendor5; txt_Vendor[5]) { }
            column(txt_Vendor6; Vendor_PhnNo) { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Comment; Comment) { }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purch. Inv. Header";
                DataItemTableView = sorting("Document No.", "Line No.");

                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Amount; Amount) { }
                column(TotalAmount; TotalAmount) { }
                column(IGST_Rate; IRate) { }
                column(IGST_Amount; IAmount1) { }
                column(CGST_Rate; CRate) { }
                column(CGST_Amount; CAmount1) { }
                column(SGST_Rate; SRate) { }
                column(SGST_Amount; SAmount1) { }
                column(Total_GSTAmount; Total_GSTAmount) { }
                column(TDSAmt; TDSAmt) { }
                column(TDSRate; TDSRate) { }
                column(GrandTotalAmount; GrandTotalAmount) { }

                trigger OnAfterGetRecord()
                begin
                    Clear(TotalAmount);
                    TotalAmount += Amount;

                    Clear(CRate);
                    Clear(CAmount);
                    Clear(CAmount1);
                    Clear(IRate);
                    Clear(IAmount);
                    Clear(IAmount1);
                    Clear(SRate);
                    Clear(SAmount);
                    Clear(SAmount1);

                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FindSet() THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CRate := DetailedGSTLedgerEntry."GST %";
                                CAmount := DetailedGSTLedgerEntry."GST Amount";
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SRate := DetailedGSTLedgerEntry."GST %";
                                SAmount := DetailedGSTLedgerEntry."GST Amount";
                                SAmount1 += SAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IRate := DetailedGSTLedgerEntry."GST %";
                                IAmount := DetailedGSTLedgerEntry."GST Amount";
                                IAmount1 += IAmount;
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                    TDSSetup.Get();
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", "Purch. Inv. Line".RecordId);
                    TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Value ID", 7);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then begin
                        repeat
                            TDSAmt += TaxTransactionValue.Amount;
                            TDSRate := TaxTransactionValue.Percent;
                        until TaxTransactionValue.Next() = 0;
                    end;

                    Clear(Total_GSTAmount);
                    Total_GSTAmount := CAmount1 + SAmount1 + IAmount1;

                    GrandTotalAmount := Total_GSTAmount + TotalAmount + TDSAmt;
                end;
            }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                // For Loaction Name.....................
                CLEAR(txtLocation);
                recLocation.GET("Location Code");
                txtLocation[1] := recLocation.Name + ' ' + recLocation."Name 2";
                txtLocation[2] := recLocation.Address;
                txtLocation[3] := recLocation."Address 2";
                txtLocation[4] := recLocation.City;
                txtLocation[5] := recLocation."Post Code";
                txtLocation[6] := recLocation."Phone No.";
                txtLocation[7] := recLocation."Home Page";
                txtLocation[8] := recLocation."E-Mail";
                COMPRESSARRAY(txtLocation);
                // For Loaction Name.....................

                // For Vendor Name.......................
                CLEAR(txt_Vendor);
                rec_Vendor.GET("Buy-from Vendor No.");
                txt_Vendor[1] := rec_Vendor.Name + ' ' + rec_Vendor."Name 2";
                txt_Vendor[2] := rec_Vendor.Address;
                txt_Vendor[3] := rec_Vendor."Address 2";
                txt_Vendor[4] := rec_Vendor.City;
                txt_Vendor[5] := rec_Vendor."State Code";
                COMPRESSARRAY(txt_Vendor);
                Vendor_PhnNo := rec_Vendor."Phone No.";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName) { }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        recCompInfo.Get();
    end;

    var
        recCompInfo: Record "Company Information";
        recLocation: Record Location;
        rec_Vendor: Record Vendor;
        txtLocation: array[10] of Text[255];
        txt_Vendor: array[10] of Text[255];
        Vendor_PhnNo: Code[15];
        TotalAmount: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
        TDSRate: Decimal;
        CRate: Decimal;
        CAmount: Decimal;
        CAmount1: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        SAmount1: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        IAmount1: Decimal;
        Total_GSTAmount: Decimal;
        GrandTotalAmount: Decimal;
}