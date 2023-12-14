pageextension 50070 "Bank Payment Voucher Ext." extends "Bank Payment Voucher"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                if not confirm('Please Check Employee Posting Group. \n Do you want to continue posting then press yes else press No') then
                    exit;

            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
            begin
                if not confirm('Please Check Employee Posting Group. \n Do you want to continue posting then press yes else press No') then
                    exit;
            end;
        } // Add changes to page actions here
    }

    var
        myInt: Integer;
}