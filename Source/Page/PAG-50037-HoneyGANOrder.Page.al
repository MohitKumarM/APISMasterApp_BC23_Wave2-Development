page 50037 "Honey GAN Order"
{
    // Caption = 'Purchase Order';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Subcontracting = FILTER(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                    field("Waybill No."; Rec."Waybill No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Vehicle No."; Rec."Vehicle No.")
                    {
                        ApplicationArea = All;
                    }
                    field("GR / LR No."; Rec."GR / LR No.")
                    {
                        ApplicationArea = All;
                    }
                    field("GR / LR Date"; Rec."GR / LR Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Gate Entry No."; Rec."Gate Entry No.")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field("Gate Entry Date"; Rec."Gate Entry Date")
                    {
                        Visible = false;
                    }
                    field("Purchaser Code"; Rec."Purchaser Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Invoice Value"; Rec."Vendor Invoice Value")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Agent Code"; Rec."Shipping Agent Code")
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
                    // field("C Form"; Rec."C Form")
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field("Form Code"; Rec."Form Code")
                    // {
                    //     Importance = Promoted;
                    //     ApplicationArea = All;
                    // }
                }
                group("Buy from Vendor")
                {
                    Caption = 'Buy from Vendor';
                    Editable = false;
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
                    Editable = false;
                    field("Location Code"; Rec."Location Code")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    field("Order Date"; Rec."Order Date")
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                    }
                    field("Document Date"; Rec."Document Date") { }
                    // field(Structure; Rec.Structure)
                    // {
                    //     Importance = Promoted;
                    // }
                }
                group("Other Detail")
                {
                    Caption = 'Other Detail';
                    Editable = false;
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
                        Visible = false;

                        trigger OnValidate()
                        begin
                            ShortcutDimension2CodeOnAfterV;
                        end;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
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
                    field("Posting No. Series"; Rec."Posting No. Series")
                    {
                        ApplicationArea = All;
                    }
                    field("Receiving No. Series"; Rec."Receiving No. Series")
                    {
                        ApplicationArea = All;
                    }
                    field("Freight Liability"; Rec."Freight Liability")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(PurchLines; "Honey GAN Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(TaxInformation; "Tax Information Factbox")
            {
                Provider = PurchLines;
                SubPageLink = "Table ID Filter" = const(39), "Document Type Filter" = const(1), "Document No. Filter" = field("Document No."), "Line No. Filter" = field("Line No.");
                ApplicationArea = Basic, Suite;
            }
            part(PurchaseDocCheckFactbox; "Purch. Doc. Check Factbox")
            {
                ApplicationArea = All;
                Caption = 'Document Check';
                Visible = PurchaseDocCheckFactboxVisible;
                SubPageLink = "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(38),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part(Control23; "Pending Approval FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No."),
                              Status = const(Open);
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Pay-to Vendor No."),
                              "Date Filter" = field("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Pay-to Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
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
                    Visible = false;

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
                    Visible = false;

                    trigger OnAction()
                    begin
                        // PurchLine.CalculateTDS(Rec);
                    end;
                }
                action("Submit for GAN Approval")
                {
                    Caption = 'Submit for GAN Approval';
                    Image = SendTo;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Buy-from Vendor No.");
                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Shortcut Dimension 1 Code");
                        Rec.TESTFIELD("Vendor Invoice No.");

                        IF NOT CONFIRM('Do you want to submit the order for GAN approval?', FALSE) THEN
                            EXIT;

                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine.SETRANGE("Document No.", Rec."No.");
                        IF PurchLine.FINDFIRST THEN
                            REPEAT
                                PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
                                PurchLine.TESTFIELD("No.");

                                recProductGroup.GET(PurchLine."New Product Group Code", PurchLine."Item Category Code");
                                IF NOT recProductGroup."Allow Direct Purch. Order" THEN
                                    ERROR('Selected Item is not allowed in direct purchase order.');

                                PurchLine.TESTFIELD("Location Code");
                                PurchLine.TESTFIELD(Quantity);
                                PurchLine.TESTFIELD("Deal No.");
                                PurchLine.TESTFIELD("Deal Line No.");
                                PurchLine.TESTFIELD("Dispatched Qty. in Kg.");
                                PurchLine.TESTFIELD(Quantity);
                                PurchLine.TESTFIELD("Packing Type");
                                PurchLine.TESTFIELD("Qty. in Pack");

                                IF PurchLine."Qty. to Receive" <> 0 THEN BEGIN
                                    recItem.GET(PurchLine."No.");
                                    IF recItem."Item Tracking Code" <> '' THEN BEGIN
                                        recItemTracking.GET(recItem."Item Tracking Code");
                                        IF recItemTracking."Lot Purchase Inbound Tracking" THEN BEGIN
                                            PurchLine.CALCFIELDS("Item Tracking Quantity Honey");
                                            IF PurchLine."Item Tracking Quantity Honey" <> PurchLine."Qty. to Receive" THEN
                                                ERROR('Item tracking is missing.');
                                        END;
                                    END;
                                END;
                            UNTIL PurchLine.NEXT = 0 ELSE
                            ERROR('Nothing to Submit.');

                        Rec."GAN Approval Pending" := TRUE;
                        Rec.MODIFY;

                        MESSAGE('The Order is successfully submitted for GAN Approval.');
                        CurrPage.CLOSE;
                    end;
                }
                action(Reopen)
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM('Do you want to reopen the order?', FALSE) THEN
                            EXIT;

                        Rec."Order Approval Pending" := FALSE;
                        Rec.MODIFY;
                        CurrPage.CLOSE;
                        MESSAGE('The selected order has been re-opened.');
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print GAN")
                {
                    Caption = '&Print GAN';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        // REPORT.RUN(50013, TRUE, TRUE, recPurchHeader); //Shivam
                        REPORT.RUN(Report::"Purchase Receipt H-Pre", TRUE, TRUE, recPurchHeader); //Shivam
                    end;
                }
                action("&Print Order")
                {
                    Caption = '&Print Order';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false; //Shivam

                    trigger OnAction()
                    var
                        recPurchHeader: Record "Purchase Header";
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Order", TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("Print GST GAN")
                {
                    Caption = 'Print GST GAN';
                    Image = Print;
                    Promoted = true;
                    Visible = false; //Shivam

                    trigger OnAction()
                    begin
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(Report::"Purchase Receipt H-Pre", TRUE, TRUE, recPurchHeader);
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
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
        // DefermentBuffer: Record 16532;

        JobQueueVisible: Boolean;
        recProductGroup: Record "New Product Group";
        recPurchHeader: Record "Purchase Header";
        recItem: Record Item;
        recItemTracking: Record "Item Tracking Code";
        HasIncomingDocument: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ShouldSearchForVendByName: Boolean;
        PurchaseDocCheckFactboxVisible: Boolean;
        IsPurchaseLinesEditable: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        // CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
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
        // CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
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

    [IntegrationEvent(true, false)]
    local procedure OnAfterSetControlAppearance()
    begin
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId());
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId());
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId(), CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        ShouldSearchForVendByName := Rec.ShouldSearchForVendorByName(Rec."Buy-from Vendor No.");
        PurchaseDocCheckFactboxVisible := DocumentErrorsMgt.BackgroundValidationEnabled();
        if not IsPurchaseLinesEditable then
            IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();

        OnAfterSetControlAppearance();
    end;

    local procedure SetExtDocNoMandatoryCondition()
    begin
        PurchSetup.GetRecordOnce();
        VendorInvoiceNoMandatory := PurchSetup."Ext. Doc. No. Mandatory";
    end;
}
