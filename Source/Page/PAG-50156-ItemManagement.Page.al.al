page 50156 "Item Management"
{
    Caption = 'Item Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Item;
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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("No. 2"; Rec."No. 2")
                {
                }
                // field("Barcode No."; Rec."Barcode No.")
                // {
                // }
                field(Description; Rec.Description)
                {
                }
                field("Extended Description"; Rec."Extended Description")
                {
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Importance = Promoted;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {

                    trigger OnValidate()
                    begin
                        EnableCostingControls;
                    end;
                }
                field("Product Group Code"; Rec."New Product Group Code")
                {
                }
                field("Search Description"; Rec."Search Description")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        EnableCostingControls;
                    end;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Importance = Promoted;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                }

                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Importance = Promoted;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    Importance = Promoted;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                }
                field("Expiry Date Formula"; Rec."Expiry Date Formula")
                {
                }
                field("Routing No."; Rec."Routing No.")
                {
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    Importance = Promoted;
                }
                field("Quality Process"; Rec."Quality Process")
                {
                }
                field("Customer Code"; Rec."Customer Code")
                {
                }
                field("Pack Size"; Rec."Pack Size")
                {
                }
                field("Gross Weight Per (Kg)"; Rec."Gross Weight Per (Kg)")
                {
                }
                field("Net Weight Per (Kg)"; Rec."Net Weight Per (Kg)")
                {
                }
                field(Length; Rec.Length_)
                {
                }
                field(Width; Rec.Width_)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field("Item Size Dimension"; Rec."Item Size Dimension")
                {
                }
                field("Item Type"; Rec."Item Type")
                {
                }
                field("Pcs. Per Cartoon"; Rec."Pcs. Per Cartoon")
                {
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                }
                field("MRP Price"; Rec."Unit List Price")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Master Data")
            {
                Caption = 'Master Data';
                Image = DataEntry;
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Price List Lines";
                    RunPageLink = "Asset Type" = filter(Item), "Asset No." = field("No.");
                    RunPageView = SORTING("Asset Type", "Asset No.", "Source Type", "Source No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                }
                action(Dimensions_)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
            group("&Item Availability by")
            {
                Caption = '&Item Availability by';
                Image = ItemAvailability;
                Visible = false;
                action(Period)
                {
                    Caption = 'Period';
                    Image = Period;
                    RunObject = Page "Item Availability by Periods";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                }
                action(Variant)
                {
                    Caption = 'Variant';
                    Image = ItemVariant;
                    RunObject = Page "Item Availability by Variant";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                }
                action(Location)
                {
                    Caption = 'Location';
                    Image = Warehouse;
                    RunObject = Page "Item Availability by Location";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Ledger Report")
                {
                    Caption = 'Ledger Report';
                    RunObject = Report 704;
                    RunPageOnRec = true;
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Visible = false;
                    action(Statistics_)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                }
            }
            group(Production)
            {
                Caption = 'Production';
                Image = Production;
                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    Image = BOM;
                    RunObject = Page "Production BOM";
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnablePlanningControls;
        EnableCostingControls;
    end;

    trigger OnInit()
    begin
        UnitCostEnable := TRUE;
        StandardCostEnable := TRUE;
        OverflowLevelEnable := TRUE;
        DampenerQtyEnable := TRUE;
        DampenerPeriodEnable := TRUE;
        LotAccumulationPeriodEnable := TRUE;
        ReschedulingPeriodEnable := TRUE;
        IncludeInventoryEnable := TRUE;
        OrderMultipleEnable := TRUE;
        MaximumOrderQtyEnable := TRUE;
        MinimumOrderQtyEnable := TRUE;
        MaximumInventoryEnable := TRUE;
        ReorderQtyEnable := TRUE;
        ReorderPointEnable := TRUE;
        SafetyStockQtyEnable := TRUE;
        SafetyLeadTimeEnable := TRUE;
        TimeBucketEnable := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EnablePlanningControls;
        EnableCostingControls;
    end;

    var
        SkilledResourceList: Page "Skilled Resource List";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

        TimeBucketEnable: Boolean;

        SafetyLeadTimeEnable: Boolean;

        SafetyStockQtyEnable: Boolean;

        ReorderPointEnable: Boolean;

        ReorderQtyEnable: Boolean;

        MaximumInventoryEnable: Boolean;

        MinimumOrderQtyEnable: Boolean;

        MaximumOrderQtyEnable: Boolean;

        OrderMultipleEnable: Boolean;

        IncludeInventoryEnable: Boolean;

        ReschedulingPeriodEnable: Boolean;

        LotAccumulationPeriodEnable: Boolean;

        DampenerPeriodEnable: Boolean;

        DampenerQtyEnable: Boolean;

        OverflowLevelEnable: Boolean;

        StandardCostEnable: Boolean;

        UnitCostEnable: Boolean;
        recFamily: Record "Family";
        recFamilyLines: Record "Family Line";
        recManufacturingSetup: Record "Manufacturing Setup";
        recItemVariant: Record "Item Variant";


    procedure EnablePlanningControls()
    var
        PlanningGetParam: Codeunit "Planning-Get Parameters";
        TimeBucketEnabled: Boolean;
        SafetyLeadTimeEnabled: Boolean;
        SafetyStockQtyEnabled: Boolean;
        ReorderPointEnabled: Boolean;
        ReorderQtyEnabled: Boolean;
        MaximumInventoryEnabled: Boolean;
        MinimumOrderQtyEnabled: Boolean;
        MaximumOrderQtyEnabled: Boolean;
        OrderMultipleEnabled: Boolean;
        IncludeInventoryEnabled: Boolean;
        ReschedulingPeriodEnabled: Boolean;
        LotAccumulationPeriodEnabled: Boolean;
        DampenerPeriodEnabled: Boolean;
        DampenerQtyEnabled: Boolean;
        OverflowLevelEnabled: Boolean;
    begin
        // PlanningGetParam.SetUpPlanningControls("Reordering Policy", "Include Inventory",
        //   TimeBucketEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled,
        //   ReorderPointEnabled, ReorderQtyEnabled, MaximumInventoryEnabled,
        //   MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled,
        //   ReschedulingPeriodEnabled, LotAccumulationPeriodEnabled,
        //   DampenerPeriodEnabled, DampenerQtyEnabled, OverflowLevelEnabled);

        TimeBucketEnable := TimeBucketEnabled;
        SafetyLeadTimeEnable := SafetyLeadTimeEnabled;
        SafetyStockQtyEnable := SafetyStockQtyEnabled;
        ReorderPointEnable := ReorderPointEnabled;
        ReorderQtyEnable := ReorderQtyEnabled;
        MaximumInventoryEnable := MaximumInventoryEnabled;
        MinimumOrderQtyEnable := MinimumOrderQtyEnabled;
        MaximumOrderQtyEnable := MaximumOrderQtyEnabled;
        OrderMultipleEnable := OrderMultipleEnabled;
        IncludeInventoryEnable := IncludeInventoryEnabled;
        ReschedulingPeriodEnable := ReschedulingPeriodEnabled;
        LotAccumulationPeriodEnable := LotAccumulationPeriodEnabled;
        DampenerPeriodEnable := DampenerPeriodEnabled;
        DampenerQtyEnable := DampenerQtyEnabled;
        OverflowLevelEnable := OverflowLevelEnabled;
    end;


    procedure EnableCostingControls()
    begin
        StandardCostEnable := Rec."Costing Method" = "Costing Method"::Standard;
        UnitCostEnable := Rec."Costing Method" <> "Costing Method"::Standard;
    end;
}

