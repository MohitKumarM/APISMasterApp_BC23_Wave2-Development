codeunit 50001 "Item Jnl.-Submit Approval"
{
    TableNo = "Item Journal Line";

    trigger OnRun()
    begin
        ItemJnlLine.COPY(Rec);
        Code;

        //Iappc - Approval Process Begin
        IF blnProcessed THEN BEGIN
            recItemJournalLines.RESET;
            recItemJournalLines.COPYFILTERS(Rec);
            IF recItemJournalLines.FindFirst() THEN BEGIN

                recInventorySetup.GET;
                IF recItemJournalLines."Source Template Code" = '' THEN BEGIN
                    recInventorySetup.TESTFIELD("Output Approval Template");
                    recInventorySetup.TESTFIELD("Output Approval Batch");

                    cdTemplate := recInventorySetup."Output Approval Template";
                    cdBatch := recInventorySetup."Output Approval Batch";
                END ELSE BEGIN
                    recInventorySetup.TESTFIELD("Output Posting Template");
                    recInventorySetup.TESTFIELD("Output Posting Batch");

                    cdTemplate := recInventorySetup."Output Posting Template";
                    cdBatch := recInventorySetup."Output Posting Batch";
                END;

                recItemJournalLinesInsert.RESET;
                recItemJournalLinesInsert.SETRANGE("Journal Template Name", cdTemplate);
                recItemJournalLinesInsert.SETRANGE("Journal Batch Name", cdBatch);
                recItemJournalLinesInsert.SETRANGE("Item No.", '');
                IF recItemJournalLinesInsert.FINDSET THEN
                    recItemJournalLinesInsert.DELETEALL;

                REPEAT
                    TempItemjournalLine.Init();
                    TempItemjournalLine.TransferFields(recItemJournalLines);
                    TempItemjournalLine.Insert();
                    recItemJournalLines.Delete();
                UNTIL recItemJournalLines.NEXT = 0;


                Clear(intLineNo);
                intLineNo := GetlastNo(cdTemplate, cdBatch);
                if TempItemjournalLine.FindFirst() then begin
                    repeat
                        recItemJournalLinesInsert.INIT;
                        recItemJournalLinesInsert.TRANSFERFIELDS(TempItemjournalLine);
                        recItemJournalLinesInsert."Journal Template Name" := cdTemplate;
                        recItemJournalLinesInsert."Journal Batch Name" := cdBatch;
                        intLineNo += 10000;
                        recItemJournalLinesInsert."Line No." := intLineNo;
                        recItemJournalLinesInsert."Source Template Code" := TempItemjournalLine."Journal Template Name";
                        recItemJournalLinesInsert."Source Batch Name" := TempItemjournalLine."Journal Batch Name";
                        recItemJournalLinesInsert.Insert();
                    until TempItemjournalLine.Next() = 0;
                    TempItemjournalLine.DeleteAll();
                end;
            END;
        END;
        //Iappc - Approval Process End
        rec.Copy(ItemJnlLine);
    end;

    var
        intLineNo: Integer;
        Text000: Label 'cannot be filtered when posting recurring journals';
        Text001: Label 'Do you want to submit the journal lines?';
        Text003: Label 'The journal lines were successfully submitted.';
        Text004: Label 'The journal lines were successfully submitted. ';
        Text005: Label 'You are now in the %1 journal.';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Submit Batch";
        TempJnlBatchName: Code[10];
        recItemJournalLines: Record "Item Journal Line";
        recInventorySetup: Record "Inventory Setup";
        recItemJournalLinesInsert: Record "Item Journal Line";
        cdTemplate: Code[20];
        cdBatch: Code[20];
        blnProcessed: Boolean;
        TempItemjournalLine: Record "Item Journal Line" temporary;

    local procedure Code()
    begin
        ItemJnlTemplate.GET(ItemJnlLine."Journal Template Name");
        ItemJnlTemplate.TESTFIELD("Force Posting Report", FALSE);
        IF ItemJnlTemplate.Recurring AND (ItemJnlLine.GETFILTER(ItemJnlLine."Posting Date") <> '') THEN
            ItemJnlLine.FIELDERROR(ItemJnlLine."Posting Date", Text000);

        blnProcessed := FALSE;
        IF NOT ItemJnlLine."Temp Message Control" THEN//Iappc - 20 Apr 2015 - Message Control
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT
            ELSE
                blnProcessed := TRUE;

        TempJnlBatchName := ItemJnlLine."Journal Batch Name";

        ItemJnlPostBatch.RUN(ItemJnlLine);

        IF TempJnlBatchName = ItemJnlLine."Journal Batch Name" THEN
            MESSAGE(Text003)
        ELSE
            MESSAGE(
              Text004 +
              Text005,
              ItemJnlLine."Journal Batch Name");

        IF NOT ItemJnlLine.FIND('=><') OR (TempJnlBatchName <> ItemJnlLine."Journal Batch Name") THEN BEGIN
            ItemJnlLine.RESET;
            ItemJnlLine.FILTERGROUP(2);
            ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", ItemJnlLine."Journal Batch Name");
            ItemJnlLine.FILTERGROUP(0);
            ItemJnlLine."Line No." := 1;
        END;
    end;

    local procedure GetlastNo(var Template: Code[20]; Batch: code[20]): Integer
    var
        ItemJournalLine1: Record "Item Journal Line";

    begin
        ItemJournalLine1.Reset();
        ItemJournalLine1.SetCurrentKey("Line No.");
        ItemJournalLine1.SetRange("Journal Template Name", Template);
        ItemJournalLine1.SetRange("Journal Batch Name", Batch);
        if ItemJournalLine1.FindLast() then
            exit(ItemJournalLine1."Line No.");
    end;
}
