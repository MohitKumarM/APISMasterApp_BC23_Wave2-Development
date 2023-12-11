page 50001 "Released Deal List"
{
    Caption = 'Released Deal';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Deal Master";
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Release));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Item Code"; rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Name"; rec."Purchaser Name")
                {
                    ApplicationArea = All;
                }
                field(Flora; rec.Flora)
                {
                    ApplicationArea = All;
                }

                field("Deal Qty."; rec."Deal Qty.")
                {
                    ApplicationArea = All;
                }
                field("Unit Rate in Kg."; rec."Unit Rate in Kg.")
                {
                    ApplicationArea = All;
                }
                field("Dispatched Qty."; rec."Dispatched Qty.")
                {
                    ApplicationArea = All;
                }
                field(decRemQuantity; decRemQuantity)
                {
                    Caption = 'Remaining Qty.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Per Unit Qty. (Kg.)"; rec."Per Unit Qty. (Kg.)")
                {
                    ApplicationArea = All;
                }
                field("Dispatched Qty. (Kg.)"; rec."Dispatched Qty. (Kg.)")
                {
                    ApplicationArea = All;
                }
                field("Rem. Qty. (Kg.)"; decRemQtyKg)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Dispatch Details")
            {
                Caption = 'Dispatch Details';
                field(cdDispatchDate; cdDispatchDate)
                {
                    Caption = 'Dispatch Date';

                    trigger OnValidate()
                    begin
                        IF cdDispatchDate < rec.Date THEN
                            ERROR('The dispatch date can not be less than the deal date.');
                    end;
                }
                field(decDispatchedQty; decDispatchedQty)
                {
                    Caption = 'Dispatched Qty.';
                    ApplicationArea = All;
                }
                field(decQtyinKg; decQtyinKg)
                {
                    Caption = 'Qty. in Kg.';
                    MinValue = 0;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        recPurchSetup.GET;
                        Rec.CALCFIELDS("Dispatched Qty. (Kg.)");
                        decRemDisQty := rec."Deal Qty." * rec."Per Unit Qty. (Kg.)";
                        decRemDisQty := decRemDisQty + (decRemDisQty * recPurchSetup."Deal Tolerance" / 100) - rec."Dispatched Qty. (Kg.)";
                        IF decQtyinKg > decRemDisQty THEN
                            ERROR('Can only dispatch %1 quantity.', decRemDisQty);
                    end;
                }
                field(cdVehicleNo; cdVehicleNo)
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                }
                field(txtVendorName; txtVendorName)
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = All;
                }
                field(txtLocationName; txtLocationName)
                {
                    Caption = 'Location Name';
                    ApplicationArea = All;
                }
                field("Dispatch Line No."; intDispatchLineNo)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
            }
            part("Deal Dispatch Details"; "Deal Dispatch Subform")
            {
                SubPageLink = "Sauda No." = FIELD("No.");
                SubPageView = SORTING("Sauda No.", "Line No.")
                              ORDER(Ascending);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Submit Dispatch Details")
            {
                Caption = 'Submit Dispatch Details';
                Image = ShipmentLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    IF rec.Status <> rec.Status::Release THEN
                        EXIT;

                    recPurchSetup.GET;
                    Rec.CALCFIELDS("Dispatched Qty. (Kg.)");
                    decRemDisQty := rec."Deal Qty." * rec."Per Unit Qty. (Kg.)";
                    decRemDisQty := decRemDisQty + (decRemDisQty * recPurchSetup."Deal Tolerance" / 100) - rec."Dispatched Qty. (Kg.)";
                    IF decQtyinKg > decRemDisQty THEN
                        ERROR('Can only dispatch %1 quantity.', decRemDisQty);

                    IF cdDispatchDate = 0D THEN
                        ERROR('Enter Dispatch Date.');

                    IF decDispatchedQty = 0 THEN
                        ERROR('Enter Dispatched Quantity.');

                    IF decQtyinKg = 0 THEN
                        ERROR('Quantity in Kg. must not be blank.');

                    IF cdVehicleNo = '' THEN
                        ERROR('Vehicle no. must not be blank.');

                    IF txtVendorName = '' THEN
                        ERROR('Vendor name must not be blank.');

                    IF txtLocationName = '' THEN
                        ERROR('Location name must not be blank.');

                    IF NOT CONFIRM('Do you want to submit the dispatch details against the selected Deal No.?', FALSE) THEN
                        EXIT;

                    recSaudaDetails.RESET;
                    recSaudaDetails.SETRANGE("Sauda No.", Rec."No.");
                    IF recSaudaDetails.FINDLAST THEN
                        intLineNo := recSaudaDetails."Line No."
                    ELSE
                        intLineNo := 0;

                    recSaudaDetails.INIT;
                    recSaudaDetails."Sauda No." := Rec."No.";
                    intLineNo += 10000;
                    recSaudaDetails."Line No." := intLineNo;
                    recSaudaDetails."Dispatch Date" := cdDispatchDate;
                    recSaudaDetails."Dispatched Tins / Buckets" := decDispatchedQty;
                    recSaudaDetails.Flora := Rec.Flora;
                    recSaudaDetails."Packing Type" := Rec."Packing Type";
                    recSaudaDetails."Vehicle No." := cdVehicleNo;
                    recSaudaDetails."Beekeeper Name Name" := txtVendorName;
                    recSaudaDetails."Qty. in Kg." := decQtyinKg;
                    recSaudaDetails."Location Name" := txtLocationName;
                    recSaudaDetails.INSERT;

                    cdDispatchDate := 0D;
                    decDispatchedQty := 0;
                    decQtyinKg := 0;
                    cdVehicleNo := '';
                    txtVendorName := '';
                    txtLocationName := '';

                    MESSAGE('The dispatch details is submitted successfully.');
                    CurrPage.UPDATE;
                end;
            }
            action("Short Close")
            {
                Caption = 'Short Close';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    IF NOT CONFIRM('Do you want to close the selected deal?', FALSE) THEN
                        EXIT;

                    rec.Status := rec.Status::Close;
                    rec.MODIFY;

                    CurrPage.UPDATE;
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    recDeal: Record "Deal Master";
                begin
                    recDeal.RESET;
                    recDeal.SETRANGE("No.", Rec."No.");
                    recDeal.FINDFIRST;

                    REPORT.RUN(Report::"Deal Print", TRUE, TRUE, recDeal);
                end;
            }
            action("Re-open")
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF intDispatchLineNo = 0 THEN
                        ERROR('Dispatch line no. must not be 0');

                    recSaudaDetails.RESET;
                    recSaudaDetails.SETRANGE("Sauda No.", Rec."No.");
                    recSaudaDetails.SETRANGE("Line No.", intDispatchLineNo);
                    IF NOT recSaudaDetails.FINDFIRST THEN
                        ERROR('Invalid dispatch line no., enter the correct line no.');

                    IF NOT CONFIRM('Do you want to re-open the selected dispatch?', FALSE) THEN
                        EXIT;

                    recPurchLine.RESET;
                    recPurchLine.SETRANGE("Deal No.", recSaudaDetails."Sauda No.");
                    recPurchLine.SETRANGE("Deal Line No.", recSaudaDetails."Line No.");
                    IF recPurchLine.FINDFIRST THEN
                        ERROR('The dispatch is already linked to order no. %1, hence can not be re-opened.', recPurchLine."Document No.");

                    recPurchRcptLine.RESET;
                    recPurchRcptLine.SETRANGE("Deal No.", recSaudaDetails."Sauda No.");
                    recPurchRcptLine.SETRANGE("Deal Line No.", recSaudaDetails."Line No.");
                    IF recPurchRcptLine.FINDFIRST THEN
                        ERROR('GAN %1 is already posted for the selected dispatch, hence can not be re-opened.', recPurchRcptLine."Document No.");

                    intDispatchLineNo := 0;
                    recSaudaDetails."GAN Created" := FALSE;
                    recSaudaDetails."GAN No." := '';
                    recSaudaDetails.MODIFY;
                    CurrPage.UPDATE;
                end;
            }
            action(Delete)
            {
                Image = Delete;
                Promoted = true;


                trigger OnAction()
                begin
                    IF intDispatchLineNo = 0 THEN
                        ERROR('Dispatch line no. must not be 0');

                    recSaudaDetails.RESET;
                    recSaudaDetails.SETRANGE("Sauda No.", Rec."No.");
                    recSaudaDetails.SETRANGE("Line No.", intDispatchLineNo);
                    IF NOT recSaudaDetails.FINDFIRST THEN
                        ERROR('Invalid dispatch line no., enter the correct line no.');

                    IF NOT CONFIRM('Do you want to delete the selected dispatch?', FALSE) THEN
                        EXIT;

                    recPurchLine.RESET;
                    recPurchLine.SETRANGE("Deal No.", recSaudaDetails."Sauda No.");
                    recPurchLine.SETRANGE("Deal Line No.", recSaudaDetails."Line No.");
                    IF recPurchLine.FINDFIRST THEN
                        ERROR('The dispatch is already linked to order no. %1, hence can not be deleted.', recPurchLine."Document No.");

                    recPurchRcptLine.RESET;
                    recPurchRcptLine.SETRANGE("Deal No.", recSaudaDetails."Sauda No.");
                    recPurchRcptLine.SETRANGE("Deal Line No.", recSaudaDetails."Line No.");
                    IF recPurchRcptLine.FINDFIRST THEN
                        ERROR('GAN %1 is already posted for the selected dispatch, hence can not be deleted.', recPurchRcptLine."Document No.");

                    intDispatchLineNo := 0;
                    recSaudaDetails.DELETE;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Dispatched Qty.", "Dispatched Qty. (Kg.)");

        decRemQuantity := rec."Deal Qty." - rec."Dispatched Qty.";
        decRemQtyKg := (rec."Deal Qty." * rec."Per Unit Qty. (Kg.)") - rec."Dispatched Qty. (Kg.)";
    end;

    var
        cdDispatchDate: Date;
        decDispatchedQty: Decimal;
        recSaudaDetails: Record "Deal Dispatch Details";
        intLineNo: Integer;
        decQtyinKg: Decimal;
        cdVehicleNo: Code[20];
        txtVendorName: Text[50];
        txtLocationName: Text[50];
        decRemQuantity: Decimal;
        recPurchSetup: Record "Purchases & Payables Setup";
        decRemDisQty: Decimal;
        decRemQtyKg: Decimal;
        intDispatchLineNo: Integer;
        recPurchLine: Record "Purchase Line";
        recPurchRcptLine: Record "Purch. Rcpt. Line";
}
