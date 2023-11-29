page 50137 "Container Store to Prod."
{
    Caption = 'Transfer Container from Store to Prod.';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Journal Line";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {

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
                        if (Rec.Drum >= 0) then begin
                            Rec.Validate(Quantity, Rec.Drum);
                            Rec.Tin := 0;
                            Rec.Can := 0;
                            Rec.Bucket := 0;
                        end else
                            Error('Value must be greater than equal to 0');
                    end;
                }
                field(Tin; Rec.Tin)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if (Rec.Tin >= 0) then begin
                            Rec.Validate(Quantity, Rec.Tin);
                            Rec.Drum := 0;
                            Rec.Can := 0;
                            Rec.Bucket := 0;
                        end else
                            Error('Value must be greater than equal to 0');
                    end;
                }
                field(Can; Rec.Can)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if (Rec.Can >= 0) then begin
                            Rec.Validate(Quantity, Rec.Can);
                            Rec.Tin := 0;
                            Rec.Drum := 0;
                            Rec.Bucket := 0;
                        end else
                            Error('Value must be greater than equal to 0');
                    end;
                }
                field(Bucket; Rec.Bucket)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if (Rec.Bucket >= 0) then begin
                            Rec.Validate(Quantity, Rec.Bucket);
                            Rec.Tin := 0;
                            Rec.Can := 0;
                            Rec.Drum := 0;
                        end else
                            Error('Value must be greater than equal to 0');
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
                    Location_loc1: Record Location;
                    Location_loc2: Record Location;
                    ProdOrder_Loc: Record "Production Order";
                begin
                    Clear(lastLineNo);
                    ManfactSetup.Get();
                    ManfactSetup.TestField("Prod. to Store Template");
                    ManfactSetup.TestField("Prod. to Store Batch");

                    if ItemJournalLine_Temp.IsTemporary then
                        ItemJournalLine_Temp.DeleteAll();

                    ItemjnlLine_Loc.Reset();
                    ItemjnlLine_Loc.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemjnlLine_Loc.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemjnlLine_Loc.SetRange("Document No.", Rec."Document No.");
                    ItemjnlLine_Loc.SetRange("Container Trasfer Stage", ItemjnlLine_Loc."Container Trasfer Stage"::"Issued RM");
                    IF ItemjnlLine_Loc.FindSet() then begin
                        ItemjnlLine_Loc_1.Reset();
                        ItemjnlLine_Loc_1.SetRange("Journal Template Name", ManfactSetup."Prod. to Store Template");
                        ItemjnlLine_Loc_1.SetRange("Journal Batch Name", ManfactSetup."Prod. to Store Batch");
                        ItemjnlLine_Loc_1.SetRange("Document No.", Rec."Document No.");
                        IF ItemjnlLine_Loc_1.FindLast() then
                            lastLineNo := ItemjnlLine_Loc_1."Line No.";

                        ProdOrder_Loc.Reset();
                        ProdOrder_Loc.SetRange("No.", Rec."Document No.");
                        ProdOrder_Loc.FindFirst();
                        ProdOrder_Loc.TestField("Location Code");
                        Location_loc.Get(ProdOrder_Loc."Location Code");
                        Location_loc.TestField("Associated Plant");
                        Location_loc1.Reset();
                        Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
                        Location_loc1.SetRange("Production Location", true);
                        Location_loc1.FindFirst();
                        Location_loc2.Reset();
                        Location_loc2.SetRange("Associated Plant", Location_loc."Associated Plant");
                        Location_loc2.SetRange("Scrap Location", true);
                        Location_loc2.FindFirst();



                        repeat
                            ItemJournalLine_Temp.Init();
                            ItemJournalLine_Temp."Journal Template Name" := ManfactSetup."Prod. to Store Template";
                            ItemJournalLine_Temp."Journal Batch Name" := ManfactSetup."Prod. to Store Batch";
                            lastLineNo += 10000;
                            ItemJournalLine_Temp."Entry Type" := ItemJournalLine_Temp."Entry Type"::Transfer;
                            ItemJournalLine_Temp."Line No." := lastLineNo;
                            ItemJournalLine_Temp."Document No." := Rec."Document No.";
                            ItemJournalLine_Temp."Posting Date" := Rec."Posting Date";
                            ItemJournalLine_Temp.Validate("Item No.", ItemjnlLine_Loc."Item No.");
                            Location_loc1.Reset();
                            Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
                            Location_loc1.SetRange("Production Location", true);
                            Location_loc1.FindFirst();
                            ItemJournalLine_Temp."Location Code" := Location_loc1.Code;
                            ItemJournalLine_Temp."New Location Code" := Location_loc2.Code;
                            ItemJournalLine_Temp.Drum := ItemjnlLine_Loc.Drum;
                            ItemJournalLine_Temp.Tin := ItemjnlLine_Loc.Tin;
                            ItemJournalLine_Temp.Can := ItemjnlLine_Loc.Can;
                            ItemJournalLine_Temp.Bucket := ItemjnlLine_Loc.Bucket;
                            ItemJournalLine_Temp.Validate(Quantity, ItemjnlLine_Loc.Quantity);
                            ItemJournalLine_Temp."Container Trasfer Stage" := ItemJournalLine_Temp."Container Trasfer Stage"::"RM Consumed";
                            ItemJournalLine_Temp.Insert();

                        until ItemjnlLine_Loc.Next() = 0;
                    end;

                    CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", Rec);
                    Commit();

                    ItemJournalLine_Temp.Reset();
                    IF ItemJournalLine_Temp.FindSet() then begin
                        repeat
                            ItemjnlLine_Loc_1.Init();
                            ItemjnlLine_Loc_1.TransferFields(ItemJournalLine_Temp);
                            ItemjnlLine_Loc_1."Container Trasfer Stage" := ItemjnlLine_Loc_1."Container Trasfer Stage"::"RM Consumed";
                            ItemjnlLine_Loc_1.Insert();
                        until ItemJournalLine_Temp.Next() = 0;
                    end;

                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var

    begin
        ManufacturingSetup_Loc.Get();
        ManufacturingSetup_Loc.TestField("Store to Prod. Template");
        ManufacturingSetup_Loc.TestField("Store to Prod. Batch");
        Rec.FilterGroup(2);
        Rec.SetRange("Journal Template Name", ManufacturingSetup_Loc."Store to Prod. Template");
        Rec.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Store to Prod. Batch");
        Rec.SetRange("Document No.", GlobDocNo);
        Rec.FilterGroup(0);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ItemJnlLine: Record "Item Journal Line";
        Location_loc: Record Location;
        Location_loc1: Record Location;
        Location_loc2: Record Location;
        ProdOrder_Loc: Record "Production Order";
    begin
        ManufacturingSetup_Loc.Get();
        ManufacturingSetup_Loc.TestField("Store to Prod. Template");
        ManufacturingSetup_Loc.TestField("Store to Prod. Batch");

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", ManufacturingSetup_Loc."Prod. to Store Template");
        ItemJnlLine.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Prod. to Store Batch");
        IF ItemJnlLine.FindLast() then;

        ProdOrder_Loc.Reset();
        ProdOrder_Loc.SetRange("No.", GlobDocNo);
        ProdOrder_Loc.FindFirst();
        ProdOrder_Loc.TestField("Location Code");
        Location_loc.Get(ProdOrder_Loc."Location Code");
        Location_loc.TestField("Associated Plant");

        Rec."Posting Date" := Today;
        Rec."Journal Template Name" := ManufacturingSetup_Loc."Store to Prod. Template";
        Rec."Journal Batch Name" := ManufacturingSetup_Loc."Store to Prod. Batch";
        Rec."Line No." := ItemJnlLine."Line No." + 10000;
        Rec."Document No." := GlobDocNo;
        Location_loc1.Reset();
        Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc1.SetRange("Store Location", true);
        Location_loc1.FindFirst();
        Rec."Location Code" := Location_loc2.Code;
        Location_loc1.Reset();
        Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc1.SetRange("Production Location", true);
        Location_loc1.FindFirst();
        Rec."New Location Code" := Location_loc1.Code;
        Rec."Container Trasfer Stage" := Rec."Container Trasfer Stage"::"Issued RM";
        Rec.Validate("Entry Type", Rec."Entry Type"::Transfer);
    end;

    procedure SetDocNo(var DocNo: Code[20])
    var
    begin
        GlobDocNo := DocNo;

    end;

    var
        GlobDocNo: Code[20];

        ManufacturingSetup_Loc: Record "Manufacturing Setup";

}