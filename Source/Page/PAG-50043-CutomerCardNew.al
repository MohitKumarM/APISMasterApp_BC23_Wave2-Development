page 50043 "Customer Card New"
{
    Caption = 'Customer Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Customer;
    LinksAllowed = false;
    AboutTitle = 'About customer details';
    AboutText = 'With the **Customer Card** you manage information about a customer and specify the terms of business, such as payment terms, prices and discounts. From here you can also drill down on past and ongoing sales activity.';

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
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Address 3"; Rec."Address 3")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = MandField;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Editable = BlockedHide;
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = All;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ApplicationArea = All;
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("P.A.N. Status"; Rec."P.A.N. Status")
                {
                    ApplicationArea = All;
                }
                field("P.A.N. Reference No."; Rec."P.A.N. Reference No.")
                {
                    Caption = 'P.A.N. Reference No.';
                    ApplicationArea = All;
                }
                field("Skip TCS Calc."; Rec."Skip TCS")
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Quality Process"; Rec."Quality Process")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Authorized person"; Rec."Authorized person")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Print Name"; Rec."Print Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("RSM Name"; Rec."RSM Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Security Cheque No"; Rec."Security Cheque No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("MSME No."; Rec."MSME No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("FASSAI No."; Rec."FASSAI No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Assessee Code"; Rec."Assessee Code")
                {
                    ApplicationArea = all;
                }
                field("ARN No."; Rec."ARN No.")
                {
                    ApplicationArea = all;
                }
                field("Parent Group"; Rec."Parent Group")
                {
                    ApplicationArea = all;
                }
                field("Child Group"; Rec."Child Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::Customer),
                              "No." = FIELD("No.");
                Visible = false;
            }

            part(SalesHistSelltoFactBox; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(SalesHistBilltoFactBox; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = All;
                Visible = false;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(CustomerStatisticsFactBox; "Customer Statistics FactBox")
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Visible = false;
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                // Visible = ShowWorkflowStatus;
            }
            part(Control1905532107; "Dimensions FactBox")
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Table ID" = CONST(18),
                              "No." = FIELD("No.");
            }
            part(Control1907829707; "Service Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control1902613707; "Service Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }

            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("ImportCustomer")
            {
                action("Import Customer")
                {
                    ApplicationArea = All;
                    Image = Import;
                    trigger OnAction()
                    var
                        ImportCustomer: XmlPort "Import Customer";
                    begin
                        ImportCustomer.Run;
                    end;
                }
            }
            group("&Customer")
            {
                Caption = '&Customer';
                Image = Customer;
                action(Dimensions)
                {
                    Visible = false;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(18),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("TDS Customer Allowed Sections")
                {
                    Caption = 'TDS Customer Allowed Sections';
                    ApplicationArea = Basic, Suite;
                    // Promoted = true;
                    // PromotedCategory = Category9;
                    // PromotedIsBig = true;
                    Image = LinkAccount;
                    RunObject = Page "Customer Allowed Sections";
                    RunPageLink = "Customer No" = field("No.");
                    ToolTip = 'Specifies the Allowed Sections on Customer.';
                }
                action("TDS Customer Concessional Codes")
                {
                    Caption = 'TDS Customer Concessional Codes';
                    ApplicationArea = Basic, Suite;
                    // Promoted = true;
                    // PromotedIsBig = true;
                    // PromotedCategory = Category9;
                    Image = LinkAccount;
                    RunObject = Page "TDS Cust Concessional Codes";
                    RunPageLink = "Customer No." = field("No.");
                    ToolTip = 'Specify the Concessional Code if concessional rate is applicable.';
                }
                action("TCS Allowed NOC")
                {
                    Caption = 'TCS Allowed NOC';
                    ApplicationArea = Basic, Suite;
                    // Promoted = true;
                    // PromotedCategory = Category9;
                    // PromotedIsBig = true;
                    Image = LinkAccount;
                    RunObject = Page "Allowed NOC";
                    RunPageLink = "Customer No." = field("No.");
                    ToolTip = 'Specifies the TCS Nature of Collection on customer.';
                }
                action("TCS Customer Concessional Codes")
                {
                    Caption = 'TCS Customer Concessional Codes';
                    ApplicationArea = Basic, Suite;
                    // Promoted = true;
                    // PromotedIsBig = true;
                    // PromotedCategory = Category9;
                    Image = LinkAccount;
                    RunObject = Page "Customer Concessional Codes";
                    RunPageLink = "Customer No." = field("No.");
                    ToolTip = 'Specify the Concessional Code if concessional rate is applicable.';
                }
                action("Bank Accounts")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'View or set up the customer''s bank accounts. You can set up any number of bank accounts for each customer.';
                }
                action("Direct Debit Mandates")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Direct Debit Mandates';
                    Image = MakeAgreement;
                    RunObject = Page "SEPA Direct Debit Mandates";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'View the direct-debit mandates that reflect agreements with customers to collect invoice payments from their bank account.';
                }
                action(ShipToAddresses)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ship-&to Addresses';
                    Image = ShipAddress;
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'View or edit alternate shipping addresses where the customer wants items delivered if different from the regular address.';
                }
                action(Contact)
                {
                    Visible = false;
                    AccessByPermission = TableData Contact = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ToolTip = 'View or edit detailed information about the contact person at the customer.';

                    trigger OnAction()
                    begin
                        rec.ShowContact();
                    end;
                }
                action("Item References")
                {
                    Visible = false;
                    AccessByPermission = TableData "Item Reference" = R;
                    ApplicationArea = Suite, ItemReferences;
                    Caption = 'Item References';
                    Image = Change;
                    RunObject = Page "Item References";
                    RunPageLink = "Reference Type" = CONST(Customer),
                                  "Reference Type No." = FIELD("No.");
                    RunPageView = SORTING("Reference Type", "Reference Type No.");
                    ToolTip = 'Set up the customer''s own identification of items that you sell to the customer. Item references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
                }
                action("Co&mments")
                {
                    Visible = false;
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(ApprovalEntries)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Attachments)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action(CustomerReportSelections)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document Layouts';
                    Image = Quote;
                    ToolTip = 'Set up a layout for different types of documents such as invoices, quotes, and credit memos.';
                    Visible = false;
                    trigger OnAction()
                    var
                        CustomReportSelection: Record "Custom Report Selection";
                    begin
                        CustomReportSelection.SetRange("Source Type", DATABASE::Customer);
                        CustomReportSelection.SetRange("Source No.", Rec."No.");
                        PAGE.RunModal(PAGE::"Customer Report Selections", CustomReportSelection);
                    end;
                }
            }

            group(History)
            {
                Visible = false;
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Action76)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    Visible = false;
                }
                action("S&ales")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&ales';
                    Image = Sales;
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View a summary of customer ledger entries. You select the time interval in the View by field. The Period column on the left contains a series of dates that are determined by the time interval you have selected.';
                }
                action("Entry Statistics")
                {
                    Visible = false;
                    ApplicationArea = Suite;
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View entry statistics for the record.';
                }
                action("Statistics by C&urrencies")
                {
                    Visible = false;
                    ApplicationArea = Suite;
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Cust. Stats. by Curr. Lines";
                    RunPageLink = "Customer Filter" = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Date Filter" = FIELD("Date Filter");
                    ToolTip = 'View statistics for customers that use multiple currencies.';
                }
                action("Item &Tracking Entries")
                {
                    Visible = false;
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'View serial or lot numbers that are assigned to items.';

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.ShowItemTrackingForEntity(1, Rec."No.", '', '', '');
                    end;
                }
                action("Sent Emails")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Emails';
                    Image = ShowList;
                    ToolTip = 'View a list of emails that you have sent to this customer.';

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::Customer, Rec.SystemId);
                    end;
                }
                separator(Action140) { }
            }
            group("Prices and Discounts")
            {
                Caption = 'Prices & Discounts';
                Visible = false;
                action("Invoice &Discounts")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category7;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    ToolTip = 'Set up different discounts that are applied to invoices for the customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.';
                }
                action(PriceLists)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Price Lists';
                    Image = Price;
                    ToolTip = 'View or set up sales price lists for products that you sell to the customer. A product price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        PriceUXManagement.ShowPriceLists(Rec, "Price Amount Type"::Any);
                    end;
                }
                action(PriceLines)
                {
                    AccessByPermission = TableData "Sales Price Access" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Prices';
                    Image = Price;
                    Scope = Repeater;
                    Visible = false;
                    ToolTip = 'View or set up sales price lines for products that you sell to the customer. A product price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ToPriceSource(PriceSource);
                        PriceUXManagement.ShowPriceListLines(PriceSource, "Price Amount Type"::Price);
                    end;
                }
                action(DiscountLines)
                {
                    AccessByPermission = TableData "Sales Discount Access" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Discounts';
                    Image = LineDiscount;
                    Scope = Repeater;
                    Visible = false;
                    ToolTip = 'View or set up different discounts for products that you sell to the customer. A product line discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ToPriceSource(PriceSource);
                        PriceUXManagement.ShowPriceListLines(PriceSource, "Price Amount Type"::Discount);
                    end;
                }
