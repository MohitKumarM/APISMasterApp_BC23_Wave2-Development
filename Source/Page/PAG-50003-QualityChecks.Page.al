page 50003 "Quality Checks"
{
    Caption = 'Posted QC';
    CardPageID = "Quality Check Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Quality Header";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Approved Quantity"; rec."Approved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Rejected Quantity"; rec."Rejected Quantity")
                {
                    ApplicationArea = All;
                }
                field("Output Quality Status"; rec."Output Quality Status")
                {
                    ApplicationArea = All;
                }
                field("Machine No."; rec."Machine No.")
                {
                    ApplicationArea = All;
                }
                field("Machine Name"; rec."Machine Name")
                {
                    ApplicationArea = All;
                }
                field("Sampled By"; rec."Sampled By")
                {
                    ApplicationArea = All;
                }
                field("QC Analytical Report No."; rec."QC Analytical Report No.")
                {
                    ApplicationArea = All;
                }
                field("Tested By"; rec."Tested By")
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
            action(New)
            {
                Caption = 'New';
                Image = Document;
                Promoted = true;

                trigger OnAction()
                begin
                    recInventorySetup.GET;
                    recInventorySetup.TESTFIELD("Quality Nos.");

                    cdDocNo := cuNoSeries.GetNextNo(recInventorySetup."Quality Nos.", TODAY, TRUE);

                    recQualityCheck.INIT;
                    recQualityCheck."No." := cdDocNo;
                    recQualityCheck.Date := TODAY;
                    recQualityCheck."Document Type" := recQualityCheck."Document Type"::"Purchase Receipt";
                    recQualityCheck."Document No." := Rec."Document No.";
                    recQualityCheck."Document Line No." := Rec."Document Line No.";
                    recQualityCheck.INSERT;

                    CLEAR(pgQuality);
                    pgQuality.SETTABLEVIEW(recQualityCheck);
                    pgQuality.RUN;
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin
                    recQualityCheck.RESET;
                    recQualityCheck.SETRANGE("No.", Rec."No.");
                    recQualityCheck.FINDFIRST;

                    IF recQualityCheck."Document Type" = recQualityCheck."Document Type"::"Purchase Receipt" THEN
                        REPORT.RUN(50017, TRUE, TRUE, recQualityCheck)
                    ELSE
                        REPORT.RUN(50054, TRUE, TRUE, recQualityCheck);
                end;
            }
        }
    }

    var
        recInventorySetup: Record "Inventory Setup";
        cdDocNo: Code[20];
        cuNoSeries: Codeunit NoSeriesManagement;
        recQualityCheck: Record "Quality Header";
        pgQuality: Page "Quality Check Card";
}
