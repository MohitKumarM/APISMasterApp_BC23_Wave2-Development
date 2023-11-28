page 50136 "Container- Prod. to Scrap"
{
    Caption = 'Transfer Container from Prod. to Scrap';
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
                field("Prod. Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;

                }
                field("Scrap/Reject Location Code"; Rec."New Location Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        manufSetup: Record "Manufacturing Setup";
                    begin
                        ManufacturingSetup_Loc.Get();
                        manufSetup.TestField("Scrap Location");
                        manufSetup.TestField("Reject Location");
                        IF not ((Rec."New Location Code" = manufSetup."Scrap Location") and (Rec."New Location Code" = ManufacturingSetup_Loc."Reject Location")) then
                            Error('Entered Location is neither scrap nor reject Location.');
                    end;

                    trigger OnDrillDown()
                    var
                        location_Loc: Record Location;
                        manufSetup: Record "Manufacturing Setup";
                    begin
                        ManufacturingSetup_Loc.Get();
                        manufSetup.TestField("Scrap Location");
                        manufSetup.TestField("Reject Location");

                        location_Loc.Reset();
                        location_Loc.SetFilter(Code, '%1|%2', manufSetup."Scrap Location", manufSetup."Reject Location");
                        if location_Loc.FindSet() then
                            if Page.RunModal(0, location_Loc) = Action::LookupOK then
                                Rec."New Location Code" := location_Loc.Code;
                    end;
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
                begin
                    CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var

    begin
        ManufacturingSetup_Loc.Get();
        ManufacturingSetup_Loc.TestField("Prod. to Store Template");
        ManufacturingSetup_Loc.TestField("Prod. to Store Batch");
        Rec.FilterGroup(2);
        Rec.SetRange("Journal Template Name", ManufacturingSetup_Loc."Prod. to Store Template");
        Rec.SetRange("Journal Batch Name", ManufacturingSetup_Loc."Prod. to Store Batch");
        Rec.SetRange("Document No.", GlobDocNo);
        Rec.FilterGroup(0);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        ManufacturingSetup_Loc.Get();
        ManufacturingSetup_Loc.TestField("Prod. to Store Template");
        ManufacturingSetup_Loc.TestField("Prod. to Store Batch");
        ManufacturingSetup_Loc.TestField("Production Location");
        ManufacturingSetup_Loc.TestField("Scrap Location");
        ManufacturingSetup_Loc.TestField("Reject Location");

        Rec."Posting Date" := Today;
        Rec.Validate("Entry Type", Rec."Entry Type"::Transfer);
        Rec."Journal Template Name" := ManufacturingSetup_Loc."Prod. to Store Template";
        Rec."Journal Batch Name" := ManufacturingSetup_Loc."Prod. to Store Batch";
        Rec."Document No." := GlobDocNo;
        Rec."Location Code" := ManufacturingSetup_Loc."Production Location";
        Rec."New Location Code" := ManufacturingSetup_Loc."Scrap Location";
        Rec."Container Trasfer Stage" := Rec."Container Trasfer Stage"::"RM Consumed";
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