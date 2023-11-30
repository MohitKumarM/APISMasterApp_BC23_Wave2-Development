report 50033 "RM Stock"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.";
            DataItemTableView = sorting("Posting Date") order(ascending) where(Positive = const(true));


            column(Item_No_; "Item No.") { }
            column(Entry_Type; "Entry Type") { }
            column(Document_No_; "Document No.") { }
            column(Document_Line_No_; "Document Line No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Rec_Date; RecDate) { }//
            column(Item_Code; "Item Category Code") { }
            column(Lot_No_; "Lot No.") { }
            column(Flora; '') { }
            column(Buyer; '') { }
            column(Product_Group; '') { }
            column(Remaining_Wt; RemainingQty) { }
            column(Tins; '') { }
            column(Buck; '') { }
            column(Can; '') { }
            column(Drum; '') { }
            column(Total_Unit; '') { }
            column(Unit; '') { }
            column(N_Wt; TotalQty) { }
            column(AVG; '') { }
            column(Location; "Location Code") { }
            column(Type; '') { }
            column(Aging; TotalDay) { }
            column(Use_Date; LastUseDate) { }
            column(AsOnDate; AsOnDate) { }
            column(RecDate3; RecDate3) { }

            trigger OnAfterGetRecord()
            begin

                Clear(RecDate);
                ILE_Rec1.Reset();
                ILE_Rec1.SetCurrentKey("Posting Date");
                ILE_Rec1.SetRange("Item No.", "Item No.");
                if ILE_Rec1.FindFirst() then
                    RecDate := ILE_Rec1."Posting Date";

                if "Posting Date" < AsOnDate then begin
                    Date_Rec.SETRANGE("Period Type", Date_Rec."Period Type"::Date);
                    Date_Rec.SETRANGE("Period Start", RecDate, AsOnDate);
                    Date_Rec.SETFILTER("Period No.", '%1..%2', 1, 7);
                    TotalDay := Date_Rec.COUNT
                end else begin
                    Date_Rec.SETRANGE("Period Type", Date_Rec."Period Type"::Date);
                    Date_Rec.SETRANGE("Period Start", AsOnDate, RecDate);
                    Date_Rec.SETFILTER("Period No.", '%1..%2', 1, 7);
                    TotalDay := Date_Rec.COUNT;
                end;



                Clear(LastUseDate);
                ILE_Rec3.Reset();
                ILE_Rec3.SetCurrentKey("Posting Date");
                ILE_Rec3.SetRange("Item No.", "Item No.");
                if ILE_Rec3.FindLast() then
                    LastUseDate := ILE_Rec3."Posting Date";

                Clear(TotalQty);
                ILE_Rec2.Reset();
                ILE_Rec2.SetRange("Item No.", "Item No.");
                ILE_Rec2.SetRange("Lot No.", "Lot No.");
                ILE_Rec2.SetRange("Location Code", "Location Code");
                ILE_Rec2.SetRange(Positive, true);
                ILE_Rec2.SetRange("Posting Date", 0D, AsOnDate);
                if ILE_Rec2.FindSet() then
                    repeat
                        TotalQty += ILE_Rec2.Quantity;
                    until ILE_Rec2.Next() = 0;

                Clear(RemainingQty);
                ILE_Rec.Reset();
                ILE_Rec.SetRange("Item No.", "Item No.");
                ILE_Rec.SetRange("Lot No.", "Lot No.");
                ILE_Rec.SetRange("Location Code", "Location Code");
                ILE_Rec.SetRange("Posting Date", 0D, AsOnDate);
                if ILE_Rec.FindSet() then
                    repeat
                        RemainingQty += ILE_Rec.Quantity;
                    until ILE_Rec.Next() = 0;

                IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Transfer THEN BEGIN
                    ItemLedgerEntry3.RESET;
                    ItemLedgerEntry3.SETRANGE("Item No.", "Item No.");
                    ItemLedgerEntry3.SetRange("Lot No.", "Lot No.");
                    ItemLedgerEntry3.SetRange("Location Code", "Location Code");
                    ItemLedgerEntry3.SETRANGE("Posting Date", 0D, AsOnDate);
                    ItemLedgerEntry3.SETRANGE(Positive, TRUE);
                    IF ItemLedgerEntry3.FINDSET THEN
                        REPEAT
                            RecDate := CallTransfer(ItemLedgerEntry3."Entry No.");
                        UNTIL ItemLedgerEntry3.NEXT = 0;
                end;
            end;

        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; AsOnDate)
                    {
                        Caption = 'As On Date';
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = '.\ReportLayouts\RMStock.rdl';
        }
    }
    PROCEDURE CallTransfer(InbountEnrtyP: Integer): Date;
    VAR
        ItemLedgerEntryL: Record 32;
        ProductionOrderLnL: Record 5406;
        ProdOrderComponentL: Record 5407;
    BEGIN
        InboundEntry := true;
        OutBoundEntryG := 0;
        InboundEntryG := InbountEnrtyP;
        REPEAT
            ItemApplEntTransfer.RESET;
            IF InboundEntry THEN BEGIN
                ItemApplEntTransfer.SETRANGE("Item Ledger Entry No.", InboundEntryG);
                InboundEntry := FALSE;
            END ELSE BEGIN
                ItemApplEntTransfer.SETRANGE("Item Ledger Entry No.", OutBoundEntryG);
                InboundEntry := TRUE;
            END;
            IF ItemApplEntTransfer.FINDFIRST THEN BEGIN
                InboundEntryG := ItemApplEntTransfer."Inbound Item Entry No.";
                OutBoundEntryG := ItemApplEntTransfer."Outbound Item Entry No.";
                //RecDate1 := ItemApplEntTransfer."Posting Date";
            END;
        UNTIL OutBoundEntryG = 0;
        IF ItemLedgerEntryL.get(InboundEntryG) then
            exit(ItemLedgerEntryL."Posting Date");

    END;


    var
        RemainingQty: Decimal;
        ILE_Rec: Record "Item Ledger Entry";
        Date_Rec: Record Date;
        AsOnDate: Date;
        TotalDay: Integer;
        ILE_Rec1: Record "Item Ledger Entry";
        RecDate: Date;
        ILE_Rec2: Record "Item Ledger Entry";
        LastUseDate: Date;
        TotalQty: Decimal;
        ILE_Rec3: Record "Item Ledger Entry";
        ILE_Rec4: Record "Item Ledger Entry";
        ItemApplEntTransfer: Record 339;
        InboundEntry: Boolean;
        OutBoundEntry: Boolean;
        OutBoundEntryG: Integer;
        ItemLedgerEntry3: Record 32;
        CheckBlnc: Decimal;
        Show1: Boolean;
        InboundEntryG: Integer;
        FromDate: Date;
        RecDate1: Date;
        RecDate3: Date;


}