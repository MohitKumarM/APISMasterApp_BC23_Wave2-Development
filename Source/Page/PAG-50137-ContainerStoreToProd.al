page 50137 "Container Store to Prod."
{
    Caption = 'Transfer Container from Store to Prod.';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Journal Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Bucket_Var; Bucket_Var)
                {
                    Caption = 'Bucket';
                    trigger OnValidate()
                    begin
                        ContainerLineCreation(GLob_ContainerType::Bucket, Bucket_Var);
                    end;
                }
                field(Can_Var; Can_Var)
                {
                    Caption = 'Can';
                    trigger OnValidate()
                    begin
                        ContainerLineCreation(GLob_ContainerType::Can, Can_Var);
                    end;
                }
                field(Drum_Var; Drum_Var)
                {
                    Caption = 'Drum';
                    trigger OnValidate()
                    begin
                        ContainerLineCreation(GLob_ContainerType::Drum, Drum_Var);
                    end;
                }
                field(Tin_Var; Tin_Var)
                {
                    Caption = 'Tin';
                    trigger OnValidate()
                    begin
                        ContainerLineCreation(GLob_ContainerType::Tin, Tin_Var);
                    end;
                }
            }
            repeater(Lines)
            {
                Editable = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("New Location Code"; Rec."New Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Drum; Rec.Drum)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Tin; Rec.Tin)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Can; Rec.Can)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Bucket; Rec.Bucket)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin

                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    ItemJournalLine_Temp: Record "Item Journal Line" temporary;
                    ManfactSetup: Record "Manufacturing Setup";
                    ItemjnlLine_Loc: Record "Item Journal Line";
                    ItemjnlLine_Loc_1: Record "Item Journal Line";
                    lastLineNo: Integer;
                    Location_loc: Record Location;
                    Location_loc2: Record Location;
                    ProdOrder_Loc: Record "Production Order";
                begin
                    Clear(lastLineNo);
                    ManfactSetup.Get();
                    ManfactSetup.TestField("Store to Prod. Template");
                    ManfactSetup.TestField("Store to Prod. Batch");

                    ItemjnlLine_Loc.Reset();
                    ItemjnlLine_Loc.SetRange("Journal Template Name", ManfactSetup."Store to Prod. Template");
                    ItemjnlLine_Loc.SetRange("Journal Batch Name", ManfactSetup."Store to Prod. Batch");
                    ItemjnlLine_Loc.SetRange("Document No.", GlobDocNo);
                    ItemjnlLine_Loc.SetRange("Container Trasfer Stage", ItemjnlLine_Loc."Container Trasfer Stage"::"Issued RM");
                    IF ItemjnlLine_Loc.FindSet() then begin
                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemjnlLine_Loc);
                        Commit();
                    end;

                    Clear(Bucket_Var);
                    Clear(Can_Var);
                    Clear(Drum_Var);
                    Clear(Tin_Var);

                    CurrPage.Update(false);
                end;
            }
            action("Item Ledger E&ntries")
            {
                Caption = 'Item Ledger E&ntries';
                Image = ItemLedger;
                ShortCutKey = 'Ctrl+F7';
                trigger OnAction()
                var
                    ILE_Page: Page "Item Ledger Entries";
                    ILE_Rec: Record "Item Ledger Entry";
                begin
                    ILE_Rec.Reset();
                    ILE_Rec.SetRange("Entry Type", ILE_Rec."Entry Type"::Transfer);
                    ILE_Rec.SetRange("Document No.", GlobDocNo);
                    ILE_Rec.SetRange("Container Trasfer Stage", ILE_Rec."Container Trasfer Stage"::"Issued RM");
                    IF ILE_Rec.FindSet() then begin
                        ILE_Page.SetTableView(ILE_Rec);
                        ILE_Page.RunModal();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        ItemjnlLine_Loc: Record "Item Journal Line";
        ManfactSetup: Record "Manufacturing Setup";
    begin
        ManfactSetup.Get();
        ManfactSetup.TestField("Store to Prod. Template");
        ManfactSetup.TestField("Store to Prod. Batch");
        Rec.FilterGroup(2);
        Rec.SetRange("Journal Template Name", ManfactSetup."Store to Prod. Template");
        Rec.SetRange("Journal Batch Name", ManfactSetup."Store to Prod. Batch");
        Rec.SetRange("Document No.", GlobDocNo);
        Rec.FilterGroup(0);
        ManfactSetup.Get();
        ManfactSetup.TestField("Store to Prod. Template");
        ManfactSetup.TestField("Store to Prod. Batch");
        ItemjnlLine_Loc.Reset();
        ItemjnlLine_Loc.SetRange("Journal Template Name", ManfactSetup."Store to Prod. Template");
        ItemjnlLine_Loc.SetRange("Journal Batch Name", ManfactSetup."Store to Prod. Batch");
        ItemjnlLine_Loc.SetRange("Document No.", GlobDocNo);
        ItemjnlLine_Loc.SetRange("Container Trasfer Stage", ItemjnlLine_Loc."Container Trasfer Stage"::"Issued RM");
        IF ItemjnlLine_Loc.FindSet() then begin
            repeat
                IF (ItemjnlLine_Loc.Bucket > 0) then
                    Bucket_Var := ItemjnlLine_Loc.Bucket;
                IF (ItemjnlLine_Loc.Can > 0) then
                    Can_Var := ItemjnlLine_Loc.Can;
                IF (ItemjnlLine_Loc.Drum > 0) then
                    Drum_Var := ItemjnlLine_Loc.Drum;
                IF (ItemjnlLine_Loc.Tin > 0) then
                    Tin_Var := ItemjnlLine_Loc.Tin;
            until ItemjnlLine_Loc.Next() = 0;
        end;
    end;

    local procedure ContainerLineCreation(ContainerType: Option Bucket,Can,Drum,Tin; Value: Integer)
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlLine_NewLine: Record "Item Journal Line";
        Location_loc: Record Location;
        Location_loc1: Record Location;
        Location_loc2: Record Location;
        ProdOrder_Loc: Record "Production Order";
        ManufacturingSetup_Loc: Record "Manufacturing Setup";
    begin
        ManufacturingSetup_Loc.Get();
        ManufacturingSetup_Loc.TestField("Store to Prod. Template");
        ManufacturingSetup_Loc.TestField("Store to Prod. Batch");
        ManufacturingSetup_Loc.TestField("Bucket Item Code");
        ManufacturingSetup_Loc.TestField("Can Item Code");
        ManufacturingSetup_Loc.TestField("Drum Item Code");
        ManufacturingSetup_Loc.TestField("Tin Item Code");

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", ManufacturingSetup_Loc."Store to Prod. Template");
        ItemJnlLine.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Store to Prod. Batch");
        ItemJnlLine.SetRange("Document No.", GlobDocNo);
        IF (ContainerType = ContainerType::Bucket) then
            ItemJnlLine.SetFilter(Bucket, '>%1', 0);
        IF (ContainerType = ContainerType::Can) then
            ItemJnlLine.SetFilter(Can, '>%1', 0);
        IF (ContainerType = ContainerType::Drum) then
            ItemJnlLine.SetFilter(Drum, '>%1', 0);
        IF (ContainerType = ContainerType::Tin) then
            ItemJnlLine.SetFilter(Tin, '>%1', 0);
        IF ItemJnlLine.FindFirst() then begin
            ItemJnlLine.Delete();
            Commit();
        end;

        If (Value <= 0) then begin
            Value := 0;
            exit;
        end;
        CurrPage.Update(true);

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", ManufacturingSetup_Loc."Store to Prod. Template");
        ItemJnlLine.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Store to Prod. Batch");
        IF ItemJnlLine.FindLast() then;

        ProdOrder_Loc.Reset();
        ProdOrder_Loc.SetRange("No.", GlobDocNo);
        ProdOrder_Loc.FindFirst();
        ProdOrder_Loc.TestField("Location Code");
        Location_loc.Get(ProdOrder_Loc."Location Code");

        ItemJnlLine_NewLine.Init();
        ItemJnlLine_NewLine.Validate("Journal Template Name", ManufacturingSetup_Loc."Store to Prod. Template");
        ItemJnlLine_NewLine.Validate("Journal Batch Name", ManufacturingSetup_Loc."Store to Prod. Batch");
        ItemJnlLine_NewLine."Line No." := ItemJnlLine."Line No." + 20000;
        ItemJnlLine_NewLine.Validate("Entry Type", ItemJnlLine_NewLine."Entry Type"::Transfer);
        ItemJnlLine_NewLine.Validate("Posting Date", Today);
        ItemJnlLine_NewLine.Validate("Document No.", GlobDocNo);
        IF (ContainerType = ContainerType::Bucket) then
            ItemJnlLine_NewLine.Validate("Item No.", ManufacturingSetup_Loc."Bucket Item Code");
        IF (ContainerType = ContainerType::Can) then
            ItemJnlLine_NewLine.Validate("Item No.", ManufacturingSetup_Loc."Can Item Code");
        IF (ContainerType = ContainerType::Drum) then
            ItemJnlLine_NewLine.Validate("Item No.", ManufacturingSetup_Loc."Drum Item Code");
        IF (ContainerType = ContainerType::Tin) then
            ItemJnlLine_NewLine.Validate("Item No.", ManufacturingSetup_Loc."Tin Item Code");

        Location_loc1.Reset();
        Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc1.SetRange("Store Location", true);
        if not Location_loc1.FindFirst() then begin
            Location_loc1.SetRange("Associated Plant");
            if Location_loc1.FindFirst() then;
        end;
        ItemJnlLine_NewLine.Validate("Location Code", Location_loc1.Code);
        ItemJnlLine_NewLine.Validate("New Location Code", ProdOrder_Loc."Location Code");
        ItemJnlLine_NewLine."Container Trasfer Stage" := ItemJnlLine_NewLine."Container Trasfer Stage"::"Issued RM";
        IF (ContainerType = ContainerType::Bucket) then begin
            ItemJnlLine_NewLine.Validate(Quantity, Bucket_Var);
            ItemJnlLine_NewLine.Bucket := Bucket_Var;
        end;
        IF (ContainerType = ContainerType::Can) then begin
            ItemJnlLine_NewLine.Validate(Quantity, Can_Var);
            ItemJnlLine_NewLine.Can := Can_Var;
        end;
        IF (ContainerType = ContainerType::Drum) then begin
            ItemJnlLine_NewLine.Validate(Quantity, Drum_Var);
            ItemJnlLine_NewLine.Drum := Drum_Var;
        end;
        IF (ContainerType = ContainerType::Tin) then begin
            ItemJnlLine_NewLine.Validate(Quantity, Tin_Var);
            ItemJnlLine_NewLine.Tin := Tin_Var;
        end;
        IF ItemJnlLine_NewLine.Insert() then;

        Commit();
        CurrPage.Update(true);

    end;

    procedure SetDocNo(var DocNo: Code[20])
    var
    begin
        GlobDocNo := DocNo;
    end;

    var
        GLob_ContainerType: Option Bucket,Can,Drum,Tin;
        Tin_Var: Integer;
        Drum_Var: Integer;
        Bucket_Var: Integer;
        Can_Var: Integer;
        GlobDocNo: Code[20];

}