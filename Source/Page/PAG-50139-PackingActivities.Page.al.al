page 50139 "Packing Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Purchase Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Production_)
            {
                Caption = 'Production';
                Visible = false;

                actions
                {
                    action("Create Packing Order")
                    {
                        Caption = 'Create Packing Order';
                        RunObject = Page "Filling Planning";
                    }
                    action("Packing Location Mat. Trf.")
                    {
                        Caption = 'Packing Location Mat. Trf.';
                        RunObject = Page "Packing Location Stock Trf.";
                    }
                    action("Approve Packing Order")
                    {
                        RunObject = Page "Packing Orders Approval";
                    }
                    action("Packing Orders_")
                    {
                        Caption = 'Packing Orders';
                        RunObject = Page "Packing Orders Material Req.";
                    }
                    action("Output Journal_")
                    {
                        Caption = 'Output Journal';
                        RunObject = Page "Output Journal";
                    }
                    action("Output Posting_")
                    {
                        Caption = 'Output Posting';
                        RunObject = Page "Output Posting";
                    }
                    action("Consumption Journal_")
                    {
                        RunObject = Page "Consumption Journal";
                    }
                    action("Dates Production Order")
                    {
                        RunObject = Page "Dates Production Orders";
                    }
                }
            }
            cuegroup(Production)
            {
                field("Create Packing Orders"; Rec."Create Packing Orders")
                {
                    DrillDownPageID = "Filling Planning";
                    LookupPageID = "Filling Planning";
                }
                field("Packing Location Stock Trf."; Rec."Packing Location Stock Trf.")
                {
                    DrillDownPageID = "Packing Location Stock Trf.";
                    LookupPageID = "Packing Location Stock Trf.";
                }
                field("Packing Order Approval"; rec."Packing Order Approval")
                {
                    DrillDownPageID = "Packing Orders Approval";
                    LookupPageID = "Packing Orders Approval";
                }
                field("Packing Orders"; Rec."Packing Orders")
                {
                    DrillDownPageID = "Packing Orders Material Req.";
                    LookupPageID = "Packing Orders Material Req.";
                }
                field("Output Journal"; Rec."Output Journal")
                {
                    DrillDownPageID = "Output Journal";
                    LookupPageID = "Output Journal";
                }
                field("Output Posting"; Rec."Output Posting")
                {
                    DrillDownPageID = "Output Posting";
                    LookupPageID = "Output Posting";
                }
                field("Consumption Journal"; Rec."Consumption Journal")
                {
                    DrillDownPageID = "Direct Consumption Journal";
                    LookupPageID = "Direct Consumption Journal";
                }
                field("Dates Orders"; Rec."Dates Orders")
                {
                    DrillDownPageID = "Dates Production Orders";
                    LookupPageID = "Dates Production Orders";
                }
            }
            cuegroup(Requisition)
            {
                Caption = 'Requisition';
                field("Material Requisition"; Rec."Material Requisition")
                {
                    DrillDownPageID = "Material Req. List";
                    LookupPageID = "Material Req. List";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
    begin
        //Iappc - User Mgmt Begin



        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

        Rec.SETFILTER("Date Filter", '>=%1', WORKDATE);
    end;
}

