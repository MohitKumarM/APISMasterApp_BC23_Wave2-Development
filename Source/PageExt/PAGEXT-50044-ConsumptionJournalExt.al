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
                    LocationCode_Loc2.FindFirst();
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
                Location_loc: Record Location;
                Location_loc1: Record Location;
                ProdOrder_Loc: Record "Production Order";
            begin
                ProdOrder_Loc.Reset();
                ProdOrder_Loc.SetRange("No.", Rec."Document No.");
                ProdOrder_Loc.FindFirst();
                ProdOrder_Loc.TestField("Location Code");
                Location_loc.Get(ProdOrder_Loc."Location Code");
                Location_loc.TestField("Associated Plant");
                Location_loc1.Reset();
                Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
                Location_loc1.SetRange("Production Location", true);
                Location_loc1.FindFirst();

                ManfactSetup.Get();

                ItemLedgerEntries.Reset();
                ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                ItemLedgerEntries.SetRange("Location Code", Location_loc1.Code);
                ItemLedgerEntries.SetRange("Document No.", Rec."Document No.");
                ItemLedgerEntries.SetRange("Container Trasfer Stage", ItemLedgerEntries."Container Trasfer Stage"::"Issued RM");
                if not ItemLedgerEntries.FindFirst() then
                    Error('Plesae Fill and Post Container Information before posting Consumption.');
            end;
        }
    }
}