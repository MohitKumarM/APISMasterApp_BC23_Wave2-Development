page 50038 "Honey GAN Order Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    InsertAllowed = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Deal No."; Rec."Deal No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Deal Line No."; Rec."Deal Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. in Pack"; Rec."Qty. in Pack")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Billed Quantity"; Rec."Billed Quantity")
                {
                    ApplicationArea = All;
                }
                //Shivam++ 20-07-23
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                //Shivam--
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Rec."Qty. to Receive" > Rec.Quantity then
                            Error('Quatity to Receive must not be greater than Quantity.');

                        if Rec."Qty. to Receive" > Rec."Outstanding Quantity" then
                            Error('Quatity to Receive must not be greater than Outstanding Quantity.');
                    end;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                // field("Input Credit"; Rec."Input Credit")
                // {
                //     ApplicationArea = All;
                // }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Lot Tracking Lines")
                {
                    Caption = 'Lot Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    var
                        recLotTracking: Record "Tran. Lot Tracking";
                        pgLotTracking: Page "Lot Tracking Entry";
                        recProductGroup: Record "New Product Group";
                    begin
                        Rec.TESTFIELD(Type, Type::Item);
                        Rec.TESTFIELD("No.");
                        recItem.GET(Rec."No.");
                        recProductGroup.GET(recItem."New Product Group Code", recItem."Item Category Code");
                        IF recProductGroup."Allow Direct Purch. Order" THEN BEGIN
                            recLotTracking.RESET;
                            recLotTracking.FILTERGROUP(2);
                            recLotTracking.SETRANGE("Document No.", Rec."Document No.");
                            recLotTracking.SETRANGE("Document Line No.", Rec."Line No.");
                            recLotTracking.SETRANGE("Item No.", Rec."No.");
                            recLotTracking.FILTERGROUP(0);

                            CLEAR(pgLotTracking);
                            pgLotTracking.SetDocumentNo(Rec."Document No.", Rec."Line No.", Rec."No.", Rec."Qty. to Receive", Rec."Location Code", 0);
                            PurchHeader.GET(Rec."Document Type", Rec."Document No.");
                            IF PurchHeader."GAN Approval Pending" THEN
                                pgLotTracking.EDITABLE := FALSE;
                            pgLotTracking.SETTABLEVIEW(recLotTracking);
                            pgLotTracking.RUN;
                        end
                        ELSE
                            Rec.OpenItemTrackingLines;
                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(ItemChargeAssignment)
                {
                    Caption = 'Item Charge &Assignment';

                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt;
                    end;
                }
                action("Str&ucture Details")
                {
                    Caption = 'Str&ucture Details';
                    Image = Hierarchy;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ShowStrDetailsForm;
                    end;
                }
                action("E&xcise Detail")
                {
                    Caption = 'E&xcise Detail';
                    Image = Excise;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ShowExcisePostingSetup;
                    end;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    Image = TaxDetail;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowDetailedTaxEntryBuffer;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        PurchHeader: Record "Purchase Header";

        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.';
        recItem: Record Item;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        IF Rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;

    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    /*  procedure ShowPrices()
     begin
         PurchHeader.GET(Rec."Document Type", Rec."Document No.");
         CLEAR(PurchPriceCalcMgt);
         PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
     end;

     procedure ShowLineDisc()
     begin
         PurchHeader.GET(Rec."Document Type", Rec."Document No.");
         CLEAR(PurchPriceCalcMgt);
         PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
     end; */

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    procedure ShowStrDetailsForm()
    var
    // StrOrderLineDetails: Record "13795";
    // StrOrderLineDetailsForm: Page 16306;
    begin
        // StrOrderLineDetails.RESET;
        // StrOrderLineDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
        // StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
        // StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
        // StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
        // StrOrderLineDetails.SETRANGE("Item No.", "No.");
        // StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
        // StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
        // StrOrderLineDetailsForm.RUNMODAL;
    end;

    procedure ShowExcisePostingSetup()
    begin
        // Rec.GetExcisePostingSetup;
    end;

    procedure ForceTotalsCalculation()
    var
        DocumentTotals: Codeunit "Document Totals";
    begin
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    procedure ShowDetailedTaxEntryBuffer()
    var
    // DetailedTaxEntryBuffer: Record 16480;
    begin
        // DetailedTaxEntryBuffer.RESET;
        // DetailedTaxEntryBuffer.SETCURRENTKEY("Transcation Type", "Document Type", "Document No.", "Line No.");
        // DetailedTaxEntryBuffer.SETRANGE("Transcation Type", DetailedTaxEntryBuffer."Transcation Type"::Purchase);
        // DetailedTaxEntryBuffer.SETRANGE("Document Type", "Document Type");
        // DetailedTaxEntryBuffer.SETRANGE("Document No.", "Document No.");
        // DetailedTaxEntryBuffer.SETRANGE("Line No.", "Line No.");
        // PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax", DetailedTaxEntryBuffer);
    end;
}
