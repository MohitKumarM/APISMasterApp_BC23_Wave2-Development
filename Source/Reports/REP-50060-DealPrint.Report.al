report 50060 "Deal Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DealPriint.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Deal Master"; "Deal Master")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            // RequestFilterFields = "No.";
            column(ImagePath; 'file:///E:/Documents/Image/APIS.bmp') { }
            column(CompanyLogo; recCompanyInfo.Picture) { }
            column(RegOffAddress; recCompanyInfo.Address) { }
            column(STD_Code_; recCompanyInfo."STD Code") { }
            column(RegOffAddress1; recCompanyInfo."Address 2") { }
            column(RegOffCity; recCompanyInfo.City) { }
            column(RegOffPostCode; recCompanyInfo."Post Code") { }
            column(RegOddPhone; recCompanyInfo."Phone No.") { }
            column(RegOffState; txtRegOffStateName) { }
            column(RegOffCountry; txtRegOffCountryName) { }
            column(RegOffContact; recCompanyInfo."Name 2") { }
            column(CompanyName; recCompanyInfo.Name) { }
            column(CompanyAddress; recLocation.Address) { }
            column(CompanyAddress2; recLocation."Address 2") { }
            column(CompanyCity; recLocation.City) { }
            column(CompanyPostCode; recLocation."Post Code") { }
            column(CompanyState; txtLocationState) { }
            column(CompanyCountry; txtLocationCountry) { }
            column(LocationPhone; recLocation."Phone No.") { }
            column(LocationContact; recLocation.Contact) { }
            column(PurchOrderNo; "No.") { }
            column(PurchaseOrderDate; FORMAT(Date)) { }
            column(VendorName; recVendor.Name) { }
            column(VendorCountry; txtVendorCountry) { }
            column(ShipToCountry; txtShipToCountry) { }
            column(VendorTIN; '') { }
            column(VendorCST; '') { }
            column(BuyerTIN; recLocation."GST Registration No.") { }
            column(CompanyPANNo; recCompanyInfo."P.A.N. No.") { }
            column(CompanyEmail; recCompanyInfo."E-Mail") { }
            column(RefText; '') { }
            column(Term2; 'All disputes subject to Delhi Jurisdiction.') { }
            column(Term3; '1. Mention Deal No. on invoice/Bill.') { }
            column(Term4; '2. Send dispatch information by mail on Kamaljeet@apisindia.com') { }
            column(SpecialTerm; "Special Instruction") { }
            column(Term5; "Quality Instruction 1") { }
            column(Term6; "Quality Instruction 2") { }
            column(Term7; "Quality Instruction 3") { }
            column(Term8; "Quality Instruction 4") { }
            column(Term9; "Quality Instruction 5") { }
            column(Term10; "Quality Instruction 6") { }
            column(TotalTaxAmount; decTotalLineAmount) { }
            column(TotalLineAmount; decTotalLineValue) { }
            column(ItemCode; "Item Code") { }
            column(ItemDescription; recItem.Description) { }
            column(Flora; Flora) { }
            column(ItemQty; "Deal Qty.") { }
            column(Packing; "Packing Type") { }
            column(ItemRate; "Unit Rate in Kg.") { }
            column(ItemValue; decTotalLineAmount) { }
            column(TotalQty; "Deal Qty." * "Per Unit Qty. (Kg.)") { }
            column(PaymentTerm; "Payment Terms") { }
            column(DispatchSchedule; "Dispatch Schedule") { }
            column(FreightTerm; 'Freight will be paid by ' + FORMAT("Freight Liability")) { }
            column(TaxTerms; txtTaxRate) { }
            column(AmountInWord1; NumberText[1]) { }
            column(AmountInWord2; NumberText[2]) { }

            trigger OnAfterGetRecord()
            begin
                PurchSetup.GET;
                /*
                IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                  CalcInvDiscForHeader;
                  COMMIT;
                END;

                IF "Purchase Header".Structure <> '' THEN BEGIN
                  PurchLine.CalculateStructures("Purchase Header");
                  PurchLine.AdjustStructureAmounts("Purchase Header");
                  PurchLine.UpdatePurchLines("Purchase Header");
                  PurchLine.CalculateTDS("Purchase Header");
                END ELSE
                  PurchLine.CalculateTDS("Purchase Header");
                COMMIT;
                */

                IF NOT recPaymentTerms.GET("Deal Master"."Payment Terms Code") THEN
                    recPaymentTerms.INIT;

                txtTaxRate := '';
                recItem.GET("Deal Master"."Item Code");
                IF recItem."Tax Group Code" <> '' THEN BEGIN
                    recTaxJurisdiction.RESET;
                    recTaxJurisdiction.SETRANGE(Type, recTaxJurisdiction.Type::IGST);
                    recTaxJurisdiction.FINDFIRST;
                    recTaxDetails.RESET;
                    recTaxDetails.SETRANGE("Tax Group Code", recItem."Tax Group Code");
                    recTaxDetails.SETRANGE("Tax Jurisdiction Code", recTaxJurisdiction.Code);
                    recTaxDetails.SETRANGE("Effective Date", 0D, "Deal Master".Date);
                    IF recTaxDetails.FINDLAST THEN
                        txtTaxRate := 'GST @ ' + FORMAT(recTaxDetails."Tax Below Maximum") + ' %'
                    ELSE
                        txtTaxRate := 'Tax Free';
                END ELSE
                    txtTaxRate := 'Tax Free';

                x := 0;
                IF "Deal Master"."Quality Instruction 1" <> '' THEN BEGIN
                    x += 1;
                    txtQualityInstruction[x] := FORMAT(x) + '. ' + "Deal Master"."Quality Instruction 1";
                END;
                IF "Deal Master"."Quality Instruction 2" <> '' THEN BEGIN
                    x += 1;
                    txtQualityInstruction[x] := FORMAT(x) + '. ' + "Deal Master"."Quality Instruction 2";
                END;
                IF "Deal Master"."Quality Instruction 3" <> '' THEN BEGIN
                    x += 1;
                    txtQualityInstruction[x] := FORMAT(x) + '. ' + "Deal Master"."Quality Instruction 3";
                END;
                IF "Deal Master"."Quality Instruction 4" <> '' THEN BEGIN
                    x += 1;
                    txtQualityInstruction[x] := FORMAT(x) + '. ' + "Deal Master"."Quality Instruction 4";
                END;
                IF "Deal Master"."Quality Instruction 5" <> '' THEN BEGIN
                    x += 1;
                    txtQualityInstruction[x] := FORMAT(x) + '. ' + "Deal Master"."Quality Instruction 5";
                END;
                IF "Deal Master"."Quality Instruction 6" <> '' THEN BEGIN
                    x += 1;
                    txtQualityInstruction[x] := FORMAT(x) + '. ' + "Deal Master"."Quality Instruction 6";
                END;

                IF "Deal Master"."Special Instruction" <> '' THEN
                    txtQualityInstruction[7] := '3. ' + "Deal Master"."Special Instruction";

                recCompanyInfo.GET;
                recCompanyInfo.CALCFIELDS(Picture);
                recVendor.GET("Deal Master"."Purchaser Code");
                recLocation.GET('RRK-QC');

                txtCompanyCountry := '';
                IF recCountry.GET(recCompanyInfo."Country/Region Code") THEN
                    txtCompanyCountry := recCountry.Name;

                txtLocationState := '';
                IF recState.GET(recLocation."State Code") THEN
                    txtLocationState := recState.Description;

                txtLocationCountry := '';
                IF recCountry.GET(recLocation."Country/Region Code") THEN
                    txtLocationCountry := recCountry.Name;

                decTotalLineAmount := "Deal Master"."Deal Qty." * "Deal Master"."Per Unit Qty. (Kg.)" * "Deal Master"."Unit Rate in Kg.";

                rptCheque.InitTextVariable;
                rptCheque.FormatNoText(NumberText, ROUND(decTotalLineAmount, 0.01), '');
            end;

            trigger OnPreDataItem()
            begin
                txtQualityInstruction[1] := '1.Vehicles rejected on Sucrose, TRS will be returned to you.';
                txtQualityInstruction[2] := '2. C4 up to 7% is accepted.';
                txtQualityInstruction[3] := '3. C4 more than 7% but less or equal to 20% is acceptable subject to 1% rate deduction in each percentage beyond 7%. (for example, if C4 reported 10%, rate will be cut by 3%)';
                txtQualityInstruction[4] := '4. C4 more than 20%, vehicle will be returned to you and no negotiation will be accepted.';
                txtQualityInstruction[5] := '5. Vehicle should come alongwith trip sheet.';
                txtQualityInstruction[6] := '6. Report of C4 will be provided to you within 15 days after arrival of the vehicle. If report is not given to you within 15 days, your vehicle will be accepted irrespective of the result of C4.';
                CLEAR(txtQualityInstruction);
            end;
        }
    }

    requestpage
    {
        layout { }

        actions { }
    }

    labels { }

    var
        rptCheque: Report "Check Report";
        recCompanyInfo: Record "Company Information";
        recCountry: Record "Country/Region";
        txtCompanyCountry: Text[50];
        txtVendorCountry: Text[50];
        txtShipToCountry: Text[50];
        recVendor: Record "Salesperson/Purchaser";
        recLocation: Record Location;
        recPaymentTerms: Record "Payment Terms";
        decTotalLineAmount: Decimal;
        // rptCheque: Report 1401;
        NumberText: array[2] of Text[80];
        // recStructureLines: Record 13794;
        decTotalLineValue: Decimal;
        txtRegOffStateName: Text[50];
        txtRegOffCountryName: Text[50];
        recItem: Record Item;
        txtLocationState: Text[50];
        txtLocationCountry: Text[50];
        recState: Record State;
        PurchSetup: Record "Purchases & Payables Setup";
        txtQualityInstruction: array[10] of Text[250];
        x: Integer;
        txtTaxRate: Text;
        recTaxJurisdiction: Record "Tax Jurisdiction";
        recTaxDetails: Record "Tax Detail";
    // "Deal Master": Record "Deal Master";
}
