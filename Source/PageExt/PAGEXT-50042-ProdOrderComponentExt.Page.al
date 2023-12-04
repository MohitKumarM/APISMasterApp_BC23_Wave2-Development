pageextension 50042 MyExtension extends "Prod. Order Components"
{
    layout
    {
        addbefore("Quantity per")
        {
            field("Required Qty"; Rec."Required Qty")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    Rec."Quantity per" := CalculateQuantityRequired();
                    Rec.Validate("Quantity per");
                end;
            }
        }
        addafter("Routing Link Code")
        {
            field("Consumed Qty."; Rec."Consumed Qty.")
            {
                ApplicationArea = all;
            }
            field("Lot Tracking Qty."; Rec."Lot Tracking Qty.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify(Reserve)
        {
            Visible = false;
        }
        modify(OrderTracking)
        {
            Visible = false;
        }
        modify(ItemTrackingLines)
        {
            Visible = false;
        }
        modify(SelectItemSubstitution)
        {
            Visible = false;
        }
        modify("Put-away/Pick Lines/Movement Lines")
        {
            Visible = false;
        }
        modify("Bin Contents")
        {
            Visible = false;
        }
        addafter(Dimensions)
        {
            action("Raw Honey Tracking Lines")
            {
                ApplicationArea = All;
                Image = ItemTracking;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    recLotTracking: Record "Tran. Lot Tracking";
                    pgLotTracking: Page "Cons. Lot Tracking Entry";
                    ProdOrder_Loc: Record "Production Order";
                    LocationCode_Loc1: Record Location;
                    LocationCode_Loc2: Record Location;
                    prodordercomponent_Loc: Record "Prod. Order Component";

                begin

                    Rec.TESTFIELD("Item No.");

                    recPurchSetup.GET;
                    recPurchSetup.TESTFIELD("Raw Honey Item");
                    recItem.GET(Rec."Item No.");
                    recProductGroup.GET(recItem."New Product Group Code", recItem."Item Category Code");

                    ProdOrder_Loc.Get(Rec.Status, Rec."Prod. Order No.");
                    Rec."Location Code" := ProdOrder_Loc."Location Code";
                    LocationCode_Loc1.Get(Rec."Location Code");
                    LocationCode_Loc2.Reset();
                    LocationCode_Loc2.SetRange("Associated Plant", LocationCode_Loc1."Associated Plant");
                    LocationCode_Loc2.SetRange("Store Location", true);
                    IF not LocationCode_Loc2.FindFirst() then begin
                        LocationCode_Loc2.SetRange("Associated Plant");
                        LocationCode_Loc2.FindFirst();
                    end;

                    IF recProductGroup."Allow Direct Purch. Order" THEN BEGIN
                        recLotTracking.RESET;
                        recLotTracking.FILTERGROUP(2);
                        recLotTracking.SETRANGE("Document Type", recLotTracking."Document Type"::Consumption);
                        recLotTracking.SETRANGE("Document No.", Rec."Prod. Order No.");
                        recLotTracking.SETRANGE("Document Line No.", Rec."Prod. Order Line No.");
                        recLotTracking.SETRANGE("Item No.", Rec."Item No.");
                        recLotTracking.FILTERGROUP(0);

                        CLEAR(pgLotTracking);
                        pgLotTracking.SetDocumentNo(Rec."Prod. Order No.", Rec."Prod. Order Line No.", Rec."Item No.", Rec."Remaining Quantity", LocationCode_Loc2.Code, 1);
                        pgLotTracking.SETTABLEVIEW(recLotTracking);
                        pgLotTracking.RunModal();
                    END ELSE BEGIN
                        recItemLedger.RESET;
                        recItemLedger.SETRANGE("Entry Type", recItemLedger."Entry Type"::Consumption);
                        recItemLedger.SETRANGE("Document No.", Rec."Prod. Order No.");
                        IF recItemLedger.FINDFIRST THEN
                            REPEAT
                                recReservationEntry.RESET;
                                recReservationEntry.SETRANGE("Source ID", Rec."Prod. Order No.");
                                recReservationEntry.SETRANGE("Source Type", 5407);
                                recReservationEntry.SETRANGE("Source Subtype", 3);
                                recReservationEntry.SETRANGE("Lot No.", recItemLedger."Lot No.");
                                IF recReservationEntry.FINDFIRST THEN
                                    recReservationEntry.DELETEALL;
                            UNTIL recItemLedger.NEXT = 0;
                        COMMIT;

                        Rec.OpenItemTrackingLines;
                    END;
                    IF (ProdOrder_Loc.Refreshed) then begin
                        Rec."Location Code" := LocationCode_Loc2.Code;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    procedure CalculateQuantityRequired(): Decimal
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        TotalQuantityWithScrap: Decimal;
        NetScrap: Decimal;

    begin
        Clear(NetScrap);
        Clear(TotalQuantityWithScrap);

        ProdOrderLine.GET(Rec.Status, Rec."Prod. Order No.", Rec."Prod. Order Line No.");

        Rec."Due Date" := ProdOrderLine."Starting Date";

        ProdOrderRtngLine.RESET;
        ProdOrderRtngLine.SETRANGE(Status, Rec.Status);
        ProdOrderRtngLine.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        IF Rec."Routing Link Code" <> '' THEN
            ProdOrderRtngLine.SETRANGE("Routing Link Code", Rec."Routing Link Code");
        IF ProdOrderRtngLine.FINDFIRST THEN begin
            TotalQuantityWithScrap := (ProdOrderLine.Quantity *
                  (1 + ProdOrderLine."Scrap %" / 100) *
                  (1 + ProdOrderRtngLine."Scrap Factor % (Accumulated)") *
                  (1 + Rec."Scrap %" / 100) +
                  ProdOrderRtngLine."Fixed Scrap Qty. (Accum.)");
        end else begin
            TotalQuantityWithScrap := (ProdOrderLine.Quantity *
              (1 + ProdOrderLine."Scrap %" / 100) * (1 + Rec."Scrap %" / 100));
        end;

        NetScrap := TotalQuantityWithScrap - ProdOrderLine.Quantity;
        exit(Rec."Required Qty" / (ProdOrderLine.Quantity - NetScrap));
    end;

    var
        recPurchSetup: Record "Purchases & Payables Setup";
        recProductGroup: Record "New Product Group";
        recItem: Record "Item";
        recItemLedger: Record "Item Ledger Entry";
        recReservationEntry: Record "Reservation Entry";
}