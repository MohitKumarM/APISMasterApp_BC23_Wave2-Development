pageextension 50058 PurchaseCrMemo extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Document Date")
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
        myInt: Integer;
}