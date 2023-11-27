page 50022 "Quality Check Card to Approve"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Purch. Rcpt. Line" = rm;
    SourceTable = "Quality Header";

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

                trigger OnAction()
                begin
                    //Error('Wait for Some time');
                    IF rec.Posted THEN
                        EXIT;

                    IF NOT CONFIRM('Do you want to post the quality lines?', FALSE) THEN
                        EXIT;

                    IF rec.Quantity = 0 THEN
                        ERROR('The quantity must not be zero.');

                    IF rec.Quantity <> rec."Approved Quantity" + rec."Rejected Quantity" THEN
                        ERROR('The sum of approved and rejected quantity must be %1.', rec.Quantity);

                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Document No.", Rec."Document No.");
                    recItemLedger.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recItemLedger.SETRANGE("Lot No.", Rec."Lot No.");
                    recItemLedger.FINDFIRST;
                    recItemLedger."Approved Quantity" := Rec."Approved Quantity";
                    recItemLedger."Rejected Quantity" := recItemLedger.Quantity - recItemLedger."Approved Quantity";
                    recItemLedger.MODIFY;

                    /*
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
                    */

                    recInventorySetup.GET;
                    recInventorySetup.TESTFIELD("QC Entry Template");
                    recInventorySetup.TESTFIELD("QC Entry Batch");

                    recItemJournal.RESET;
                    recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                    recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                    recItemJournal.SETRANGE("Item No.", '');
                    IF recItemJournal.FINDLAST THEN
                        recItemJournal.DELETEALL;

                    recItemJournal.RESET;
                    recItemJournal.SETRANGE("Journal Template Name", recInventorySetup."QC Entry Template");
                    recItemJournal.SETRANGE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                    IF recItemJournal.FINDLAST THEN
                        intLineNo := recItemJournal."Line No.";

                    recItemLedger.RESET;
                    recItemLedger.SETRANGE("Document No.", Rec."Document No.");
                    recItemLedger.SETRANGE("Document Line No.", Rec."Document Line No.");
                    recItemLedger.SETRANGE("Lot No.", Rec."Lot No.");
                    recItemLedger.SETRANGE("Quality Checked", FALSE);
                    IF recItemLedger.FINDFIRST THEN
                        REPEAT
                            IF recItemLedger."Rejected Quantity" <> 0 THEN BEGIN
                                recItemJournal.INIT;
                                recItemJournal.VALIDATE("Journal Template Name", recInventorySetup."QC Entry Template");
                                recItemJournal.VALIDATE("Journal Batch Name", recInventorySetup."QC Entry Batch");
                                intLineNo += 10000;
                                recItemJournal.VALIDATE("Line No.", intLineNo);
                                recItemJournal.VALIDATE("Posting Date", TODAY);
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
                                recItemJournal."Qty. in Pack" := ROUND((recItemLedger."Qty. in Pack" / recItemLedger.Quantity * recItemLedger."Rejected Quantity"), 1);
                                decTinsAdjusted := recItemJournal."Qty. in Pack";

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::Moisture);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal."Moisture (%)" := recQualityLines.Observation;
                                    recItemLedger."Moisture (%)" := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::Color);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal."Color (MM)" := recQualityLines.Observation;
                                    recItemLedger."Color (MM)" := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::HMF);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal."HMF (PPM)" := recQualityLines.Observation;
                                    recItemLedger."HMF (PPM)" := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::TRS);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal.TRS := recQualityLines.Observation;
                                    recItemLedger.TRS := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::Sucrose);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal.Sucrose := recQualityLines.Observation;
                                    recItemLedger.Sucrose := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::FG);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal.FG := recQualityLines.Observation;
                                    recItemLedger.FG := recQualityLines.Observation;
                                END;

                                recItemJournal.INSERT(TRUE);

                                recPostedLotTracking.RESET;
                                IF recPostedLotTracking.FINDLAST THEN
                                    intEntryNo := recPostedLotTracking."Entry No."
                                ELSE
                                    intEntryNo := 0;

                                decRemainingQty := recItemLedger."Rejected Quantity";
                                recLotTracking.RESET;
                                recLotTracking.SETCURRENTKEY("Document No.", "Document Line No.", "Item No.", "Location Code", "Lot No.", Positive, "Remaining Qty.");
                                recLotTracking.SETRANGE("Document No.", recItemLedger."Document No.");
                                recLotTracking.SETRANGE("Document Line No.", recItemLedger."Document Line No.");
                                recLotTracking.SETRANGE("Item No.", recItemLedger."Item No.");
                                recLotTracking.SETRANGE("Lot No.", recItemLedger."Lot No.");
                                recLotTracking.SETRANGE("Location Code", recItemLedger."Location Code");
                                recLotTracking.SETRANGE(Positive, TRUE);
                                IF recLotTracking.FINDFIRST THEN
                                    REPEAT
                                        IF decRemainingQty < recLotTracking."Remaining Qty." THEN
                                            decQtyToAdjust := decRemainingQty
                                        ELSE
                                            decQtyToAdjust := recLotTracking."Remaining Qty.";

                                        decRemainingQty := decRemainingQty - recLotTracking."Remaining Qty.";

                                        recPostedLotTracking.INIT;
                                        recPostedLotTracking.TRANSFERFIELDS(recLotTracking);
                                        intEntryNo += 1;
                                        recPostedLotTracking."Entry No." := intEntryNo;
                                        decQtyInPacks := ROUND(decQtyToAdjust / recLotTracking."Average Qty. In Pack", 1);
                                        recPostedLotTracking."Qty. In Packs" := -decQtyInPacks;
                                        recPostedLotTracking.Quantity := -decQtyToAdjust;
                                        recPostedLotTracking."Remaining Qty." := 0;
                                        recPostedLotTracking.Positive := FALSE;
                                        recPostedLotTracking."Ref. Entry No." := recLotTracking."Entry No.";
                                        recPostedLotTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                                        recPostedLotTracking."Color (MM)" := recItemLedger."Color (MM)";
                                        recPostedLotTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                                        recPostedLotTracking.TRS := recItemLedger.TRS;
                                        recPostedLotTracking.Sucrose := recItemLedger.Sucrose;
                                        recPostedLotTracking.FG := recItemLedger.FG;
                                        recPostedLotTracking."Posting Date" := TODAY;
                                        recPostedLotTracking.INSERT;

                                        recPostedLotTracking.INIT;
                                        recPostedLotTracking.TRANSFERFIELDS(recLotTracking);
                                        intEntryNo += 1;
                                        recPostedLotTracking."Entry No." := intEntryNo;
                                        recPostedLotTracking."Qty. In Packs" := decQtyInPacks;
                                        recPostedLotTracking.Quantity := decQtyToAdjust;
                                        recPostedLotTracking."Remaining Qty." := decQtyToAdjust;
                                        recPostedLotTracking.Positive := TRUE;
                                        recPostedLotTracking."Ref. Entry No." := intEntryNo;
                                        recPostedLotTracking."Location Code" := recLocation."QC Rejection Location";
                                        recPostedLotTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                                        recPostedLotTracking."Color (MM)" := recItemLedger."Color (MM)";
                                        recPostedLotTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                                        recPostedLotTracking.TRS := recItemLedger.TRS;
                                        recPostedLotTracking.Sucrose := recItemLedger.Sucrose;
                                        recPostedLotTracking.FG := recItemLedger.FG;
                                        recPostedLotTracking."Posting Date" := TODAY;
                                        recPostedLotTracking.INSERT;

                                        recLotTracking."Remaining Qty." := recLotTracking."Remaining Qty." - decQtyToAdjust;
                                        IF recLotTracking."Remaining Qty." < 0 THEN
                                            ERROR('Remaining Quantity can not be less than 0');
                                        recLotTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                                        recLotTracking."Color (MM)" := recItemLedger."Color (MM)";
                                        recLotTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                                        recLotTracking.TRS := recItemLedger.TRS;
                                        recLotTracking.Sucrose := recItemLedger.Sucrose;
                                        recLotTracking.FG := recItemLedger.FG;
                                        recLotTracking.MODIFY;
                                    UNTIL recLotTracking.NEXT = 0;

                                IF (recItemLedger."Lot No." <> '') OR (recItemLedger."Serial No." <> '') THEN BEGIN
                                    recReservationEntry.RESET;
                                    IF recReservationEntry.FIND('+') THEN
                                        intEntryNo := recReservationEntry."Entry No.";

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
                                recItemJournal.VALIDATE("Posting Date", TODAY);
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
                                recItemJournal."Qty. in Pack" := recItemLedger."Qty. in Pack" - decTinsAdjusted;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::Moisture);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal."Moisture (%)" := recQualityLines.Observation;
                                    recItemLedger."Moisture (%)" := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::Color);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal."Color (MM)" := recQualityLines.Observation;
                                    recItemLedger."Color (MM)" := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::HMF);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal."HMF (PPM)" := recQualityLines.Observation;
                                    recItemLedger."HMF (PPM)" := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::TRS);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal.TRS := recQualityLines.Observation;
                                    recItemLedger.TRS := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::Sucrose);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal.Sucrose := recQualityLines.Observation;
                                    recItemLedger.Sucrose := recQualityLines.Observation;
                                END;

                                recQualityLines.RESET;
                                recQualityLines.SETRANGE("QC No.", Rec."No.");
                                recQualityLines.SETFILTER("Measure Type", '%1', recQualityLines."Measure Type"::FG);
                                IF recQualityLines.FINDFIRST THEN BEGIN
                                    recItemJournal.FG := recQualityLines.Observation;
                                    recItemLedger.FG := recQualityLines.Observation;
                                END;
                                recItemJournal.INSERT(TRUE);

                                recPostedLotTracking.RESET;
                                IF recPostedLotTracking.FINDLAST THEN
                                    intEntryNo := recPostedLotTracking."Entry No."
                                ELSE
                                    intEntryNo := 0;

                                decRemainingQty := recItemLedger."Approved Quantity";
                                recLotTracking.RESET;
                                recLotTracking.SETCURRENTKEY("Document No.", "Document Line No.", "Item No.", "Location Code", "Lot No.", Positive, "Remaining Qty.");
                                recLotTracking.SETRANGE("Document No.", recItemLedger."Document No.");
                                recLotTracking.SETRANGE("Document Line No.", recItemLedger."Document Line No.");
                                recLotTracking.SETRANGE("Item No.", recItemLedger."Item No.");
                                recLotTracking.SETRANGE("Lot No.", recItemLedger."Lot No.");
                                recLotTracking.SETRANGE("Location Code", recItemLedger."Location Code");
                                recLotTracking.SETRANGE(Positive, TRUE);
                                IF recLotTracking.FINDFIRST THEN
                                    REPEAT
                                        IF decRemainingQty < recLotTracking."Remaining Qty." THEN
                                            decQtyToAdjust := decRemainingQty
                                        ELSE
                                            decQtyToAdjust := recLotTracking."Remaining Qty.";

                                        decRemainingQty := decRemainingQty - recLotTracking."Remaining Qty.";

                                        recPostedLotTracking.INIT;
                                        recPostedLotTracking.TRANSFERFIELDS(recLotTracking);
                                        intEntryNo += 1;
                                        recPostedLotTracking."Entry No." := intEntryNo;
                                        decQtyInPacks := ROUND(decQtyToAdjust / recLotTracking."Average Qty. In Pack", 1);
                                        recPostedLotTracking."Qty. In Packs" := -decQtyInPacks;
                                        recPostedLotTracking.Quantity := -decQtyToAdjust;
                                        recPostedLotTracking."Remaining Qty." := 0;
                                        recPostedLotTracking.Positive := FALSE;
                                        recPostedLotTracking."Ref. Entry No." := recLotTracking."Entry No.";
                                        recPostedLotTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                                        recPostedLotTracking."Color (MM)" := recItemLedger."Color (MM)";
                                        recPostedLotTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                                        recPostedLotTracking.TRS := recItemLedger.TRS;
                                        recPostedLotTracking.Sucrose := recItemLedger.Sucrose;
                                        recPostedLotTracking.FG := recItemLedger.FG;
                                        recPostedLotTracking."Posting Date" := TODAY;
                                        recPostedLotTracking.INSERT;

                                        recPostedLotTracking.INIT;
                                        recPostedLotTracking.TRANSFERFIELDS(recLotTracking);
                                        intEntryNo += 1;
                                        recPostedLotTracking."Entry No." := intEntryNo;
                                        recPostedLotTracking."Qty. In Packs" := decQtyInPacks;
                                        recPostedLotTracking.Quantity := decQtyToAdjust;
                                        recPostedLotTracking."Remaining Qty." := decQtyToAdjust;
                                        recPostedLotTracking.Positive := TRUE;
                                        recPostedLotTracking."Ref. Entry No." := intEntryNo;
                                        recPostedLotTracking."Location Code" := recLocation."OK Store Location";
                                        recPostedLotTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                                        recPostedLotTracking."Color (MM)" := recItemLedger."Color (MM)";
                                        recPostedLotTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                                        recPostedLotTracking.TRS := recItemLedger.TRS;
                                        recPostedLotTracking.Sucrose := recItemLedger.Sucrose;
                                        recPostedLotTracking.FG := recItemLedger.FG;
                                        recPostedLotTracking."Posting Date" := TODAY;
                                        recPostedLotTracking.INSERT;

                                        recLotTracking."Remaining Qty." := recLotTracking."Remaining Qty." - decQtyToAdjust;
                                        IF recLotTracking."Remaining Qty." < 0 THEN
                                            ERROR('Remaining Quantity can not be less than 0');
                                        recLotTracking."Moisture (%)" := recItemLedger."Moisture (%)";
                                        recLotTracking."Color (MM)" := recItemLedger."Color (MM)";
                                        recLotTracking."HMF (PPM)" := recItemLedger."HMF (PPM)";
                                        recLotTracking.TRS := recItemLedger.TRS;
                                        recLotTracking.Sucrose := recItemLedger.Sucrose;
                                        recLotTracking.FG := recItemLedger.FG;
                                        recLotTracking.MODIFY;
                                    UNTIL recLotTracking.NEXT = 0;

                                IF (recItemLedger."Lot No." <> '') OR (recItemLedger."Serial No." <> '') THEN BEGIN
                                    recReservationEntry.RESET;
                                    IF recReservationEntry.FIND('+') THEN
                                        intEntryNo := recReservationEntry."Entry No.";

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
                    /*
                    recPurchRcptLine."QC Completed" := TRUE;
                    recPurchRcptLine.MODIFY;
                    */
                    Rec.Posted := TRUE;
                    Rec.MODIFY;

                    MESSAGE('Quality lines successfully posted.');

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

                    REPORT.RUN(Report::"Inward Quality Report", TRUE, TRUE, recQuality);
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
        recItemLedger: Record "Item Ledger Entry";
        recItemJournal: Record "Item Journal Line";
        recInventorySetup: Record "Inventory Setup";
        intLineNo: Integer;
        recLocation: Record Location;
        recReservationEntry: Record "Reservation Entry";
        intEntryNo: Integer;
        decTinsAdjusted: Decimal;
        recQualityLines: Record "Quality Line";
        recLotTracking: Record "Lot Tracking Entry";
        recPostedLotTracking: Record "Lot Tracking Entry";
        decQtyInPacks: Decimal;
        decRemainingQty: Decimal;
        decQtyToAdjust: Decimal;
        recQuality: Record "Quality Header";
}
