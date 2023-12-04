page 50140 "QC Partly4"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Purchase Cue";

    layout
    {
        area(content)
        {
            cuegroup(Quality_)
            {
                Caption = 'Quality';
                Visible = false;

                actions
                {
                    action("Pending Inward Quality_")
                    {
                        Caption = 'Pending Inward Quality';
                        RunObject = Page "Pending Inward QC";
                    }
                    action("Posted Quantity")
                    {
                        Caption = 'Posted Quantity';
                        RunObject = Page "Quality Checks";
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
                field("Posted QC"; Rec."Posted QC")
                {
                    DrillDownPageID = "Quality Checks";
                    LookupPageID = "Quality Checks";
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        intUserCount: Integer;
        recGLSetup: Record "General Ledger Setup";
        recUser: Record "User";
        recActiveSession: Record "Active Session";
    begin



        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

        Rec.SETFILTER("Date Filter", '>=%1', WORKDATE);
    end;
}

