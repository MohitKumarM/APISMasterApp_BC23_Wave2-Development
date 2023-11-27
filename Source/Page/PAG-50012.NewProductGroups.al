page 50012 "New Product Groups"
{
    ApplicationArea = All;
    Caption = 'Product Groups';
    SourceTable = "New Product Group";
    UsageCategory = Administration;
    InsertAllowed = true;
    PageType = List;
    ShowFilter = true;
    AutoSplitKey = false;
    DelayedInsert = true;
    LinksAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = true;
    Editable = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Allow Direct Purch. Order"; Rec."Allow Direct Purch. Order")
                {
                    ToolTip = 'Specifies the value of the Allow Direct Purch. Order field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