#if not CLEAN21
                action(PriceListsDiscounts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Price Lists (Discounts)';
                    Image = LineDiscount;
                    Visible = false;
                    ToolTip = 'View or set up different discounts for products that you sell to the customer. A product line discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Action PriceLists shows all sales price lists with prices and discounts';
                    ObsoleteTag = '18.0';

                    trigger OnAction()
                    var
                        PriceUXManagement: Codeunit "Price UX Management";
                        AmountType: Enum "Price Amount Type";
                    begin
                        PriceUXManagement.ShowPriceLists(Rec, AmountType::Discount);
                    end;
                }
#endif
#if not CLEAN21
                action(Prices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prices';
                    Image = Price;
                    //   Visible = not ExtendedPriceEnabled;
                    Visible = false;
                    ToolTip = 'View or set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    var
                        SalesPrice: Record "Sales Price";
                    begin
                        SalesPrice.SetCurrentKey("Sales Type", "Sales Code");
                        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::Customer);
                        SalesPrice.SetRange("Sales Code", Rec."No.");
                        Page.Run(Page::"Sales Prices", SalesPrice);
                    end;
                }
                action("Line Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    Visible = false;
                    //  Visible = not ExtendedPriceEnabled;
                    ToolTip = 'View or set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    var
                        SalesLineDiscount: Record "Sales Line Discount";
                    begin
                        SalesLineDiscount.SetCurrentKey("Sales Type", "Sales Code");
                        SalesLineDiscount.SetRange("Sales Type", SalesLineDiscount."Sales Type"::Customer);
                        SalesLineDiscount.SetRange("Sales Code", Rec."No.");
                        Page.Run(Page::"Sales Line Discounts", SalesLineDiscount);
                    end;
                }
                action("Prices and Discounts Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prices & Discounts Overview';
                    Image = PriceWorksheet;
                    Visible = false;
                    // Visible = not ExtendedPriceEnabled;
                    ToolTip = 'View all the sales prices and line discounts that you grant for this customer when certain criteria are met, such as quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    var
                        SalesPriceAndLineDiscounts: Page "Sales Price and Line Discounts";
                    begin
                        SalesPriceAndLineDiscounts.InitPage(false);
                        SalesPriceAndLineDiscounts.LoadCustomer(Rec);
                        SalesPriceAndLineDiscounts.RunModal();
                    end;
                }
