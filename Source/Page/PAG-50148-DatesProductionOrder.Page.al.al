page 50148 "Dates Production Order"
{
    Caption = 'Dates Production Order';
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released),
                            "Order Type" = FILTER(Dates));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    Lookup = false;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    QuickEntry = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        IF xRec."Source Type" <> Rec."Source Type" THEN
                            Rec."Source No." := '';
                    end;
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Search Description"; Rec."Search Description")
                {
                    QuickEntry = false;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    QuickEntry = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                }
                field("Customer Code"; Rec."Customer Code")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Batch No."; Rec."Batch No.")
                {
                }
                field(Moisture; Rec.Moisture)
                {
                }
                field(Color; Rec.Color)
                {
                }
                field(FG; Rec.FG)
                {
                }
                field(HMF; Rec.HMF)
                {
                }
            }
            part(ProdOrderLines; "Released Prod. Order Lines")
            {
                Editable = false;
                SubPageLink = "Prod. Order No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Image = "Order";
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                }
                action(RefreshProductionOrder)
                {
                    Caption = 'Re&fresh Production Order';
                    Ellipsis = true;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Refresh Production Order", TRUE, TRUE, ProdOrder);
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Order Type" := Rec."Order Type"::Dates;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Order Type" := Rec."Order Type"::Dates;
    end;

    var
        CopyProdOrderDoc: Report "Copy Production Order Document";
        ManuPrintReport: Codeunit "Manu. Print Report";
        Text000: Label 'Inbound Whse. Requests are created.';
        Text001: Label 'No Inbound Whse. Request is created.';
        Text002: Label 'Inbound Whse. Requests have already been created.';

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    end;
}

