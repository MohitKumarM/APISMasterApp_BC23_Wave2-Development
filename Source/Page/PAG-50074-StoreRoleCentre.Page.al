page 50074 "Store Role Centre"
{
    Caption = 'Store Role Centre';
    PageType = RoleCenter;
    ApplicationArea = Basic, Suite;


    layout
    {
        area(rolecenter)
        {
            part("Stores Activities"; "Stores Activities")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Voucher)
            {
                Caption = 'Voucher';
                Image = Statistics;
                action("Item Journal")
                {
                    Caption = 'Item Journal';
                    RunObject = Page "Item Journal";
                }
                action("Item Transfer")
                {
                    Caption = 'Item Transfer';
                    RunObject = Page "Transfer Orders";
                }
                action("De-Assemble Item")
                {
                    RunObject = Page "Assembly Orders";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                Image = Statistics;
                group("Purchase Reports")
                {
                    Caption = 'Purchase Reports';
                    action("Stock Status")
                    {
                        Caption = 'Stock Status';
                        RunObject = Page "Item Trial";
                    }


                }

                group("Production / Quality Reports")
                {
                    Caption = 'Production / Quality Reports';

                    action("Incoming Report")
                    {
                        Caption = 'Incoming Report';
                        Image = Print;
                        RunObject = Page "Incoming Material Report";
                    }
                }
                group(Registers)
                {
                    Caption = 'Registers';


                    action("Item Ageing Quantity")
                    {
                        Caption = 'Item Ageing Quantity';
                        RunObject = Report "Item Age Composition - Qty.";
                    }
                    action("Item Ageing Value")
                    {
                        Caption = 'Item Ageing Value';
                        RunObject = Report "Item Age Composition - Value";
                    }
                    action("G/L Register")
                    {
                        Caption = 'G/L Register';
                        RunObject = Page "G/L Registers";
                    }
                }
            }
            group("History & Balances")
            {
                Caption = 'History & Balances';
                group(History)
                {
                    Caption = 'History';

                    action("Raw Honey Stock Report")
                    {
                        RunObject = Page "Lot Entries";
                    }
                    action("Posted Sales Shipments")
                    {
                        Caption = 'Posted Sales Shipments';
                        RunObject = Page "Posted Sales Shipments";
                    }
                    action("Posted Purch. Receipts")
                    {
                        Caption = 'Posted Purch. Receipts';
                        RunObject = Page "Posted Purchase Receipts";
                    }
                    action("Posted Transfer Shipment")
                    {
                        Caption = 'Posted Transfer Shipment';
                        RunObject = Page "Posted Transfer Shipments";
                    }
                    action("Posted Transfer Receipts")
                    {
                        Caption = 'Posted Transfer Receipts';
                        RunObject = Page "Posted Transfer Receipts";
                    }
                }
                group(Balances)
                {
                    Caption = 'Balances';

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

