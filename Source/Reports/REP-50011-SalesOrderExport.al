report 50011 "Sales Order Export\Domestic"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesOrderExport.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Order"));
            RequestFilterFields = "No.";
            column(Shipper_Name; Rec_CompanyInfo.Name) { }
            column(Shipper_Address1; txtLocation[1]) { }
            column(Shipper_Address2; txtLocation[2] + ',' + txtLocation[3]) { }
            column(Shipper_Address3; txtLocation[4] + ',' + txtLocation[5]) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address" + ',' + "Ship-to Address 2") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address" + ',' + "Bill-to Address 2") { }
            column(Reference_Invoice_No_; Ref_InvNo) { }//Invoice No
            column(Posting_Date; Var_Posting_Date) { }//Invoice Date
            column(ERP_Sales_Order_No; "No.") { }
            column(ERP_Sales_Order_Date; "Order Date") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Buyer_Order_No; "External Document No.") { }
            column(Requested_Delivery_Date; "Requested Delivery Date") { }
            column(Buyer_Order_Date; "Order Date") { }
            column(Payment_Terms; "Payment Terms Code") { }
            column(Incoterm; "Shipment Method Code") { }
            column(Documentry_credit_No; "Reference Invoice No.") { }
            // column(Other_Documents_RemarksAny; '') { }
            // column(Buyer_Requested_Receipt_Date; '') { }
            column(Currency_Code; "Currency Code") { }
            column(First_Notify_PartyName; '') { }
            column(First_Notify_Address; '') { }
            column(Second_Notify_PartyName; '') { }
            column(Second_Notify_Address; '') { }
            column(Pre_Carriage_By; "Pre-Carriage By") { }
            column(Pre_Carriae_receipt_By; "Pre-Carriage Receipt Place") { }
            column(Vessel_Name_Flight_No; "Vessel / Flight No.") { }
            column(GST_Type; "GST Type on Export") { }
            column(Loading_Port_AirPort_Dept; "Loading Port / Airport Dep.") { }
            column(Port_Of_Discharge; "Discharge Port / Airport") { }
            column(Final_Destination; '') { }
            column(Shipping_Remarks; "Shipping Marks") { }
            column(Echange_Rate; '') { }
            column(Pallet_Requirement; Pallet_Req) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(No_; "No.") { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Description; Description) { }
                column(Location_Code; "Location Code") { }
                column(Packing; '') { }
                column(Order_Qty; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount_Excl_VAT; "Line Amount") { }
                column(GST_Percent; GST_Percent) { }
                column(GST_Amount; Total_GSTAmount) { }
                column(Discount_Percent; "Line Discount %") { }
                column(Discount_Amount; "Line Discount Amount") { }
                column(Final_AmountIn_USD; Amount) { }

                trigger OnAfterGetRecord()
                begin

                    Clear(CAmount);
                    Clear(CAmount1);
                    Clear(IAmount);
                    Clear(IAmount1);
                    Clear(SAmount);
                    Clear(SAmount1);
                    Clear(GST_Percent1);
                    Clear(GST_Percent2);
                    Clear(GST_Percent3);

                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FindSet() THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                GST_Percent1 := DetailedGSTLedgerEntry."GST %";
                                CAmount := DetailedGSTLedgerEntry."GST Amount";
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                GST_Percent2 := DetailedGSTLedgerEntry."GST %";
                                SAmount := DetailedGSTLedgerEntry."GST Amount";
                                SAmount1 += SAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                GST_Percent3 := DetailedGSTLedgerEntry."GST %";
                                IAmount := DetailedGSTLedgerEntry."GST Amount";
                                IAmount1 += IAmount;
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                    Clear(GST_Percent);
                    GST_Percent := GST_Percent1 + GST_Percent2 + GST_Percent3;
                    Clear(Total_GSTAmount);
                    Total_GSTAmount := CAmount1 + SAmount1 + IAmount1;
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
                txtLocation[5] := recLocation."Post Code";
                COMPRESSARRAY(txtLocation);
                // For Loaction Name.....................
                SIH.Reset();
                SIH.SetRange("Order No.", "No.");
                if SIH.FindFirst() then begin
                    Ref_InvNo := SIH."No.";
                    Var_Posting_Date := SIH."Posting Date";
                end;

                //Rec_PrepackingList.Get("Sales Header"."No.");
                // Rec_PrepackingList.Reset();
                // Rec_PrepackingList.SetRange("Order No.", "No.");
                // if Rec_PrepackingList.FindFirst() then begin
                //     if Rec_PrepackingList."Order No." <> '' then
                //         Pallet_Req := 'Yes'
                //     else
                //         Pallet_Req := 'No';
                // end;
            end;
        }
    }

    requestpage
    {
        layout { }

        actions { }
    }
    trigger OnPreReport()
    begin
        Rec_CompanyInfo.Get();
    end;

    var
        Rec_CompanyInfo: Record "Company Information";
        recLocation: Record Location;
        txtLocation: array[10] of Text[255];
        SIH: Record "Sales Invoice Header";
        Ref_InvNo: Code[20];
        Var_Posting_Date: Date;
        Rec_PrepackingList: Record "Pre Packing List";
        Pallet_Req: Text[5];
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GST_Percent: Decimal;
        GST_Percent1: Decimal;
        GST_Percent2: Decimal;
        GST_Percent3: Decimal;
        CAmount: Decimal;
        CAmount1: Decimal;
        SAmount: Decimal;
        SAmount1: Decimal;
        IAmount: Decimal;
        IAmount1: Decimal;
        Total_GSTAmount: Decimal;
}