page 50041 "GAN Approval Order"
{
    Caption = 'GAN Approval Order';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Subcontracting = const(false));

    layout
    {
        area(content)
        {
            group("GAN Details")
            {
                Caption = 'GAN Details';
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry No."; Rec."Gate Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry Date"; Rec."Gate Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Waybill No."; Rec."Waybill No.") { }
                field("GR / LR No."; Rec."GR / LR No.")
                {
                    ApplicationArea = All;
                }
                field("GR / LR Date"; Rec."GR / LR Date")
                {
                    ApplicationArea = All;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = All;
                }
                field("GST Dependency Type"; Rec."GST Dependency Type")
                {
                    ApplicationArea = All;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date") { }
                field("Activity Name"; Rec."Activity Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity Name field.';
                }
                field("Activity City"; Rec."Activity City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity City field.';
                }
                field("Activity State"; Rec."Activity State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity State field.';
                }
                field("Sales Channel"; Rec."Sales Channel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Channel field.';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Receiving No. Series"; Rec."Receiving No. Series")
                {
                    ApplicationArea = All;
                }
            }
            group(General)
            {
                Caption = 'General';
                Editable = false;
                group("Buy from Vendor")
                {
                    Caption = 'Buy from Vendor';
                    field("No."; Rec."No.")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            IF Rec.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                        end;
                    }
                    field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            BuyfromVendorNoOnAfterValidate;
                        end;
                    }
                    field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        Importance = Additional;
                        ApplicationArea = All;
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        Importance = Additional;
                        ApplicationArea = All;
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        Importance = Additional;
                        ApplicationArea = All;
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = All;
                    }
                    field(State; Rec.State)
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                    {
                        ApplicationArea = All;
                    }
                }
                group("General ")
                {
                    Caption = 'General ';
                    field("Location Code"; Rec."Location Code")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field("Order Date"; Rec."Order Date")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    // field(Structure; Rec.Structure)
                    // {
                    //     Importance = Promoted;
                    // }
                }
                group("Other Detail")
                {
                    Caption = 'Other Detail';
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            ShortcutDimension1CodeOnAfterV;
                        end;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            ShortcutDimension2CodeOnAfterV;
                        end;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    field("Shipment Method Code"; Rec."Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Transport Method"; Rec."Transport Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Currency Code"; Rec."Currency Code")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            CLEAR(ChangeExchangeRate);
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                            IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                                Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                                CurrPage.UPDATE;
                            END;
                            CLEAR(ChangeExchangeRate);
                        end;
                    }
                    field(Status; Rec.Status)
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }

                    // field("Job Queue Status"; Rec."Job Queue Status")
                    // {
                    //     ApplicationArea = All;
                    // }
                }
            }
            part(PurchLines; "Honey GAN Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    Visible = false;

                    // trigger OnAction()
                    // begin
                    //     PurchSetup.GET;
                    //     IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                    //         Rec.CalcInvDiscForHeader;
                    //         COMMIT;
                    //     END;
                    //     IF Structure <> '' THEN BEGIN
                    //         PurchLine.CalculateStructures(Rec);
                    //         PurchLine.AdjustStructureAmounts(Rec);
                    //         PurchLine.UpdatePurchLines(Rec);
                    //         PurchLine.CalculateTDS(Rec);
                    //     END ELSE
                    //         PurchLine.CalculateTDS(Rec);

                    //     COMMIT;
                    //     PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    // end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                // action("St&ructure")
                // {
                //     Caption = 'St&ructure';
                //     Image = Hierarchy;
                //     RunObject = Page 16305;
                //     RunPageLink = Type = CONST(Purchase),
                //                   "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("No.");
                // }
                // action("Detailed &Tax")
                // {
                //     Caption = 'Detailed &Tax';
                //     Image = TaxDetail;
                //     RunObject = Page 16341;
                //     RunPageLink = "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("No."),
                //                   "Transcation Type" = CONST(Purchase);
                // }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;

                    trigger OnAction()
                    begin
                        // PurchLine.CalculateStructures(Rec);
                        // PurchLine.AdjustStructureAmounts(Rec);
                        // PurchLine.UpdatePurchLines(Rec);
                    end;
                }
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';

                    trigger OnAction()
                    begin
                        // PurchLine.CalculateTDS(Rec);
                    end;
                }
                action(Statistics1)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        rec.OpenPurchaseOrderStatistics();
                        CurrPage.PurchLines.Page.ForceTotalsCalculation();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        CheckQtyToReceive();

                        Post(CODEUNIT::"Purch.-Post (Yes/No)");

                        Rec."GAN Approval Pending" := false;
                        Rec.MODIFY;
                        CurrPage.CLOSE;
                    end;
                }
                action("Sent Back")
                {
                    Image = Reject;
                    Promoted = true;

                    trigger OnAction()
                    var
                        usersetup: Record "User Setup";
                    begin
                        if usersetup.Get(UserId) then begin
                            if usersetup."Allow Send Back Deal" then begin
                                IF NOT CONFIRM('Do you want to return the GAN for correction?', FALSE) THEN
                                    EXIT;

                                Rec."GAN Approval Pending" := false;
                                Rec.MODIFY;
                                CurrPage.CLOSE;
                            end else
                                if usersetup."Allow Send Back Deal" = false then
                                    Error('You are not allowed to Send back the PO %1', Rec."No.");
                        end;
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("Print GST GAN (Honey)")
                {
                    Caption = 'Print GST GAN (Honey)';
                    Image = Print;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt H-Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("Print GST GAN (Other)")
                {
                    Caption = 'Print GST GAN (Other)';
                    Image = Print;
                    Promoted = true;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt Other Pre", TRUE, TRUE, recPurchHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        // DefermentBuffer: Record 16532;

        JobQueueVisible: Boolean;
    // recProductGroup: Record 5723;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CheckQtyToReceive()
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", Rec."Document Type");
        PurchLine.SetRange("Document No.", Rec."No.");
        if PurchLine.FindSet() then
            repeat
                if PurchLine."Qty. to Receive" > PurchLine."Outstanding Quantity" then
                    Error('Quatity to Receive must not be greater than Outstanding Quantity.');
            until PurchLine.Next() = 0;
    end;
}
