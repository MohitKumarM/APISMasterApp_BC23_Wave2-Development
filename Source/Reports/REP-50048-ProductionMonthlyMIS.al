report 50048 "Production Monthly MIS"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = where("Item No." = filter('I3''I4'), "Entry Type" = filter(output));
            column(Document_No_; "Document No.") { }
            column(Production_Type; '') { }
            column(Month; '') { }
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
            LayoutFile = '.\ReportLayouts\MonthlyMIS.rdl';
        }
    }
}