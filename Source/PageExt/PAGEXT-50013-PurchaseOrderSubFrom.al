pageextension 50013 PurchaOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Deal No."; Rec."Deal No.")
            {
                ApplicationArea = All;
                Visible = false;
            }

            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Qty. in Pack"; Rec."Qty. in Pack")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
            {
                ApplicationArea = All;
                Caption = 'Order Quantity';
                Visible = false;
            }
            field(Flora; Rec.Flora)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Unit Rate"; Rec."Unit Rate")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Other Charges"; Rec."Other Charges")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field("New TDS Base Amount"; Rec."New TDS Base Amount")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("Item Tracking Lines")
        {
            action("Get Tin,Drum & Bucket")
            {
                ApplicationArea = All;
                Image = CreateLinesFromJob;

                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                    PurchaseLine2: Record "Purchase Line";
                    LineNo: Integer;
                    Qty: Decimal;
                    i: Integer;
                    ItemNo: Code[20];
                    ReservationEntry: Record "Reservation Entry";
                    PurchasePayableSetup: Record "Purchases & Payables Setup";
                    ReserVationEntry2: Record "Reservation Entry";
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchasePayableSetup.Get();
                    Clear(i);
                    ReservationEntry.SetRange("Source Type", Database::"Purchase Line");
                    ReservationEntry.SetRange("Source ID", Rec."Document No.");
                    ReservationEntry.CalcSums(Tin, Drum, Bucket, Can);

                    ReserVationEntry2.Reset();
                    ReserVationEntry2.SetRange("Source Type", Database::"Purchase Line");
                    ReserVationEntry2.SetRange("Source ID", Rec."Document No.");
                    if ReserVationEntry2.FindFirst() then begin
                        Message('%1 Tin,%2 Drum,%3 Bucket,%4 Can', ReservationEntry.Tin, ReservationEntry.Drum, ReservationEntry.Bucket, ReservationEntry.Can);
                        for i := 1 to 4 do begin
                            Qty := 0;
                            if (i = 1) and (ReservationEntry.Tin <> 0) then begin
                                Qty := ReservationEntry.Tin;
                                PurchasePayableSetup.TestField("Tin Item");
                            end else
                                if (i = 2) and (ReservationEntry.Drum <> 0) then begin
                                    Qty := ReservationEntry.Drum;
                                    PurchasePayableSetup.TestField("Drum Item");
                                end else
                                    if (i = 3) and (ReservationEntry.Bucket <> 0) then begin
                                        Qty := ReservationEntry.Bucket;
                                        PurchasePayableSetup.TestField("Bucket Item");
                                    end else
                                        if (i = 4) and (ReservationEntry.Can <> 0) then begin
                                            Qty := ReservationEntry.Can;
                                            PurchasePayableSetup.TestField("CAN Item");
                                        end;
                            if i = 1 then
                                ItemNo := PurchasePayableSetup."Tin Item"
                            else
                                if i = 2 then
                                    ItemNo := PurchasePayableSetup."Drum Item"
                                else
                                    if i = 3 then
                                        ItemNo := PurchasePayableSetup."Bucket Item"
                                    else
                                        if i = 4 then
                                            ItemNo := PurchasePayableSetup."CAN Item";
                            if (Qty <> 0) then begin
                                PurchaseLine.Reset();
                                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                                PurchaseLine.SetRange("Document No.", ReserVationEntry2."Source ID");
                                if PurchaseLine.FindLast() then
                                    LineNo := PurchaseLine."Line No." + 10000
                                else
                                    LineNo := 10000;

                                PurchaseLine2.Reset();
                                PurchaseLine2.SetRange("Document Type", PurchaseLine2."Document Type"::Order);
                                PurchaseLine2.SetRange("Document No.", ReserVationEntry2."Source ID");
                                PurchaseLine2.SetRange("No.", ItemNo);
                                if not PurchaseLine2.FindFirst() then begin
                                    PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Order;
                                    PurchaseLine2."Document No." := ReserVationEntry2."Source ID";
                                    PurchaseLine2."Line No." := LineNo;
                                    PurchaseLine2.Validate(Type, PurchaseLine2.Type::Item);
                                    PurchaseLine2.Validate("No.", ItemNo);
                                    PurchaseLine2.Validate(Quantity, Qty);
                                    PurchaseLine2.Insert(true);
                                end else begin
                                    PurchaseLine2.Validate(Quantity, Qty);
                                    PurchaseLine2.Modify();
                                end;
                            end else begin
                                PurchaseLine2.Reset();
                                PurchaseLine2.SetRange("Document Type", PurchaseLine2."Document Type"::Order);
                                PurchaseLine2.SetRange("Document No.", ReserVationEntry2."Source ID");
                                PurchaseLine2.SetRange("No.", ItemNo);
                                if PurchaseLine2.FindFirst() then
                                    PurchaseLine2.Delete(true);
                            end;
                        end;
                        if PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then begin
                            PurchaseHeader."Creation Tin&Drum&Bucket Item" := true;
                            PurchaseHeader.Modify();
                        end;
                    end;
                end;
            }
        }
    }

    procedure UpdateTaxAmount()
    var
        CalculateTax: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTax.CallTaxEngineOnPurchaseLine(Rec, xRec);
    end;
}