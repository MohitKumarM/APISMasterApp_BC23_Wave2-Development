page 50004 "Quality Check Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Purch. Rcpt. Line" = rm;
    SourceTable = "Quality Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field("QC Analytical Report No."; rec."QC Analytical Report No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Code"; rec."Item Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Name"; rec."Item Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; rec."Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approved Quantity"; rec."Approved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Rejected Quantity"; rec."Rejected Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Sampled By"; rec."Sampled By")
                {
                    ApplicationArea = All;
                }
                field("Tested By"; rec."Tested By")
                {
                    ApplicationArea = All;
                }
            }
            part("Quality Check Lines"; "Quality Check Lines")
            {
                SubPageLink = "QC No." = FIELD("No.");
                SubPageView = SORTING("QC No.")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF rec.Posted THEN
                        EXIT;

                    IF NOT CONFIRM('Do you want to post the quality lines?', FALSE) THEN
                        EXIT;

                    IF rec.Quantity = 0 THEN
                        ERROR('The quantity must not be zero.');

                    IF rec.Quantity <> rec."Approved Quantity" + rec."Rejected Quantity" THEN
                        ERROR('The sum of approved and rejected quantity must be %1.', rec.Quantity);

                    recPurchRcptLine.RESET;
                    recPurchRcptLine.SETRANGE("Document No.", Rec."Document No.");
                    recPurchRcptLine.SETRANGE("Line No.", Rec."Document Line No.");
                    recPurchRcptLine.SETRANGE(Type, recPurchRcptLine.Type::Item);
                    recPurchRcptLine.SETRANGE("QC Completed", FALSE);
                    recPurchRcptLine.FINDFIRST;

                    decApprovedQty := Rec."Approved Quantity";
                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Document No.", Rec."Document No.");
                    recItemLedger.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recItemLedger.SETRANGE("Quality Checked", FALSE);
                    recItemLedger.FINDFIRST;
                    REPEAT
                        IF decApprovedQty <= recItemLedger.Quantity THEN BEGIN
                            recItemLedger."Approved Quantity" := decApprovedQty;
                            recItemLedger."Rejected Quantity" := recItemLedger.Quantity - recItemLedger."Approved Quantity";
                            recItemLedger.MODIFY;
                            decApprovedQty := 0;
                        END ELSE BEGIN
                            recItemLedger."Approved Quantity" := recItemLedger.Quantity;
                            recItemLedger."Rejected Quantity" := 0;
                            recItemLedger.MODIFY;
                            decApprovedQty := decApprovedQty - recItemLedger.Quantity;
                        END;
                    UNTIL (recItemLedger.NEXT = 0) OR (decApprovedQty = 0);

                    recInventorySetup.GET;
                    recInventorySetup.TESTFIELD("QC Entry Template");
                    recInventorySetup.TESTFIELD("QC Entry Batch");

                    recItemJournal.INIT;
                    recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                    recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                    recItemJournal.SETRANGE("Item No.", '');
                    IF recItemJournal.FINDLAST THEN
                        recItemJournal.DELETEALL;

                    recItemJournal.INIT;
                    recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                    recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                    IF recItemJournal.FINDLAST THEN
                        intLineNo := recItemJournal."Line No.";

                    recReservationEntry.RESET;
                    IF recReservationEntry.FIND('+') THEN
                        intEntryNo := recReservationEntry."Entry No.";

                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Document No.", Rec."Document No.");
                    recItemLedger.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recItemLedger.SETRANGE("Quality Checked", FALSE);
                    //recItemLedger.SETFILTER("Rejected Quantity", '<>%1', 0);
                    IF recItemLedger.FINDFIRST THEN
                        REPEAT
                            IF recItemLedger."Rejected Quantity" <> 0 THEN BEGIN
                                recItemJournal.INIT;
                                recItemJournal.VALIDATE("Journal Template Name", recInventorySetup."QC Entry Template");
                                recItemJournal.VALIDATE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                                intLineNo += 10000;
                                recItemJournal.VALIDATE("Line No.", intLineNo);
                                recItemJournal.VALIDATE("Posting Date", WORKDATE);
                                recItemJournal.VALIDATE("Document No.", recItemLedger."Document No.");
                                recItemJournal.VALIDATE("Item No.", recItemLedger."Item No.");
                                recItemJournal.VALIDATE("Entry Type", recItemJournal."Entry Type"::Transfer);
                                recItemJournal.VALIDATE("Location Code", recItemLedger."Location Code");
                                recLocation.GET(recItemLedger."Location Code");
                                recLocation.TESTFIELD("QC Rejection Location");
                                recItemJournal.VALIDATE("New Location Code", recLocation."QC Rejection Location");

                                recItemJournal.VALIDATE(Quantity, recItemLedger."Rejected Quantity");
                                recItemJournal.VALIDATE("Shortcut Dimension 1 Code", recItemLedger."Global Dimension 1 Code");
                                recItemJournal.VALIDATE("Shortcut Dimension 2 Code", recItemLedger."Global Dimension 2 Code");
                                recItemJournal.VALIDATE("New Shortcut Dimension 1 Code", recItemLedger."Global Dimension 1 Code");
                                recItemJournal.VALIDATE("New Shortcut Dimension 2 Code", recItemLedger."Global Dimension 2 Code");
                                //  recItemJournal.VALIDATE("Applies-to Entry","Entry No.");
                                recItemJournal."Temp Message Control" := TRUE;
                                recItemJournal.INSERT(TRUE);

                                IF (recItemLedger."Lot No." <> '') OR (recItemLedger."Serial No." <> '') THEN BEGIN
                                    recReservationEntry.INIT;
                                    intEntryNo += 1;
                                    recReservationEntry."Entry No." := intEntryNo;
                                    recReservationEntry.Positive := FALSE;
                                    recReservationEntry."Item No." := recItemLedger."Item No.";
                                    recReservationEntry."Location Code" := recItemLedger."Location Code";
                                    recReservationEntry.VALIDATE("Quantity (Base)", -recItemLedger."Rejected Quantity");
                                    recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                                    recReservationEntry."Creation Date" := TODAY;
                                    recReservationEntry."Source Type" := 83;
                                    recReservationEntry."Source Subtype" := 4;
                                    recReservationEntry."Source ID" := recInventorySetup."QC Entry Template";
                                    recReservationEntry."Source Batch Name" := recInventorySetup."QC Entry Batch";
                                    recReservationEntry."Source Ref. No." := intLineNo;
                                    recReservationEntry."Appl.-to Item Entry" := recItemLedger."Entry No.";

                                    IF recItemLedger."Lot No." <> '' THEN BEGIN
                                        recReservationEntry."Lot No." := recItemLedger."Lot No.";
                                        recReservationEntry."New Lot No." := recItemLedger."Lot No.";
                                        recReservationEntry."New Expiration Date" := recItemLedger."Expiration Date";
                                        recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                                    END;
                                    IF recItemLedger."Serial No." <> '' THEN BEGIN
                                        recReservationEntry."Serial No." := recItemLedger."Serial No.";
                                        recReservationEntry."New Serial No." := recItemLedger."Serial No.";
                                        recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Serial No.";
                                    END;

                                    recReservationEntry."Created By" := USERID;
                                    recReservationEntry."Qty. per Unit of Measure" := 1;
                                    recReservationEntry.Binding := recReservationEntry.Binding::" ";
                                    recReservationEntry."Suppressed Action Msg." := FALSE;
                                    recReservationEntry."Planning Flexibility" := recReservationEntry."Planning Flexibility"::Unlimited;
                                    recReservationEntry."Quantity Invoiced (Base)" := 0;
                                    recReservationEntry.Correction := FALSE;
                                    recReservationEntry.INSERT;
                                END;
                            END;
                            IF recItemLedger."Approved Quantity" <> 0 THEN BEGIN
                                recItemJournal.INIT;
                                recItemJournal.VALIDATE("Journal Template Name", recInventorySetup."QC Entry Template");
                                recItemJournal.VALIDATE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                                intLineNo += 10000;
                                recItemJournal.VALIDATE("Line No.", intLineNo);
                                recItemJournal.VALIDATE("Posting Date", WORKDATE);
                                recItemJournal.VALIDATE("Document No.", recItemLedger."Document No.");
                                recItemJournal.VALIDATE("Item No.", recItemLedger."Item No.");
                                recItemJournal.VALIDATE("Entry Type", recItemJournal."Entry Type"::Transfer);
                                recItemJournal.VALIDATE("Location Code", recItemLedger."Location Code");
                                recLocation.GET(recItemLedger."Location Code");
                                recLocation.TESTFIELD("OK Store Location");
                                recItemJournal.VALIDATE("New Location Code", recLocation."OK Store Location");

                                recItemJournal.VALIDATE(Quantity, recItemLedger."Approved Quantity");
                                recItemJournal.VALIDATE("Shortcut Dimension 1 Code", recItemLedger."Global Dimension 1 Code");
                                recItemJournal.VALIDATE("Shortcut Dimension 2 Code", recItemLedger."Global Dimension 2 Code");
                                recItemJournal.VALIDATE("New Shortcut Dimension 1 Code", recItemLedger."Global Dimension 1 Code");
                                recItemJournal.VALIDATE("New Shortcut Dimension 2 Code", recItemLedger."Global Dimension 2 Code");
                                //  recItemJournal.VALIDATE("Applies-to Entry","Entry No.");
                                recItemJournal."Temp Message Control" := TRUE;
                                recItemJournal.INSERT(TRUE);

                                IF (recItemLedger."Lot No." <> '') OR (recItemLedger."Serial No." <> '') THEN BEGIN
                                    recReservationEntry.INIT;
                                    intEntryNo += 1;
                                    recReservationEntry."Entry No." := intEntryNo;
                                    recReservationEntry.Positive := FALSE;
                                    recReservationEntry."Item No." := recItemLedger."Item No.";
                                    recReservationEntry."Location Code" := recItemLedger."Location Code";
                                    recReservationEntry.VALIDATE("Quantity (Base)", -recItemLedger."Approved Quantity");
                                    recReservationEntry."Reservation Status" := recReservationEntry."Reservation Status"::Prospect;
                                    recReservationEntry."Creation Date" := TODAY;
                                    recReservationEntry."Source Type" := 83;
                                    recReservationEntry."Source Subtype" := 4;
                                    recReservationEntry."Source ID" := recInventorySetup."QC Entry Template";
                                    recReservationEntry."Source Batch Name" := recInventorySetup."QC Entry Batch";
                                    recReservationEntry."Source Ref. No." := intLineNo;
                                    recReservationEntry."Appl.-to Item Entry" := recItemLedger."Entry No.";

                                    IF recItemLedger."Lot No." <> '' THEN BEGIN
                                        recReservationEntry."Lot No." := recItemLedger."Lot No.";
                                        recReservationEntry."New Lot No." := recItemLedger."Lot No.";
                                        recReservationEntry."New Expiration Date" := recItemLedger."Expiration Date";
                                        recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Lot No.";
                                    END;
                                    IF recItemLedger."Serial No." <> '' THEN BEGIN
                                        recReservationEntry."Serial No." := recItemLedger."Serial No.";
                                        recReservationEntry."New Serial No." := recItemLedger."Serial No.";
                                        recReservationEntry."Item Tracking" := recReservationEntry."Item Tracking"::"Serial No.";
                                    END;

                                    recReservationEntry."Created By" := USERID;
                                    recReservationEntry."Qty. per Unit of Measure" := 1;
                                    recReservationEntry.Binding := recReservationEntry.Binding::" ";
                                    recReservationEntry."Suppressed Action Msg." := FALSE;
                                    recReservationEntry."Planning Flexibility" := recReservationEntry."Planning Flexibility"::Unlimited;
                                    recReservationEntry."Quantity Invoiced (Base)" := 0;
                                    recReservationEntry.Correction := FALSE;
                                    recReservationEntry.INSERT;
                                END;
                            END;
                            recItemLedger."Quality Checked" := TRUE;
                            recItemLedger.MODIFY;
                        UNTIL recItemLedger.NEXT = 0;

                    recItemJournal.RESET;
                    recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                    recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                    recItemJournal.SETRANGE("Document No.", Rec."Document No.");
                    IF recItemJournal.FIND('-') THEN
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", recItemJournal);

                    recPurchRcptLine."QC Completed" := TRUE;
                    recPurchRcptLine.MODIFY;

                    Rec.Posted := TRUE;
                    Rec.MODIFY;

                    MESSAGE('Quality lines successfully posted.');

                    CurrPage.CLOSE;
                end;
            }
            action("Submit for Approval")
            {
                Caption = 'Submit for Approval';
                Image = SendTo;
                Promoted = true;

                trigger OnAction()
                begin
                    IF rec.Posted THEN
                        EXIT;

                    IF rec.Quantity = 0 THEN
                        ERROR('The quantity must not be zero.');

                    IF rec.Quantity <> rec."Approved Quantity" + rec."Rejected Quantity" THEN
                        ERROR('The sum of approved and rejected quantity must be %1.', rec.Quantity);

                    IF NOT CONFIRM('Want to submit the QC Details for Approval?', FALSE) THEN
                        EXIT;

                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Document No.", Rec."Document No.");
                    recItemLedger.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recItemLedger.SETRANGE("Lot No.", Rec."Lot No.");
                    recItemLedger.FINDFIRST;
                    recItemLedger."QC To Approve" := TRUE;
                    recItemLedger.MODIFY;

                    /*
                    recPurchRcptLine.RESET;
                    recPurchRcptLine.SETRANGE("Document No.", Rec."Document No.");
                    recPurchRcptLine.SETRANGE("Line No.", Rec."Document Line No.");
                    recPurchRcptLine.SETRANGE(Type, recPurchRcptLine.Type::Item);
                    recPurchRcptLine.SETRANGE("QC Completed", FALSE);
                    recPurchRcptLine.SETRANGE("Pending QC Approval", FALSE);
                    recPurchRcptLine.FINDFIRST;

                    recPurchRcptLine."Pending QC Approval" := TRUE;
                    recPurchRcptLine.MODIFY;
                    */
                    CurrPage.CLOSE;
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin
                    recQuality.RESET;
                    recQuality.SETRANGE("No.", Rec."No.");
                    recQuality.FINDFIRST;

                    IF recQuality."Document Type" = recQuality."Document Type"::"Purchase Receipt" THEN
                        REPORT.RUN(50017, TRUE, TRUE, recQuality)
                    ELSE
                        REPORT.RUN(50054, TRUE, TRUE, recQuality);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF rec.Posted THEN
            CurrPage.EDITABLE := FALSE;
    end;

    var
        recPurchRcptLine: Record "Purch. Rcpt. Line";
        recItemLedger: Record "Item Ledger Entry";
        decApprovedQty: Decimal;
        recItemJournal: Record "Item Journal Line";
        recInventorySetup: Record "Inventory Setup";
        intLineNo: Integer;
        recLocation: Record Location;
        recReservationEntry: Record "Reservation Entry";
        intEntryNo: Integer;
        recQuality: Record "Quality Header";
}
