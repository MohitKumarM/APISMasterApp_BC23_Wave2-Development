page 50157 "Item Approval Card"
{
    Caption = 'Item Approval Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Nonstock Item";

    layout
    {
        area(content)
        {
            group(General1)
            {
                field(txtRemarks; txtRemarks)
                {
                    Caption = 'Approval / Rejection Remarks';
                }
            }
            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field("Extended Description"; Rec."Extended Description")
                {
                }
                field("Barcode No."; Rec."Barcode No.")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Importance = Promoted;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                }
                field("GST Tax Group Code"; Rec."GST Tax Group Code")
                {
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                }
                field("Customer Code"; Rec."Customer Code")
                {
                }
                field("Pack Size"; Rec."Pack Size")
                {
                }
                field("Net Weight Per (Kg)"; Rec."Net Weight Per (Kg)")
                {
                }
                field("Item Size Dimension"; Rec."Item Size Dimension")
                {
                }
                field("Gross Weight Per (Kg)"; Rec."Gross Weight Per (Kg)")
                {
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                }
                field("No. 2"; Rec."No. 2")
                {
                }
                field("Pcs. Per Cartoon"; Rec."Pcs. Per Cartoon")
                {
                }
                field("HSN Code"; Rec."HSN Code")
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Description);
                    Rec.TESTFIELD("Unit of Measure");
                    Rec.TESTFIELD("Inventory Posting Group");
                    Rec.TESTFIELD("Gen. Prod. Posting Group");
                    Rec.TESTFIELD("Item Tracking Code");
                    Rec.TESTFIELD("HSN Code");
                    Rec.TESTFIELD("GST Tax Group Code");

                    IF NOT CONFIRM('Do you want to approve the item?', FALSE) THEN
                        EXIT;

                    IF txtRemarks = '' THEN
                        ERROR('Enter Rejection Remarks.');

                    recItemCategory.TESTFIELD("Item Nos.");

                    cdItem := cuNoSeries.GetNextNo(recItemCategory."Item Nos.", TODAY, TRUE);

                    recItem.INIT;
                    recItem."No." := cdItem;
                    recItem.INSERT(TRUE);

                    recItem.VALIDATE(Description, Rec.Description);
                    recItem.VALIDATE("Base Unit of Measure", Rec."Unit of Measure");
                    recItem.VALIDATE("Inventory Posting Group", Rec."Inventory Posting Group");
                    recItem.VALIDATE("Gen. Prod. Posting Group", Rec."Gen. Prod. Posting Group");
                    recItem.VALIDATE("Tax Group Code", Rec."GST Tax Group Code");
                    recItem.VALIDATE("Item Tracking Code", Rec."Item Tracking Code");
                    recItem.VALIDATE("Tariff No.", Rec."HSN Code");
                    recItem."Customer Code" := Rec."Customer Code";
                    recItem."Pack Size" := Rec."Pack Size";
                    recItem."Net Weight Per (Kg)" := Rec."Net Weight Per (Kg)";
                    recItem."Item Size Dimension" := Rec."Item Size Dimension";
                    recItem."Gross Weight Per (Kg)" := Rec."Gross Weight Per (Kg)";
                    recItem."Reorder Point" := Rec."Reorder Point";
                    recItem."No. 2" := Rec."No. 2";
                    recItem."Pcs. Per Cartoon" := Rec."Pcs. Per Cartoon";
                    recItem.Length_ := Rec.Length;
                    recItem.Width_ := Rec.Width;
                    recItem.Height := Rec.Height;
                    recItem."Extended Description" := Rec."Extended Description";
                    //recItem."Barcode No." := Rec."Barcode No.";
                    recItem.MODIFY(TRUE);

                    recCommentLine.RESET;
                    recCommentLine.SETRANGE("Table Name", recCommentLine."Table Name"::Item);
                    recCommentLine.SETRANGE("No.", Rec."Entry No.");
                    IF recCommentLine.FINDFIRST THEN
                        intLineNo := recCommentLine."Line No."
                    ELSE
                        intLineNo := 100000;

                    recCommentLine.INIT;
                    intLineNo := intLineNo - 10;
                    recCommentLine."Table Name" := recCommentLine."Table Name"::Item;
                    recCommentLine."No." := Rec."Entry No.";
                    recCommentLine."Line No." := intLineNo;
                    recCommentLine.Date := TODAY;
                    recCommentLine.Comment := txtRemarks;
                    //recCommentLine."User ID" := USERID;
                    recCommentLine.INSERT;

                    recSourceComment.RESET;
                    recSourceComment.SETRANGE("Table Name", recSourceComment."Table Name"::Item);
                    recSourceComment.SETRANGE("No.", Rec."Entry No.");
                    IF recSourceComment.FINDFIRST THEN
                        REPEAT
                            recCommentLine.INIT;
                            recCommentLine.TRANSFERFIELDS(recSourceComment);
                            recCommentLine."No." := cdItem;
                            recCommentLine.INSERT;

                            recSourceComment.DELETE;
                        UNTIL recSourceComment.NEXT = 0;

                    Rec."Item No." := cdItem;
                    Rec."Pending Approval" := FALSE;
                    Rec.Approved := TRUE;
                    Rec.MODIFY;

                    MESSAGE('The Item is successfully Approved.');
                    CurrPage.CLOSE;
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Do you want to reject the Item?', FALSE) THEN
                        EXIT;

                    IF txtRemarks = '' THEN
                        ERROR('Enter Rejection Remarks.');

                    recCommentLine.RESET;
                    recCommentLine.SETRANGE("Table Name", recCommentLine."Table Name"::Item);
                    recCommentLine.SETRANGE("No.", Rec."Entry No.");
                    IF recCommentLine.FINDFIRST THEN
                        intLineNo := recCommentLine."Line No."
                    ELSE
                        intLineNo := 100000;

                    recCommentLine.INIT;
                    intLineNo := intLineNo - 10;
                    recCommentLine."Table Name" := recCommentLine."Table Name"::Item;
                    recCommentLine."No." := Rec."Entry No.";
                    recCommentLine."Line No." := intLineNo;
                    recCommentLine.Date := TODAY;
                    recCommentLine.Comment := txtRemarks;
                    //recCommentLine."User ID" := USERID;
                    recCommentLine.INSERT;

                    Rec."Pending Approval" := FALSE;
                    Rec.MODIFY;

                    MESSAGE('The Item is rejected.');
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        txtRemarks: Text[250];
        recCommentLine: Record "Comment Line";
        recItem: Record "Item";
        cdItem: Code[20];
        intLineNo: Integer;
        recSourceComment: Record "Comment Line";
        recItemCategory: Record "Item Category";
        cuNoSeries: Codeunit "NoSeriesManagement";
}

