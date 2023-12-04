pageextension 50050 SalesInvoice extends "Sales Invoice"
{
    layout
    {
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
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}