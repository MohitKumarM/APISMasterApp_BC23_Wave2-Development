namespace Microsoft.Purchases.Document;

using Microsoft.Finance.AllocationAccount;
using Microsoft.Finance.AllocationAccount.Purchase;
using Microsoft.Inventory.Tracking;
using Microsoft.Finance.Currency;
using Microsoft.Finance.Deferral;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Foundation.Attachment;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Foundation.Navigate;
using Microsoft.Inventory.Availability;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Setup;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Setup;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Utilities;
using System.Environment.Configuration;
using System.Integration.Excel;
using System.Utilities;

page 50162 "Store Honey Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = filter(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Deal No."; Rec."Deal No.")
                {
                    ApplicationArea = All;
                }
                /* field("Deal Line No."; Rec."Deal Line No.")
                {
                    ApplicationArea = All;
                } */ // 15800 Dispatch Discontinue
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = all;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = all;
                }

                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. in Pack"; Rec."Qty. in Pack")
                {
                    ApplicationArea = All;
                }
                field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                // field("Tax Group Code"; Rec."Tax Group Code")
                // {
                //     ApplicationArea = All;
                //     Visible = true;
                // }
                // field("Tax Area Code"; Rec."Tax Area Code")
                // {
                //     Editable = false;
                // }

                field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        REc.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Honey Item No."; Rec."Honey Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SelectMultiItems)
            {
                AccessByPermission = TableData Item = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Select items';
                Ellipsis = true;
                Image = NewItem;
                ToolTip = 'Add two or more items from the full list of your inventory items.';

                trigger OnAction()
                begin
                    Rec.SelectMultipleItems();
                end;
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    Enabled = Rec.Type = Rec.Type::Item;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod())
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                        end;
                    }
                    action(Lot)
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Lot';
                        Image = LotInfo;
                        RunObject = Page "Item Availability by Lot No.";
                        RunPageLink = "No." = field("No."),
                            "Location Filter" = field("Location Code"),
                            "Variant Filter" = field("Variant Code");
                        ToolTip = 'View the current and projected quantity of the item in each lot.';
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    ApplicationArea = Reservation;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'View all reservation entries for the selected item. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Item Tracking Lines")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Ctrl+Alt+I';
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'View or edit serial and lot numbers for the selected item. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                }
                action("Get Tin,Drum & Bucket")
                {
                    ApplicationArea = All;
                    Image = CreateLinesFromJob;

                    trigger OnAction()
                    var
                        PurchaseLine: Record "Purchase Line";
                        PurchaseLine2: Record "Purchase Line";
                        LineNo: Integer;
                        Qty: Decimal;
                        i: Integer;
                        ItemNo: Code[20];
                        ReservationEntry: Record "Reservation Entry";
                        PurchasePayableSetup: Record "Purchases & Payables Setup";
                        ReserVationEntry2: Record "Reservation Entry";
                        PurchaseHeader: Record "Purchase Header";
                        Rec_PurchaseHeader: Record "Purchase Header";
                        Rec_PurchaseHeader2: Record "Purchase Header";
                    begin
                        if Rec_PurchaseHeader.get(rec."Document Type", Rec."Document No.") then begin
                            Rec_PurchaseHeader.Status := Rec_PurchaseHeader.Status::Open;
                            Rec_PurchaseHeader.Modify();
                        end;
                        PurchasePayableSetup.Get();
                        Clear(i);
                        ReservationEntry.SetRange("Source Type", Database::"Purchase Line");
                        ReservationEntry.SetRange("Source ID", Rec."Document No.");
                        ReservationEntry.CalcSums(Tin, Drum, Bucket, Can);

                        ReserVationEntry2.Reset();
                        ReserVationEntry2.SetRange("Source Type", Database::"Purchase Line");
                        ReserVationEntry2.SetRange("Source ID", Rec."Document No.");
                        if ReserVationEntry2.FindFirst() then begin
                            Message('%1 Tin,%2 Drum,%3 Bucket,%4 Can', ReservationEntry.Tin, ReservationEntry.Drum, ReservationEntry.Bucket, ReservationEntry.Can);
                            for i := 1 to 4 do begin
                                Qty := 0;
                                if (i = 1) and (ReservationEntry.Tin <> 0) then begin
                                    Qty := ReservationEntry.Tin;
                                    PurchasePayableSetup.TestField("Tin Item");
                                end else
                                    if (i = 2) and (ReservationEntry.Drum <> 0) then begin
                                        Qty := ReservationEntry.Drum;
                                        PurchasePayableSetup.TestField("Drum Item");
                                    end else
                                        if (i = 3) and (ReservationEntry.Bucket <> 0) then begin
                                            Qty := ReservationEntry.Bucket;
                                            PurchasePayableSetup.TestField("Bucket Item");
                                        end else
                                            if (i = 4) and (ReservationEntry.Can <> 0) then begin
                                                Qty := ReservationEntry.Can;
                                                PurchasePayableSetup.TestField("CAN Item");
                                            end;
                                if i = 1 then
                                    ItemNo := PurchasePayableSetup."Tin Item"
                                else
                                    if i = 2 then
                                        ItemNo := PurchasePayableSetup."Drum Item"
                                    else
                                        if i = 3 then
                                            ItemNo := PurchasePayableSetup."Bucket Item"
                                        else
                                            if i = 4 then
                                                ItemNo := PurchasePayableSetup."CAN Item";
                                if (Qty <> 0) then begin
                                    PurchaseLine.Reset();
                                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                                    PurchaseLine.SetRange("Document No.", ReserVationEntry2."Source ID");
                                    if PurchaseLine.FindLast() then
                                        LineNo := PurchaseLine."Line No." + 10000
                                    else
                                        LineNo := 10000;

                                    PurchaseLine2.Reset();
                                    PurchaseLine2.SetRange("Document Type", PurchaseLine2."Document Type"::Order);
                                    PurchaseLine2.SetRange("Document No.", ReserVationEntry2."Source ID");
                                    PurchaseLine2.SetRange("No.", ItemNo);
                                    if not PurchaseLine2.FindFirst() then begin
                                        PurchaseLine2."Document Type" := PurchaseLine2."Document Type"::Order;
                                        PurchaseLine2."Document No." := ReserVationEntry2."Source ID";
                                        PurchaseLine2."Line No." := LineNo;
                                        PurchaseLine2.Validate(Type, PurchaseLine2.Type::Item);
                                        PurchaseLine2.Validate("No.", ItemNo);
                                        PurchaseLine2.Validate(Quantity, Qty);
                                        PurchaseLine2.Insert(true);
                                    end else begin
                                        PurchaseLine2.Validate(Quantity, Qty);
                                        PurchaseLine2.Modify();
                                    end;
                                end else begin
                                    PurchaseLine2.Reset();
                                    PurchaseLine2.SetRange("Document Type", PurchaseLine2."Document Type"::Order);
                                    PurchaseLine2.SetRange("Document No.", ReserVationEntry2."Source ID");
                                    PurchaseLine2.SetRange("No.", ItemNo);
                                    if PurchaseLine2.FindFirst() then
                                        PurchaseLine2.Delete(true);
                                end;
                            end;
                            if PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then begin
                                PurchaseHeader."Creation Tin&Drum&Bucket Item" := true;
                                PurchaseHeader.Modify();
                            end;
                        end;

                        if Rec_PurchaseHeader2.get(rec."Document Type", Rec."Document No.") then begin
                            Rec_PurchaseHeader2.Status := Rec_PurchaseHeader2.Status::Released;
                            Rec_PurchaseHeader2.Modify();
                        end;
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(ItemChargeAssignment)
                {
                    AccessByPermission = TableData "Item Charge" = R;
                    ApplicationArea = ItemCharges;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;
                    Enabled = Rec.Type = Rec.Type::"Charge (Item)";
                    ToolTip = 'Record additional direct costs, for example for freight. This action is available only for Charge (Item) line types.';

                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt();
                        SetItemChargeFieldsStyle();
                    end;
                }
                action(DocumentLineTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document &Line Tracking';
                    ToolTip = 'View related open, posted, or archived documents or document lines.';

                    trigger OnAction()
                    begin
                        ShowDocumentLineTracking();
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = Suite;
                    Caption = 'Deferral Schedule';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;
                    ToolTip = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.';

                    trigger OnAction()
                    begin
                        Rec.ShowDeferralSchedule();
                    end;
                }
                /*  action(RedistributeAccAllocations)
                 {
                     ApplicationArea = All;
                     Caption = 'Redistribute Account Allocations';
                     Image = EditList;
 #pragma warning disable AA0219
                     ToolTip = 'Use this action to redistribute the account allocations for this line.';
 #pragma warning restore AA0219

                     trigger OnAction()
                     var
                         AllocAccManualOverride: Page Microsoft.Finance.AllocationAccount."Redistribute Acc. Allocations";
                     begin
                         if ((Rec."Type" <> Rec."Type"::"Allocation Account") and (Rec."Selected Alloc. Account No." = '')) then
                             Error(ActionOnlyAllowedForAllocationAccountsErr);

                         AllocAccManualOverride.SetParentSystemId(Rec.SystemId);
                         AllocAccManualOverride.SetParentTableId(Database::"Purchase Line");
                         AllocAccManualOverride.RunModal();
                     end;
                 } */
                action(DocAttach)
                {
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
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Suite;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'Add a line for each component on the bill of materials for the selected item. For example, this is useful for selling the parent item as a kit. CAUTION: The line for the parent item will be deleted and only its description will display. To undo this action, delete the component lines and add a line for the parent item again. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        ExplodeBOM();
                    end;
                }
                action("Insert Ext. Texts")
                {
                    AccessByPermission = TableData "Extended Text Header" = R;
                    ApplicationArea = Suite;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                    trigger OnAction()
                    begin
                        InsertExtendedText(true);
                    end;
                }
                /*  action("Attach to Inventory Item Line")
                 {
                     ApplicationArea = Basic, Suite;
                     Caption = 'Attach to inventory item line';
                     Image = Allocations;
                     Visible = AttachingLinesEnabled;
                     Enabled = AttachToInvtItemEnabled;
                     ToolTip = 'Attach the selected non-inventory product lines to a inventory item line in this purchase order.';

                     trigger OnAction()
                     var
                         SelectedPurchLine: Record "Purchase Line";
                     begin
                         CurrPage.SetSelectionFilter(SelectedPurchLine);
                         Rec.AttachToInventoryItemLine(SelectedPurchLine);
                     end;
                 } */
                action(Reserve)
                {
                    ApplicationArea = Reservation;
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'Reserve the quantity of the selected item that is required on the document line from which you opened this page. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        Rec.Find();
                        Rec.ShowReservation();
                    end;
                }
                action(OrderTracking)
                {
                    ApplicationArea = Suite;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;
                    Enabled = Rec.Type = Rec.Type::Item;
                    ToolTip = 'Track the connection of a supply to its corresponding demand for the selected item. This can help you find the original demand that created a specific production order or purchase order. This action is available only for lines that contain an item.';

                    trigger OnAction()
                    begin
                        ShowTracking();
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Sales &Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'View the sales order that is the source of the line. This applies only to drop shipments and special orders.';

                        trigger OnAction()
                        begin
                            OpenSalesOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action1901038504)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        ApplicationArea = Suite;
                        Caption = 'Sales &Order';
                        Image = Document;
                        ToolTip = 'View the sales order that is the source of the line. This applies only to drop shipments and special orders.';

                        trigger OnAction()
                        begin
                            OpenSpecOrderSalesOrderForm();
                        end;
                    }
                }
                action(BlanketOrder)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Order';
                    Image = BlanketOrder;
                    ToolTip = 'View the blanket purchase order.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        BlanketPurchaseOrder: Page "Blanket Purchase Order";
                    begin
                        Rec.TestField("Blanket Order No.");
                        PurchaseHeader.SetRange("No.", Rec."Blanket Order No.");
                        if not PurchaseHeader.IsEmpty() then begin
                            BlanketPurchaseOrder.SetTableView(PurchaseHeader);
                            BlanketPurchaseOrder.Editable := false;
                            BlanketPurchaseOrder.Run();
                        end;
                    end;
                }
            }
            group(Errors)
            {
                Caption = 'Issues';
                Image = ErrorLog;
                Visible = BackgroundErrorCheck;
                ShowAs = SplitButton;

                action(ShowLinesWithErrors)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Lines with Issues';
                    Image = Error;
                    Visible = BackgroundErrorCheck;
                    Enabled = not ShowAllLinesEnabled;
                    ToolTip = 'View a list of purchase lines that have issues before you post the document.';

                    trigger OnAction()
                    begin
                        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
                    end;
                }
                action(ShowAllLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show All Lines';
                    Image = ExpandAll;
                    Visible = BackgroundErrorCheck;
                    Enabled = ShowAllLinesEnabled;
                    ToolTip = 'View all purchase lines, including lines with and without issues.';

                    trigger OnAction()
                    begin
                        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
                    end;
                }
            }
            group("Page")
            {
                Caption = 'Page';

                action(EditInExcel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Edit in Excel';
                    Image = Excel;

                    Visible = IsSaaSExcelAddinEnabled;
                    ToolTip = 'Send the data in the sub page to an Excel file for analysis or editing';
                    AccessByPermission = System "Allow Action Export To Excel" = X;

                    trigger OnAction()
                    var
                        EditinExcel: Codeunit "Edit in Excel";
                        EditinExcelFilters: Codeunit "Edit in Excel Filters";
                    begin
                        EditinExcelFilters.AddField('Document_No', Enum::"Edit in Excel Filter Type"::Equal, Rec."Document No.", Enum::"Edit in Excel Edm Type"::"Edm.String");

                        EditinExcel.EditPageInExcel(
                            'Purchase_Order_Line',
                            Page::"Purchase Order Subform",
                            EditinExcelFilters,
                            StrSubstNo(ExcelFileNameTxt, Rec."Document No."));
                    end;

                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetTotalsPurchaseHeader();
        CalculateTotals();
        UpdateEditableOnRow();
        UpdateTypeText();
        SetItemChargeFieldsStyle();
    end;

    trigger OnAfterGetRecord()
    var
        Item: Record "Item";
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        UpdateTypeText();
        SetItemChargeFieldsStyle();
        if Rec."Variant Code" = '' then
            VariantCodeMandatory := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
    end;

    trigger OnDeleteRecord(): Boolean
    var
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            Commit();
            if not PurchLineReserve.DeleteLineConfirm(Rec) then
                exit(false);
            OnBeforeDeleteReservationEntries(Rec);
            PurchLineReserve.DeleteLine(Rec);
        end;
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        DocumentTotals.PurchaseCheckAndClearTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        exit(Rec.Find(Which));
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        PurchasesPayablesSetup.Get();
        InventorySetup.Get();
        TempOptionLookupBuffer.FillLookupBuffer(TempOptionLookupBuffer."Lookup Type"::Purchases);
        IsFoundation := ApplicationAreaMgmtFacade.IsFoundationEnabled();
        Currency.InitRoundingPrecision();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType();
        SetDefaultType();

        Clear(ShortcutDimCode);
        UpdateTypeText();
    end;

    trigger OnOpenPage()
    var
        AllocationAccountMgt: Codeunit "Allocation Account Mgt.";
    begin
        UseAllocationAccountNumber := AllocationAccountMgt.UseAllocationAccountNoField();
        SetOpenPage();

        SetDimensionsVisibility();
        SetOverReceiptControlsVisibility();
        SetItemReferenceVisibility();
    end;

    var
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        InventorySetup: Record "Inventory Setup";
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.';
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        DocumentTotals: Codeunit "Document Totals";
        AmountWithDiscountAllowed: Decimal;
        TypeAsText: Text[30];
        ItemChargeStyleExpression: Text;
        ItemChargeToHandleStyleExpression: Text;
        VariantCodeMandatory: Boolean;
        InvDiscAmountEditable: Boolean;
        BackgroundErrorCheck: Boolean;
        ShowAllLinesEnabled: Boolean;
        IsFoundation: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        AttachingLinesEnabled: Boolean;
        ShowNonDedVATInLines: Boolean;
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        CurrPageIsEditable: Boolean;
        SuppressTotals: Boolean;
        UseAllocationAccountNumber: Boolean;
        ActionOnlyAllowedForAllocationAccountsErr: Label 'This action is only available for lines that have Allocation Account set as Type.';
        ExcelFileNameTxt: Label 'Purchase Order %1 - Lines', Comment = '%1 = document number, ex. 10000';

    protected var
        Currency: Record Currency;
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        ShortcutDimCode: array[8] of Code[20];
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        VATAmount: Decimal;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        IsBlankNumber: Boolean;
        IsCommentLine: Boolean;
        OverReceiptAllowed: Boolean;
        ItemReferenceVisible: Boolean;
        AttachToInvtItemEnabled: Boolean;

    local procedure SetOpenPage()
    var
        ServerSetting: Codeunit "Server Setting";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
    begin
        OnBeforeSetOpenPage();

        IsSaaSExcelAddinEnabled := ServerSetting.GetIsSaasExcelAddinEnabled();
        SuppressTotals := CurrentClientType() = ClientType::ODataV4;
        BackgroundErrorCheck := DocumentErrorsMgt.BackgroundValidationEnabled();
        AttachingLinesEnabled :=
            PurchasesPayablesSetup."Auto Post Non-Invt. via Whse." = PurchasesPayablesSetup."Auto Post Non-Invt. via Whse."::"Attached/Assigned";
        ShowNonDedVATInLines := NonDeductibleVAT.ShowNonDeductibleVATInLines();
    end;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        if SuppressTotals then
            exit;

        PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader.InvoicedLineExists() then
            if not ConfirmManagement.GetResponseOrDefault(UpdateInvDiscountQst, true) then
                exit;

        DocumentTotals.PurchaseDocTotalsNotUpToDate();
        PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchaseHeader);
        CurrPage.Update(false);
    end;

    local procedure ExplodeBOM()
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            Error(Text001);
        CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    local procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOpenSalesOrderForm(Rec, SalesHeader, SalesOrder, IsHandled);
        if IsHandled then
            exit;

        Rec.TestField("Sales Order No.");
        SalesHeader.SetRange("No.", Rec."Sales Order No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run();
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeInsertExtendedText(Rec, IsHandled);
        if IsHandled then
            exit;

        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord();
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RunModal();
    end;

    protected procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOpenSpecOrderSalesOrderForm(Rec, SalesHeader, SalesOrder, IsHandled);
        if IsHandled then
            exit;

        Rec.TestField("Special Order Sales No.");
        SalesHeader.SetRange("No.", Rec."Special Order Sales No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    procedure NoOnAfterValidate()
    begin
        UpdateEditableOnRow();
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord();

        OnAfterNoOnAfterValidate(Rec, xRec);
    end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking: Page "Document Line Tracking";
    begin
        Clear(DocumentLineTracking);
        DocumentLineTracking.SetDoc(1, Rec."Document No.", Rec."Line No.", Rec."Blanket Order No.", Rec."Blanket Order Line No.", '', 0);
        DocumentLineTracking.RunModal();
    end;

    procedure RedistributeTotalsOnAfterValidate()
    begin
        if SuppressTotals then
            exit;

        CurrPage.SaveRecord();

        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.Update(false);
    end;

    local procedure GetTotalsPurchaseHeader()
    begin
        DocumentTotals.GetTotalPurchaseHeaderAndCurrency(Rec, TotalPurchaseHeader, Currency);
    end;

    procedure ClearTotalPurchaseHeader();
    begin
        Clear(TotalPurchaseHeader);
    end;

    procedure CalculateTotals()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCalculateTotals(Rec, SuppressTotals, DocumentTotals, IsHandled);
        if IsHandled then
            exit;

        if SuppressTotals then
            exit;

        DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.CalculatePurchaseSubPageTotals(
          TotalPurchaseHeader, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        DocumentTotals.RefreshPurchaseLine(Rec);
    end;

    procedure DeltaUpdateTotals()
    begin
        if SuppressTotals then
            exit;

        OnBeforeDeltaUpdateTotals(Rec, xRec);
        DocumentTotals.PurchaseDeltaUpdateTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        CheckSendLineInvoiceDiscountResetNotification();
    end;

    procedure ForceTotalsCalculation()
    begin
        DocumentTotals.PurchaseDocTotalsNotUpToDate();
    end;

    local procedure CheckSendLineInvoiceDiscountResetNotification()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckSendLineInvoiceDiscountResetNotification(Rec, IsHandled);
        if IsHandled then
            exit;

        if Rec."Line Amount" <> xRec."Line Amount" then
            Rec.SendLineInvoiceDiscountResetNotification();
    end;

    procedure UpdateEditableOnRow()
    begin
        IsCommentLine := Rec.Type = Rec.Type::" ";
        IsBlankNumber := IsCommentLine;
        if AttachingLinesEnabled then
            AttachToInvtItemEnabled := not Rec.IsInventoriableItem();

        CurrPageIsEditable := CurrPage.Editable;
        InvDiscAmountEditable :=
            CurrPageIsEditable and not PurchasesPayablesSetup."Calc. Inv. Discount" and
            (TotalPurchaseHeader.Status = TotalPurchaseHeader.Status::Open);

        OnAfterUpdateEditableOnRow(Rec, IsCommentLine, IsBlankNumber);
    end;

    procedure UpdateTypeText()
    var
        RecRef: RecordRef;
    begin
        if not IsFoundation then
            exit;

        OnBeforeUpdateTypeText(Rec);

        RecRef.GetTable(Rec);
        TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.Field(Rec.FieldNo(Type)));
    end;

    local procedure SetItemChargeFieldsStyle()
    begin
        ItemChargeStyleExpression := '';
        ItemChargeToHandleStyleExpression := '';
        if Rec.AssignedItemCharge() then begin
            if Rec."Qty. To Assign" <> (Rec.Quantity - Rec."Qty. Assigned") then
                ItemChargeStyleExpression := 'Unfavorable';
            if Rec."Item Charge Qty. to Handle" <> Rec."Qty. to Invoice" then
                ItemChargeToHandleStyleExpression := 'Unfavorable';
        end;
    end;

    local procedure SetItemReferenceVisibility()
    var
        ItemReference: Record "Item Reference";
    begin
        ItemReferenceVisible := not ItemReference.IsEmpty();
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);

        OnAfterSetDimensionsVisibility();
    end;

    local procedure SetDefaultType()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSetDefaultType(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if xRec."Document No." = '' then
            Rec.Type := Rec.GetDefaultLineType();
    end;

    local procedure SetOverReceiptControlsVisibility()
    var
        OverReceiptMgt: Codeunit "Over-Receipt Mgt.";
    begin
        OverReceiptAllowed := OverReceiptMgt.IsOverReceiptAllowed();
    end;

    [IntegrationEvent(TRUE, false)]
    local procedure OnAfterNoOnAfterValidate(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpdateEditableOnRow(PurchaseLine: Record "Purchase Line"; var IsCommentLine: Boolean; var IsBlankNumber: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var PurchaseLine: Record "Purchase Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateTotals(var PurchLine: Record "Purchase Line"; SuppressTotals: Boolean; var DocumentTotals: Codeunit "Document Totals"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckSendLineInvoiceDiscountResetNotification(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenSpecOrderSalesOrderForm(var PurchaseLine: Record "Purchase Line"; var SalesHeader: Record "Sales Header"; var SalesOrder: Page "Sales Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetDefaultType(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateTypeText(var PurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnItemReferenceNoOnLookup(var PurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenSalesOrderForm(var PurchaseLine: Record "Purchase Line"; var SalesHeader: Record "Sales Header"; var SalesOrder: Page "Sales Order"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeSetOpenPage()
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterSetDimensionsVisibility()
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeDeltaUpdateTotals(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeDeleteReservationEntries(var PurchaseLine: Record "Purchase Line");
    begin
    end;
}

