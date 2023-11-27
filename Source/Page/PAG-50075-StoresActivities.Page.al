page 50075 "Stores Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Purchase Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            cuegroup(Stores_)
            {
                Caption = 'Stores';
                Visible = false;

                actions
                {
                    action("Material Issue_")
                    {
                        Caption = 'Material Issue';
                        RunObject = Page "Material Req. Issue List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Production Material Issue_")
                    {
                        Caption = 'Production Material Issue';
                        RunObject = Page "Material Req. List";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            cuegroup(Stores)
            {

                field("Material Issue"; Rec."Material Issue")
                {
                    DrillDownPageID = "Material Req. Issue List";
                    LookupPageID = "Material Req. Issue List";
                    ApplicationArea = Basic, Suite;
                }
                field("Production Material Issue"; Rec."Issue Material")
                {
                    DrillDownPageID = "Production Material Issue";
                    LookupPageID = "Production Material Issue";
                    ApplicationArea = Basic, Suite;
                }
            }

            cuegroup(Requisition)
            {
                Caption = 'Requisition';
                field("Material Requisition"; Rec."Material Requisition")
                {
                    DrillDownPageID = "Material Req. List";
                    LookupPageID = "Material Req. List";
                    ApplicationArea = Basic, Suite;
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



        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;

        Rec.SETFILTER("Date Filter", '>=%1', WORKDATE);
    end;
}

