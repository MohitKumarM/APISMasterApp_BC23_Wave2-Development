pageextension 50017 ItemLedgerEntry extends "Item Ledger Entries"
{
    layout
    {
        addafter(Quantity)
        {
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
            }
            field("MFG. Date"; Rec."MFG. Date")
            {
                ApplicationArea = all;
            }
            field(Tin; Rec.Tin)
            {
                ApplicationArea = all;
            }
            field(Drum; Rec.Drum)
            {
                ApplicationArea = all;
            }
            field(Bucket; Rec.Bucket)
            {
                ApplicationArea = all;
            }
            field(Can; Rec.Can)
            {
                ApplicationArea = all;
            }
            field("Deal No."; Rec."Deal No.")
            {
                ApplicationArea = all;
            }
            /*  field("Deal Line No."; Rec."Deal Line No.")
             {
                 ApplicationArea = All;
                 ToolTip = 'Specifies the value of the Deal Line No. field.';
             } */ // // 15800 Dispatch Discontinue
            field("Qty. in Pack"; Rec."Qty. in Pack")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. in Pack field.';
            }
            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packing Type field.';
            }
            field("Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchaser Code field.';
            }
            field("Purchaser Name"; Rec."Purchaser Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchaser Name field.';
            }
            field("Tare Weight"; Rec."Tare Weight")
            {
                ApplicationArea = all;
            }
            field(Flora; Rec.Flora)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Flora field.';
            }
            field("Dispatched Qty. in Kg."; Rec."Dispatched Qty. in Kg.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatched Qty. in Kg. field.';
            }

            field("QC To Approve"; Rec."QC To Approve")
            {
                ApplicationArea = All;
            }
            field("Approved Quantity"; Rec."Approved Quantity")
            {
                ApplicationArea = all;
            }
            field("Rejected Quantity"; Rec."Rejected Quantity")
            {
                ApplicationArea = all;
            }
            field("Quality Checked"; Rec."Quality Checked")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}