// report 50016 "Plan Book"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultRenderingLayout = LayoutName;

//     dataset
//     {
//         dataitem("Production Order"; 5405)
//         {
//             DataItemTableView = WHERE(Status = filter(Released), Refreshed = CONST(true), "Order Type" = filter(Production));
//             RequestFilterFields = "No.";
//             column(Order_No; "No.") { }
//             column(Status; Status) { }
//             column(Issued_from_Lab; "Requested Material Issue") { }
//             column(Customer; "Customer Code") { }
//             column(Brand; Item_Rec."Planning type") { }
//             column(Batch_No; "Batch No.") { }
//             column(Drum; '') { }
//             column(Bucket; '') { }
//             column(Tin; '') { }
//             column(Can; '') { }
//             column(Lot_No; LotTrackingEntry_Rec."Lot No.") { }
//             column(Flora; LotTrackingEntry_Rec.Flora) { }
//             column(Quantity; LotTrackingEntry_Rec.Quantity) { }
//             column(Total; LotTrackingEntry_Rec."Remaining Qty.") { }
//             column(Unit; "Location Code") { }
//             column(Prod_Type; "Production Type") { }
//             column(Issue_Time; SystemCreatedAt) { }

//             trigger OnAfterGetRecord()
//             begin
//                 ProdOrderLine_rec.Reset();
//                 ProdOrderLine_rec.SetRange("Prod. Order No.", "No.");
//                 if ProdOrderLine_rec.FindFirst() then begin
//                     repeat
//                         ProdOrderComponent_Rec.Reset();
//                         ProdOrderComponent_Rec.SetRange("Prod. Order No.", "No.");
//                         ProdOrderComponent_Rec.SetRange(Status, Status);
//                         ProdOrderComponent_Rec.SetRange("Prod. Order Line No.", ProdOrderLine_rec."Line No.");
//                         if ProdOrderComponent_Rec.FindFirst() then begin
//                             repeat
//                                 TranLotTracking.Reset();
//                                 TranLotTracking.SetRange("Document No.", ProdOrderComponent_Rec."Prod. Order No.");
//                                 TranLotTracking.SetRange("Document Line No.", ProdOrderComponent_Rec."Prod. Order Line No.");
//                                 TranLotTracking.SetRange("Item No.", ProdOrderComponent_Rec."Item No.");
//                                 if TranLotTracking.FindSet() then begin
//                                     repeat
//                                         LotTrackingEntry_Rec.Reset();
//                                         LotTrackingEntry_Rec.SetRange("Entry No.", TranLotTracking."Ref. Entry No.");
//                                         if LotTrackingEntry_Rec.FindFirst() then begin

//                                         end;
//                                     until TranLotTracking.Next() = 0;
//                                 end;
//                             until ProdOrderComponent_Rec.Next() = 0;
//                         end;
//                     until ProdOrderLine_rec.Next() = 0;
//                 end;

//                 Item_Rec.Reset();
//                 Item_Rec.SetRange("No.", ProdOrderLine_rec."Item No.");
//                 if Item_Rec.FindFirst() then;
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(Name; '')
//                     {
//                         ApplicationArea = All;

//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     rendering
//     {
//         layout(LayoutName)
//         {
//             Type = RDLC;
//             LayoutFile = '.\ReportLayouts\PlanBook.rdl';
//         }
//     }

//     var
//         LotTrackingEntry_Rec: Record "Lot Tracking Entry";
//         ProdOrderComponent_Rec: Record "Prod. Order Component";
//         TranLotTracking: Record 50009;
//         ILE_Rec: Record "Item Ledger Entry";
//         Item_Rec: Record Item;
//         ProdOrderLine_rec: Record 5406;
// }