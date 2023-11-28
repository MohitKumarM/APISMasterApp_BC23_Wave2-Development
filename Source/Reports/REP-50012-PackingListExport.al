report 50012 "Packing List Export"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\Reportlayouts\packingListExport.rdl';

    dataset
    {
        dataitem("Posted Packing List"; "Posted Packing List")
        {
            column(Item_Code; "Item Code") { }
            column(Packing_Size; "Packing Size") { }
            column(Packing; Packing) { }
            column(Container_No_; "Container No.") { }
            column(FCL_Type; "FCL Type") { }
            column(Batch_No_; "Batch No.") { }
            column(Prod__Date; "Prod. Date") { }
            column(Expiry_Date; "Expiry Date") { }
            column(Cartoons_Serial_No_; "Cartoons Serial No.") { }
            column(Pallet_Serial_No_; "Pallet Serial No.") { }
            column(Pallet_Qty; "No. of Pallets") { }
            column(Quantity_InCaseOF_Drum; "Quantity In Case Of Drum") { }
            column(Per_Pallet_weight; "Per Pallet Weight") { }
            column(Total_Pallet_Weight; "Total Pallet Weight Kg") { }
            column(Net_WeightKG; "Net Weight In Kg") { }
            column(Tare_Weight; "Tare Weight") { }
            column(Gross_WeightInKG; "Gross Weight In Kg") { }
        }
    }
}