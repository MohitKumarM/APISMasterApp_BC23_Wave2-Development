report 50014 "PM Incoming Sheet"
{
    Caption = 'PM Incoming Sheet';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PMIncomingSheet.rdl';


    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            // RequestFilterFields = "Posting Date";
            DataItemTableView = sorting("Document No.", "Line No.");

            column(Branch_Code; PIH_Rec."Shortcut Dimension 1 Code") { }//Shortcut Dimension 1 Code
            column(Location_Code; "Location Code") { }
            column(Gate_Entry_No; PostedGateEntyLine_Rec."Gate Entry No.") { }
            column(Gate_Entry_Date; PostedGateEntyHdr_Rec."Posting Date") { }
            column(Document_No_; "Document No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Order_No_; "Order No.") { }
            column(Order_Date; PIH_Rec."Order Date") { }//Order Date
            column(Order_Line_No_; "Order Line No.") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(vander_Name; PIH_Rec."Buy-from Vendor Name") { }//Buy-from Vendor Name
            column(vendor_Invoice_No; PIH_Rec."Vendor Invoice No.") { }//Vendor Invoice No.
            column(vendor_Invoice_Date; PIH_Rec."Document Date") { }//Douument Date
            column(Type; Type) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Unit_of_Measure_Code; "Unit of Measure Code") { }
            column(Quantity; Quantity) { }
            column(Quantity_Invoiced; "Quantity Invoiced") { }
            column(Direct_Unit_Cost; "Direct Unit Cost") { }
            column(Order_Quantity; '') { }//PO Qty
            column(Billed_Quantity; Quantity) { }//PIL Qty
            column(Approved_Qty; '') { }//Need to Quality
            column(Rejected_Qty; '') { }//Need to Quality
            column(Pack_Size; '') { }//
            column(Item_Category_Code; Item_Rec."Item Category Code") { }
            column(Product_Group_Code; '') { }
            column(Inventory_Posting_Group; Item_Rec."Inventory Posting Group") { }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Purch. Rcpt. Line";
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = sorting("Document No.", "Document Type", "Document Line No.");


                column(GAN_Tolerance; '') { }//PLI
                column(OrderQty_with_Tolerance; '') { }//Need
                column(Document_Line_No_; "Document Line No.") { }
                column(Lot_No_; "Lot No.") { }

                trigger OnAfterGetRecord()
                begin

                end;

            }
            trigger OnAfterGetRecord()
            begin
                IF PIH_Rec.Get("Document No.") then;
                if Item_Rec.Get("No.") then;

                PostedGateEntyLine_Rec.Reset();
                PostedGateEntyLine_Rec.SetRange("Source No.", "Order No.");
                if PostedGateEntyLine_Rec.FindFirst() then;

                if PostedGateEntyHdr_Rec.get(PostedGateEntyLine_Rec."Entry Type", PostedGateEntyLine_Rec."Gate Entry No.") then;
            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; '')
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    var
        PIH_Rec: Record "Purch. Inv. Header";
        GateEntryHeadr: Record "Gate Entry Header";
        GateEntryLine: Record "Gate Entry Line";
        PL: Record "Purchase Line";
        Item_Rec: Record Item;
        ILE_Rec: Record "Item Ledger Entry";

        PuchRecptHeader: Record "Purch. Rcpt. Header";
        PostedGateEntyHdr_Rec: Record "Posted Gate Entry Header";
        PostedGateEntyLine_Rec: Record "Posted Gate Entry Line";


}
