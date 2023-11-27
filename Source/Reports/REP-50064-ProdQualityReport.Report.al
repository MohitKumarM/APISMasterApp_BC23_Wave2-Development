report 50064 "Prod. Quality Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ProdQualityReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Quality Header"; "Quality Header")
        {
            RequestFilterFields = "No.";
            CalcFields = "Document Date";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            column(RepotNo; "QC Analytical Report No.")
            {
            }
            column(Note; 'Note: This is a system generated Reports and needs no signature.')
            {
            }
            column(CompanyName; recCompanyInfo.Name)
            {
            }
            column(Logo; recCompanyInfo.Picture)
            {
            }
            column(Heading; txtHeading)
            {
            }
            column(Product; recProductionOrder."Customer Name")
            {
            }
            column(BatchQuatity; Quantity)
            {
            }
            column(BatchNo; cdLotNo)
            {
            }
            column(MfgDate; FORMAT(dtMfgDate))
            {
            }
            column(TestedByID; "Tested By")
            {
            }
            column(CheckedBy; "Sampled By")
            {
            }
            column(ExpiryDate; FORMAT(dtExpiryDate))
            {
            }
            dataitem("Quality Line"; "Quality Line")
            {
                DataItemLink = "QC No." = FIELD("No.");
                DataItemTableView = SORTING("QC No.", "Line No.")
                                    ORDER(Ascending);
                column(Measure; "Quality Measure")
                {
                }
                column(Parameter; Parameter)
                {
                }
                column(Specs; Specs)
                {
                }
                column(Limit; Limit)
                {
                }
                column(Observation; Observation)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF "Quality Header".Posted THEN
                    txtHeading := 'Quality Control Analytical Report'
                ELSE
                    txtHeading := 'Test Quality Control Analytical Report';

                recProductionOrder.RESET;
                recProductionOrder.SETRANGE("No.", "Quality Header"."Document No.");
                recProductionOrder.FINDFIRST;
                recProductionOrder.CALCFIELDS("Customer Name");

                dtMfgDate := 0D;
                recItemJournalLine.RESET;
                recItemJournalLine.SETRANGE("Document No.", "Quality Header"."Document No.");
                recItemJournalLine.SETRANGE("Order Line No.", "Quality Header"."Document Line No.");
                IF recItemJournalLine.FINDFIRST THEN BEGIN
                    IF recItemJournalLine."Prod. Date for Expiry Calc" = 0D THEN
                        dtMfgDate := recItemJournalLine."Posting Date"
                    ELSE
                        dtMfgDate := recItemJournalLine."Prod. Date for Expiry Calc";
                END ELSE BEGIN
                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Document No.", "Quality Header"."Document No.");
                    recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Output);
                    IF recItemLedger.FINDFIRST THEN BEGIN
                        dtMfgDate := recItemLedger."Posting Date";
                        cdLotNo := recItemLedger."Lot No.";
                    END;
                END;
                IF cdLotNo = '' THEN
                    cdLotNo := recProductionOrder."Batch No.";

                dtExpiryDate := 0D;
                recItem.GET(recProductionOrder."Source No.");
                IF FORMAT(recItem."Expiry Date Formula") <> '' THEN
                    dtExpiryDate := CALCDATE(recItem."Expiry Date Formula", dtMfgDate);
            end;

            trigger OnPreDataItem()
            begin
                recCompanyInfo.GET;
                recCompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        recCompanyInfo: Record "Company Information";
        txtHeading: Text[50];
        dtMfgDate: Date;
        recItemJournalLine: Record "Item Journal Line";
        recItemLedger: Record "Item Ledger Entry";
        recProductionOrder: Record "Production Order";
        dtExpiryDate: Date;
        recItem: Record Item;
        cdLotNo: Code[20];
    // "Quality Header": Record "Quality Header";
    // "Quality Line": Record "Quality Line";
}
