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
            column(Shipper_Name; '') { }
            column(Shipper_Address; '') { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address" + ',' + "Ship-to Address 2") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address" + ',' + "Bill-to Address 2") { }
            column(Reference_Invoice_No_; "Reference Invoice No.") { }//Invoice No
            column(Posting_Date; "Posting Date") { }//Invoice Date
            column(ERP_Sales_Order_No; "No.") { }
            column(ERP_Sales_Order_Date; "Document Date") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Buyer_Order_No; '') { }
            column(Requested_Delivery_Date; "Requested Delivery Date") { }
            column(Buyer_Order_Date; "Order Date") { }
            column(Payment_Terms; "Payment Terms Code") { }
            column(Incoterm; '') { }
            column(Documentry_credit_No; '') { }

            column(Other_Documents_RemarksAny; '') { }
            column(Buyer_Requested_Receipt_Date; '') { }
            column(Currency_Code; "Currency Code") { }
            column(First_Notify_PartyName; '') { }
            column(First_Notify_Address; '') { }
            column(Second_Notify_PartyName; '') { }
            column(Second_Notify_Address; '') { }
            column(Pre_Carriage_By; '') { }
            column(Pre_Carriae_receipt_By; '') { }
            column(Vessel_Name_Flight_No; '') { }
            column(GST_Type; '') { }
            column(Loading_Port_AirPort_Dept; '') { }
            column(Port_Of_Discharge; '') { }
            column(Final_Destination; '') { }
            column(Shipping_Remarks; '') { }
            column(Echange_Rate; '') { }
            column(Pallet_Requirement; '') { }


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
                column(Line_Amount_Excl_VAT; GetLineAmountExclVAT()) { }
                column(GST_Percent; GST_Percent) { }
                column(GST_Amount; Total_GSTAmount) { }
                column(Discount_Percent; "Line Discount %") { }
                column(Discount_Amount; "Line Discount Amount") { }
                column(Add_FreightOrOtherCharges; '') { }
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
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }



    var
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