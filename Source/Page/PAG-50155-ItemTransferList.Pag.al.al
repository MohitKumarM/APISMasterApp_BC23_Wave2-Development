page 50155 "Item Transfer List"
{
    Caption = 'Transfer List';
    CardPageID = "Transfer Order";
    Editable = false;
    PageType = List;
    SourceTable = "Transfer Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    var
        DimMgt: Codeunit "DimensionManagement";
}

