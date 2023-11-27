pageextension 50032 "RequestToApprove" extends "Requests to Approve"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Approve)
        {
            trigger OnBeforeAction()
            begin
                //  Message('Test');
            end;
        }
    }
}