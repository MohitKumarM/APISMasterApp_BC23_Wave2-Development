report 50017 "RM COA"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Quality Header"; "Quality Header")
        {
            DataItemTableView = sorting("No.");
            column(FMT_NO; '') { }
            column(QC_Report_No; "QC Analytical Report No.") { }
            column(Item_No; "Item Code") { }
            column(Unit_of_Measure; '') { }
            column(Received_Quantity; '') { }
            column(Vendor_Name; '') { }
            column(Invoice_Number; '') { }
            column(QC_Date; '') { }
            column(Item_Name; "Item Name") { }
            column(Remarks; Remarks) { }
            column(Sampled_By; "Sampled By") { }
            column(Tested_By; "Tested By") { }
            column(Lot_No; "Lot No.") { }
            column(Picture; ComInfor_Rec.Picture) { }
            dataitem("Quality Line"; "Quality Line")
            {
                DataItemLink = "QC No." = field("No.");

                column(PARAMETER; Parameter) { }
                column(SPECIFICATION; Specs) { }
                column(LIMIT; Limit) { }
                column(OBSERVATION; Observation) { }
            }
            trigger OnPreDataItem()
            begin
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; '')
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
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = '.\ReportLayouts\RMCOA.rdl';
        }
    }
    trigger OnPreReport()
    begin
        ComInfor_Rec.get;
        ComInfor_Rec.CalcFields(Picture);
    end;

    var
        ComInfor_Rec: Record "Company Information";
}