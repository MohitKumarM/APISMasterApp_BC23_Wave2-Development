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
                        Location_Loc1: Record Location;
                        Location_Loc2: Record Location;
                        Location_Loc3: Record Location;
                        ProdOrder_Loc: Record "Production Order";
                    begin
                        Rec.TestField("Document No.");
                        ProdOrder_Loc.Reset();
                        ProdOrder_Loc.SetRange("No.", Rec."Document No.");
                        ProdOrder_Loc.FindFirst();
                        ProdOrder_Loc.TestField("Location Code");
                        Location_Loc1.Get(ProdOrder_Loc."Location Code");
                        Location_Loc2.Reset();
                        Location_Loc2.SetRange("Associated Plant", Location_Loc1."Associated Plant");
                        Location_Loc2.SetRange("Scrap Location", true);
                        Location_Loc2.FindFirst();
                        Location_Loc3.Reset();
                        Location_Loc3.SetRange("Associated Plant", Location_Loc1."Associated Plant");
                        Location_Loc3.SetRange("Reject Location", true);
                        Location_Loc3.FindFirst();

                        IF not ((Rec."New Location Code" = Location_Loc2.Code) or (Rec."New Location Code" = Location_Loc3.Code)) then
                            Error('Entered Location is neither scrap nor reject Location.');
                    end;

                    trigger OnDrillDown()
                    var
                        location_Loc: Record Location;
                        manufSetup: Record "Manufacturing Setup";
                        Location_Loc1: Record Location;
                        Location_Loc2: Record Location;
                        Location_Loc3: Record Location;
                        ProdOrder_Loc: Record "Production Order";
                    begin
                        Rec.TestField("Document No.");
                        ProdOrder_Loc.Reset();
                        ProdOrder_Loc.SetRange("No.", Rec."Document No.");
                        ProdOrder_Loc.FindFirst();
                        ProdOrder_Loc.TestField("Location Code");
                        Location_Loc1.Get(ProdOrder_Loc."Location Code");
                        Location_Loc2.Reset();
                        Location_Loc2.SetRange("Associated Plant", Location_Loc1."Associated Plant");
                        Location_Loc2.SetRange("Scrap Location", true);
                        Location_Loc2.FindFirst();
                        Location_Loc3.Reset();
                        Location_Loc3.SetRange("Associated Plant", Location_Loc1."Associated Plant");
                        Location_Loc3.SetRange("Reject Location", true);
                        Location_Loc3.FindFirst();


                        location_Loc.Reset();
                        location_Loc.SetFilter(Code, '%1|%2', Location_Loc2.Code, Location_Loc3.Code);
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
        ItemJnlLine: Record "Item Journal Line";
        Location_loc: Record Location;
        Location_loc1: Record Location;
        Location_loc2: Record Location;
        ProdOrder_Loc: Record "Production Order";
    begin

        ManufacturingSetup_Loc.Get();
        ManufacturingSetup_Loc.TestField("Prod. to Store Template");
        ManufacturingSetup_Loc.TestField("Prod. to Store Batch");


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
        Rec.Validate("Entry Type", Rec."Entry Type"::Transfer);
        Rec."Journal Template Name" := ManufacturingSetup_Loc."Prod. to Store Template";
        Rec."Journal Batch Name" := ManufacturingSetup_Loc."Prod. to Store Batch";
        Rec."Line No." := ItemJnlLine."Line No." + 10000;
        Rec."Document No." := GlobDocNo;
        Location_loc1.Reset();
        Location_loc1.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc1.SetRange("Production Location", true);
        Location_loc1.FindFirst();
        Rec."Location Code" := Location_loc1.Code;
        Location_loc2.Reset();
        Location_loc2.SetRange("Associated Plant", Location_loc."Associated Plant");
        Location_loc2.SetRange("Scrap Location", true);
        Location_loc2.FindFirst();
        Rec."New Location Code" := Location_loc2.Code;
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