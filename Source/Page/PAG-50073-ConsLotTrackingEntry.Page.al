page 50073 "Cons. Lot Tracking Entry"
{
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Tran. Lot Tracking";
    SourceTableView = SORTING("Document No.", "Document Line No.", "Item No.", "Lot No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ref. Entry No."; Rec."Ref. Entry No.")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        recLotEntry.RESET;
                        recLotEntry.SETCURRENTKEY("Document No.", "Document Line No.", "Item No.", "Location Code", "Lot No.", Positive, "Remaining Qty.");
                        recLotEntry.FILTERGROUP(2);
                        recLotEntry.SETRANGE("Item No.", cdItemCode);
                        recLotEntry.SETRANGE("Location Code", cdLocationCode);
                        recLotEntry.SETFILTER("Remaining Qty.", '<>%1', 0);
                        recLotEntry.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, recLotEntry) = ACTION::LookupOK THEN BEGIN
                            recLotTracking.RESET;
                            recLotTracking.SETRANGE("Document No.", cdDocumentNo);
                            recLotTracking.SETRANGE("Document Line No.", intLineNo);
                            recLotTracking.SETFILTER("Document Type", '%1|%2', recLotTracking."Document Type"::Consumption, recLotTracking."Document Type"::Transfer);
                            recLotTracking.SETRANGE("Item No.", cdItemCode);
                            recLotTracking.SETRANGE("Ref. Entry No.", recLotEntry."Entry No.");
                            IF recLotTracking.FINDFIRST THEN
                                ERROR('The Entr no. %1 is already selected.', recLotEntry."Entry No.");

                            Rec."Item No." := recLotEntry."Item No.";
                            Rec."Lot No." := recLotEntry."Lot No.";
                            Rec.Flora := recLotEntry.Flora;
                            Rec."Packing Type" := recLotEntry."Packing Type";
                            Rec."Average Qty. In Pack" := recLotEntry."Average Qty. In Pack";
                            Rec."Document No." := cdDocumentNo;
                            Rec."Document Line No." := intLineNo;
                            Rec."Location Code" := cdLocationCode;
                            Rec."Document Type" := opDocumentType;
                            Rec."Ref. Entry No." := recLotEntry."Entry No.";

                            recLotEntry.CALCFIELDS("Applied Qty. In Packs");
                            IF recLotEntry."Applied Qty. In Packs" = 0 THEN BEGIN
                                Rec."Remaining Quantity" := recLotEntry."Remaining Qty.";
                                recLotEntry.CALCFIELDS("Rem. Qty. In Packs");
                                Rec."Remaining Qty. In Packs" := recLotEntry."Rem. Qty. In Packs";
                            END ELSE BEGIN
                                recLotEntry.CALCFIELDS("Rem. Qty. In Packs");
                                Rec."Remaining Qty. In Packs" := recLotEntry."Rem. Qty. In Packs" - recLotEntry."Applied Qty. In Packs";
                                Rec."Remaining Quantity" := Rec."Remaining Qty. In Packs" * recLotEntry."Average Qty. In Pack";
                            END;
                        END;
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                }
                field(Flora; Rec.Flora)
                {
                    Editable = false;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    Editable = false;
                }
                field("Qty. In Packs"; Rec."Qty. In Packs")
                {
                    trigger OnValidate()
                    begin
                        IF Rec."Remaining Qty. In Packs" - Rec."Qty. In Packs" < 0 THEN
                            ERROR('Can not use more than %1 quantity', Rec."Remaining Qty. In Packs");
                        recLotEntry.GET(Rec."Ref. Entry No.");
                        Rec."Average Qty. In Pack" := recLotEntry."Average Qty. In Pack";
                        IF Rec."Qty. In Packs" = Rec."Remaining Qty. In Packs" THEN
                            Rec.Quantity := Rec."Remaining Quantity"
                        ELSE
                            Rec.Quantity := ROUND(Rec."Qty. In Packs" * recLotEntry."Average Qty. In Pack", 1);
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Average Qty. In Pack"; Rec."Average Qty. In Pack")
                {
                    Editable = false;
                }
                field("Remaining Qty. In Packs"; Rec."Remaining Qty. In Packs") { }
                field("Remaining Quantity"; Rec."Remaining Quantity") { }
            }
        }
    }

    actions { }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF (cdDocumentNo = '') OR (intLineNo = 0) OR (cdItemCode = '') OR (decTotalToRcd = 0) OR (cdLocationCode = '') OR (opDocumentType = 0) THEN
            ERROR('Document No., Line No. or Item No. must not be blank.');

        Rec."Document No." := cdDocumentNo;
        Rec."Document Line No." := intLineNo;
        Rec."Item No." := cdItemCode;
        Rec."Location Code" := cdLocationCode;
        Rec."Document Type" := opDocumentType;
    end;

    var
        cdDocumentNo: Code[20];
        intLineNo: Integer;
        cdItemCode: Code[20];
        decTotalToRcd: Decimal;
        recLotTracking: Record "Tran. Lot Tracking";
        recLotEntry: Record "Lot Tracking Entry";
        cdLocationCode: Code[20];
        opDocumentType: Option "Purch. Receipt",Consumption;

    procedure SetDocumentNo(DocNo: Code[20]; LineNo: Integer; ItemNo: Code[20]; QtyToRcd: Decimal; LocationCode: Code[20]; DocumentType: Integer)
    begin
        cdDocumentNo := DocNo;
        intLineNo := LineNo;
        cdItemCode := ItemNo;
        decTotalToRcd := QtyToRcd;
        cdLocationCode := LocationCode;
        opDocumentType := DocumentType;
    end;
}
