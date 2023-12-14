page 50146 "Released Production Order Ap"
{
    Caption = 'Released Production Order';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Document;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released));
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
                }
                field(Quantity; Rec.Quantity)
                {
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                    QuickEntry = false;
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