#endif
            }
            group(Action82)
            {
                Caption = 'S&ales';
                Image = Sales;
                Visible = false;
                action("Prepa&yment Percentages")
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Sales Type" = CONST(Customer),
                                  "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ToolTip = 'View or edit the percentages of the price that can be paid as a prepayment. ';
                    Visible = false;
                }
                action("Recurring Sales Lines")
                {
                    Visible = false;
                    ApplicationArea = Suite;
                    Caption = 'Recurring Sales Lines';
                    Ellipsis = true;
                    Image = CustomerCode;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Standard Customer Sales Codes";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'Set up recurring sales lines for the customer, such as a monthly replenishment order, that can quickly be inserted on a sales document for the customer.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                Visible = false;
                action(Quotes)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ToolTip = 'View a list of ongoing sales quotes for the customer.';
                }
                action(Invoices)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Sales Invoice List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ToolTip = 'View a list of ongoing sales invoices for the customer.';
                }
                action(Orders)
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ToolTip = 'View a list of ongoing sales orders for the customer.';
                }
                action("Return Orders")
                {
                    Visible = false;
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ToolTip = 'Open the list of ongoing return orders.';
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Image = Documents;
                    Visible = false;
                    action("Issued &Reminders")
                    {
                        Visible = false;
                        ApplicationArea = Suite;
                        Caption = 'Issued &Reminders';
                        Image = OrderReminder;
                        RunObject = Page "Issued Reminder List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ToolTip = 'View the reminders that you have sent to the customer.';
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        Visible = false;
                        ApplicationArea = Suite;
                        Caption = 'Issued &Finance Charge Memos';
                        Image = FinChargeMemo;
                        RunObject = Page "Issued Fin. Charge Memo List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ToolTip = 'View the finance charge memos that you have sent to the customer.';
                    }
                }
                action("Blanket Orders")
                {
                    Visible = false;
                    ApplicationArea = Suite;
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Orders";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ToolTip = 'Open the list of ongoing blanket orders.';
                }
                action("&Jobs")
                {
                    Visible = false;
                    ApplicationArea = Jobs;
                    Caption = '&Jobs';
                    Image = Job;
                    RunObject = Page "Job List";
                    RunPageLink = "Bill-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Bill-to Customer No.");
                    ToolTip = 'Open the list of ongoing jobs.';
                }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = ServiceItem;
                Visible = false;
                action("Service Orders")
                {
                    Visible = false;
                    ApplicationArea = Service;
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Orders";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Customer No.");
                    ToolTip = 'Open the list of ongoing service orders.';
                }
                action("Ser&vice Contracts")
                {
                    Visible = false;
                    ApplicationArea = Service;
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                    ToolTip = 'Open the list of ongoing service contracts.';
                }
                action("Service &Items")
                {
                    Visible = false;
                    ApplicationArea = Service;
                    Caption = 'Service &Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                    ToolTip = 'View or edit the service items that are registered for the customer.';
                }
            }
        }
        area(creation)
        {
            action(NewBlanketSalesOrder)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Suite;
                Caption = 'Blanket Sales Order';
                Image = BlanketOrder;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Blanket Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a blanket sales order for the customer.';
                Visible = false;
            }
            action(NewSalesQuote)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote';
                Image = NewSalesQuote;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
                Visible = false;
            }
            action(NewSalesInvoice)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a sales invoice for the customer.';
                Visible = false;
            }
            action(NewSalesOrder)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order';
                Image = Document;
                RunObject = Page "Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a sales order for the customer.';
                Visible = false;
            }
            action(NewSalesCreditMemo)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memo';
                Image = CreditMemo;
                RunObject = Page "Sales Credit Memo";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
                Visible = false;
            }
            action(NewSalesQuoteAddin)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote';
                Image = NewSalesQuote;
                ToolTip = 'Offer items or services to a customer.';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.CreateAndShowNewQuote();
                end;
            }
            action(NewSalesInvoiceAddin)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                ToolTip = 'Create a sales invoice for the customer.';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.CreateAndShowNewInvoice();
                end;
            }
            action(NewSalesOrderAddin)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order';
                Image = Document;
                ToolTip = 'Create a sales order for the customer.';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.CreateAndShowNewOrder();
                end;
            }
            action(NewSalesCreditMemoAddin)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memo';
                Image = CreditMemo;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
                Visible = false;

                trigger OnAction()
                begin
                    Rec.CreateAndShowNewCreditMemo();
                end;
            }
            action(NewSalesReturnOrder)
            {
                AccessByPermission = TableData "Sales Header" = RIM;
                ApplicationArea = SalesReturnOrder;
                Caption = 'Sales Return Order';
                Image = ReturnOrder;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Sales Return Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                Visible = false;
                ToolTip = 'Create a new sales return order for items or services.';
            }
            action(NewServiceQuote)
            {
                AccessByPermission = TableData "Service Header" = RIM;
                ApplicationArea = Service;
                Caption = 'Service Quote';
                Image = Quote;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Service Quote";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service quote for the customer.';
                Visible = false;
            }
            action(NewServiceInvoice)
            {
                AccessByPermission = TableData "Service Header" = RIM;
                ApplicationArea = Service;
                Caption = 'Service Invoice';
                Image = Invoice;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Service Invoice";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service invoice for the customer.';
                Visible = false;
            }
            action(NewServiceOrder)
            {
                AccessByPermission = TableData "Service Header" = RIM;
                ApplicationArea = Service;
                Caption = 'Service Order';
                Image = Document;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Service Order";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service order for the customer.';
                Visible = false;
            }
            action(NewServiceCreditMemo)
            {
                Visible = false;
                AccessByPermission = TableData "Service Header" = RIM;
                ApplicationArea = Service;
                Caption = 'Service Credit Memo';
                Image = CreditMemo;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Service Credit Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service credit memo for the customer.';
            }
            action(NewReminder)
            {
                AccessByPermission = TableData "Reminder Header" = RIM;
                ApplicationArea = Suite;
                Caption = 'Reminder';
                Image = Reminder;
                RunObject = Page Reminder;
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new reminder for the customer.';
                Visible = false;
            }
            action(NewFinanceChargeMemo)
            {
                AccessByPermission = TableData "Finance Charge Memo Header" = RIM;
                ApplicationArea = Suite;
                Caption = 'Finance Charge Memo';
                Image = FinChargeMemo;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                RunObject = Page "Finance Charge Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new finance charge memo.';
                Visible = false;
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                Visible = OpenApprovalEntriesExistCurrUser;
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval to change the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        rec.TestField(Name);
                        Rec.TestField("Print Name");
                        Rec.TestField(Address);
                        if rec."Country/Region Code" = 'IN' then
                            rec.TestField("State Code");
                        rec.TestField("Gen. Bus. Posting Group");
                        rec.TestField("Customer Posting Group");
                        rec.TestField("Payment Terms Code");
                        //rec.TestField("Currency Code");
                        Rec.TestField("Quality Process");
                        Rec.TestField("Authorized person");
                        Rec.TestField("Security Cheque No");
                        rec.TestField("MSME No.");
                        Rec.TestField("FASSAI No.");
                        Rec.TestField("RSM Name");
                        Rec.TestField("GST Customer Type");

                        if ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendCustomerForApproval(Rec);
                        SetWorkFlowEnabled();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(Rec.RecordId);
                    end;
                }
                group(Flow)
                {
                    Visible = false;
                    Caption = 'Power Automate';

#if not CLEAN22
                    action(CreateFlow)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create a Power Automate approval flow';
                        Image = Flow;
                        ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
                        Visible = false;
                        ObsoleteReason = 'This action will be handled by platform as part of the CreateFlowFromTemplate customaction';
                        ObsoleteState = Pending;
                        ObsoleteTag = '22.0';

                        trigger OnAction()
                        var
                            FlowServiceManagement: Codeunit "Flow Service Management";
                            FlowTemplateSelector: Page "Flow Template Selector";
                        begin
                            // Opens page 6400 where the user can use filtered templates to create new flows.
                            FlowTemplateSelector.SetSearchText(FlowServiceManagement.GetCustomerTemplateFilter());
                            FlowTemplateSelector.Run();
                        end;
                    }
