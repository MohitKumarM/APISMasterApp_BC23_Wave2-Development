report 50013 "Invoice Export"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InvoiceExport.rdl';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Shipper_Name; Rec_CompanyInfo.Name) { }
            column(Shipper_Address1; txtLocation[1]) { }
            column(Shipper_Address2; txtLocation[2] + ',' + txtLocation[3]) { }
            column(Shipper_Address3; txtLocation[4] + ',' + txtLocation[5]) { }
            column(Sale_Order_no; "Order No.") { }
            column(Invoice_No; "No.") { }
            column(Invoice_Date; "Posting Date") { }
            column(Consignee_Name; "Ship-to Name") { }
            column(Consignee_Address; "Ship-to Address" + "Ship-to Address 2") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address" + "Bill-to Address 2") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Buyer_Order_No; "External Document No.") { }
            column(Payment_Terms; "Payment Terms Code") { }
            column(Incoterm; "Shipment Method Code") { }
            column(Documentary_Credit_No; "Reference Invoice No.") { }
            column(Precarriage_By; Var_Precarriage_By) { }
            column(Precarriage_receipt_By; Var_Precarriage_receipt_By) { }
            column(VesselName_Flight_No; Var_VessalFlightNo) { }
            column(LoadingPort_AirPortDept; '') { }
            column(PortOfDischarge; '') { }
            column(Final_Destination; '') { }
            column(Shipping_Remarks; '') { }
            column(First_Notify_PartyName; '') { }
            column(First_Notify_Address; '') { }
            column(Second_Notify_PartyName; '') { }
            column(Second_Notify_Address; '') { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Sr_No; Sr_No) { }
                column(Item_Code; "No.") { }
                column(Item_Description; Description) { }
                column(Packing; '') { }// Available On Indent App Item Card
                column(Container_No; '') { }
                column(FCL_Type; '') { }
                column(Batch_No; '') { }
                column(Production_Date; '') { }
                column(Expiry_Date; '') { }
                column(Qty_InCaseORDrum; '') { }
                column(Unit_Price; "Unit Price") { }
                column(Amount; Amount) { }
                column(Line_Discount__; "Line Discount %")// Dis %
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")// Discounted Amount Value in $
                {
                }
                column(Other_Charges; '')// Add or less Other charges
                {
                }
                column(Final_AmtIN_USD; '') { }
                trigger OnPreDataItem()
                begin
                    Sr_No := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    Sr_No += 1;
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

                rec_salesHeader.Reset();
                rec_salesHeader.SetRange("No.", "No.");
                if rec_salesHeader.FindFirst() then begin
                    Var_Precarriage_By := rec_salesHeader."Pre-Carriage By";
                    Var_Precarriage_receipt_By := rec_salesHeader."Pre-Carriage Receipt Place";
                    Var_VessalFlightNo := rec_salesHeader."Vessel / Flight No.";
                    Var_Shippingmarks := rec_salesHeader."Shipping Marks";

                end;
            end;
        }
    }

    /* requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;
                    }
                }
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
     */
    /* rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    } */

    var
        Sr_No: Integer;
        Rec_CompanyInfo: Record "Company Information";
        recLocation: Record Location;
        txtLocation: array[10] of Text[255];
        rec_salesHeader: Record "Sales Header";
        Var_Precarriage_By: Code[10];
        Var_Precarriage_receipt_By: Text[30];
        Var_VessalFlightNo: Text[30];
        Var_Shippingmarks: Text[50];
}