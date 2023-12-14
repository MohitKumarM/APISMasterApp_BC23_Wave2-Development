page 50068 "Production Role Center"
{
    Caption = 'Production Role Center';
    PageType = RoleCenter;
    ApplicationArea = All, Basic, Suite;

    layout
    {
        area(RoleCenter)
        {
            part("Production Activity"; "Production Activity")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action("Production Planning")
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Production Planning';
                RunObject = page "Production Planning";
                Image = Order;
            }

            action("Prod. Order to Refresh")
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Prod. Order to Refresh';
                RunObject = page "Production Orders to Refresh";
                Image = Order;
            }
            action("Select Honey Batch")
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Select Honey Batch';
                RunObject = page "Prod. Orders Material Request";
                Image = Order;
            }
            action("Output Journal")
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Output Journal';
                RunObject = page "Output Journal";
                Image = Order;
            }
            action("Output Posting")
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Output Posting';
                RunObject = page "Output Posting";
                Image = Order;
            }
            action("Material Requisition")
            {
                ApplicationArea = Manufacturing, Basic, Suite;
                Caption = 'Material Requisition';
                RunObject = page "Material Req. List";
                Image = Order;
            }
        }
    }
}
