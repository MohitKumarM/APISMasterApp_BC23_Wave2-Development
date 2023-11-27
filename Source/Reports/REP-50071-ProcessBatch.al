report 50071 "Process Batch"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ParentCustomer; Customer)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                CustomerLedgerEntry: Record "Cust. Ledger Entry";
            begin
                CustomerLedgerEntry.Reset();
                CustomerLedgerEntry.SetRange("Customer No.", ParentCustomer."No.");
                if CustomerLedgerEntry.FindSet() then
                    repeat
                        CustomerLedgerEntry."Parent Group" := ParentCustomer."Parent Group";
                        CustomerLedgerEntry.Modify();
                    until CustomerLedgerEntry.Next() = 0;

            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Customer No"; CustomerNo)
                    {
                        Visible = false;
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var

    begin
        ParentCustomer.SetFilter("Parent Group", '<>%1', '');
    end;

    var
        CustomerNo: Code[20];
}