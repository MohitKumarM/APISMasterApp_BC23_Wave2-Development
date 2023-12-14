page 50152 "Production BOM  List"
{
    Caption = 'Production BOM List';
    CardPageID = "Production BOM Management";
    Editable = false;
    PageType = List;
    SourceTable = "Production BOM Header";
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
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
}

