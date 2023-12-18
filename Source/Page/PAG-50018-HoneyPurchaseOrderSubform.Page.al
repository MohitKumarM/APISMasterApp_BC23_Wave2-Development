page 50018 "Honey Purchase Order Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    ApplicationArea = All;
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Honey Item No."; Rec."Honey Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Deal No."; Rec."Deal No.")
                {
                    ApplicationArea = All;
                }
                /* field("Deal Line No."; Rec."Deal Line No.")
                {
                    ApplicationArea = All;
                } */ // 15800 Dispatch Discontinue
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. in Pack"; Rec."Qty. in Pack")
                {
                    ApplicationArea = All;
                }
                field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                // field("Tax Group Code"; Rec."Tax Group Code")
                // {
                //     ApplicationArea = All;
                //     Visible = true;
                // }
                // field("Tax Area Code"; Rec."Tax Area Code")
                // {
                //     Editable = false;
                // }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    ApplicationArea = All;

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
                        REc.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

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
                    ApplicationArea = All;

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
                action("Item Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
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
                    visible = false;
                    trigger OnAction()
                    begin
                        // This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        // ShowStrDetailsForm;
                    end;
                }
                action("E&xcise Detail")
                {
                    Caption = 'E&xcise Detail';
                    Image = Excise;
                    Visible = False;

                    trigger OnAction()
                    begin
                        // This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        //ShowExcisePostingSetup;
                    end;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    Image = TaxDetail;
                    Visible = False;
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
        DocumentTotals: Codeunit "Document Totals";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        //PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.';

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

    /* procedure ShowPrices()
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
    // StrOrderLineDetails: Record 13795;
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

    procedure ForceTotalsCalculation()
    begin
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;
}
