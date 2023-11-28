report 50029 "Packing Slip logistic"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PackingSlipLogistic.rdl';
    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            RequestFilterFields = "Document No.";
            column(Order_No; Order_No) { }
            column(Order_Date; Order_Date) { }
            column(Customer_Name; Cust_Name) { }
            column(Customer_Address; Cust_Address) { }
            column(Transporter_Name; '') { }
            column(Vehicle_no; '') { }
            column(Driver_Name; '') { }
            column(Driver_Mob_No; '') { }
            column(Driver_Adhar_No; '') { }
            column(Loading_StartTime; '') { }
            column(Loading_EndTime; '') { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Location_Code; "Location Code") { }
            column(Stock_In_Hand; '') { }
            column(MRP; '') { }
            column(Batch_No; Batch_No) { }
            column(MFG; '') { }
            column(Expiry; Expiry) { }
            column(Quantity; Quantity) { }
            column(Gross_Weight_KG; "Gross Weight") { }
            column(Quantity_Loaded; '') { }
            trigger OnAfterGetRecord()
            begin
                Rec_SalesHeader.Reset();
                Rec_SalesHeader.SetRange("No.", "Document No.");
                if Rec_SalesHeader.FindFirst() then begin
                    Order_No := Rec_SalesHeader."No.";
                    Order_Date := Rec_SalesHeader."Order Date";
                    Cust_Name := Rec_SalesHeader."Sell-to Customer Name";
                    Cust_Address := Rec_SalesHeader."Sell-to Address";
                end;

                Rec_ItemTrackingList.Reset();
                Rec_ItemTrackingList.SetRange("Item No.", "Document No.");
                Rec_ItemTrackingList.SetRange("Location Code", "Location Code");
                Rec_ItemTrackingList.SetRange("Source Type", 37);
                if Rec_ItemTrackingList.FindFirst() then begin
                    Batch_No := Rec_ItemTrackingList."Lot No.";
                    Expiry := Rec_ItemTrackingList."Expiration Date";
                end;
            end;
        }
    }

    var
        Rec_SalesHeader: Record "Sales Header";
        Order_No: Code[20];
        Order_Date: Date;
        Cust_Name: Text[100];
        Cust_Address: Text[100];
        Rec_ItemTrackingList: Record "Tracking Specification";
        Batch_No: Code[50];
        Expiry: Date;
}