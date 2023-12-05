report 50030 "Mktg Exp Report"
{
    ApplicationArea = All;
    Caption = 'Mktg Exp Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\ReportLayouts\MktgExpreport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(Invoice_Date; "Document Date") { }
            column(Cost_Centers; GenLedsetup."Shortcut Dimension 7 Code") { }//Shortcut Dimenstion 3
            column(Cost_Heads; GenLedsetup."Shortcut Dimension 8 Code") { }
            column(Activity_Name; "Activity Name") { }
            column(Activity_City; "Activity City") { }
            column(Activity_State; "Activity State") { }
            column(Sales_Channel; "Sales Channel") { }
            column(Vandor_Name; rec_Vendor.Name) { }
            column(Vendor_Code; rec_Vendor."No.") { }
            column(Vendor_Address; rec_Vendor.Address + ',' + rec_Vendor."Address 2") { }
            column(Invoice_No; "No.") { }
            column(PO_No; "Order No.") { }
            column(PO_Date; "Order Date") { }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purch. Inv. Header";
                DataItemTableView = sorting("Document No.", "Line No.");

                column(Type; Type) { }// Item No. __Replace NAme
                column(Description; Description) { }// Item Description
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Total_Qty; Quantity) { }
                column(Unit_Price; "Direct Unit Cost") { }
                column(GST_Base_Amount; Amount) { }//Total_Base_Price 
                column(GST_Percent; GST_Percent) { }
                column(GST_Amount; Total_GSTAmount) { }
                column(Total_Amount; Amount + Total_GSTAmount) { }

                trigger OnPreDataItem()
                begin
                end;

                trigger OnAfterGetRecord()
                begin

                    "Purch. Inv. Line".CalcSums(Quantity, Amount);

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
                                GST_Percent := DetailedGSTLedgerEntry."GST %";
                                CAmount := DetailedGSTLedgerEntry."GST Amount";
                                CAmount1 += CAmount;
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                GST_Percent := DetailedGSTLedgerEntry."GST %";
                                SAmount := DetailedGSTLedgerEntry."GST Amount";
                                SAmount1 += SAmount
                            END;

                            IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                GST_Percent := DetailedGSTLedgerEntry."GST %";
                                IAmount := DetailedGSTLedgerEntry."GST Amount";
                                IAmount1 += IAmount;
                            END;
                        UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                    Clear(Total_GSTAmount);
                    Total_GSTAmount := CAmount1 + SAmount1 + IAmount1;
                end;
            }
            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                rec_Vendor.Get("Buy-from Vendor No.");

                GenLedsetup.get();
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName) { }
            }
        }
        actions
        {
            area(processing) { }
        }
    }
    var
        rec_Vendor: Record Vendor;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CAmount1: Decimal;
        CAmount: Decimal;
        SAmount1: Decimal;
        SAmount: Decimal;
        IAmount1: Decimal;
        IAmount: Decimal;
        GST_Percent: Decimal;
        Total_GSTAmount: Decimal;
        GenLedsetup: Record "General Ledger Setup";
}
