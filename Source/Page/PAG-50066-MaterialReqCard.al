page 50066 "Material Req. Card"
{
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Material Requisition Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Date; Rec.Date) { }
                field("User ID"; Rec."User ID") { }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field(Status; Rec.Status) { }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    Caption = 'Request Remarks';
                }
                field("Department Name"; Rec."Department Name") { }
                field("Issue Remarks"; Rec."Issue Remarks") { }
            }
            part("Material Req. SubPage"; "Material Req. SubPage")
            {
                SubPageLink = "Req. No." = FIELD("No.");
                SubPageView = SORTING("Req. No.", "Line No.")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fill Requirement")
            {
                Caption = 'Fill Requirement';
                Image = Calculate;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*
                    Rec.TESTFIELD("Document No.");

                    IF NOT CONFIRM('Want to Fill Pending Lines', FALSE) THEN
                      EXIT;

                    recRequisitionLine.RESET;
                    recRequisitionLine.SETRANGE("Req. No.", Rec."No.");
                    IF recRequisitionLine.FINDLAST THEN
                      intLineNo := recRequisitionLine."Line No."
                    ELSE
                      intLineNo := 0;

                    blnPendingLines := FALSE;
                    recComponentLines.RESET;
                    recComponentLines.SETRANGE(Status, recComponentLines.Status::Released);
                    recComponentLines.SETRANGE("Prod. Order No.", "Document No.");
                    recComponentLines.SETFILTER("Remaining Quantity", '<>%1', 0);
                    IF recComponentLines.FINDFIRST THEN REPEAT
                      recComponentLines.CALCFIELDS("Material Issued Qty.", recComponentLines."Material To Issue Qty.");
                      IF recComponentLines."Remaining Quantity" - recComponentLines."Material Issued Qty." - recComponentLines."Material To Issue Qty." > 0 THEN BEGIN
                        recRequisitionLine.INIT;
                        recRequisitionLine."Req. No." := Rec."No.";
                        intLineNo += 10000;
                        recRequisitionLine."Line No." := intLineNo;
                        recRequisitionLine.Type := Rec.Type;
                        recRequisitionLine."Document No." := Rec."Document No.";
                        recRequisitionLine."Document Line No." := recComponentLines."Prod. Order Line No.";
                        recRequisitionLine."Component Line No." := recComponentLines."Line No.";
                        recRequisitionLine."Item Code" := recComponentLines."Item No.";
                        recRequisitionLine."Item Name" := recComponentLines.Description;
                        recRequisitionLine."Unit of Measure" := recComponentLines."Unit of Measure Code";
                        recRequisitionLine."Source Quantity" := recComponentLines."Remaining Quantity" - recComponentLines."Material Issued Qty." - recComponentLines."Material To Issue Qty.";
                        recRequisitionLine."Requested Quantity" := recComponentLines."Remaining Quantity" - recComponentLines."Material Issued Qty." - recComponentLines."Material To Issue Qty.";
                        recRequisitionLine."Location Code" := recComponentLines."Location Code";
                        recRequisitionLine.INSERT;

                        blnPendingLines := TRUE;
                      END;
                    UNTIL recComponentLines.NEXT = 0;

                    IF blnPendingLines THEN
                      MESSAGE('The material requisition is generated successfully.')
                    ELSE
                      ERROR('Nothing to Fill.');

                    CurrPage.UPDATE;
                    */
                end;
            }
            action(Submit)
            {
                Caption = 'Submit';
                Image = SendTo;
                Promoted = true;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Want to submit the material requisition?', FALSE) THEN
                        EXIT;

                    recRequisitionLine.RESET;
                    recRequisitionLine.SETRANGE("Req. No.", Rec."No.");
                    recRequisitionLine.SETFILTER("Requested Quantity", '<>%1', 0);
                    IF NOT recRequisitionLine.FINDFIRST THEN
                        ERROR('Nothing to Submit.');

                    recRequisitionLine.RESET;
                    recRequisitionLine.SETRANGE("Req. No.", Rec."No.");
                    recRequisitionLine.SETFILTER("Requested Quantity", '%1', 0);
                    IF recRequisitionLine.FINDFIRST THEN
                        ERROR('There are lines with 0 requested quantity, delete the lines first.');

                    recRequisitionLine.RESET;
                    recRequisitionLine.SETRANGE("Req. No.", Rec."No.");
                    IF recRequisitionLine.FINDFIRST THEN
                        recRequisitionLine.MODIFYALL(Status, recRequisitionLine.Status::Release);

                    Rec.Status := Rec.Status::Release;
                    Rec.MODIFY;

                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        recRequisitionLine: Record "Material Requisition Line";
}
