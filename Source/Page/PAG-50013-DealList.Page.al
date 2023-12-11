page 50013 "Deal List"
{
    CardPageID = "Deal Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Deal Master";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Open),
                            "Pending Approval" = FILTER(false));

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
                field("Deal Qty."; Rec."Deal Qty.")
                {
                    ApplicationArea = All;
                }
                field("Unit Rate in Kg."; Rec."Unit Rate in Kg.")
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

                trigger OnAction()
                begin
                    recSalesSetup.GET;
                    recSalesSetup.TESTFIELD("Sauda Nos.");

                    recSauda.INIT;
                    cdSaudaCode := cuNoSeries.GetNextNo(recSalesSetup."Sauda Nos.", TODAY, TRUE);
                    recSauda."No." := cdSaudaCode;
                    recSauda.Date := TODAY;
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

    var
        recSalesSetup: Record "Sales & Receivables Setup";
        recSauda: Record "Deal Master";
        cdSaudaCode: Code[20];
        cuNoSeries: Codeunit NoSeriesManagement;
        pgSaudaCard: Page "Deal Card";
}
