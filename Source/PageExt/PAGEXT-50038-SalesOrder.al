pageextension 50038 "SalesOrder" extends "Sales Order"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()

            begin
                if rec."GST Customer Type" = Rec."GST Customer Type"::Export then
                    Error('Export Orders Can be Create Only Export Page.');
            end;
        }
        addafter("Salesperson Code")
        {

            field(NSM; Rec.NSM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NSM field.';
            }
            field(ZSM; Rec.ZSM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ZSM field.';
            }
            field(RSM; Rec.RSM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RSM field.';
            }
            field(ASM; Rec.ASM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ASM field.';
            }
            field(TSM; Rec.TSM)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TSM field.';
            }
            field(SO; Rec.SO)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SO field.';
            }
            field("APIS_Transaction Type"; Rec."APIS_Transaction Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction Type field.';
            }

        }
        addafter("Shipping Agent Code")
        {
            field("Driver Name"; Rec."Driver Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Driver Name field.';
            }
            field("Driver Mob No."; Rec."Driver Mob No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Driver Mob No. field.';
            }
            field("Driver Adhar No."; Rec."Driver Adhar No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Driver Adhar No. field.';
            }
            field("Loading Start Time"; Rec."Loading Start Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Loading Start Time field.';
            }
            field("Loading End Time"; Rec."Loading End Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Loading End Time field.';
            }
            field("Stock In Hand"; Rec."Stock In Hand")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Stock In Hand field.';
            }
            field("Quantity Loaded"; Rec."Quantity Loaded")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Stock In Hand field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
}