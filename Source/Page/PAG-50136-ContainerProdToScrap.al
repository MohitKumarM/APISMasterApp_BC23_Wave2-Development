page 50136 "Container Prod. to Store."
{
    Caption = 'Transfer Container from Prod. to Store.';
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
                group(Production)
                {
                    Caption = 'Production Unit';
                    Editable = false;
                    field(Bucket_Var; Bucket_Var)
                    {
                        Caption = 'Bucket';

                    }
                    field(Can_Var; Can_Var)
                    {
                        Caption = 'Can';

                    }
                    field(Drum_Var; Drum_Var)
                    {
                        Caption = 'Drum';

                    }
                    field(Tin_Var; Tin_Var)
                    {
                        Caption = 'Tin';

                    }
                }
                group(Gen)
                {
                    ShowCaption = false;
                    group(Scrap)
                    {
                        Caption = 'Scrap Unit';

                        field(ScrapBucket_Var; ScrapBucket_Var)
                        {
                            Caption = 'Bucket';
                            trigger OnValidate()
                            begin
                                IF ((ScrapBucket_Var + RejectBucket_Var) > Bucket_Var) then
                                    Error('Scrap and Reject Bucket Qty must not exceed Production Bucket Qty.');

                                ContainerLineCreation(GLob_ContainerType::Bucket, ScrapBucket_Var, Container_Location::Scrap);
                            end;
                        }
                        field(ScrapCan_Var; ScrapCan_Var)
                        {
                            Caption = 'Can';
                            trigger OnValidate()
                            begin
                                IF ((ScrapCan_Var + RejectCan_Var) > Can_Var) then
                                    Error('Scrap and Reject Can Qty must not exceed Production Can Qty.');

                                ContainerLineCreation(GLob_ContainerType::Can, ScrapCan_Var, Container_Location::Scrap);
                            end;
                        }
                        field(ScrapDrum_Var; ScrapDrum_Var)
                        {
                            Caption = 'Drum';
                            trigger OnValidate()
                            begin
                                IF ((ScrapDrum_Var + RejectDrum_Var) > Drum_Var) then
                                    Error('Scrap and Reject Drum Qty must not exceed Production Drum Qty.');

                                ContainerLineCreation(GLob_ContainerType::Drum, ScrapDrum_Var, Container_Location::Scrap);
                            end;
                        }
                        field(ScrapTin_Var; ScrapTin_Var)
                        {
                            Caption = 'Tin';
                            trigger OnValidate()
                            begin
                                IF ((ScrapTin_Var + RejectTin_Var) > Tin_Var) then
                                    Error('Scrap and Reject Tin Qty must not exceed Production Tin Qty.');

                                ContainerLineCreation(GLob_ContainerType::Tin, ScrapTin_Var, Container_Location::Scrap);
                            end;
                        }
                    }
                    group(Reject)
                    {
                        Caption = 'Reject Unit';

                        field(RejectBucket_Var; RejectBucket_Var)
                        {
                            Caption = 'Bucket';
                            trigger OnValidate()
                            begin
                                IF ((ScrapBucket_Var + RejectBucket_Var) > Bucket_Var) then
                                    Error('Scrap and Reject Bucket Qty must not exceed Production Bucket Qty.');

                                ContainerLineCreation(GLob_ContainerType::Bucket, RejectBucket_Var, Container_Location::Reject);
                            end;
                        }
                        field(RejectCan_Var; RejectCan_Var)
                        {
                            Caption = 'Can';
                            trigger OnValidate()
                            begin
                                IF ((ScrapCan_Var + RejectCan_Var) > Can_Var) then
                                    Error('Scrap and Reject Can Qty must not exceed Production Can Qty.');

                                ContainerLineCreation(GLob_ContainerType::Can, RejectCan_Var, Container_Location::Reject);
                            end;
                        }
                        field(RejectDrum_Var; RejectDrum_Var)
                        {
                            Caption = 'Drum';
                            trigger OnValidate()
                            begin
                                IF ((ScrapDrum_Var + RejectDrum_Var) > Drum_Var) then
                                    Error('Scrap and Reject Drum Qty must not exceed Production Drum Qty.');

                                ContainerLineCreation(GLob_ContainerType::Drum, RejectDrum_Var, Container_Location::Reject);
                            end;
                        }
                        field(RejectTin_Var; RejectTin_Var)
                        {
                            Caption = 'Tin';
                            trigger OnValidate()
                            begin
                                IF ((ScrapTin_Var + RejectTin_Var) > Tin_Var) then
                                    Error('Scrap and Reject Tin Qty must not exceed Production Tin Qty.');

                                ContainerLineCreation(GLob_ContainerType::Tin, RejectTin_Var, Container_Location::Reject);
                            end;
                        }
                    }
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
                    ManfactSetup: Record "Manufacturing Setup";
                    ItemjnlLine_Loc: Record "Item Journal Line";
                begin
                    ManfactSetup.Get();
                    ManfactSetup.TestField("Prod. to Store Template");
                    ManfactSetup.TestField("Prod. to Store Batch");
                    ItemjnlLine_Loc.Reset();
                    ItemjnlLine_Loc.SetRange("Journal Template Name", ManfactSetup."Prod. to Store Template");
                    ItemjnlLine_Loc.SetRange("Journal Batch Name", ManfactSetup."Prod. to Store Batch");
                    ItemjnlLine_Loc.SetRange("Document No.", GlobDocNo);
                    ItemjnlLine_Loc.SetRange("Container Trasfer Stage", ItemjnlLine_Loc."Container Trasfer Stage"::"RM Consumed");
                    IF ItemjnlLine_Loc.FindSet() then begin
                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemjnlLine_Loc);
                        Commit();
                    end;

                    Clear(Bucket_Var);
                    Clear(Can_Var);
                    Clear(Drum_Var);
                    Clear(Tin_Var);
                    Clear(ScrapBucket_Var);
                    Clear(ScrapCan_Var);
                    Clear(ScrapDrum_Var);
                    Clear(ScrapTin_Var);
                    Clear(RejectBucket_Var);
                    Clear(RejectCan_Var);
                    Clear(RejectDrum_Var);
                    Clear(RejectTin_Var);


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
                    ILE_Rec.SetRange("Container Trasfer Stage", ILE_Rec."Container Trasfer Stage"::"RM Consumed");
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
        ILE_Rec: Record "Item Ledger Entry";
        ItemjnlLine_Loc: Record "Item Journal Line";
        ManfactSetup: Record "Manufacturing Setup";
        ProdOrder_Loc: Record "Production Order";
    begin
        ILE_Rec.Reset();
        ILE_Rec.SetRange("Entry Type", ILE_Rec."Entry Type"::Transfer);
        ILE_Rec.SetRange("Document No.", GlobDocNo);
        ILE_Rec.SetRange("Container Trasfer Stage", ILE_Rec."Container Trasfer Stage"::"RM Consumed");
        if ILE_Rec.FindFirst() then
            Error(StrSubstNo('Containers has already been posted against the %1 production Output', GlobDocNo));
        ProdOrder_Loc.Reset();
        ProdOrder_Loc.SetRange("No.", GlobDocNo);
        if ProdOrder_Loc.FindFirst() then
            ProdOrder_Loc.TestField("Location Code");
        ILE_Rec.Reset();
        ILE_Rec.SetRange("Entry Type", ILE_Rec."Entry Type"::Transfer);
        ILE_Rec.SetRange("Document No.", GlobDocNo);
        ILE_Rec.SetRange("Container Trasfer Stage", ILE_Rec."Container Trasfer Stage"::"Issued RM");
        ILE_Rec.SetRange("Location Code", ProdOrder_Loc."Location Code");
        IF ILE_Rec.FindSet() then begin
            repeat
                if (ILE_Rec.Bucket > 0) then
                    Bucket_Var += ILE_Rec.Bucket;
                if (ILE_Rec.Can > 0) then
                    Can_Var += ILE_Rec.Can;
                if (ILE_Rec.Drum > 0) then
                    Drum_Var += ILE_Rec.Drum;
                if (ILE_Rec.Tin > 0) then
                    Tin_Var += ILE_Rec.Tin;
            until ILE_Rec.Next() = 0;
        end;
    end;

    local procedure ContainerLineCreation(ContainerType: Option Bucket,Can,Drum,Tin; Value: Integer; Container_Location: Option Scrap,Reject)
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
        ManufacturingSetup_Loc.TestField("Prod. to Store Template");
        ManufacturingSetup_Loc.TestField("Prod. to Store Batch");
        ManufacturingSetup_Loc.TestField("Bucket Item Code");
        ManufacturingSetup_Loc.TestField("Can Item Code");
        ManufacturingSetup_Loc.TestField("Drum Item Code");
        ManufacturingSetup_Loc.TestField("Tin Item Code");

        ProdOrder_Loc.Reset();
        ProdOrder_Loc.SetRange("No.", GlobDocNo);
        ProdOrder_Loc.FindFirst();
        ProdOrder_Loc.TestField("Location Code");
        Location_loc.Get(ProdOrder_Loc."Location Code");

        Location_loc1.Reset();
        Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc1.SetRange("Scrap Location", true);
        if not Location_loc1.FindFirst() then begin
            Location_loc1.SetRange("Associated Plant");
            if not Location_loc1.FindFirst() then
                Error('There is no Scrap Location');
        end;

        Location_loc2.Reset();
        Location_loc2.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc2.SetRange("Reject Location", true);
        if not Location_loc2.FindFirst() then begin
            Location_loc2.SetRange("Associated Plant");
            if not Location_loc2.FindFirst() then
                Error('There is no Reject Location');
        end;

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", ManufacturingSetup_Loc."Prod. to Store Template");
        ItemJnlLine.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Prod. to Store Batch");
        ItemJnlLine.SetRange("Document No.", GlobDocNo);
        IF Container_Location = Container_Location::Scrap then
            ItemJnlLine.SetRange("New Location Code", Location_loc1.Code)
        else
            ItemJnlLine.SetRange("New Location Code", Location_loc2.Code);
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
        ItemJnlLine.SetRange("Journal Template Name", ManufacturingSetup_Loc."Prod. to Store Template");
        ItemJnlLine.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Prod. to Store Batch");
        IF ItemJnlLine.FindLast() then;

        ItemJnlLine_NewLine.Init();
        ItemJnlLine_NewLine.Validate("Journal Template Name", ManufacturingSetup_Loc."Prod. to Store Template");
        ItemJnlLine_NewLine.Validate("Journal Batch Name", ManufacturingSetup_Loc."Prod. to Store Batch");
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


        ItemJnlLine_NewLine.Validate("Location Code", Location_loc.Code);
        IF Container_Location = Container_Location::Scrap then
            ItemJnlLine_NewLine.Validate("New Location Code", Location_loc1.Code)
        else
            ItemJnlLine_NewLine.Validate("New Location Code", Location_loc2.Code);

        ItemJnlLine_NewLine."Container Trasfer Stage" := ItemJnlLine_NewLine."Container Trasfer Stage"::"RM Consumed";

        IF (ContainerType = ContainerType::Bucket) then begin
            if (Container_Location = Container_Location::Scrap) then
                ItemJnlLine_NewLine.Validate(Quantity, ScrapBucket_Var)
            else
                ItemJnlLine_NewLine.Validate(Quantity, RejectBucket_Var);
            ItemJnlLine_NewLine.Bucket := ItemJnlLine_NewLine.Quantity;
        end;
        IF (ContainerType = ContainerType::Can) then begin
            if (Container_Location = Container_Location::Scrap) then
                ItemJnlLine_NewLine.Validate(Quantity, ScrapCan_Var)
            else
                ItemJnlLine_NewLine.Validate(Quantity, RejectCan_Var);
            ItemJnlLine_NewLine.Bucket := ItemJnlLine_NewLine.Quantity;
        end;
        IF (ContainerType = ContainerType::Drum) then begin
            if (Container_Location = Container_Location::Scrap) then
                ItemJnlLine_NewLine.Validate(Quantity, ScrapDrum_Var)
            else
                ItemJnlLine_NewLine.Validate(Quantity, RejectDrum_Var);
            ItemJnlLine_NewLine.Bucket := ItemJnlLine_NewLine.Quantity;
        end;
        IF (ContainerType = ContainerType::Tin) then begin
            if (Container_Location = Container_Location::Scrap) then
                ItemJnlLine_NewLine.Validate(Quantity, ScrapTin_Var)
            else
                ItemJnlLine_NewLine.Validate(Quantity, RejectTin_Var);
            ItemJnlLine_NewLine.Bucket := ItemJnlLine_NewLine.Quantity;
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
        Container_Location: Option Scrap,Reject;
        ScrapTin_Var: Integer;
        ScrapDrum_Var: Integer;
        ScrapBucket_Var: Integer;
        ScrapCan_Var: Integer;
        RejectTin_Var: Integer;
        RejectDrum_Var: Integer;
        RejectBucket_Var: Integer;
        RejectCan_Var: Integer;
        Tin_Var: Integer;
        Drum_Var: Integer;
        Bucket_Var: Integer;
        Can_Var: Integer;
        GlobDocNo: Code[20];

}