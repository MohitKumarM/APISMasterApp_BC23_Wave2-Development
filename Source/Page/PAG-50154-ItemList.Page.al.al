page 50154 "Item  List"
{
    // <changelog>
    //     <change releaseversion="IN6.00"/>
    // </changelog>

    Caption = 'Item List';
    CardPageID = "Item Management";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = Item;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("No."; rec."No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("No. 2"; rec."No. 2")
                {
                }
                // field("Barcode No."; rec."Barcode No.")
                // {
                // }
                field(Description; rec.Description)
                {
                }
                field("Extended Description"; rec."Extended Description")
                {
                }
                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    Importance = Promoted;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                }
                field("Product Group Code"; rec."New Product Group Code")
                {
                }
                field("Search Description"; rec."Search Description")
                {
                }
                field(Blocked; rec.Blocked)
                {
                }
                field("Costing Method"; rec."Costing Method")
                {
                    Importance = Promoted;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    Importance = Promoted;
                }
                // field("MRP Price"; rec."MRP Price")
                // {
                // }
                field("Tariff No."; rec."Tariff No.")
                {
                }
                field("Tax Group Code"; rec."Tax Group Code")
                {
                    Importance = Promoted;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    Importance = Promoted;
                }
                field("Sales Unit of Measure"; rec."Sales Unit of Measure")
                {
                }
                field("Replenishment System"; rec."Replenishment System")
                {
                    Importance = Promoted;
                }
                field("Purch. Unit of Measure"; rec."Purch. Unit of Measure")
                {
                }
                field("Manufacturing Policy"; rec."Manufacturing Policy")
                {
                }
                field("Expiry Date Formula"; rec."Expiry Date Formula")
                {
                }
                field("Routing No."; rec."Routing No.")
                {
                }
                field("Production BOM No."; rec."Production BOM No.")
                {
                }
                field("Rounding Precision"; rec."Rounding Precision")
                {
                }
                field("Flushing Method"; rec."Flushing Method")
                {
                }
                field("Item Tracking Code"; rec."Item Tracking Code")
                {
                    Importance = Promoted;
                }
                field("Quality Process"; rec."Quality Process")
                {
                }
                field("Customer Code"; rec."Customer Code")
                {
                }
                field("Pack Size"; rec."Pack Size")
                {
                }
                field("Gross Weight Per (Kg)"; rec."Gross Weight Per (Kg)")
                {
                }
                field("Net Weight Per (Kg)"; rec."Net Weight Per (Kg)")
                {
                }
                field("Item Size Dimension"; rec."Item Size Dimension")
                {
                }
                field("Item Type"; rec."Item Type")
                {
                }
                field("Pcs. Per Cartoon"; rec."Pcs. Per Cartoon")
                {
                }
                field("Reorder Quantity"; rec."Reorder Quantity")
                {
                }
                field(Length; rec.Length_)
                {
                }
                field(Width; rec.Width_)
                {
                }
                field(Height; rec.Height)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        SkilledResourceList: Page "Skilled Resource List";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";


    procedure GetSelectionFilter(): Text
    var
        Item: Record Item;
        SelectionFilterManagement: Codeunit "SelectionFilterManagement";
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;


    procedure SetSelection(var Item: Record Item)
    begin
        CurrPage.SETSELECTIONFILTER(Item);
    end;
}

