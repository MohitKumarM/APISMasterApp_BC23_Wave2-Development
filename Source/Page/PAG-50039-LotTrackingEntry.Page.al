page 50039 "Lot Tracking Entry"
{
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Tran. Lot Tracking";
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTableView = SORTING("Document No.", "Document Line No.", "Item No.", "Lot No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Qty. In Packs"; Rec."Qty. In Packs")
                {
                    ApplicationArea = All;
                }
                field("Tare Weight"; Rec."Tare Weight")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Quantity > (decRemQty + xRec.Quantity) THEN
                            ERROR('Can not receive more than %1.', (decRemQty + xRec.Quantity));
                        decRemQty := decRemQty + xRec.Quantity - Rec.Quantity;
                        decAppliedQty := decAppliedQty + (decRemQty + xRec.Quantity);
                        CurrPage.UPDATE;
                    end;
                }
                field("Average Qty. In Pack"; Rec."Average Qty. In Pack")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Receive"; Rec."Qty. To Receive")
                {
                    ApplicationArea = All;
                }
                field("Applied Qty."; Rec."Applied Qty.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF (cdDocumentNo = '') OR (intLineNo = 0) OR (cdItemCode = '') OR (decTotalToRcd = 0) OR (cdLocationCode = '') THEN
            ERROR('Document No., Line No. or Item No. must not be blank.');

        Rec."Document No." := cdDocumentNo;
        Rec."Document Line No." := intLineNo;
        Rec."Item No." := cdItemCode;
        Rec."Location Code" := cdLocationCode;
        Rec."Document Type" := opDocumentType;
        Rec.TESTFIELD("Lot No.");
        Rec.TESTFIELD(Flora);
        Rec.TESTFIELD("Packing Type");
        Rec.TESTFIELD("Qty. In Packs");
        Rec.TESTFIELD(Quantity);
    end;

    trigger OnOpenPage()
    begin
        decAppliedQty := 0;
        recLotTracking.RESET;
        recLotTracking.SETCURRENTKEY("Document No.", "Document Line No.", "Item No.", "Lot No.");
        recLotTracking.SETRANGE("Document No.", cdDocumentNo);
        recLotTracking.SETRANGE("Document Line No.", intLineNo);
        recLotTracking.SETRANGE("Item No.", cdItemCode);
        IF recLotTracking.FINDFIRST THEN BEGIN
            recLotTracking.CALCFIELDS("Applied Qty.");
            decAppliedQty := recLotTracking."Applied Qty.";
        END;
        decRemQty := decTotalToRcd - decAppliedQty;
    end;

    var
        cdDocumentNo: Code[20];
        intLineNo: Integer;
        cdItemCode: Code[20];
        decTotalToRcd: Decimal;
        decRemQty: Decimal;
        decAppliedQty: Decimal;
        recLotTracking: Record "Tran. Lot Tracking";
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
