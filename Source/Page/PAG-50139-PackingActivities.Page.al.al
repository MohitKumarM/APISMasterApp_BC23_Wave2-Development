page 50139 "Packing Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = Table9055;

    layout
    {
        area(content)
        {
            cuegroup(Production)
            {
                Caption = 'Production';
                Visible = false;

                actions
                {
                    action("Create Packing Order")
                    {
                        Caption = 'Create Packing Order';
                        RunObject = Page 50094;
                    }
                    action("Packing Location Mat. Trf.")
                    {
                        Caption = 'Packing Location Mat. Trf.';
                        RunObject = Page 50142;
                    }
                    action("Approve Packing Order")
                    {
                        RunObject = Page 50135;
                    }
                    action("Packing Orders")
                    {
                        Caption = 'Packing Orders';
                        RunObject = Page 50054;
                    }
                    action("Output Journal")
                    {
                        Caption = 'Output Journal';
                        RunObject = Page 99000823;
                    }
                    action("Output Posting")
                    {
                        Caption = 'Output Posting';
                        RunObject = Page 50092;
                    }
                    action("Consumption Journal")
                    {
                        RunObject = Page 50077;
                    }
                    action("Dates Production Order")
                    {
                        RunObject = Page 50144;
                    }
                }
            }
            cuegroup(Production)
            {
                field("Create Packing Orders"; "Create Packing Orders")
                {
                    DrillDownPageID = "Filling Planning";
                    LookupPageID = "Filling Planning";
                }
                field("Packing Location Stock Trf."; "Packing Location Stock Trf.")
                {
                    DrillDownPageID = "Packing Location Stock Trf.";
                    LookupPageID = "Packing Location Stock Trf.";
                }
                field("Packing Order Approval"; "Packing Order Approval")
                {
                    DrillDownPageID = "Packing Orders Approval";
                    LookupPageID = "Packing Orders Approval";
                }
                field("Packing Orders"; "Packing Orders")
                {
                    DrillDownPageID = "Packing Orders Material Req.";
                    LookupPageID = "Packing Orders Material Req.";
                }
                field("Output Journal"; "Output Journal")
                {
                    DrillDownPageID = "Output Journal";
                    LookupPageID = "Output Journal";
                }
                field("Output Posting"; "Output Posting")
                {
                    DrillDownPageID = "Output Posting";
                    LookupPageID = "Output Posting";
                }
                field("Consumption Journal"; "Consumption Journal")
                {
                    DrillDownPageID = "Direct Consumption Journal";
                    LookupPageID = "Direct Consumption Journal";
                }
                field("Dates Orders"; "Dates Orders")
                {
                    DrillDownPageID = "Dates Production Orders";
                    LookupPageID = "Dates Production Orders";
                }
            }
            cuegroup(Requisition)
            {
                Caption = 'Requisition';
                field("Material Requisition"; "Material Requisition")
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
        intUserCount: Integer;
        recGLSetup: Record "98";
        recUser: Record "2000000120";
        recActiveSession: Record "2000000110";
    begin
        //Iappc - User Mgmt Begin
        recGLSetup.GET;

        intUserCount := 0;

        recUser.RESET;
        recUser.SETRANGE("User Name", USERID);
        recUser.FINDFIRST;

        IF recUser."License  Type" <> recUser."License  Type"::Administrator THEN BEGIN
            recActiveSession.RESET;
            recActiveSession.SETFILTER("Client Type", '%1', recActiveSession."Client Type"::"Web Client");

            IF recUser."License  Type" = recUser."License  Type"::"Full User" THEN
                recActiveSession.SETFILTER("License  Type", '%1', recActiveSession."License  Type"::"Full User")
            ELSE
                recActiveSession.SETFILTER("License  Type", '%1', recActiveSession."License  Type"::"Limited User");
            IF recActiveSession.FINDLAST THEN BEGIN
                intUserCount := recActiveSession.COUNT;

                IF (recUser."License  Type" = recUser."License  Type"::"Full User") AND (intUserCount > recGLSetup."Full User Nos.") THEN
                    STOPSESSION(recActiveSession."Session ID");
                IF (recUser."License  Type" = recUser."License  Type"::"Limited User") AND (intUserCount > recGLSetup."Limited User Nos.") THEN
                    STOPSESSION(recActiveSession."Session ID");
            END;
        END;
        //Iappc - User Mgmt End


        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        SETFILTER("Date Filter", '>=%1', WORKDATE);
    end;
}

