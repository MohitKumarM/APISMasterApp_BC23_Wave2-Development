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
            column(Shipper_Name; '') { }
            column(Shipper_Address; '') { }
            column(Sale_Order_no; "Order No.") { }
            column(Invoice_No; "No.") { }
            column(Invoice_Date; "Posting Date") { }
            column(Consignee_Name; "Ship-to Name") { }
            column(Consignee_Address; "Ship-to Address" + "Ship-to Address 2") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address" + "Bill-to Address 2") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Buyer_Order_No; '') { }
            column(Payment_Terms; '') { }
            column(Incoterm; '') { }
            column(Documentary_Credit_No; '') { }
            column(Precarriage_By; '') { }
            column(Precarriage_receipt_By; '') { }
            column(VesselName_Flight_No; '') { }
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
}