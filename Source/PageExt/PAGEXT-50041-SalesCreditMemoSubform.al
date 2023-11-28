pageextension 50041 SalesCreditMemoSUbform extends "Sales Cr. Memo Subform"
{
    layout
    {
        modify("TCS Nature of Collection")
        {
            Visible = false;
        }
        addbefore("TCS Nature of Collection")
        {
            field("TCS Nature Of Collection 2"; Rec."TCS Nature Of Collection 2")
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                var
                    LCustomer: Record Customer;
                begin
                    Clear(rec."TCS Nature of Collection");
                    Clear(rec."TCS Nature of Collection 2");
                    if LCustomer.get(Rec."Sell-to Customer No.") then
                        if not LCustomer."Skip Tcs" then begin
                            Rec.AllowedNocLookup(Rec, Rec."Sell-to Customer No.");
                            Rec."TCS Nature of Collection 2" := Rec."TCS Nature of Collection";
                            UpdateTaxAmount();
                        end else begin
                            UpdateTaxAmount();
                            Message('SKIP TCS feature is Enabled');
                        end;
                end;

                trigger OnValidate()
                var
                    LCustomer: Record Customer;
                    AllowedNOC: Record "Allowed NOC";
                    TCSNatureOfCollection: Record "TCS Nature Of Collection";
                    NOCTypeErr: Label '%1 does not exist in table %2.', Comment = '%1=TCS Nature of Collection., %2=The Table Name.';
                    NOCNotDefinedErr: Label 'TCS Nature of Collection %1 is not defined for Customer no. %2.', Comment = '%1= TCS Nature of Collection, %2=Customer No.';
                begin
                    Rec."TCS Nature of Collection" := rec."TCS Nature of Collection 2";
                    UpdateTaxAmount();
                    if Rec."TCS Nature of Collection 2" = '' then
                        exit;
                    if not TCSNatureOfCollection.Get(Rec."TCS Nature of Collection 2") then
                        Error(NOCTypeErr, Rec."TCS Nature of Collection 2", TCSNatureOfCollection.TableCaption());

                    if not AllowedNOC.Get(Rec."Bill-to Customer No.", Rec."TCS Nature of Collection 2") then
                        Error(NOCNotDefinedErr, Rec."TCS Nature of Collection 2", Rec."Bill-to Customer No.");
                    if LCustomer.get(Rec."Sell-to Customer No.") then
                        if LCustomer."Skip Tcs" then begin
                            Clear(rec."TCS Nature of Collection");
                            Clear(rec."TCS Nature of Collection 2");
                            UpdateTaxAmount();
                            Message('SKIP TCS feature is Enabled');
                        end;
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    local procedure UpdateTaxAmount()
    var
        CalculateTax: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTax.CallTaxEngineOnSalesLine(Rec, xRec);
    end;
}