#endif
#if not CLEAN21
                    action(SeeFlows)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'See my flows';
                        Image = Flow;
                        RunObject = Page "Flow Selector";
                        ToolTip = 'View and configure Power Automate flows that you created.';
                        Visible = false;
                        ObsoleteState = Pending;
                        ObsoleteReason = 'This action has been moved to the tab dedicated to Power Automate';
                        ObsoleteTag = '21.0';
                    }
#endif
                }
            }
            group(Workflow)
            {
                Visible = false;
                Caption = 'Workflow';
                action(CreateApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Approval Workflow';
                    Enabled = NOT EnabledApprovalWorkflowsExist;
                    Image = CreateWorkflow;
                    ToolTip = 'Set up an approval workflow for creating or changing customers, by going through a few pages that will guide you.';
                    Visible = false;
                    trigger OnAction()
                    begin
                        PAGE.RunModal(PAGE::"Cust. Approval WF Setup Wizard");
                        SetWorkFlowEnabled();
                    end;
                }
                action(ManageApprovalWorkflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Manage Approval Workflows';
                    Enabled = EnabledApprovalWorkflowsExist;
                    Image = WorkflowSetup;
                    ToolTip = 'View or edit existing approval workflows for creating or changing customers.';
                    Visible = false;
                    trigger OnAction()
                    var
                        WorkflowManagement: Codeunit "Workflow Management";
                    begin
                        WorkflowManagement.NavigateToWorkflows(DATABASE::Customer, WorkFlowEventFilter);
                        SetWorkFlowEnabled();
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                Visible = false;
                action(Templates)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Templates';
                    Image = Template;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'View or edit customer templates.';
                    Visible = false;
                    trigger OnAction()
                    var
                        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
                    begin
                        CustomerTemplMgt.ShowTemplates();
                    end;
                }
                action(ApplyTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Template';
                    Image = ApplyTemplate;
                    ToolTip = 'Apply a template to update the entity with your standard settings for a certain type of entity.';
                    Visible = false;
                    trigger OnAction()
                    var
                        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
                    begin
                        CustomerTemplMgt.UpdateCustomerFromTemplate(Rec);
                    end;
                }
                action(SaveAsTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Save as Template';
                    Image = Save;
                    ToolTip = 'Save the customer card as a template that can be reused to create new customer cards. Customer templates contain preset information to help you fill fields on customer cards.';
                    Visible = false;
                    trigger OnAction()
                    var
                        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
                    begin
                        CustomerTemplMgt.SaveAsTemplate(Rec);
                    end;
                }
                action(MergeDuplicate)
                {
                    AccessByPermission = TableData "Merge Duplicates Buffer" = RIMD;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Merge With';
                    Ellipsis = true;
                    Image = ItemSubstitution;
                    ToolTip = 'Merge two customer records into one. Before merging, review which field values you want to keep or override. The merge action cannot be undone.';
                    Visible = false;
                    trigger OnAction()
                    var
                        TempMergeDuplicatesBuffer: Record "Merge Duplicates Buffer" temporary;
                    begin
                        TempMergeDuplicatesBuffer.Show(DATABASE::Customer, Rec."No.");
                    end;
                }
            }
            action("Post Cash Receipts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Cash Receipts';
                Ellipsis = true;
                Image = CashReceiptJournal;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Cash Receipt Journal";
                ToolTip = 'Create a cash receipt journal line for the customer, for example, to post a payment receipt.';
                Visible = false;
            }
            action("Sales Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journal';
                Image = Journals;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Journal";
                ToolTip = 'Post any sales transaction for the customer.';
                Visible = false;
            }
            action(PaymentRegistration)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Register Customer Payments';
                Image = Payment;
                Visible = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Payment Registration";
                RunPageLink = "Source No." = FIELD("No.");
                ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
            }
            action(WordTemplate)
            {
                ApplicationArea = All;
                Caption = 'Apply Word Template';
                ToolTip = 'Apply a Word template on the selected records.';
                Image = Word;
                Visible = false;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    WordTemplateSelectionWizard: Page "Word Template Selection Wizard";
                begin
                    CurrPage.SetSelectionFilter(Customer);
                    WordTemplateSelectionWizard.SetData(Customer);
                    WordTemplateSelectionWizard.RunModal();
                end;
            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this customer.';
                Visible = false;
                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::Customer, Rec.SystemId);
                    TempEmailitem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
        }
        area(reporting)
        {
            action("Report Customer Detailed Aging")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Detailed Aging';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                ToolTip = 'View a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                Visible = false;
                trigger OnAction()
                begin
                    RunReport(REPORT::"Customer Detailed Aging", Rec."No.");
                end;
            }
            action("Report Customer - Labels")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer - Labels';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category9;
                ToolTip = 'View mailing labels with the customers'' names and addresses.';
                Visible = false;
                trigger OnAction()
                begin
                    RunReport(REPORT::"Customer - Labels", Rec."No.");
                end;
            }

            action("Report Customer - Balance to Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer - Balance to Date';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category9;
                ToolTip = 'View a list with customers'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                Visible = false;
                trigger OnAction()
                begin
                    RunReport(REPORT::"Customer - Balance to Date", Rec."No.");
                end;
            }
            action("Report Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Statement';
                Image = "Report";
                ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                Visible = false;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomReportSelection: Record "Custom Report Selection";
                    CustomLayoutReporting: Codeunit "Custom Layout Reporting";
                    RecRef: RecordRef;
                begin
                    RecRef.Open(Database::Customer);
                    CustomLayoutReporting.SetOutputFileBaseName(StatementFileNameTxt);
                    CustomReportSelection.SetRange(Usage, "Report Selection Usage"::"C.Statement");
                    if CustomReportSelection.FindFirst() then
                        CustomLayoutReporting.SetTableFilterForReportID(CustomReportSelection."Report ID", Rec."No.")
                    else
                        CustomLayoutReporting.SetTableFilterForReportID(Report::"Standard Statement", Rec."No.");
                    CustomLayoutReporting.ProcessReportData(
                        "Report Selection Usage"::"C.Statement", RecRef, Customer.FieldName("No."),
                        Database::Customer, Customer.FieldName("No."), true);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Visible = false;
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(Contact_Promoted; Contact) { }
                actionref(ApplyTemplate_Promoted; ApplyTemplate) { }
                actionref(MergeDuplicate_Promoted; MergeDuplicate) { }
                actionref(Email_Promoted; Email) { }
            }
            group(Category_Category5)
            {
                Caption = 'Approve', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Approve_Promoted; Approve) { }
                actionref(Reject_Promoted; Reject) { }
                actionref(Comment_Promoted; Comment) { }
                actionref(Delegate_Promoted; Delegate) { }
            }
            group(Category_Category6)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest) { }
                actionref(CancelApproavlRequest_Promoted; CancelApprovalRequest) { }
                actionref(ApprovalEntries_Promoted; ApprovalEntries) { }
