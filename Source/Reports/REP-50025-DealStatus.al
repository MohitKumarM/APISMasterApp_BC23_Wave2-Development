report 50025 "Deal Status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = '.\ReportLayouts\DealStatus.rdl';

    dataset
    {
        dataitem("Deal Master"; "Deal Master")
        {
            RequestFilterFields = "No.";
            column(SrNoLbl; SrNoLbl) { }
            column(DealRateLbl; DealRateLbl) { }
            column(DealQtyLbl; DealQtyLbl) { }

            column(CurrentStausLbl; CurrentStausLbl) { }
            column(BalNetWtLbl; BalNetWtLbl) { }
            column(BalQtyLbl; BalQtyLbl) { }
            column(DateLbl; DateLbl) { }
            column(DealFloralbl; DealFloralbl) { }
            column(DealNoLbl; DealNoLbl) { }
            column(DealNetWtlbl; DealNetWtlbl) { }
            column(RecQtyLbl; RecQtyLbl) { }
            column(RecNetWtLbl; RecNetWtLbl) { }
            column(SupplierLbl; SupplierLbl) { }
            column(Date_DealMaster; "Date") { }
            column(DealQty_DealMaster; "Deal Qty.") { }
            column(DispatchedQty_DealMaster; "Dispatched Qty.") { }
            column(DispatchedQtyKg_DealMaster; "Dispatched Qty. (Kg.)") { }
            column(Flora_DealMaster; Flora) { }
            column(PerUnitQtyKg_DealMaster; "Per Unit Qty. (Kg.)") { }
            column(PurchaserName_DealMaster; "Purchaser Name") { }
            column(Status_DealMaster; Status) { }
            column(SrNo; SrNo) { }
            column(UnitRateinKg_DealMaster; "Unit Rate in Kg.") { }
            column(No_; "No.") { }
            column(Deal_Qty_; "Deal Qty.") { }
            column(ReamainigQty; ReamainigQty) { }
            column(DealNetWt; DealNetWt) { }
            column(BalanceNetWt; BalanceNetWt) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SrNo := 0;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ReamainigQty := 0;
                ReamainigQty := ("Deal Qty." - "Dispatched Qty.");
                DealNetWt := 0;
                DealNetWt := ("Deal Qty." * "Per Unit Qty. (Kg.)");
                BalanceNetWt := 0;
                BalanceNetWt := (DealNetWt - "Dispatched Qty. (Kg.)");

                SrNo := SrNo + 1;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName) { }
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



    var
        SrNo: Integer;
        ReamainigQty: Decimal;
        DealNetWt: Decimal;
        BalanceNetWt: Decimal;
        SrNoLbl: Label 'Sr. No.';
        DealNoLbl: Label 'Deal No.';

        DateLbl: Label 'Date';
        SupplierLbl: Label 'Supplier';
        DealFloralbl: Label 'Deal Flora';

        DealRateLbl: Label 'Deal Rate';
        DealQtyLbl: Label 'Deal Qty. (Nos.)';
        RecQtyLbl: Label 'Rec. Qty. (Nos.)';
        BalQtyLbl: Label 'Bal. Qty. (Nos.)';
        CurrentStausLbl: Label 'Current Status';
        DealNetWtlbl: Label 'Deal Net Wt.';
        RecNetWtLbl: Label 'Rec. Net Wt.';
        BalNetWtLbl: Label 'Bal. Net Wt.';

}