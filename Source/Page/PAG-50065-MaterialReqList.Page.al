page 50065 "Material Req. List"
{
    Caption = 'Material Requisition';
    ApplicationArea = all;
    UsageCategory = Lists;
    CardPageID = "Material Req. Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Material Requisition Header";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field(Date; Rec.Date) { }
                field("Document No."; Rec."Document No.") { }
                field(Status; Rec.Status) { }
            }
        }
    }

    actions { }
}
