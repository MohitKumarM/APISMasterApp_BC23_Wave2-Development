report 50036 "FG Stock"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Item; 27)
        {
            column(Unit_Depot_Code; '') { }
            column(Depot_Name; '') { }
            column(Brand; '') { }
            column(Sub_Brand; '') { }
            column(Item_Code_FG_Code; "No.") { }
            column(Item_Description; Description) { }
            column(Pack_Size_SKU; '') { }
            column(Packaging_Type; '') { }
            column(Item_Category; "Item Category Code") { }
            column(Item_Variant; '') { }
            column(UOM; "Base Unit of Measure") { }
            column(Sales_Channel; '') { }
            column(FG_Stock_Qnty_nos; '') { }
            column(Stock_Status; '') { }
            column(Intransit_Qnty; '') { }
            column(PKD; '') { }
            column(USE_By; '') { }
            column(MRP; '') { }
            column(Batch_No; '') { }
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
            LayoutFile = '.\ReportLayouts\FGStock.rdl';
        }
    }
}