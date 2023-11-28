pageextension 50006 ItemTrackingLine extends "Item Tracking Lines"
{
    layout
    {
        modify("Item No.")
        {
            Visible = true;
        }

        modify("Lot No.")
        {
            trigger OnAfterValidate()
            var
                PriceListLine: Record "Price List Line";
            begin

                if rec."Source Type" <> 37 then begin
                    PriceListLine.Reset();
                    PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::"All Customers");
                    PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                    PriceListLine.SetRange("Product No.", Rec."Item No.");
                    PriceListLine.SetRange(Status, PriceListLine.Status::Active);
                    PriceListLine.SetRange("Ending Date", 0D);
                    if PriceListLine.FindFirst() then begin
                        Rec."MRP Price" := PriceListLine."MRP Price";
                        Rec.Modify();
                    end else begin
                        PriceListLine.Reset();
                        PriceListLine.SetCurrentKey("Ending Date");
                        PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::"All Customers");
                        PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                        PriceListLine.SetRange("Product No.", Rec."Item No.");
                        PriceListLine.SetRange(Status, PriceListLine.Status::Active);
                        if PriceListLine.FindLast() then begin
                            Rec."MRP Price" := PriceListLine."MRP Price";
                            Rec.Modify();
                        end;
                    end;
                end;
            end;
        }
        addafter("Appl.-from Item Entry")
        {
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
                Editable = Item_Editable;
            }
            field("MFG. Date"; Rec."MFG. Date")
            {
                ApplicationArea = all;
                Editable = Item_Editable;
                trigger OnValidate()
                var
                    L_Item: Record Item;
                begin
                    if Rec."MFG. Date" <> 0D then begin
                        Rec.TestField("Lot No.");
                        if L_Item.get(Rec."Item No.") then
                            if Format(L_Item."Expiry Date Formula") <> '' then begin
                                Rec."Expiration Date" := CalcDate(L_Item."Expiry Date Formula", Rec."MFG. Date");
                                Rec.Modify();
                            end;
                    end else
                        Clear(Rec."Expiration Date");
                end;
            }
            field(Tin; Rec.Tin)
            {
                Visible = Item_Visible;
                ApplicationArea = all;
                Editable = Item_Editable;
            }
            field(Drum; Rec.Drum)
            {
                ApplicationArea = all;
                Visible = Item_Visible;
                Editable = Item_Editable;
            }
            field(Bucket; Rec.Bucket)
            {
                ApplicationArea = all;
                Visible = Item_Visible;
                Editable = Item_Editable;
            }
            field(Can; Rec.Can)
            {
                ApplicationArea = all;
                Visible = Item_Visible;
                Editable = Item_Editable;
            }
        }
    }

    actions { }

    var

        Item_Visible: Boolean;
        Item_Editable: Boolean;

    trigger OnOpenPage()
    begin
        Item_Visible := true;
        Item_Editable := true;
        if (Rec."Source Type" <> 39) then begin
            if Rec."Source Type" = 37 then begin
                Item_Visible := true;
                Item_Editable := false;
            end else begin
                Item_Visible := false;
                Item_Editable := true;
            end;
        end else begin
            Item_Visible := true;
            Item_Editable := true;
        end;
    end;

    trigger OnAfterGetRecord()
    var

    begin
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        PriceListLine: Record "Price List Line";
        SalesLine: Record "Sales Line";
    begin
        if rec."Source Type" = 37 then begin

            PriceListLine.Reset();
            PriceListLine.SetRange("Source Type", PriceListLine."Source Type"::"All Customers");
            PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
            PriceListLine.SetRange("Product No.", Rec."Item No.");
            PriceListLine.SetRange(Status, PriceListLine.Status::Active);
            PriceListLine.SetRange("MRP Price", Rec."MRP Price");
            if PriceListLine.FindFirst() then begin
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", Rec."Source ID");
                SalesLine.SetRange("Line No.", Rec."Source Ref. No.");
                SalesLine.SetRange("No.", Rec."Item No.");
                if SalesLine.FindFirst() then begin
                    SalesLine.Validate("Unit Price", PriceListLine."Unit Price");
                    SalesLine.Modify();
                end;
            end;
        end;
    end;
}