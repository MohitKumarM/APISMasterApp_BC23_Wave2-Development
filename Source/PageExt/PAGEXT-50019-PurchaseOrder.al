pageextension 50019 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Entry Point")
        {
            Visible = false;
        }
        addafter("Vendor Invoice No.")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = all;
            }
            field("Short Close Comment"; Rec."Short Close Comment")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
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

                if not CONFIRM('Do you want to Receive the selected Order?', false) then
                    Error('');
            end;
        }
        modify(Statistics)
        {
            trigger OnBeforeAction()
            begin
                rec.CallnewTdsfunctionsForMessage();//200523
                Rec.CallnewTdsfunctions();//200523
            end;
        }
        addafter("Archive Document")
        {
            action("Short Closed")
            {
                Caption = 'Short Closed';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    PurchasePayableSetup: Record "Purchases & Payables Setup";
                    ArchiveManagement: Codeunit ArchiveManagement;
                begin
                    PurchasePayableSetup.get;
                    PurchasePayableSetup.TestField("Archive Orders", true);
                    rec.TestField("Short Close Comment");
                    IF NOT CONFIRM('Do you want to Short Close the selected Order?', FALSE) THEN
                        EXIT;
                    Rec."Short Close" := true;
                    Rec.Modify();
                    ArchiveManagement.AutoArchivePurchDocument(Rec);
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SetRange("Short Close", false);
        Rec.FILTERGROUP(0);
    end;
}