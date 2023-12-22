page 50161 "Store Honey PO"
{
    // Caption = 'Purchase Order';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    Editable = false;
    PageType = Document;
    ApplicationArea = All;
    RefreshOnActivate = true;
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
                    field("Shipping Vendor"; Rec."Shipping Vendor")
                    {
                        ApplicationArea = All;
                    }
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
                    field("Order Type"; Rec."Order Type")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field("Document Date"; Rec."Document Date")
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
                        Visible = false;
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
                    field("Shipping Agent Code"; Rec."Shipping Agent Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Valid Till"; Rec."Valid Till")
                    {
                        ApplicationArea = All;
                    }
                    field("Transit Insurance"; Rec."Transit Insurance")
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
                    // field("C Form"; Rec."C Form")
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field("Form Code"; Rec."Form Code")
                    // {
                    //     Importance = Promoted;
                    //     ApplicationArea = All;
                    // }
                    field(Status; Rec.Status)
                    {
                        Importance = Promoted;
                        ApplicationArea = All;
                        Enabled = true;
                    }
                    field("Product Group Code"; Rec."Product Group Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Posting No. Series"; Rec."Posting No. Series")
                    {
                        ApplicationArea = All;
                    }
                    field("Receiving No. Series"; Rec."Receiving No. Series")
                    {
                        ApplicationArea = All;
                    }
                    field("Waybill No."; Rec."Waybill No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Freight Liability"; Rec."Freight Liability")
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
                }
            }
            part(PurchLines; "Store Honey Subform")
            {
                SubPageLink = "Document No." = field("No.");
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

            action(Post1)
            {
                ApplicationArea = Suite;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostOrder;
                ShortCutKey = 'F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    GateEntryAttachment: Record "Gate Entry Attachment";
                    ReservationEntry: Record "Reservation Entry";
                    PurchaseLine: Record "Purchase Line";
                    PurchasePayableSetup: Record "Purchases & Payables Setup";
                    TotalQuantity: Decimal;
                begin
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source Type", Database::"Purchase Line");
                    ReservationEntry.SetRange("Source ID", Rec."No.");
                    ReservationEntry.CalcSums(ReservationEntry.Tin, ReservationEntry.Drum, ReservationEntry.Bucket, ReservationEntry.Can);

                    if (ReservationEntry.Tin <> 0) or (ReservationEntry.Drum <> 0) or (ReservationEntry.Bucket <> 0) or (ReservationEntry.Can <> 0) then
                        if not rec."Creation Tin&Drum&Bucket Item" then
                            Error('Please first Click the "Get Tin,Drum & Bucket" Button on Purchase Line');
                    TotalQuantity := (ReservationEntry.Tin + ReservationEntry.Drum + ReservationEntry.Can + ReservationEntry.Bucket);
                    PurchasePayableSetup.Get();
                    PurchasePayableSetup.TestField("Tin Item");
                    PurchasePayableSetup.TestField("Drum Item");
                    PurchasePayableSetup.TestField("Bucket Item");
                    PurchasePayableSetup.TestField("CAN Item");

                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", Rec."No.");
                    PurchaseLine.SetRange("No.", PurchasePayableSetup."Tin Item");
                    if PurchaseLine.FindFirst() then begin
                        if PurchaseLine.Quantity <> ReservationEntry.Tin then
                            Error('Tin Item Quantity Must be Match Total Tin Qty. value In Reservation Entry.');
                    end else begin
                        if (ReservationEntry.Tin <> 0) then begin
                            Error('You have Define Tin Quantity in Tracking Lines But Not get the PO So Please Click again the "Get Tin,Drum & Bucket" Button on Purchase Line');
                        end;
                    end;

                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", Rec."No.");
                    PurchaseLine.SetRange("No.", PurchasePayableSetup."Drum Item");
                    if PurchaseLine.FindFirst() then begin
                        if PurchaseLine.Quantity <> ReservationEntry.Drum then
                            Error('Drum Item Quantity Must be Match Total Drum Qty. value In Reservation Entry.');
                    end else begin
                        if (ReservationEntry.Drum <> 0) then begin
                            Error('You have Define Drum Quantity in Tracking Lines But Not get the PO So Please Click again the "Get Tin,Drum & Bucket" Button on Purchase Line');
                        end;
                    end;
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", Rec."No.");
                    PurchaseLine.SetRange("No.", PurchasePayableSetup."Bucket Item");
                    if PurchaseLine.FindFirst() then begin
                        if PurchaseLine.Quantity <> ReservationEntry.Bucket then
                            Error('Bucket Item Quantity Must be Match Total Bucket Qty. value In Reservation Entry.');
                    end else begin
                        if (ReservationEntry.Bucket <> 0) then begin
                            Error('You have Define Bucket Quantity in Tracking Lines But Not get the PO So Please Click again the "Get Tin,Drum & Bucket" Button on Purchase Line');
                        end;
                    end;

                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", Rec."No.");
                    PurchaseLine.SetRange("No.", PurchasePayableSetup."CAN Item");
                    if PurchaseLine.FindFirst() then begin
                        if PurchaseLine.Quantity <> ReservationEntry.Can then
                            Error('Can Item Quantity Must be Match Total Can Qty. value In Reservation Entry.');
                    end else begin
                        if (ReservationEntry.Can <> 0) then begin
                            Error('You have Define Can Quantity in Tracking Lines But Not get the PO So Please Click again the "Get Tin,Drum & Bucket" Button on Purchase Line');
                        end;
                    end;

                    GateEntryAttachment.Reset();
                    GateEntryAttachment.SetRange("Source Type", GateEntryAttachment."Source Type"::"Purchase Order");
                    GateEntryAttachment.SetRange("Entry Type", GateEntryAttachment."Entry Type"::Inward);
                    GateEntryAttachment.SetRange("Source No.", rec."No.");
                    if not GateEntryAttachment.FindFirst() then
                        Error('Gate Entry Must be Attached.');
                    if not CONFIRM('Do you want to Receive the selected Order?', false) then
                        Error('');
                    PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");
                end;
            }

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
                    Visible = true;

                    trigger OnAction()
                    begin
                        Rec.OpenPurchaseOrderStatistics();
                        CurrPage.PurchLines.Page.ForceTotalsCalculation();
                        // PurchSetup.GET;
                        // IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        //     Rec.CalcInvDiscForHeader;
                        //     COMMIT;
                        // END;
                        // IF Structure <> '' THEN BEGIN
                        //     PurchLine.CalculateStructures(Rec);
                        //     PurchLine.AdjustStructureAmounts(Rec);
                        //     PurchLine.UpdatePurchLines(Rec);
                        //     PurchLine.CalculateTDS(Rec);
                        // END ELSE
                        //     PurchLine.CalculateTDS(Rec);

                        // COMMIT;
                        // PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
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
                action("Get Gate Entry Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Image = GetLines;
                    ToolTip = 'View available gate entry lines for attachment.';
                    trigger OnAction()
                    var
                        GateEntryHandler: Codeunit "Gate Entry Handler";
                    begin
                        GateEntryHandler.GetPurchaseGateEntryLines(Rec);
                    end;
                }
                action("Attached Gate Entry")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Gate Entry Attachment List";
                    RunPageLink = "Source No." = field("No."), "Source Type" = const("Purchase Order"), "Entry Type" = const(Inward);
                    ToolTip = 'View attached gate entry list.';
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
                action("Submit for GAN Creation")
                {
                    Caption = 'Submit for GAN Creation';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Buy-from Vendor No.");
                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Shortcut Dimension 1 Code");

                        IF NOT CONFIRM('Do you want to submit the order for GAN creation?', FALSE) THEN
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
                                // 15800 Dispatch DiscontinuePurchLine.TESTFIELD("Deal Line No.");
                                // 15800 Dispatch Discontinue  PurchLine.TESTFIELD("Dispatched Qty. in Kg.");
                                PurchLine.TESTFIELD(Quantity);
                                // 15800 Dispatch Discontinue  PurchLine.TESTFIELD("Packing Type");
                                PurchLine.TESTFIELD("Qty. in Pack");
                            UNTIL PurchLine.NEXT = 0 ELSE
                            ERROR('Nothing to Submit.');

                        Rec."Order Approval Pending" := TRUE;
                        Rec.MODIFY;

                        MESSAGE('The Order is successfully submitted for GAN Creation.');
                        CurrPage.CLOSE;
                    end;
                }
                // action("Short Closed")
                // {
                //     Caption = 'Short Closed';
                //     Image = Close;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = all;
                //     Visible = false;
                //     trigger OnAction()
                //     var
                //         PurchasePayableSetup: Record "Purchases & Payables Setup";
                //     begin

                //         PurchasePayableSetup.get;
                //         PurchasePayableSetup.TestField("Archive Orders", true);
                //         rec.TestField("Short Close Comment");
                //         IF NOT CONFIRM('Do you want to Short Close the selected Order?', FALSE) THEN
                //             EXIT;
                //         Rec."Short Close" := true;
                //         Rec.Modify();
                //         ArchiveManagement.AutoArchivePurchDocument(Rec);
                //         CurrPage.Close();
                //     end;
                // }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = rec.Status <> Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
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
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(50062, TRUE, TRUE, recPurchHeader);
                    end;
                }
                action("&Print GST")
                {
                    Caption = '&Print GST';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        recPurchHeader.RESET;
                        recPurchHeader.SETRANGE("Document Type", Rec."Document Type"::Order);
                        recPurchHeader.SETRANGE("No.", Rec."No.");

                        REPORT.RUN(50061, TRUE, TRUE, recPurchHeader);
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
            Rec.SetRange("Short Close", false);
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

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
        IsHandled: Boolean;
        DocumentIsPosted: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        IsHandled := false;
        //OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            Enum::"Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        //  ShowPostedConfirmationMessage();

                        if IsScheduledPosting or DocumentIsPosted then
                            CurrPage.Close();
                end;
            Enum::"Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    //OnPostDocumentOnBeforePurchaseHeaderInsert(PurchaseHeader);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;




}
