// 15800 Dispatch Discontinue
// page 50015 "Deal Dispatch Subform"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     LinksAllowed = false;
//     ModifyAllowed = false;
//     PageType = ListPart;
//     UsageCategory = Lists;
//     SourceTable = "Deal Dispatch Details";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Sauda No."; Rec."Sauda No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Line No."; Rec."Line No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Dispatch Date"; Rec."Dispatch Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Dispatched Tins / Buckets"; Rec."Dispatched Tins / Buckets")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Qty. in Kg."; Rec."Qty. in Kg.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Flora; Rec.Flora)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Packing Type"; Rec."Packing Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Vehicle No."; Rec."Vehicle No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Beekeeper Name Name"; Rec."Beekeeper Name Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Location Name"; Rec."Location Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("GAN Created"; Rec."GAN Created")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("GAN No."; Rec."GAN No.")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Re-open")
//             {
//                 Image = Delete;

//                 trigger OnAction()
//                 begin
//                     IF NOT CONFIRM('Do you want to re-open the dispatch?', FALSE) THEN
//                         EXIT;

//                     recPurchLine.RESET;
//                     recPurchLine.SETRANGE("Deal No.", Rec."Sauda No.");
//                     recPurchLine.SETRANGE("Deal Line No.", Rec."Line No.");
//                     IF recPurchLine.FINDFIRST THEN
//                         ERROR('The dispatch is already linked to order no. %1, hence can not be re-opened.', recPurchLine."Document No.");

//                     recPurchRcptLine.RESET;
//                     recPurchRcptLine.SETRANGE("Deal No.", Rec."Sauda No.");
//                     recPurchRcptLine.SETRANGE("Deal Line No.", Rec."Line No.");
//                     IF recPurchRcptLine.FINDFIRST THEN
//                         ERROR('GAN %1 is already posted for the selected dispatch, hence can not be re-opened.', recPurchRcptLine."Document No.");

//                     Rec."GAN Created" := FALSE;
//                     Rec."GAN No." := '';
//                     Rec.MODIFY;
//                     CurrPage.UPDATE;
//                 end;
//             }
//         }
//     }

//     var
//         recPurchLine: Record "Purchase Line";
//         recPurchRcptLine: Record "Purch. Rcpt. Line";
// }
