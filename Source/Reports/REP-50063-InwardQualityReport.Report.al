report 50063 "Inward Quality Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InwardQualityReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Quality Header"; "Quality Header")
        {
            // CalcFields = "Document Date";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            column(RepotNo; "QC Analytical Report No.") { }
            column(InvoiceNo; recPurchReceipt."Vendor Shipment No.") { }
            column(TestedBy; "Tested By") { }
            column(LotNo; "Lot No.") { }
            column(Note; 'Note: This is a system generated Reports and needs no signature.') { }
            column(CompanyName; recCompanyInfo.Name) { }
            column(Logo; recCompanyInfo.Picture) { }
            column(Heading; txtHeading) { }
            column(QCNo; "No.") { }
            column(QCDate; FORMAT(Date)) { }
            column(GANNo; "Document No.") { }
            // column(GANDate; FORMAT("Document Date"))
            // {
            // }
            column(ItemCode; "Item Code") { }
            column(ItemName; "Item Name") { }
            column(UOM; recItem."Base Unit of Measure") { }
            column(QuanityReceived; Quantity) { }
            column(ApprovedQuantity; "Approved Quantity") { }
            column(RejectedQuantity; "Rejected Quantity") { }
            column(Remarks; Remarks) { }
            column(VendorName; recPurchReceipt."Buy-from Vendor Name") { }
            column(SampledBy; "Sampled By") { }
            column(VeninvNo; VeninvNo) { }
            column(GANDate; GANDate) { }
            dataitem("Quality Line"; "Quality Line")
            {
                DataItemLink = "QC No." = FIELD("No.");
                DataItemTableView = SORTING("QC No.", "Line No.")
                                    ORDER(Ascending);
                column(Measure; "Quality Measure") { }
                column(Parameter; Parameter) { }
                column(Specs; Specs) { }
                column(Limit; Limit) { }
                column(Observation; Observation) { }
            }

            trigger OnAfterGetRecord()
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                IF "Quality Header".Posted THEN
                    txtHeading := 'Quality Control Analytical Report'
                ELSE
                    txtHeading := 'Test Quality Control Analytical Report';

                IF NOT recPurchReceipt.GET("Quality Header"."Document No.") THEN
                    recPurchReceipt.INIT;

                recItem.GET("Quality Header"."Item Code");

                Clear(GANDate);
                Clear(VeninvNo);
                recPurchReceipt.Reset();//Saurav
                recPurchReceipt.SetRange("No.", "Quality Header"."Document No.");
                if recPurchReceipt.FindFirst() then begin
                    GANDate := recPurchReceipt."Posting Date";
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", recPurchReceipt."Order No.");
                    if PurchaseHeader.FindFirst() then
                        VeninvNo := PurchaseHeader."Vendor Invoice No.";
                end;
                // Message('%1', VeninvNo);
            end;

            trigger OnPreDataItem()
            begin
                recCompanyInfo.GET;
                recCompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        layout { }

        actions { }
    }

    labels { }

    var
        recCompanyInfo: Record "Company Information";
        txtHeading: Text[50];
        recPurchReceipt: Record "Purch. Rcpt. Header";
        recItem: Record Item;
        // "Quality Header": Record "Quality Header";
        // "Quality Line": Record "Quality Line";
        VeninvNo: code[35];
        GANDate: date;
}
