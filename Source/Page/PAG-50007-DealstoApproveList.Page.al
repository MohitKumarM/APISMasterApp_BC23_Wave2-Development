page 50007 "Deals to Approve List"
{
    Caption = 'Deals Apporve';
    CardPageID = "Deal Approval Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Deal Master";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Open),
                            "Pending Approval" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Name"; Rec."Purchaser Name")
                {
                    ApplicationArea = All;
                }
                field(Flora; Rec.Flora)
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Deal Qty."; Rec."Deal Qty.")
                {
                    ApplicationArea = All;
                }
                field("Unit Rate in Kg."; Rec."Unit Rate in Kg.")
                {
                    ApplicationArea = All;
                }
                field("Discount Rate in Kg."; Rec."Discount Rate in Kg.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(New)
            {
                Caption = 'New';
                Image = Document;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    recSalesSetup.GET;
                    recSalesSetup.TESTFIELD("Sauda Nos.");

                    recSauda.INIT;
                    cdSaudaCode := cuNoSeries.GetNextNo(recSalesSetup."Sauda Nos.", TODAY, TRUE);
                    recSauda."No." := cdSaudaCode;
                    recSauda.Date := TODAY;
                    recSauda."Pending Approval" := TRUE;
                    recSauda.INSERT;

                    recSauda.RESET;
                    recSauda.SETRANGE("No.", cdSaudaCode);

                    CLEAR(pgSaudaCard);
                    pgSaudaCard.SETTABLEVIEW(recSauda);
                    pgSaudaCard.RUN;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        recUserSetup.GET(USERID);
        IF NOT recUserSetup."Allow Deal Approval" THEN
            ERROR('You are not authorized for deal approval, contact your system administrator.');
        Rec.FILTERGROUP(2);
        Rec.SetRange("Approver ID", UserId);
        Rec.FILTERGROUP(0);
    end;

    var
        recSalesSetup: Record "Sales & Receivables Setup";
        recSauda: Record "Deal Master";
        cdSaudaCode: Code[20];
        cuNoSeries: Codeunit NoSeriesManagement;
        pgSaudaCard: Page "Deal Approval Card";
        recUserSetup: Record "User Setup";
}
