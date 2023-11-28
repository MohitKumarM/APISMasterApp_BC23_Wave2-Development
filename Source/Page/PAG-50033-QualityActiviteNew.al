page 50033 "Quality Activities New"
{
    Caption = 'Quality Activities';
    PageType = CardPart;
    SourceTable = "Purchase Cue";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            cuegroup(Quality1)
            {
                Caption = 'Quality';
                // Visible = false;

                actions
                {
                    action("Pending Inward Quality1")
                    {
                        Caption = 'Pending Inward Quality';
                        RunObject = Page "Pending Inward QC";
                    }
                    action("Quality to Approve1")
                    {
                        Caption = 'Quality to Approve';
                        RunObject = Page "Inward QC to Approve";
                    }
                    action("Pending Output QC1")
                    {
                        Caption = 'Pending Output QC';
                        RunObject = Page "Output QC";
                    }
                    action("Posted Quality")
                    {
                        Caption = 'Posted Quality';
                        RunObject = Page "Quality Checks";
                    }
                }
            }
            cuegroup(Productions)
            {
                Caption = 'Production';
                Visible = false;

                actions
                {
                    action("Production Planning1")
                    {
                        Caption = 'Production Planning';
                        RunObject = Page "Production Planning";
                    }
                    action("Prod. Order to Refresh1")
                    {
                        Caption = 'Prod. Order to Refresh';
                        RunObject = Page "Production Orders to Refresh";
                    }
                    action("Select Honey Batch1")
                    {
                        Caption = 'Select Honey Batch';
                        RunObject = Page "Prod. Orders Material Request";
                    }
                    action("Output Journal1")
                    {
                        Caption = 'Output Journal';
                        RunObject = Page "Output Journal";
                    }
                    action("Output Posting1")
                    {
                        Caption = 'Output Posting';
                        RunObject = Page "Output Posting";
                    }
                }
            }
            cuegroup(Quality)
            {
                field("Pending Inward Quality"; Rec."Pending Inward Quality")
                {
                    DrillDownPageID = "Pending Inward QC";
                    LookupPageID = "Pending Inward QC";
                }
                field("Quality to Approve"; Rec."Quality to Approve")
                {
                    DrillDownPageID = "Inward QC to Approve";
                    LookupPageID = "Inward QC to Approve";
                }
                field("Pending Output QC"; Rec."Pending Output QC")
                {
                    DrillDownPageID = "Output QC";
                    LookupPageID = "Output QC";
                }
                field("Posted QC"; Rec."Posted QC")
                {
                    DrillDownPageID = "Quality Checks";
                    LookupPageID = "Quality Checks";
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
        recUser: Record User;
    begin
        //Iappc - User Mgmt Begin
        recGLSetup.GET;

        intUserCount := 0;

        recUser.RESET;
        recUser.SETRANGE("User Name", USERID);
        recUser.FINDFIRST;

        // IF recUser."License  Type" <> recUser."License  Type"::Administrator THEN BEGIN
        //     recActiveSession.RESET;
        //     recActiveSession.SETFILTER("Client Type", '%1', recActiveSession."Client Type"::"Web Client");

        //     IF recUser."License  Type" = recUser."License  Type"::"Full User" THEN
        //         recActiveSession.SETFILTER("License  Type", '%1', recActiveSession."License  Type"::"Full User")
        //     ELSE
        //         recActiveSession.SETFILTER("License  Type", '%1', recActiveSession."License  Type"::"Limited User");
        //     IF recActiveSession.FINDLAST THEN BEGIN
        //         intUserCount := recActiveSession.COUNT;

        //         IF (recUser."License  Type" = recUser."License  Type"::"Full User") AND (intUserCount > recGLSetup."Full User Nos.") THEN
        //             STOPSESSION(recActiveSession."Session ID");
        //         IF (recUser."License  Type" = recUser."License  Type"::"Limited User") AND (intUserCount > recGLSetup."Limited User Nos.") THEN
        //             STOPSESSION(recActiveSession."Session ID");
        //     END;
        // END;
        //Iappc - User Mgmt End

        // RESET;
        // IF NOT GET THEN BEGIN
        //     INIT;
        //     INSERT;
        // END;

        // SETFILTER("Date Filter", '>=%1', WORKDATE);
    end;
}
