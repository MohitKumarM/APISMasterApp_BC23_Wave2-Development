page 50053 "Production Planning"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Item Budget Entry";
    SourceTableView = SORTING("Analysis Area", "Budget Name", "Item No.", "Source Type", "Source No.", Date, "Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code")
                      ORDER(Ascending) WHERE("Analysis Area" = FILTER(Sales), "Budget Name" = FILTER(''));
    ApplicationArea = ALL;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(decQtyToProduce; decQtyToProduce)
                {
                    Caption = 'Enter Qty. to Process';
                }
                field(cdLocationCode; cdLocationCode)
                {
                    Caption = 'Select Production Location';
                    //TableRelation = Location.Code where("Production Unit" = const(true));
                    // TableRelation = Location WHERE(Code = FILTER('RRK-PR1' | 'RRK-PR2'));
                    trigger OnDrillDown()
                    var
                        LocationLoc: Record Location;
                        ManufSetup: Record "Manufacturing Setup";
                    begin
                        ManufSetup.Get();
                        LocationLoc.Reset();
                        LocationLoc.SetRange(Code, ManufSetup."Production Location");
                        if LocationLoc.FindFirst then
                            if page.RunModal(0, LocationLoc) = Action::LookupOK then
                                cdLocationCode := LocationLoc.Code;
                    end;

                    trigger OnValidate()
                    begin
                        // IF (STRPOS(cdLocationCode, 'RRK-PR1') = 0) AND (STRPOS(cdLocationCode, 'RRK-PR2') = 0) THEN
                        //     ERROR('Invalid location, it must be RRK-PR1 or RRK-PR2');
                    end;
                }
                field("Plan Date"; dtPlanDate) { }
                field("Production For"; ProductionFor)
                {
                    Caption = 'Production For';

                    trigger OnValidate()
                    var
                    begin
                        IF (ProductionFor = ProductionFor::Customer) then
                            ProductionForEnable := true
                        else
                            ProductionForEnable := false;
                    end;
                }
                field(cdCustomerCode; cdCustomerCode)
                {
                    Caption = 'Select Customer';
                    TableRelation = Customer;
                    Enabled = ProductionForEnable;

                    trigger OnValidate()
                    begin
                        cdBulkItemNo := '';

                        IF recCustomer.GET(cdCustomerCode) THEN
                            txtCustomerName := recCustomer.Name
                        ELSE
                            txtCustomerName := '';
                    end;
                }
                field(txtCustomerName; txtCustomerName)
                {
                    Caption = 'Customer Name';
                    Editable = false;
                }
                field(dBatchNo; dBatchNo)
                {
                    Caption = 'Enter Batch No.';
                }
                field(opProductionType; opProductionType)
                {
                    Caption = 'Production Type';
                }
                field(cdBulkItemNo; cdBulkItemNo)
                {
                    Caption = 'Bulk Item No.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        recItem.RESET;
                        recItem.SETRANGE("New Product Group Code", 'BULK');
                        //recItem.SETRANGE("Customer Code", cdCustomerCode);
                        IF PAGE.RUNMODAL(0, recItem) = ACTION::LookupOK THEN BEGIN
                            cdBulkItemNo := recItem."No.";
                        END;
                    end;
                }
                field(Moisture; txtQualityValues) { }
                field(Color; txtColor) { }
                field(FG; txtFG) { }
                field(HMF; txtHMF) { }
            }
            repeater(Group)
            {
                Visible = false;
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Item Name"; Rec."Item Name") { }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name") { }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    Editable = false;
                }
                field("Stock Adjusted"; Rec."Stock Adjusted")
                {
                    Editable = false;
                }
                field("Remaining Qty. to Produce"; Rec."Remaining Qty. to Produce")
                {
                    Editable = false;
                }
                field("Calculation Date"; Rec."Calculation Date")
                {
                    Editable = false;
                }
                field("Packing Order Qty."; Rec."Packing Order Qty.") { }
                field("Qty. to Pack"; Rec."Qty. to Pack") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Prod. Order")
            {
                Caption = 'Create Prod. Order';
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF (ProductionFor = ProductionFor::" ") then
                        Error('Please Select a value for Production For Field on Page');

                    recManufacturingSetup.GET;
                    recManufacturingSetup.TESTFIELD("Production Location");
                    recManufacturingSetup.TESTFIELD("Loose Honey Code");

                    IF decQtyToProduce = 0 THEN
                        ERROR('Enter Quantity to Process.');

                    IF cdLocationCode = '' THEN
                        ERROR('Select Production Location first.');

                    IF dBatchNo = '' THEN
                        ERROR('Enter Batch No.');

                    IF opProductionType = 0 THEN
                        ERROR('Select Production Type');

                    recProductionOrder.RESET;
                    recProductionOrder.SETRANGE(Status, recProductionOrder.Status::Released);
                    recProductionOrder.SETRANGE(Refreshed, FALSE);
                    IF recProductionOrder.FINDFIRST THEN
                        ERROR('There are production orders to refresh, first refresh them manually.');

                    recProductionOrder.INIT;
                    recProductionOrder.VALIDATE(Status, recProductionOrder.Status::Released);
                    recProductionOrder."No." := '';
                    recProductionOrder.INSERT(TRUE);
                    cdProdOrderCode := recProductionOrder."No.";

                    recProductionOrder.VALIDATE("Source Type", recProductionOrder."Source Type"::Item);

                    recProductionOrder.VALIDATE("Source No.", recManufacturingSetup."Loose Honey Code");
                    recProductionOrder.VALIDATE(Quantity, decQtyToProduce);
                    recProductionOrder.VALIDATE("Location Code", cdLocationCode);
                    IF cdCustomerCode <> '' THEN
                        recProductionOrder.VALIDATE("Customer Code", cdCustomerCode);
                    recProductionOrder."Batch No." := dBatchNo;
                    recProductionOrder."Production Type" := opProductionType;
                    IF dtPlanDate <> 0D THEN
                        recProductionOrder."Creation Date" := dtPlanDate;

                    recRoutingHeader.RESET;
                    recRoutingHeader.SETRANGE("Production Type", opProductionType);
                    recRoutingHeader.SETRANGE("Auto Selection", TRUE);
                    recRoutingHeader.FINDFIRST;
                    recProductionOrder.VALIDATE("Routing No.", recRoutingHeader."No.");
                    recProductionOrder.Moisture := txtQualityValues;
                    recProductionOrder.Color := txtColor;
                    recProductionOrder.FG := txtFG;

                    recProductionOrder.HMF := txtHMF;
                    recProductionOrder.MODIFY(TRUE);
                    COMMIT;

                    recProductionOrder.RESET;
                    recProductionOrder.SETRANGE(Status, recProductionOrder.Status::Released);
                    recProductionOrder.SETRANGE(Refreshed, FALSE);
                    IF recProductionOrder.FINDFIRST THEN
                        REPEAT

                            recProdOrderToRefresh.RESET;
                            recProdOrderToRefresh.SETRANGE(Status, recProductionOrder.Status);
                            recProdOrderToRefresh.SETRANGE("No.", recProductionOrder."No.");
                            recProdOrderToRefresh.FINDFIRST;
                            COMMIT;

                            REPORT.RUNMODAL(Report::"Refresh Production Order", FALSE, TRUE, recProdOrderToRefresh);
                            COMMIT;
                        UNTIL recProductionOrder.NEXT = 0;

                    MESSAGE('Production order %1 created.', cdProdOrderCode);
                    Clear(decQtyToProduce);
                    Clear(cdLocationCode);
                    Clear(dtPlanDate);
                    Clear(cdCustomerCode);
                    Clear(txtCustomerName);
                    Clear(dBatchNo);
                    Clear(opProductionType);
                    Clear(cdBulkItemNo);
                    Clear(txtQualityValues);
                    Clear(txtColor);
                    Clear(txtFG);
                    Clear(txtHMF);
                    CurrPage.Update();
                end;
            }

            action("Item Balance")
            {
                Caption = 'Item Balance';
                Image = ItemAvailbyLoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Item Trial";
            }
        }
    }

    trigger OnOpenPage()
    begin
        dtPlanDate := TODAY;
        IF (ProductionFor = ProductionFor::Customer) then
            ProductionForEnable := true
        else
            ProductionForEnable := false;
    end;

    var
        recProductionOrder: Record "Production Order";
        recProdOrderToRefresh: Record "Production Order";
        recManufacturingSetup: Record "Manufacturing Setup";
        decQtyToProduce: Decimal;
        cdLocationCode: Code[20];
        dBatchNo: Code[20];
        cdCustomerCode: Code[20];
        cdProdOrderCode: Code[20];
        opProductionType: Option " ","Bulk Without Filteration","Bulk With Filteration","Small Pack";
        recRoutingHeader: Record "Routing Header";
        cdBulkItemNo: Code[20];
        recItem: Record "Item";
        txtCustomerName: Text[50];
        recCustomer: Record "Customer";
        txtQualityValues: Text[30];
        txtColor: Text[30];
        txtFG: Text[30];
        txtHMF: Text[30];
        dtPlanDate: Date;
        ProductionFor: Option " ","In House",Customer;
        ProductionForEnable: Boolean;
}
