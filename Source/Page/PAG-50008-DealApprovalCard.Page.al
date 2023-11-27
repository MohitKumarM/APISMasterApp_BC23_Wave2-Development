page 50008 "Deal Approval Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "Deal Master";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Item Code"; Rec."Item Code")
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
                field("Per Unit Qty. (Kg.)"; Rec."Per Unit Qty. (Kg.)")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Payment Term"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Schedule"; Rec."Dispatch Schedule")
                {
                    ApplicationArea = All;
                }
                field("Freight Liability"; Rec."Freight Liability")
                {
                    ApplicationArea = All;
                }
                field("Quality Instruction 1"; Rec."Quality Instruction 1")
                {
                    ApplicationArea = All;
                }
                field("Quality Instruction 2"; Rec."Quality Instruction 2")
                {
                    ApplicationArea = All;
                }
                field("Quality Instruction 3"; Rec."Quality Instruction 3")
                {
                    ApplicationArea = All;
                }
                field("Quality Instruction 4"; Rec."Quality Instruction 4")
                {
                    ApplicationArea = All;
                }
                field("Quality Instruction 5"; Rec."Quality Instruction 5")
                {
                    ApplicationArea = All;
                }
                field("Quality Instruction 6"; Rec."Quality Instruction 6")
                {
                    ApplicationArea = All;
                }
                field("Special Instruction"; Rec."Special Instruction")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Open THEN
                        EXIT;

                    Rec.TESTFIELD(Date);
                    Rec.TESTFIELD("Purchaser Code");
                    Rec.TESTFIELD(Flora);
                    Rec.TESTFIELD("Packing Type");
                    Rec.TESTFIELD("Deal Qty.");
                    Rec.TESTFIELD("Unit Rate in Kg.");
                    Rec.TESTFIELD("Per Unit Qty. (Kg.)");
                    Rec.TESTFIELD("Item Code");

                    recItem.GET(Rec."Item Code");
                    recProductGroup.GET(recItem."New Product Group Code", recItem."Item Category Code");
                    IF NOT recProductGroup."Allow Direct Purch. Order" THEN
                        ERROR('Selected Item is not allowed in direct purchase order.');

                    IF NOT CONFIRM('Do you want to release the Deal?', FALSE) THEN
                        EXIT;

                    Rec.Status := Rec.Status::Release;
                    Rec.MODIFY;

                    MESSAGE('The Deal is successfully released.');
                    CurrPage.CLOSE;
                end;
            }
            action(Cancel)
            {
                Caption = 'Cancel';
                Image = Close;
                Promoted = true;

                trigger OnAction()
                begin
                    Rec.TestField(Comment);
                    IF NOT CONFIRM('Do you want to close the selected deal?', FALSE) THEN
                        EXIT;

                    Rec.Status := Rec.Status::Close;
                    Rec.MODIFY;

                    CurrPage.UPDATE;
                end;
            }
            action("Submit for Approval")
            {
                Caption = 'Submit for Approval';
                Image = SendTo;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF NOT CONFIRM('Want to submit for Approval?', FALSE) THEN
                        EXIT;

                    Rec.TESTFIELD("No.");
                    Rec.TESTFIELD(Date);
                    Rec.TESTFIELD("Purchaser Code");
                    Rec.TESTFIELD(Flora);
                    Rec.TESTFIELD("Packing Type");
                    Rec.TESTFIELD("Deal Qty.");
                    Rec.TESTFIELD("Unit Rate in Kg.");
                    Rec.TESTFIELD("Per Unit Qty. (Kg.)");

                    Rec."Pending Approval" := TRUE;
                    Rec.MODIFY;

                    CurrPage.CLOSE;
                    CurrPage.RunModal()
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    recDeal: Record "Deal Master";
                begin
                    recDeal.RESET;
                    recDeal.SETRANGE("No.", Rec."No.");
                    recDeal.FINDFIRST;

                    REPORT.RUN(Report::"Deal Print", TRUE, TRUE, recDeal);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF Rec.Status <> Rec.Status::Open THEN
            CurrPage.EDITABLE := FALSE;
    end;

    var
        recItem: Record Item;
        recProductGroup: Record "New Product Group";
}