#if not CLEAN21

#endif
            }
            group(Category_Category4)
            {
                Visible = false;
                Caption = 'New Document', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(NewSalesQuoteAddin_Promoted; NewSalesQuoteAddin) { }
                actionref(NewSalesQuote_Promoted; NewSalesQuote) { }
                actionref(NewSalesOrderAddin_Promoted; NewSalesOrderAddin) { }
                actionref(NewSalesOrder_Promoted; NewSalesOrder) { }
                actionref(NewSalesInvoiceAddin_Promoted; NewSalesInvoiceAddin) { }
                actionref(NewSalesInvoice_Promoted; NewSalesInvoice) { }
                actionref(NewSalesCreditMemoAddin_Promoted; NewSalesCreditMemoAddin) { }
                actionref(NewSalesCreditMemo_Promoted; NewSalesCreditMemo) { }
                actionref(NewReminder_Promoted; NewReminder) { }
            }
            group(Category_Category7)
            {
                Visible = false;
                Caption = 'Prices & Discounts', Comment = 'Generated from the PromotedActionCategories property index 6.';

#if not CLEAN21
#endif
            }
            group(Category_Category9)
            {
                Visible = false;
                Caption = 'Customer', Comment = 'Generated from the PromotedActionCategories property index 8.';

                actionref("Ledger E&ntries_Promoted"; "Ledger E&ntries") { }
                actionref(Dimensions_Promoted; Dimensions) { }
                actionref(Action76_Promoted; Action76) { }
                actionref(Attachments_Promoted; Attachments) { }
                actionref("Co&mments_Promoted"; "Co&mments") { }
                separator(Navigate_Separator) { }
                actionref(CustomerReportSelections_Promoted; CustomerReportSelections) { }
                actionref("Bank Accounts_Promoted"; "Bank Accounts") { }
                actionref(ShipToAddresses_Promoted; ShipToAddresses) { }
                actionref("Direct Debit Mandates_Promoted"; "Direct Debit Mandates") { }
                actionref("Item References_Promoted"; "Item References") { }
#if not CLEAN21
                actionref(Quotes_Promoted; Quotes)
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Demoted: The page can be accessed from the FactBox.';
                    ObsoleteTag = '21.0';
                }
                actionref(Invoices_Promoted; Invoices)
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Demoted: The page can be accessed from the FactBox.';
                    ObsoleteTag = '21.0';
                }
                actionref(Orders_Promoted; Orders)
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Demoted: The page can be accessed from the FactBox.';
                    ObsoleteTag = '21.0';
                }
                actionref("Return Orders_Promoted"; "Return Orders")
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Demoted: The page can be accessed from the FactBox.';
                    ObsoleteTag = '21.0';
                }
                actionref("&Jobs_Promoted"; "&Jobs")
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Demoted: The page can be accessed from the FactBox.';
                    ObsoleteTag = '21.0';
                }
