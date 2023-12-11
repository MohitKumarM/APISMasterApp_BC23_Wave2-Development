pageextension 50064 "Item reclass Ext." extends "Item Reclass. Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore(Post)
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
                    ContainerStoreToProd.RunModal();
                end;
            }
        }
        modify(Post)
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
    }

    procedure ProdOrderNo(DocNo_Loc: Code[20])
    begin
        GlobDocNo := DocNo_Loc;
    end;

    var
        GlobDocNo: Code[20];



}