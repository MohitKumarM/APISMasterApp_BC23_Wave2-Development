report 50018 "APIS COA"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Quality Header"; "Quality Header")
        {
            DataItemTableView = sorting("No.");
            column(SAMPLED_BY; "Sampled By") { }
            column(TESTED_BY; "Tested By") { }
            column(BATCH_NO; "Lot No.") { }
            column(PRODUCT; '') { }
            column(BATCH_QTY; Quantity) { }
            column(MFG_DATE; '') { }
            column(EXPIRY_DATE; '') { }
            column(Picture; ComInfor_Rec.Picture) { }
            dataitem("Quality Line"; "Quality Line")
            {
                DataItemLink = "QC No." = field("No.");
                column(SR_NO; SrNO) { }
                column(QC_NO; "QC No.") { }
                column(PARAMETERS; Parameter) { }
                column(UNIT; '') { }
                column(SPECIFICATION; Specs) { }
                column(OBSERVATIONS; Observation) { }

                trigger OnAfterGetRecord()
                begin
                    SrNO += 1;
                end;
            }
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
            LayoutFile = '.\ReportLayouts\APISCOA.rdl';
        }
    }
    trigger OnPreReport()
    begin
        ComInfor_Rec.get;
        ComInfor_Rec.CalcFields(Picture);
    end;

    var
        SrNO: Integer;
        ComInfor_Rec: Record "Company Information";
}