report 50031 "Sales Scheme Exp"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesSchemeExp.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Customer_Code; "Sell-to Customer No.") { }
            column(Customer_Firm_Name; "Sell-to Customer Name") { }
            column(Cstomer_Location; "Sell-to Address" + ',' + "Sell-to Address 2") { }
            column(Customer_District; "Sell-to City") { }
            column(Customer_State; State) { }
            column(Customer_Region; "Sell-to Country/Region Code") { }
            column(Customer_Area; "Sell-to Post Code") { }
            column(ASM; ASM) { }// 13 no table
            column(RSM; RSM) { }
            column(Month; '') { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = sorting("Document No.", "Line No.");

                column(Total_Invoice_Value; Amount + Total_GSTAmount) { }
                column(GST_Base_Amount; Amount) { }
                column(Scheme_Discount_Amt; "Line Discount Amount") { }
                trigger OnAfterGetRecord()
                begin
                    Clear(CAmount);
                    Clear(CAmount1);
                    Clear(IAmount);
                    Clear(IAmount1);
                    Clear(SAmount);
                    Clear(SAmount1);

                    DetailedGSTLedgerEntry.RESET;
                    DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SETRANGE("No.", "No.");
                    DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                    IF DetailedGSTLedgerEntry.FindSet() THEN
                        REPEAT
                            IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                CAmount := DetailedGSTLedgerEntry."GST Amount";
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                SAmount := DetailedGSTLedgerEntry."GST Amount";
                                SAmount1 += SAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                IAmount := DetailedGSTLedgerEntry."GST Amount";
                                IAmount1 += IAmount;
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                    Clear(Total_GSTAmount);
                    Total_GSTAmount := CAmount1 + SAmount1 + IAmount1;
                end;
            }
        }
    }

    requestpage
    {
        layout { }

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
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        Total_GSTAmount: Decimal;
        CAmount: Decimal;
        CAmount1: Decimal;
        SAmount: Decimal;
        SAmount1: Decimal;
        IAmount: Decimal;
        IAmount1: Decimal;
}