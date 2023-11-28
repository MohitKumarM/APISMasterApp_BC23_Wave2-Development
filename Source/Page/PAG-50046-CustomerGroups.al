page 50046 "Customer Groups"
{
    PageType = List;
    Caption = 'Customer Groups';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer Group Master";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowAsTree = true;
                IndentationColumn = Indenation;
                IndentationControls = "Parent Group";
                field("Parent Group"; ParentGroup)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    HideValue = IndentationHideValue;
                }
                field("No."; No)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = StyleExperssion;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = StyleExperssion;
                }
                field("Balance LCY"; Balance)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = StyleExperssion;
                }
            }
        }
        area(Factboxes) { }
    }
    actions
    {
        area(Processing)
        {
            action("Ledger E&ntries")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                Caption = 'Ledger E&ntries';
                Enabled = LedgerEntries;
                Image = CustomerLedger;
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Customer No." = field(Code);
                RunPageView = sorting("Customer No.")
                                  order(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
            action("Parent Ledger E&ntries")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                Enabled = ParentLedgerEntries;
                Caption = 'Parent Ledger E&ntries';
                Image = CustomerLedger;
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Parent Group" = field("Parent Group");
                RunPageView = sorting("Customer No.")
                                  order(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
        }
    }

    var
        ParentGroup: Code[20];
        Indenation: Integer;
        i: Integer;
        Name: Text;
        No: Code[20];
        Balance: Decimal;
        PrenGrp: Code[20];
        IndentationHideValue: Boolean;
        EntryNo: Integer;
        StyleExperssion: Boolean;
        L_CustomerGrpMaster: Record "Customer Group Master";
        ParentLedgerEntries: Boolean;
        LedgerEntries: Boolean;

    trigger OnAfterGetRecord()
    begin

        ParentGroup := rec."Parent Group";
        Indenation := rec.Indentation;
        No := rec.Code;
        Name := Rec.Name;
        Balance := Rec."Balance LCY";
        if rec.Indentation = 0 then begin
            IndentationHideValue := false;
            StyleExperssion := true;
            ParentLedgerEntries := true;
            LedgerEntries := false;
        end else begin
            IndentationHideValue := true;
            StyleExperssion := false;
            ParentLedgerEntries := false;
            LedgerEntries := true;
        end;
    end;

    trigger OnOpenPage()
    var
        Rec_Customer: Record Customer;
        Customer2: Record Customer;
        CustomerGroupMaster: Record "Customer Group Master";
        CustomerGroupMaster2: Record "Customer Group Master";
        Rec_Customer2: Record Customer;
        TotalGroupBalance: Decimal;
    begin
        L_CustomerGrpMaster.Reset();
        L_CustomerGrpMaster.DeleteAll();
        EntryNo := 0;
        Rec_Customer.SetCurrentKey("Parent Group");
        Rec_Customer.SetFilter("Parent Group", '<>%1', '');
        Rec_Customer.SetAutoCalcFields("Balance (LCY)");
        if Rec_Customer.FindSet() then
            i += 0;
        repeat
            if Rec_Customer."Parent Group" <> PrenGrp then
                i := 0;
            if Rec_Customer."Parent Group" <> PrenGrp then begin
                TotalGroupBalance := 0;
                Rec_Customer2.Reset();
                Rec_Customer2.SetRange("Parent Group", Rec_Customer."Parent Group");
                Rec_Customer2.SetAutoCalcFields("Balance (LCY)");
                if Rec_Customer2.FindSet() then
                    repeat
                        TotalGroupBalance += Rec_Customer2."Balance (LCY)";
                    until Rec_Customer2.Next() = 0;
                EntryNo += 1;
                CustomerGroupMaster.Init();
                CustomerGroupMaster."Entry No." := EntryNo;
                CustomerGroupMaster.Code := Rec_Customer."Parent Group";
                CustomerGroupMaster."Parent Group" := Rec_Customer."Parent Group";
                CustomerGroupMaster."Balance LCY" := TotalGroupBalance;
                if Customer2.get(Rec_Customer."Parent Group") then
                    CustomerGroupMaster.Name := Customer2.Name;
                CustomerGroupMaster.Indentation := 0;
                CustomerGroupMaster.Insert();
                i := 1;
            end;
            if CustomerGroupMaster2.FindLast() then
                EntryNo := EntryNo + 1
            else
                EntryNo := 1;
            // if Rec_Customer."Parent Group" <> Rec_Customer."No." then begin
            Rec.Init();
            rec."Entry No." := EntryNo;
            Rec.Code := Rec_Customer."No.";
            rec."Parent Group" := Rec_Customer."Parent Group";
            Rec.Name := Rec_Customer.Name;
            Rec."Balance LCY" := Rec_Customer."Balance (LCY)";
            rec.Indentation := i;
            i := 1;
            rec.Insert();
            PrenGrp := Rec_Customer."Parent Group";
        // end;
        until Rec_Customer.Next() = 0;
    end;

    trigger OnClosePage()
    var
    begin
        L_CustomerGrpMaster.Reset();
        L_CustomerGrpMaster.DeleteAll();
    end;
}