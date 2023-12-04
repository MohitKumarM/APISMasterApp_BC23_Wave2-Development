pageextension 50001 Purchase_Invoice extends "Purchase Invoice"
{
    layout
    {
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Entry Point")
        {
            Visible = false;
        }
        addafter("Vendor Invoice No.")
        {
            field("Activity Name"; Rec."Activity Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activity Name field.';
            }
            field("Activity City"; Rec."Activity City")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activity City field.';
            }
            field("Activity State"; Rec."Activity State")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activity State field.';
            }
            field("Sales Channel"; Rec."Sales Channel")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Channel field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}