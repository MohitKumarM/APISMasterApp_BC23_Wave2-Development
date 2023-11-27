pageextension 50040 RoutingExt extends Routing
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Production Type"; Rec."Production Type")
            {
                ApplicationArea = all;
            }
            field("Auto Selection"; Rec."Auto Selection")
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