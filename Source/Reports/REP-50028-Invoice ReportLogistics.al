report 50028 "Invoice Report Logistics"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InvoiceReportLogistics.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.") order(ascending);
            column(CompanyInfo; '')
            {

            }
            column(Picture; '')
            {

            }
            column(QR_Code; "QR Code")
            {

            }
            column(Invoice_No; "No.")
            {

            }
            column(Invoice_Date; "Posting Date")
            {

            }
            column(BuyerOrder_No; '')
            {

            }
            column(BuyerOrder_Date; "Order Date")
            {

            }
            column(Payment_Terms; '')
            {

            }
            column(Shipping_Method; '')
            {

            }
            column(Shipping_Agent; '')
            {

            }
            column(GR_No; '')
            {

            }
            column(GR_Date; '')
            {

            }
            column(IRN_No; '')
            {

            }
            column(Email; '')
            {

            }
            column(Home_Page; '')
            {

            }
            column(PAN_No; '')
            {

            }
            column(CIN_N0; '')
            {

            }
            column(FSSAI_NO; '')
            {

            }
            column(State_Code; State)
            {

            }
            //Buyer
            //Consignee
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Item_Code; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Batch_No; '')
                {

                }
                column(PKD; '')
                {

                }
                column(Expiry_Date; '')
                {

                }
                column(Pack_Size; '')
                {

                }
                column(MRP; '')
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Taxable_Amount; '')
                {

                }
                column(GST_Percent; '')
                {

                }
                column(GST_Amount; '')
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
            }
        }
    }

    requestpage
    {
        layout
        {
            /*  area(Content)
             {
                 group(GroupName)
                 {
                     field(Name; SourceExpression)
                     {
                         ApplicationArea = All;

                     }
                 }
             } */
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
    var
        myInt: Integer;
}