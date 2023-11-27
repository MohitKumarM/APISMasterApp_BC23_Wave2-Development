page 50069 "Production BOM Lines View"
{
    AutoSplitKey = true;
    Caption = 'Production BOM Lines View';
    DataCaptionFields = "Production BOM No.";
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Production BOM Line";

    layout
    {
        area(content)
        {
            repeater(Grp1)
            {
                field("Product Group"; Rec."Product Group")
                {
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                }
                field("FG Name"; Rec."FG Name")
                {
                }
                field("Customer Code"; Rec."Customer Code")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                }
                field("BOM Status"; Rec."BOM Status")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Calculation Formula"; Rec."Calculation Formula")
                {
                    Visible = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Item Category Code (RM / PM)"; Rec."Item Category Code (RM / PM)")
                {
                }
                field("Product Group Code (RM / PM)"; Rec."Product Group Code (RM / PM)")
                {
                }
                field("Wastage %"; Rec."Wastage %")
                {
                }
                field("Net Req. Qty."; decNetQty)
                {
                    DecimalPlaces = 4 : 4;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Component")
            {
                Caption = '&Component';
                Image = Components;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        ShowComment;
                    end;
                }
                action("Where-Used")
                {
                    Caption = 'Where-Used';
                    Image = "Where-Used";

                    trigger OnAction()
                    begin
                        ShowWhereUsed;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        decNetQty := ROUND((Rec."Quantity per" * (100 + Rec."Wastage %") / 100), 0.0001);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
    end;

    var
        decNetQty: Decimal;


    procedure ShowComment()
    var
        ProdOrderCompComment: Record "Production BOM Comment Line";
    begin
        ProdOrderCompComment.SETRANGE("Production BOM No.", Rec."Production BOM No.");
        ProdOrderCompComment.SETRANGE("BOM Line No.", Rec."Line No.");
        ProdOrderCompComment.SETRANGE("Version Code", Rec."Version Code");

        PAGE.RUN(PAGE::"Prod. Order BOM Cmt. Sheet", ProdOrderCompComment);
    end;


    procedure ShowWhereUsed()
    var
        Item: Record "Item";
        ProdBomHeader: Record "Production BOM Header";
        ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
    begin
        IF Rec.Type = Rec.Type::" " THEN
            EXIT;

        CASE Rec.Type OF
            Rec.Type::Item:
                BEGIN
                    Item.GET(Rec."No.");
                    ProdBOMWhereUsed.SetItem(Item, WORKDATE);
                END;
            Rec.Type::"Production BOM":
                BEGIN
                    ProdBomHeader.GET(Rec."No.");
                    ProdBOMWhereUsed.SetProdBOM(ProdBomHeader, WORKDATE);
                END;
        END;
        ProdBOMWhereUsed.RUNMODAL;
        CLEAR(ProdBOMWhereUsed);
    end;
}

