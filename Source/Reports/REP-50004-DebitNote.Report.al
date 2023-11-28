report 50004 "Debit Note-New"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DebitNoteNew.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; 124)
        {
            RequestFilterFields = "No.";
            column(CompName; recCompInfo.Name) { }
            column(CompAddress; recCompInfo.Address) { }
            column(CompAddress2; recCompInfo."Address 2") { }
            column(CITY; recCompInfo.City) { }
            column(PostCode; recCompInfo."Post Code") { }
            column(Picture; recCompInfo.Picture) { }
            column(QR_Code; '') { }
            column(Location1; txtLocation[1]) { }
            column(Location2; txtLocation[2] + ' ' + txtLocation[3]) { }
            column(Location3; txtLocation[4] + ' ' + txtLocation[5]) { }
            column(DebitNote_No; "Purch. Cr. Memo Hdr."."No.") { }
            column(DebitNote_Date; FORMAT("Purch. Cr. Memo Hdr."."Posting Date")) { }
            column(Location_GST_Reg__No_; "Location GST Reg. No.") { }
            //Buyer Info.
            column(txt_Vendor1; txt_Vendor[1]) { }
            column(txt_Vendor2; txt_Vendor[2]) { }
            column(txt_Vendor3; txt_Vendor[3]) { }
            column(txt_Vendor4; txt_Vendor[4]) { }
            column(txt_Vendor5; txt_Vendor[5]) { }
            column(txt_Vendor6; txt_Vendor[6]) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Buyer_GSTNo; "Purch. Cr. Memo Hdr."."Vendor GST Reg. No.") { }
            column(PAN_No; PAN_No) { }
            column(CINNO; '') { }
            column(HOME_PAGE; Home_Page) { }
            column(EMAIL; '') { }
            column(PaymentTerm_Remarks; '') { }
            column(BuyerOrder_No; '')// External Doc No
            {
            }
            column(BuyerOrder_Date; '')// External Doc Date
            {
            }
            column(OPS_No; '') { }
            column(SalesOrder_Date; '') { }
            column(Dispatch_through; '') { }
            column(Destination; '') { }
            column(paymentDue_Date; '') { }
            column(Ref_No; '') { }
            column(IRN_No; '') { }
            dataitem("Purch. Cr. Memo Line"; 125)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Sr_No; Sr_No) { }
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_Price__LCY_; "Unit Price (LCY)") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }
                column(TaxPersent; '') { }
                column(S_TaxPersent; '') { }
                column(Amount; Amount) { }
                column(TotalAmount; TotalAmount) { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(IGST_Rate; IRate) { }
                column(IGST_Amount; IAmount1) { }
                column(CGST_Rate; CRate) { }
                column(CGST_Amount; CAmount1) { }
                column(SGST_Rate; SRate) { }
                column(SGST_Amount; SAmount1) { }
                column(Total_GSTAmount; Total_GSTAmount) { }
                column(GRAND_RoundOff_Total; GRAND_RoundOff_Total) { }
                trigger OnPostDataItem()
                begin
                    Sr_No := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    Sr_No += 1;

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

                    Total_GSTAmount := CAmount1 + SAmount1 + IAmount1;
                    GrandTotalAmount := Total_GSTAmount + TotalAmount;
                    GRAND_RoundOff_Total := Round(GrandTotalAmount, 1, '=')
                end;

                trigger OnPreDataItem()
                begin
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // For Loaction Name.....................
                CLEAR(txtLocation);
                recLocation.GET("Location Code");
                txtLocation[1] := recLocation.Name + ' ' + recLocation."Name 2";
                txtLocation[2] := recLocation.Address;
                txtLocation[3] := recLocation."Address 2";
                txtLocation[4] := recLocation.City;
                txtLocation[6] := recLocation."Post Code";
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
                txt_Vendor[6] := rec_Vendor."Phone No.";
                COMPRESSARRAY(txt_Vendor);

                BuyerGST_NO := Rec_vendor."GST Registration No.";
                PAN_No := rec_Vendor."P.A.N. No.";
                Home_Page := rec_Vendor."Home Page";
                // For Loaction Name.....................
            end;
        }
    }

    requestpage
    {
        layout { }

        actions { }
    }

    labels { }

    trigger OnPreReport()
    begin
        recCompInfo.GET();
        recCompInfo.CalcFields(Picture);
    end;

    var
        recLocation: Record Location;
        txtLocation: array[10] of Text[255];
        rec_Vendor: Record Vendor;
        BuyerGST_NO: Code[25];
        Home_Page: Text[90];
        PAN_No: Code[25];
        txt_Vendor: array[10] of Text[255];
        recCompInfo: Record "Company Information";
        TotalAmount: Decimal;
        Sr_No: Integer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CRate: Decimal;
        CAmount: Decimal;
        CAmount1: Decimal;
        IRate: Decimal;
        IAmount: Decimal;
        IAmount1: Decimal;
        SRate: Decimal;
        SAmount: Decimal;
        SAmount1: Decimal;
        Total_GSTAmount: Decimal;
        GrandTotalAmount: Decimal;
        GRAND_RoundOff_Total: Decimal;
}
