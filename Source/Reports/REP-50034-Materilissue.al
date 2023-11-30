report 50034 "Material Issue"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(Date; "Posting Date") { }
            column(Item_Code; "Item Category Code") { }
            column(Description; Description) { }
            column(Location_Code; "Location Code") { }
            column(New_Location_Code; '') { }
            column(Required_qty; '') { }
            column(Issued_Qty; '') { }
            column(Unit_of_Measure_Code; "Unit of Measure Code") { }
            column(Order_No; '') { }
            column(Order_Date; '') { }
            column(Batch_No; "Lot No.") { }
            column(Sale_Order_N; '') { }
            column(Order_qty; '') { }
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
            LayoutFile = '.\ReportLayouts\MaterialIssue.rdl';
        }
    }

    var
        myInt: Integer;
}