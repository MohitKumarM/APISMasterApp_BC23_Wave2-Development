pageextension 50044 ConsumptionJournalExt extends "Consumption Journal"
{
    layout
    {
        modify("Order No.")
        {
            trigger OnAfterValidate()
            var
                prodOrder_loc: Record "Production Order";
                ManufacturingSetup_loc: Record "Manufacturing Setup";
            begin
                if (Rec."Order No." <> '') and (prodOrder_loc.Get(prodOrder_loc.Status::Released, Rec."Order No.")) then begin
                    ManufacturingSetup_loc.Get();
                    Rec."Location Code" := ManufacturingSetup_loc."Store Location";
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
                    ContainerStoreToProd.Run();
                end;
            }
        }
        modify("P&ost")
        {
            trigger OnBeforeAction()
            var
                ManfactSetup: Record "Manufacturing Setup";
                ItemLedgerEntries: Record "Item Ledger Entry";
            begin
                ManfactSetup.Get();
                ManfactSetup.TestField("Production Location");

                ItemLedgerEntries.Reset();
                ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                ItemLedgerEntries.SetRange("Location Code", ManfactSetup."Production Location");
                ItemLedgerEntries.SetRange("Document No.", Rec."Document No.");
                ItemLedgerEntries.SetRange("Container Trasfer Stage", ItemLedgerEntries."Container Trasfer Stage"::"Issued RM");
                if not ItemLedgerEntries.FindFirst() then
                    Error('Plesae Fill and Post Container Information before posting Consumption.');


            end;
        }
    }
}