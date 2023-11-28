page 50034 "Purchase Que"
{
    PageType = List;
    SourceTable = "Purchase Cue";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Not Invoiced"; Rec."Not Invoiced")
                {
                    ToolTip = 'Specifies received orders that are not invoiced. The orders are displayed in the Purchase Cue on the Purchasing Agent role center, and filtered by today''s date.';
                }
                field("Outstanding Purchase Orders"; Rec."Outstanding Purchase Orders")
                {
                    ToolTip = 'Specifies the number of outstanding purchase orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Partially Invoiced"; Rec."Partially Invoiced")
                {
                    ToolTip = 'Specifies the number of partially invoiced orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Pending Inward Quality"; Rec."Pending Inward Quality")
                {
                    ToolTip = 'Specifies the value of the Pending Inward Quality field.';
                }
                field("Pending Output QC"; Rec."Pending Output QC")
                {
                    ToolTip = 'Specifies the value of the Pending Output QC field.';
                }
                field("Posted QC"; Rec."Posted QC")
                {
                    ToolTip = 'Specifies the value of the Posted QC field.';
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                }
                field("Purchase Return Orders - All"; Rec."Purchase Return Orders - All")
                {
                    ToolTip = 'Specifies the number of purchase return orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Quality to Approve"; Rec."Quality to Approve")
                {
                    ToolTip = 'Specifies the value of the Quality to Approve field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("To Send or Confirm"; Rec."To Send or Confirm")
                {
                    ToolTip = 'Specifies the number of documents to send or confirm that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
                field("Upcoming Orders"; Rec."Upcoming Orders")
                {
                    ToolTip = 'Specifies the number of upcoming orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                }
            }
        }
        area(Factboxes) { }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}