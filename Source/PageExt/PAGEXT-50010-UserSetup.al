pageextension 50010 UsersSetup extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("Default Store Location"; Rec."Default Store Location")
            {
                ApplicationArea = all;
            }
            field("Allow Item Journal Posting"; Rec."Allow Item Journal Posting")
            {
                ApplicationArea = all;
            }
            field("Allow Customer Approval"; Rec."Allow Customer Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Customer Approval field.';
            }
            field("Allow Deal Approval"; Rec."Allow Deal Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Deal Approval field.';
            }

            field("Allow Purch. Order Approval"; Rec."Allow Purch. Order Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Purch. Order Approval field.';
            }
            field("Allow Sales Order Approval"; Rec."Allow Sales Order Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Sales Order Approval field.';
            }
            field("Allow Vendor Approval"; Rec."Allow Vendor Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Vendor Approval field.';
            }
            field("Allow Receipt"; Rec."Allow Receipt")
            {
                ApplicationArea = all;
            }
            field("Allow Purchase Invoice"; Rec."Allow Purchase Invoice")
            {
                ApplicationArea = all;
            }
            field("Purchaser Profile"; Rec."Purchaser Profile")
            {
                ApplicationArea = all;
            }
            field("Allow Send Back Deal"; Rec."Allow Send Back Deal")
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