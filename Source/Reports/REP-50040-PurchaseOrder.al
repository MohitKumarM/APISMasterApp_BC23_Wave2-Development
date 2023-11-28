report 50040 "purchase Order Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseOrder.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchases & Payables Setup"; "Purchases & Payables Setup")
        {
            column(Pament_Terms; "PO Terms & Conditions") { }
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.", "Document Type";
            column(CompanyName; recCompanyInfo.Name) { }
            column(Picture; recCompanyInfo.Picture) { }
            column(Company_PhnNo; recCompanyInfo."Phone No.") { }
            column(Company_Email; recCompanyInfo."E-Mail") { }
            column(Company_Address; recCompanyInfo.Address + ',' + recCompanyInfo."Address 2") { }
            column(Company_Website; '') { }
            column(Purch_Order_Name; Purch_Order_Name) { }
            column(PurchOrder_No; "No.") { }
            column(PurchOrder_PostingDate; "Posting Date") { }
            column(Location_GST_Reg__No_; "Location GST Reg. No.") { }
            column(Vendor_GST_Reg__No_; Vendor_GST_No) { }
            column(CIN_No; '') { }
            column(PAN_No; recCompanyInfo."P.A.N. No.") { }
            column(Vendor_PANNo; Vendor_PAN_No) { }
            column(Reverse_Charger; Reverse_Charger) { }
            column(Bill_to_Location_POS_; "Bill to-Location(POS)") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Name_2; "Ship-to Name 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Order_Date; "Order Date") { }
            column(validTill; '') { }
            column(Freight; '') { }
            column(Transit_Insurance; '') { }
            column(ModeOf_Delivery; '') { }
            column(Payment_Terms; '') { }
            column(Currency_Code; "Currency Code") { }
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
            column(txt_Vendor6; txt_Vendor[6]) { }
            column(txt_vendor_No; "Pay-to Vendor No.") { }
            column(Comment; Comment) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                column(SrNo; Sr_No) { }
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Delivery_Time; '') { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(unitPricePer_DisPercent; '') { }
                column(TotalValue_DisAmt; '') { }
                column(Total_Amount; Amount) { }
                column(Sum_TotalAmount; TotalAmount) { }
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

                trigger OnPreDataItem()
                begin
                    Sr_No := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    Sr_No += 1;

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
                    TaxTransactionValue.SetRange("Tax Record ID", "Purchase Line".RecordId);
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

                trigger OnPostDataItem()
                begin
                end;
            }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                if "Purchase Header".Status = "Purchase Header".Status::Open then
                    Purch_Order_Name := 'Draft Purchase Order No.';
                if "Purchase Header".Status = "Purchase Header".Status::Released then
                    Purch_Order_Name := 'Purchase Order No.';

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
                Vendor_GST_No := rec_Vendor."GST Registration No.";
                Vendor_PAN_No := rec_Vendor."P.A.N. No.";

                if rec_Vendor."GST Vendor Type" = rec_Vendor."GST Vendor Type"::Registered then
                    Reverse_Charger := 'No';
                if rec_Vendor."GST Vendor Type" = rec_Vendor."GST Vendor Type"::Unregistered then
                    Reverse_Charger := 'Yes';
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                /* field(No; "Purchase Header"."No.")
                {
                    Caption = 'No';
                    ApplicationArea = All;
                    TableRelation = "Purchase Header"."No.";

                    /trigger OnLookup(var text: Text): Boolean

                    var
                        Purch_Header: Record "Purchase Header";
                    begin
                        Purch_Header.Reset();
                        if Page.RunModal(Page::"Purchase Order List", Purch_Header) = Action::LookupOK then
                            P_No := Purch_Header."No.";
                    end;
                } */
            }
        }

        actions
        {
            area(processing) { }
        }
    }
    trigger OnPreReport()
    begin
        recCompanyInfo.Get();
        recCompanyInfo.CalcFields(Picture);
    end;

    var
        Purch_Order_Name: Text[25];
        Reverse_Charger: Text[10];
        Vendor_GST_No: Code[20];
        Vendor_PAN_No: Code[10];
        recCompanyInfo: Record "Company Information";
        recLocation: Record Location;
        rec_Vendor: Record Vendor;
        txtLocation: array[10] of Text[255];
        txt_Vendor: array[10] of Text[255];
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TaxTransactionValue: Record "Tax Transaction Value";
        Sr_No: Integer;
        TDSSetup: Record "TDS Setup";
        TotalAmount: Decimal;
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
        TDSAmt: Decimal;
        TDSRate: Decimal;
        GrandTotalAmount: Decimal;
}