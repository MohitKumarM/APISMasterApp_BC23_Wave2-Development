page 50032 "Quality Role Centre New"
{
    Caption = 'Quality Role Centre';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(rolecenter)
        {
            group(General)
            {
                part("Quality Activities"; "Quality Activities New")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Masters)
            {
                Caption = 'Masters';
                Image = Journals;
                group("Masters View")
                {
                    Caption = 'Masters View';
                    Image = Bank;
                    action("Item View")
                    {
                        Image = Item;
                        RunObject = Page "Item List";
                    }
                }
                group("Production Design")
                {
                    Caption = 'Production Design';
                    Image = Bank;
                    action("BOM List View")
                    {
                        RunObject = Page "Production BOM Lines View";
                    }
                    action("Quality Process")
                    {
                        Caption = 'Quality Process';
                        Image = Questionaire;
                        RunObject = Page "Standard Tasks";
                    }
                }
            }
        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                Image = Statistics;
                group("Production / Quality Reports")
                {
                    Caption = 'Production / Quality Reports';
                    Image = Ledger;

                    action("Incoming Report")
                    {
                        Caption = 'Incoming Report';
                        Image = Print;
                        RunObject = Page "Incoming Material Report";
                    }
                    action("Plan Book Register")
                    {
                        Caption = 'Plan Book Register';
                        Image = Print;
                        //RunObject = Report "Plan Book Register";
                    }
                    action("Yield Report")
                    {
                        Caption = 'Yield Report';
                        Image = Print;
                        //RunObject = Report "Yield Reprt";
                    }

                    action("PM Stock with QC Details")
                    {
                        // RunObject = Report 50053;
                    }
                }
            }
            group("History & Balances")
            {
                Caption = 'History & Balances';
                group(Balances)
                {
                    Caption = 'Balances';
                    Image = Statistics;
                    action("Item Balance")
                    {
                        Caption = 'Item Balance';
                        RunObject = Page "VAT Product Posting Groups";
                    }
                }
            }
            group("Books and Ledger")
            {
                Caption = 'Books and Ledger';
                group(Ledgers)
                {
                    Caption = 'Ledgers';
                    Image = Ledger;
                    action("Item Ledger")
                    {
                        Caption = 'Item Ledger';
                        RunObject = Report "Inventory - Transaction Detail";
                    }
                }
            }
        }
    }
}
