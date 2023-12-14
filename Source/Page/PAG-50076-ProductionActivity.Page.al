page 50076 "Production Activity"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Purchase Cue";
    ApplicationArea = All, Basic, Suite;

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
                    action("Production Planning_")
                    {
                        Caption = 'Production Planning';
                        RunObject = Page "Production Planning";
                    }
                    action("Prod. Order to Refresh_")
                    {
                        Caption = 'Prod. Order to Refresh';
                        RunObject = Page "Production Orders to Refresh";
                    }
                    action("Select Honey Batch_")
                    {
                        Caption = 'Select Honey Batch';
                        RunObject = Page "Prod. Orders Material Request";
                    }
                    action("Output Journal_")
                    {
                        Caption = 'Output Journal';
                        RunObject = Page "Output Posting";
                    }
                    action("Output Posting_")
                    {
                        Caption = 'Output Posting';
                        RunObject = Page "Material Req. List";
                    }
                }
            }
            cuegroup(Production)
            {
                field("Production Planning"; Rec."Production Planning")
                {
                    DrillDownPageID = "Production Planning";
                    LookupPageID = "Production Planning";
                }
                field("Prod. Order to Refresh"; Rec."Prod. Order to Refresh")
                {
                    DrillDownPageID = "Production Orders to Refresh";
                    LookupPageID = "Production Orders to Refresh";
                }
                field("Select Honey Batch"; Rec."Select Honey Batch")
                {
                    DrillDownPageID = "Prod. Orders Material Request";
                    LookupPageID = "Prod. Orders Material Request";
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

    actions { }

    trigger OnOpenPage()
    var
        intUserCount: Integer;
        recGLSetup: Record "General Ledger Setup";
        recUser: Record "User";
    begin
        //Iappc - User Mgmt Begin
        recGLSetup.GET;

        intUserCount := 0;

        recUser.RESET;
        recUser.SETRANGE("User Name", USERID);
        recUser.FINDFIRST;

        //Iappc - User Mgmt End

        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

        Rec.SETFILTER("Date Filter", '>=%1', WORKDATE);
    end;
}
