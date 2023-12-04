// page 50138 "Prod Packing & Item RoleCentre"
// {
//     Caption = 'Role Centre';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Grp)
//             {
//                 part(; "Packing Activities")
//                 {
//                 }
//                 part("QC Activities"; "QC Partly4")
//                 {
//                     Caption = 'QC Activities';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("Masters Management")
//             {
//                 Caption = 'Masters Management';
//                 Image = Bank;
//                 action(Items)
//                 {
//                     Caption = 'Items';
//                     RunObject = Page "Item  List";
//                 }
//                 group("Masters Creation")
//                 {
//                     Caption = 'Masters Creation';
//                     Image = Bank;
//                     action(Item_)
//                     {
//                         Caption = 'Item';
//                         Image = NewItem;
//                         RunObject = Page "Nonstock Item List";
//                     }
//                 }
//             }
//             group("Masters Approval")
//             {
//                 Caption = 'Masters Approval';
//                 Image = Bank;
//                 action(Item)
//                 {
//                     Caption = 'Item';
//                     Image = NewItem;
//                     RunObject = Page "Item Approval List";
//                 }
//             }
//             group(Voucher)
//             {
//                 Caption = 'Voucher';
//                 Image = Statistics;
//                 action("Item Transfer")
//                 {
//                     Caption = 'Item Transfer';
//                     RunObject = Page 50137;
//                 }
//                 action("De-Assemble Item")
//                 {
//                     RunObject = Page 902;
//                 }
//             }
//             group(Masters)
//             {
//                 Caption = 'Masters';
//                 Image = Journals;
//                 group("Production Design")
//                 {
//                     Caption = 'Production Design';
//                     Image = Bank;
//                     action("Production BOM")
//                     {
//                         Caption = 'Production BOM';
//                         Image = ProdBOMMatrixPerVersion;
//                         RunObject = Page 50032;
//                     }
//                     action("BOM List View")
//                     {
//                         RunObject = Page 50136;
//                     }
//                     action("Item List")
//                     {
//                         RunObject = Page 16566;
//                     }
//                 }
//                 group(Balances)
//                 {
//                     Caption = 'Balances';
//                     Image = Statistics;
//                     action("Item Balance")
//                     {
//                         Caption = 'Item Balance';
//                         RunObject = Page 471;
//                     }
//                 }
//             }
//         }
//     }
// }

