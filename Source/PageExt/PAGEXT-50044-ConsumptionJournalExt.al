pageextension 50044 ConsumptionJournalExt extends "Consumption Journal"
{
    layout
    {
        modify("Order No.")
        {
            trigger OnAfterValidate()
            var
                prodOrder_loc: Record "Production Order";
                LocationCode_Loc1: Record Location;
                LocationCode_Loc2: Record Location;
            begin
                if (Rec."Order No." <> '') and (prodOrder_loc.Get(prodOrder_loc.Status::Released, Rec."Order No.")) then begin

                    LocationCode_Loc1.Get(prodOrder_loc."Location Code");
                    LocationCode_Loc2.Reset();
                    LocationCode_Loc2.SetRange("Associated Plant", LocationCode_Loc1."Associated Plant");
                    LocationCode_Loc2.SetRange("Store Location", true);
                    if not LocationCode_Loc2.FindFirst() then begin
                        LocationCode_Loc2.SetRange("Associated Plant");
                        if LocationCode_Loc2.FindFirst() then;
                    end;
                    Rec."Location Code" := LocationCode_Loc2.Code;
                end;
            end;
        }

    }

    actions
    {
        addbefore("P&ost")
        {
            action("Container Information")
            {
                Image = Order;
                Caption = 'Container Information';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    ContainerStoreToProd: page "Container Store to Prod.";
                    ItemjournalLine: Record "Item Journal Line";
                    ManufacSetup: Record "Manufacturing Setup";
                begin
                    ManufacSetup.Get();
                    ManufacSetup.TestField("Store to Prod. Template");
                    ManufacSetup.TestField("Store to Prod. Batch");

                    ItemjournalLine.Reset();
                    ItemjournalLine.SetRange("Journal Template Name", ManufacSetup."Store to Prod. Template");
                    ItemjournalLine.SetRange("Journal Batch Name", ManufacSetup."Store to Prod. Batch");
                    ItemjournalLine.SetRange("Document No.", Rec."Document No.");
                    ContainerStoreToProd.SetTableView(ItemjournalLine);
                    ContainerStoreToProd.SetDocNo(Rec."Document No.");
                    ContainerStoreToProd.RunModal();
                end;
            }
            action("Calc_Co&nsumption")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Calc. Co&nsumption';
                Ellipsis = true;
                Image = CalculateConsumption;
                ToolTip = 'Use a batch job to help you fill the consumption journal with actual or expected consumption figures.';

                trigger OnAction()
                var
                    CalcConsumption: Report "Calc. ConsumptionN";
                begin
                    CalcConsumption.SetTemplateAndBatchName(Rec."Journal Template Name", Rec."Journal Batch Name");

                    CalcConsumption.RunModal();
                end;
            }
        }

        modify("P&ost")
        {
            trigger OnBeforeAction()
            var
                ManfactSetup: Record "Manufacturing Setup";
                ItemLedgerEntries: Record "Item Ledger Entry";
                Location_loc: Record Location;
                Location_loc1: Record Location;
                ProdOrder_Loc: Record "Production Order";
            begin
                ProdOrder_Loc.Reset();
                ProdOrder_Loc.SetRange("No.", Rec."Document No.");
                ProdOrder_Loc.FindFirst();
                ProdOrder_Loc.TestField("Location Code");
                Location_loc.Get(ProdOrder_Loc."Location Code");

                Location_loc1.Reset();
                Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
                Location_loc1.SetRange("Production Location", true);
                if not Location_loc1.FindFirst() then begin
                    Location_loc1.SetRange("Associated Plant");
                    if Location_loc1.FindFirst() then;
                end;

                ManfactSetup.Get();

                ItemLedgerEntries.Reset();
                ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                ItemLedgerEntries.SetRange("Location Code", Location_loc1.Code);
                ItemLedgerEntries.SetRange("Document No.", Rec."Document No.");
                ItemLedgerEntries.SetRange("Container Trasfer Stage", ItemLedgerEntries."Container Trasfer Stage"::"Issued RM");
                if not ItemLedgerEntries.FindFirst() then
                    Error('Plesae Fill and Post Container Information before posting Consumption.');
            end;

            trigger OnAfterAction()
            var
                ProdOrder: Record "Production Order";
            begin
                ProdOrder.Reset();
                ProdOrder.SetRange("No.", GlobDocNo);
                if ProdOrder.FindFirst() then begin
                    ProdOrder."Requested Material Issued" := true;
                    ProdOrder.Modify();
                end;
            end;
        }
        modify("Calc. Co&nsumption")
        {
            Visible = false;
        }
    }

    procedure ProdOrderNo(DocNo_Loc: Code[20])
    begin
        GlobDocNo := DocNo_Loc;
    end;

    var
        GlobDocNo: Code[20];
}