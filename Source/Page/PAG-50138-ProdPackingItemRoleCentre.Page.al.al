page 50138 "Prod Packing & Item RoleCentre"
{
    Caption = 'Packing Item Role Centre';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(rolecenter)
        {
            group(Grp)
            {
                part("Packing Activities"; "Packing Activities")
                {
                    Caption = 'Packing Activities';
                }
                part("QC Activities"; "QC Partly4")
                {
                    Caption = 'QC Activities';
                }
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(CreatePackingOrders)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Create Packing Orders';
                RunObject = Page "Filling Planning";
                Image = Order;

            }
            action(PackingLocationStockTRF)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Packing Location Mat. Trf.';
                RunObject = Page "Packing Location Stock Trf.";
                Image = Order;

            }
            action(PackingOrderApproval)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Packing Order Approval';
                RunObject = Page "Packing Orders Approval";
                Image = Order;

            }
            action(PackingOrders)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Packing Orders';
                RunObject = Page "Packing Orders Material Req.";
                Image = Order;

            }
            action(OutputJournal)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Output Journal';
                RunObject = Page "Output Journal";
                Image = Order;

            }
            action(OutputPosting)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Output Posting';
                RunObject = page "Output Posting";
                Image = Order;

            }
            action(ConsumptionJournal)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Consumption Journal';
                RunObject = Page "Consumption Journal";
                Image = Order;

            }
            action(DatesOrders)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Dates Orders';
                RunObject = Page "Dates Production Orders";
                Image = Order;

            }
            action(MaterialRequisition)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Material Requisition';
                RunObject = page "Material Req. List";
                Image = Order;

            }
            action(PendingInwardQuality)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Pending Inward Quality';
                RunObject = page "Pending Inward QC";
                Image = Order;

            }
            action(PostedQC)
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Posted QC';
                RunObject = page "Quality Checks";
                Image = Order;

            }
        }
        area(processing)
        {
            group("Masters Management")
            {
                Caption = 'Masters Management';
                Image = Bank;
                action(Items)
                {
                    Caption = 'Items';
                    RunObject = Page "Item  List";
                }
                group("Masters Creation")
                {
                    Caption = 'Masters Creation';
                    Image = Bank;
                    action(Item_)
                    {
                        Caption = 'Item';
                        Image = NewItem;
                        RunObject = Page "Nonstock Item List";
                    }
                }
            }
            group("Masters Approval")
            {
                Caption = 'Masters Approval';
                Image = Bank;
                action(Item)
                {
                    Caption = 'Item';
                    Image = NewItem;
                    RunObject = Page "Item Approval List";
                }
            }
            group(Voucher)
            {
                Caption = 'Voucher';
                Image = Statistics;
                action("Item Transfer")
                {
                    Caption = 'Item Transfer';
                    RunObject = Page 50137;
                }
                action("De-Assemble Item")
                {
                    RunObject = Page "Assembly Orders";
                }
            }
            group(Masters)
            {
                Caption = 'Masters';
                Image = Journals;
                group("Production Design")
                {
                    Caption = 'Production Design';
                    Image = Bank;
                    action("Production BOM")
                    {
                        Caption = 'Production BOM';
                        Image = ProdBOMMatrixPerVersion;
                        RunObject = Page 50032;
                    }
                    action("BOM List View")
                    {
                        RunObject = Page 50136;
                    }
                    action("Item List")
                    {
                        RunObject = Page "Item List";
                    }
                }
                group(Balances)
                {
                    Caption = 'Balances';
                    Image = Statistics;
                    action("Item Balance")
                    {
                        Caption = 'Item Balance';
                        RunObject = Page "Item Trial";
                    }
                }
            }
        }
    }
}

