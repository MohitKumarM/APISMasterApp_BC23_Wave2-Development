report 50015 "PM Stock Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where(Positive = const(true));
            column(Item_Category_Code; "Item Category Code") { }
            column(Description; Description) { }
            column(Product_Group_Code; '') { }
            column(Unit_of_Measure_Code; "Unit of Measure Code") { }
            column(Location_Code_RRKST; "Location Code") { }
            column(Total; TotalQty) { }
            column(Last_used_date; "Posting Date") { }
            column(Lot_No_; "Lot No.") { }
            column(Ageing; TotalDay) { }
            column(Receiving_Date; RecDate) { }
            column(Remaining_Quantity; "Remaining Quantity") { }
            column(Item_No_; "Item No.") { }
            column(AsOnDate; AsOnDate) { }

            trigger OnAfterGetRecord()
            begin
                Clear(RecDate);
                ILE_Rec1.Reset();
                ILE_Rec1.SetCurrentKey("Posting Date");
                ILE_Rec1.SetRange("Item No.", "Item No.");
                if ILE_Rec1.FindFirst() then
                    RecDate := ILE_Rec1."Posting Date";

                if "Posting Date" < AsOnDate then begin
                    Date_Rec.SETRANGE("Period Type", Date_Rec."Period Type"::Date);
                    Date_Rec.SETRANGE("Period Start", RecDate, AsOnDate);
                    Date_Rec.SETFILTER("Period No.", '%1..%2', 1, 7);
                    TotalDay := Date_Rec.COUNT
                end else begin
                    Date_Rec.SETRANGE("Period Type", Date_Rec."Period Type"::Date);
                    Date_Rec.SETRANGE("Period Start", AsOnDate, RecDate);
                    Date_Rec.SETFILTER("Period No.", '%1..%2', 1, 7);
                    TotalDay := Date_Rec.COUNT;
                end;
            end;

            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SetFilter("Posting Date", '%1..%2', 0D, AsOnDate);
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
                    field(AsOnDate; AsOnDate)
                    {
                        Caption = 'As On Date';
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
            LayoutFile = '.\ReportLayouts\PMStockSheet.rdl';
        }
    }

    var
        AsOnDate: Date;
        TotalDay: Integer;
        TotalQty: Decimal;
        Date_Rec: Record Date;
        RecDate: Date;
        ILE_Rec1: Record "Item Ledger Entry";
}