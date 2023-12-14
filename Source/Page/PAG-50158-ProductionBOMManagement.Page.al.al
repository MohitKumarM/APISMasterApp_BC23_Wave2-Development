page 50158 "Production BOM Management"
{
    // <changelog>
    //     <change releaseversion="IN6.00"/>
    // </changelog>

    Caption = 'Production BOM';
    PageType = ListPlus;
    SourceTable = "Production BOM Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Search Name"; Rec."Search Name")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
            }
            part(ProdBOMLine; 99000788)
            {
                SubPageLink = "Production BOM No." = FIELD("No."),
                              "Version Code" = CONST();
                SubPageView = SORTING("Production BOM No.", "Version Code", "Line No.");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ActiveVersionCode := VersionMgt.GetBOMVersion(Rec."No.", WORKDATE, TRUE);
    end;

    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
        ProductionBOMCopy: Codeunit "Production BOM-Copy";
        VersionMgt: Codeunit "VersionManagement";
        ActiveVersionCode: Code[20];
}

