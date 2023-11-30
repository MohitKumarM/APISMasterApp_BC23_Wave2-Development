report 50035 "Sales Report Dispatch"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Customer_Name; "Bill-to Name") { }
            column(Custmer_Price_Group_Sales_Channel; "Customer Price Group") { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");
                column(Zone; '') { }//We have to create
                column(Region; '') { }//We have to create
                column(State; '') { }//We have to create
                column(Area_; '') { }//We have to create
                column(Invoice_Date; "Posting Date") { }
                column(Month; ConvertDate("Posting Date")) { }
                column(Invoice_No; "No.") { }
                column(Customer_Code; '') { }
                column(Customer_Type; '') { }//We have to create
                column(Customer_Location; "Location Code") { }
                column(Customer_District; '') { }//We have to create

                column(ZSM; '') { }//We have to create
                column(ZSM_RSM; '') { }//We have to create
                column(ASM_KAM; '') { }//We have to create
                column(SO; '') { }
                column(SR; '') { }
                column(Billing_Location; '') { }
                column(Transaction_Type; '') { }//Need to create new field
                column(Brand; '') { }//Need to create new field
                column(Sub_brand; '') { }//Need to create new field
                column(Item_Code_FG_Code; "No.") { }
                column(Item_Description; Description) { }
                column(Pack_Size_SKU; '') { }/////Need to create new field
                column(Packaging_Type; '') { }/////Need to create new field
                column(Item_Category; "Item Category Code") { }
                column(Item_Variant; '') { }/////Need to create new field
                column(UOM; "Unit of Measure") { }
                column(Unit_Net_Weight_kg; '') { }
                column(Total_Sale_Quantity_nos; Quantity) { }//Layout Sum
                column(Total_Net_Weight_kg; "Net Weight") { }
                column(Unit_Rate; "Unit Price") { }
                column(Line_Scheme_Discount_Per; "Line Discount %") { }
                column(Line_Scheme_Discount_Amount; "Line Discount Amount") { }
                column(Line_Sale_Amount; "Line Amount") { }
                column(HSN; "HSN/SAC Code") { }
                column(GST_Per; Gstper) { }
                column(Tax_Amount; GetTotalGSTAmtPostedLine("Document No.", "Line No.")) { }
                column(Invoice_Line_Amount; Abs(GSTBaseAmt) + GetTotalGSTAmtPostedLine("Document No.", "Line No.")) { }
                column(Batch_No; BatchNo) { }
                column(MFG; MFG) { }
                column(Expiry; Expiry) { }
                column(MRP; MRP) { }

                trigger OnAfterGetRecord()
                var

                begin
                    Item_Rec.Reset();
                    Item_Rec.SetRange("No.", "Sales Invoice Line"."No.");
                    if Item_Rec.FindFirst() then;

                    Clear(BatchNo);
                    Clear(MFG);
                    Clear(Expiry);
                    Clear(MRP);
                    ILE_Rec.Reset();
                    ILE_Rec.SetRange("Document No.", "Document No.");
                    if ILE_Rec.FindSet() then begin
                        repeat
                            BatchNo := ILE_Rec."Lot No.";
                            // MFG := ILE_Rec."MFG. Date";
                            // MRP := ILE_Rec."MRP Price";
                            Expiry := ILE_Rec."Expiration Date";
                        until ILE_Rec.Next() = 0;
                    end;

                    Clear(TotalInvoiceAmt);
                    Clear(GSTBaseAmt);
                    Clear(Gstper);
                    DetGstLedEntry_Rec.RESET();
                    DetGstLedEntry_Rec.SETRANGE("Document No.", "Document No.");
                    DetGstLedEntry_Rec.SetRange("Document Line No.", "Line No.");
                    IF DetGstLedEntry_Rec.FindSet() THEN begin
                        repeat
                            if DetGstLedEntry_Rec."GST Component Code" = 'IGST' then begin
                                GSTBaseAmt := DetGstLedEntry_Rec."GST Base Amount";
                                Gstper := DetGstLedEntry_Rec."GST %";
                            end;
                            if DetGstLedEntry_Rec."GST Component Code" = 'SGST' then begin
                                GSTBaseAmt := DetGstLedEntry_Rec."GST Base Amount";
                                Gstper := DetGstLedEntry_Rec."GST %" * 2;
                            end;
                            if DetGstLedEntry_Rec."GST Component Code" = 'SGST' then
                                GSTBaseAmt := DetGstLedEntry_Rec."GST Base Amount";
                        //Gstper := DetGstLedEntry_Rec."GST %";
                        until DetGstLedEntry_Rec.Next() = 0;
                    end;

                end;
            }
            trigger OnAfterGetRecord()
            begin
                Customer_Rec.Reset();
                Customer_Rec.SetRange("No.", "Sell-to Customer No.");
                if Customer_Rec.FindFirst() then;
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
            LayoutFile = '.\ReportLayouts\SalesReportDispatch.rdl';
        }
    }

    procedure GetTotalGSTAmtPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        IF DetGstLedEntry.FindSet() THEN begin
            repeat
                if DetGstLedEntry."GST Component Code" = 'IGST' then
                    IGSTAmt := abs(DetGstLedEntry."GST Amount");

                if DetGstLedEntry."GST Component Code" = 'SGST' then
                    SGSTAmt := abs(DetGstLedEntry."GST Amount");

                if DetGstLedEntry."GST Component Code" = 'CGST' then
                    CGSTAmt := abs(DetGstLedEntry."GST Amount");

            until DetGstLedEntry.Next() = 0;
        end;

        Clear(TotalAmt);
        TotalAmt := IGSTAmt + SGSTAmt + CGSTAmt;
        EXIT(ABS(TotalAmt));
    end;

    procedure ConvertDate(DateP: Date): Text
    var
        MonthTxt: Text;
        Month: Text;
        Year: Integer;
        Day: Integer;
    begin
        Day := DATE2DMY(DateP, 2);
        /*  MonthTxt := COPYSTR(DateP, 4, 3);
         EVALUATE(Day, COPYSTR(DateP, 1, 2));
         EVALUATE(Year, COPYSTR(DateP, 8, 4)); */
        CASE Day OF
            1:
                Month := 'Jan';
            2:
                Month := 'Feb';
            3:
                Month := 'Mar';
            4:
                Month := 'Apr';
            5:
                Month := 'May';
            6:
                Month := 'Jun';
            7:
                Month := 'Jul';
            8:
                Month := 'Aug';
            9:
                Month := 'Sep';
            10:
                Month := 'Oct';
            11:
                Month := 'Nov';
            12:
                Month := 'Dec';
        END;
        EXIT(Month);
    end;


    var
        BatchNo: Code[50];
        MFG: Date;
        Expiry: Date;
        MRP: Decimal;
        GSTBaseAmt: Decimal;
        Gstper: Decimal;
        Customer_Rec: Record Customer;
        Item_Rec: Record Item;
        DetGstLedEntry_Rec: Record 18001;
        TotalInvoiceAmt: Decimal;
        ILE_Rec: Record "Item Ledger Entry";
}