report 50027 "Return Vehicle"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = '.\ReportLayouts\ReturnVehicle.rdl';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            column(DealNoLbl; DealNoLbl) { }
            column(SLbl; SLbl) { }
            column(ReturnMonthLbl; ReturnMonthLbl) { }
            column(ArrivalDateLbl; ArrivalDateLbl) { }
            column(GateEntryLbl; GateEntryLbl) { }
            column(GateDtLbl; GateDtLbl) { }
            column(UnloadingDtLbl; UnloadingDtLbl) { }
            column(VehicleNoLbl; VehicleNoLbl) { }
            column(PartyNameLbl; PartyNameLbl) { }
            column(BillNoLbl; BillNoLbl) { }
            column(BillDateLbl; BillDateLbl) { }
            column(LotNoLbl; LotNoLbl) { }
            column(DealRateLbl; DealRateLbl) { }
            column(NoTinsLbl; NoTinsLbl) { }
            column(NoBucketsLbl; NoBucketsLbl) { }
            column(NoCainsLbl; NoCainsLbl) { }
            column(NoDrumsLbl; NoDrumsLbl) { }
            column(TotalUnitsLbl; TotalUnitsLbl) { }
            column(UnitLbl; UnitLbl) { }
            column(FactoryNetWtLbl; FactoryNetWtLbl) { }
            column(FactoryGrossLbl; FactoryGrossLbl) { }
            column(FactoryTareLbl; FactoryTareLbl) { }
            column(InveNetWtLbl; InveNetWtLbl) { }
            column(ShortageExcessLbl; ShortageExcessLbl) { }
            column(ExtraDiscountLbl; ExtraDiscountLbl) { }
            column(FinalWtLbl; FinalWtLbl) { }
            column(AmtAsPerbillLbl; AmtAsPerbillLbl) { }
            column(StateLbl; StateLbl) { }
            column(LoadedFromLbl; LoadedFromLbl) { }
            column(AmountLbl; AmountLbl) { }
            column(CSTLbl; CSTLbl) { }
            column(OthersChargesLbl; OthersChargesLbl) { }
            column(TransporterNameLbl; TransporterNameLbl) { }
            column(GRNolbl; GRNolbl) { }
            column(GrDateLbl; GrDateLbl) { }
            column(TFreightLbl; TFreightLbl) { }
            column(AdvFreightLbl; AdvFreightLbl) { }
            column(BalFreightLbl; BalFreightLbl) { }
            column(GANNoLbl; GANNoLbl) { }
            column(PONumberLbl; PONumberLbl) { }
            column(DebitNoteNoLbl; DebitNoteNoLbl) { }
            column(DebitNoteDateLbl; DebitNoteDateLbl) { }
            column(TransportNameLbl; TransportNameLbl) { }
            column(GrNumberLbl; GrNumberLbl) { }
            column(SendLotNoLbl; SendLotNoLbl) { }
            column(QtyInkgLbl; QtyInkgLbl) { }


            column(No_DataItemName; "No.")
            {
            }
        }
    }



    var
        DealNoLbl: Label 'Deal No.';
        SLbl: Label 'S#';
        ReturnMonthLbl: Label 'Return Month';
        ArrivalDateLbl: Label 'Arrival Date';
        GateEntryLbl: Label 'Gate Entry';
        GateDtLbl: Label 'Gate Dt';
        UnloadingDtLbl: Label 'Unloading Dt.';
        VehicleNoLbl: Label 'Vehicle No.';
        PartyNameLbl: Label 'Party Name';
        BillNoLbl: Label 'Bill No.';
        BillDateLbl: Label 'Bill Date';
        LotNoLbl: Label 'Lot No.';
        DealRateLbl: Label 'Deal Rate';
        NoTinsLbl: Label 'No. Tins';
        NoBucketsLbl: Label 'No. Buckets';
        NoCainsLbl: Label 'No. Cains';
        NoDrumsLbl: Label 'No. Drums';
        TotalUnitsLbl: Label 'Total Units';
        UnitLbl: Label 'Unit';
        FactoryNetWtLbl: Label 'Factory Net Wt';
        FactoryTareLbl: Label 'Factory Tare';
        FactoryGrossLbl: Label 'Factory Gross';
        InveNetWtLbl: Label 'Inv. Net Wt';
        ShortageExcessLbl: Label 'Shortage/ Excess';
        FinalWtLbl: Label 'Final Weight';
        AmtAsPerbillLbl: Label 'Amt. as per bill';
        StateLbl: Label 'State';
        LoadedFromLbl: Label 'Loaded from';
        AmountLbl: Label 'Amount';
        ExtraDiscountLbl: Label 'Extra/Discount';
        CSTLbl: Label 'CST@2%';
        OthersChargesLbl: Label 'Other Charges(+ -)';
        TransporterNameLbl: Label 'Transporter Name';
        GRNolbl: Label 'GR No.';
        GrDateLbl: Label 'GR Date';
        TFreightLbl: Label 'T Freight';
        AdvFreightLbl: Label 'Adv. Freight';
        BalFreightLbl: Label 'Bal. Freight';
        GANNoLbl: Label 'GAN No.';
        PONumberLbl: Label 'PO Nomber';
        DebitNoteNoLbl: Label 'Debit Note No.';
        DebitNoteDateLbl: Label 'Debit Note Date';
        TransportNameLbl: Label 'Transporter Name';
        GrNumberLbl: Label 'GR Number';
        SendLotNoLbl: Label 'Send Lot No.';
        QtyInkgLbl: Label 'Qty in Kg.';
}