#endif
            }
            group(Category_Category8)
            {
                Visible = false;
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 7.';
            }
            group(Category_Report)
            {
                Visible = false;
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("Report Statement_Promoted"; "Report Statement") { }
                actionref("Report Customer - Balance to Date_Promoted"; "Report Customer - Balance to Date") { }
                actionref("Report Customer Detailed Aging_Promoted"; "Report Customer Detailed Aging") { }
                actionref("S&ales_Promoted"; "S&ales") { }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        if rec."Country/Region Code" = 'IN' then
            MandField := true
        else
            MandField := false;
        Rec.Blocked := rec.Blocked::All;
    end;

    trigger OnAfterGetRecord()
    begin
        if rec."Country/Region Code" = 'IN' then
            MandField := true
        else
            MandField := false;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if GuiAllowed() then
            OnAfterGetCurrRecordFunc()
        else
            OnAfterGetCurrRecordFuncBackground();
        if rec."Country/Region Code" = 'IN' then
            MandField := true
        else
            MandField := false;
    end;

    local procedure OnAfterGetCurrRecordFunc()
    var
        WorkflowStepInstance: Record "Workflow Step Instance";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        /* if NewMode then
            CreateCustomerFromTemplate()
        else
            StartBackgroundCalculations(); */
        ActivateFields();
        SetCreditLimitStyle();

        if CRMIntegrationEnabled or CDSIntegrationEnabled then begin
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
            if Rec."No." <> xRec."No." then
                CRMIntegrationManagement.SendResultNotification(Rec);
        end;
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        OpenApprovalEntriesExistCurrUser := false;
        if AnyWorkflowExists then begin
            CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
            WorkflowStepInstance.SetRange("Record ID", Rec.RecordId);
            ShowWorkflowStatus := not WorkflowStepInstance.IsEmpty();
            if ShowWorkflowStatus then
                CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
            if OpenApprovalEntriesExist then
                OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        end;
    end;

    local procedure OnAfterGetCurrRecordFuncBackground()
    begin
        Rec.CalcFields("Sales (LCY)", "Profit (LCY)", "Inv. Discounts (LCY)", "Payments (LCY)");
        CustomerMgt.CalculateStatisticsWithCurrentCustomerValues(Rec, AdjmtCostLCY, AdjCustProfit, AdjProfitPct, CustInvDiscAmountLCY, CustPaymentsLCY, CustSalesLCY, CustProfit);
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        PrevCountryCode := '*';
        FoundationOnly := ApplicationAreaMgmtFacade.IsFoundationEnabled();

        ContactEditable := true;

        OpenApprovalEntriesExistCurrUser := true;

        CaptionTxt := CurrPage.Caption;

        CurrPage.Caption(CaptionTxt);

#if not CLEAN22
        InitPowerAutomateTemplateVisibility();
#endif
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        if GuiAllowed then
            if rec."No." = '' then
                if DocumentNoVisibility.CustomerNoSeriesIsDefault() then
                    NewMode := true;
    end;

    trigger OnOpenPage()
    begin
        if UserId = 'WSRV32058-IND\APIS1' then
            BlockedHide := true
        else
            BlockedHide := false;
        if Rec.GetFilter("Date Filter") = '' then
            Rec.SetRange("Date Filter", 0D, WorkDate());
        if GuiAllowed() then
            OnOpenPageFunc()
        else
            OnOpenBackground();
    end;

    local procedure OnOpenPageFunc()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        EnvironmentInfo: Codeunit "Environment Information";
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        OfficeManagement: Codeunit "Office Management";
    begin
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
        if CRMIntegrationEnabled or CDSIntegrationEnabled then
            if IntegrationTableMapping.Get('CUSTOMER') then
                BlockedFilterApplied := IntegrationTableMapping.GetTableFilter().Contains('Field39=1(0)');
        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();

        SetNoFieldVisible();

        SalesReceivablesSetup.GetRecordOnce();
        IsAllowMultiplePostingGroupsVisible := SalesReceivablesSetup."Allow Multiple Posting Groups";

        IsSaaS := EnvironmentInfo.IsSaaS();
        IsOfficeAddin := OfficeManagement.IsAvailable();
        WorkFlowEventFilter :=
            WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode() + '|' +
            WorkflowEventHandling.RunWorkflowOnCustomerChangedCode();

        SetWorkFlowEnabled();
    end;

    local procedure OnOpenBackground()
    begin
        Rec.SetAutoCalcFields("Sales (LCY)", "Profit (LCY)", "Inv. Discounts (LCY)", "Payments (LCY)");
    end;

    local procedure StartBackgroundCalculations()
    var
        Args: Dictionary of [Text, Text];
    begin
        if Rec."No." = PrevCustNo then
            exit;
        PrevCustNo := Rec."No.";
        if (BackgroundTaskId <> 0) then
            CurrPage.CancelBackgroundTask(BackgroundTaskId);

        DaysPastDueDate := 0;
        ExpectedMoneyOwed := 0;
        AvgDaysToPay := 0;
        TotalMoneyOwed := 0;
        AttentionToPaidDay := false;
        AmountOnPostedInvoices := 0;
        AmountOnPostedCrMemos := 0;
        AmountOnOutstandingInvoices := 0;
        AmountOnOutstandingCrMemos := 0;
        Totals := 0;
        AdjmtCostLCY := 0;
        AdjCustProfit := 0;
        AdjProfitPct := 0;
        CustInvDiscAmountLCY := 0;
        CustPaymentsLCY := 0;
        CustSalesLCY := 0;
        CustProfit := 0;
        NoPostedInvoices := 0;
        NoPostedCrMemos := 0;
        NoOutstandingInvoices := 0;
        NoOutstandingCrMemos := 0;
        OverdueBalance := 0;
        LinkedVendorNo := '';
        BalanceAsVendor := 0;
        BalanceAsVendorEnabled := false;

        CurrPage.EnqueueBackgroundTask(BackgroundTaskId, Codeunit::"Customer Card Calculations", Args);

        Session.LogMessage('0000D4Q', StrSubstNo(PageBckGrndTaskStartedTxt, Rec."No."), Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', CustomerCardServiceCategoryTxt);
    end;

    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        CalendarMgmt: Codeunit "Calendar Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CustomerMgt: Codeunit "Customer Mgt.";
        FormatAddress: Codeunit "Format Address";
        LinkedVendorNo: Code[20];
        BalanceAsVendor: Decimal;
        StyleTxt: Text;
        CRMIntegrationEnabled: Boolean;
        CDSIntegrationEnabled: Boolean;
        BlockedFilterApplied: Boolean;
        ExtendedPriceEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        NoFieldVisible: Boolean;
        BalanceExhausted: Boolean;
        AttentionToPaidDay: Boolean;
        Totals: Decimal;
        AmountOnPostedInvoices: Decimal;
        AmountOnPostedCrMemos: Decimal;
        AmountOnOutstandingInvoices: Decimal;
        AmountOnOutstandingCrMemos: Decimal;
        AdjmtCostLCY: Decimal;
        AdjCustProfit: Decimal;
        CustProfit: Decimal;
        AdjProfitPct: Decimal;
        CustInvDiscAmountLCY: Decimal;
        CustPaymentsLCY: Decimal;
        CustSalesLCY: Decimal;
        OverdueBalance: Decimal;
        DaysPastDueDate: Decimal;
        CustomerCardServiceCategoryTxt: Label 'Customer Card', Locked = true;
        PageBckGrndTaskStartedTxt: Label 'Page Background Task to calculate customer statistics for customer %1 started.', Locked = true, Comment = '%1 = Customer No.';
        ExpectedMoneyOwed: Decimal;
        TotalMoneyOwed: Decimal;
        AvgDaysToPay: Decimal;
        FoundationOnly: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        AnyWorkflowExists: Boolean;
        NewMode: Boolean;
        WorkFlowEventFilter: Text;
        CaptionTxt: Text;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsSaaS: Boolean;
        IsCountyVisible: Boolean;
        IsAllowMultiplePostingGroupsVisible: Boolean;
        StatementFileNameTxt: Label 'Statement', Comment = 'Shortened form of ''Customer Statement''';
        PrevCustNo: Code[20];
        PrevCountryCode: Code[10];
        BackgroundTaskId: Integer;
        BalanceAsVendorEnabled: Boolean;
        BlockedHide: Boolean;

        ContactEditable: Boolean;
        IsOfficeAddin: Boolean;
        NoPostedInvoices: Integer;
        NoPostedCrMemos: Integer;
        NoOutstandingInvoices: Integer;
        NoOutstandingCrMemos: Integer;
        MandField: Boolean;

    [TryFunction]
    local procedure TryGetDictionaryValueFromKey(var DictionaryToLookIn: Dictionary of [Text, Text]; KeyToSearchFor: Text; var ReturnValue: Text)
    begin
        ReturnValue := DictionaryToLookIn.Get(KeyToSearchFor);
    end;

    local procedure SetWorkFlowEnabled()
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        AnyWorkflowExists := WorkflowManagement.AnyWorkflowExists();
        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer, WorkFlowEventFilter);
    end;

    protected procedure ActivateFields()
    begin
        ContactEditable := Rec."Primary Contact No." = '';
        if Rec."Country/Region Code" <> PrevCountryCode then
            IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
        PrevCountryCode := Rec."Country/Region Code";
    end;

    local procedure SetCreditLimitStyle()
    begin
        StyleTxt := '';
        BalanceExhausted := false;
        if Rec."Credit Limit (LCY)" > 0 then
            BalanceExhausted := Rec."Balance (LCY)" >= Rec."Credit Limit (LCY)";
        if BalanceExhausted then
            StyleTxt := 'Unfavorable';
    end;

    local procedure HasCustomBaseCalendar(): Boolean
    begin
        if Rec."Base Calendar Code" = '' then
            exit(false)
        else
            exit(CalendarMgmt.CustomizedChangesExist(Rec));
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields();
    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.CustomerNoIsVisible();
    end;

    procedure RunReport(ReportNumber: Integer; CustomerNumber: Code[20])
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("No.", CustomerNumber);
        REPORT.RunModal(ReportNumber, true, true, Customer);
    end;

    local procedure CreateCustomerFromTemplate()
    var
        Customer: Record Customer;
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
    begin

        if not NewMode then
            exit;
        NewMode := false;

        if CustomerTemplMgt.InsertCustomerFromTemplate(Customer) then begin
            VerifyVatRegNo(Customer);
            Rec.Copy(Customer);

            CurrPage.Update();
        end else
            if CustomerTemplMgt.TemplatesAreNotEmpty() then
                if not CustomerTemplMgt.IsOpenBlankCardConfirmed() then
                    CurrPage.Close();
    end;

    local procedure VerifyVatRegNo(var Customer: Record Customer)
    var
        VATRegNoSrvConfig: Record "VAT Reg. No. Srv Config";
        EUVATRegistrationNoCheck: Page "EU VAT Registration No Check";
        CustomerRecRef: RecordRef;
    begin
        if VATRegNoSrvConfig.VATRegNoSrvIsEnabled() then
            if Customer."Validate EU Vat Reg. No." then begin
                EUVATRegistrationNoCheck.SetRecordRef(Customer);
                Commit();
                EUVATRegistrationNoCheck.RunModal();
                EUVATRegistrationNoCheck.GetRecordRef(CustomerRecRef);
                CustomerRecRef.SetTable(Customer);
            end;
    end;

    var
        PowerAutomateTemplatesEnabled: Boolean;
        PowerAutomateTemplatesFeatureLbl: Label 'PowerAutomateTemplates', Locked = true;

    local procedure InitPowerAutomateTemplateVisibility()
    var
        FeatureKey: Record "Feature Key";
    begin
        PowerAutomateTemplatesEnabled := true;
        if FeatureKey.Get(PowerAutomateTemplatesFeatureLbl) then
            if FeatureKey.Enabled <> FeatureKey.Enabled::"All Users" then
                PowerAutomateTemplatesEnabled := false;
    end;
}
