pageextension 50033 "Sales Order Subform" extends "Sales Order Subform"
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
        addafter("&Line")
        {
            action("Packing List")
            {
                Image = PickLines;
                ApplicationArea = All;
                trigger OnAction()
                var
                    recItem: Record Item;
                    recPackingList: Record "Pre Packing List";
                    pgBulkPackingList: Page "Drum Packing List";
                    pgSmallPackingList: Page "Bottling Packing List";
                begin
                    Rec.TESTFIELD(Type, Type::Item);
                    Rec.TESTFIELD("No.");
                    recItem.GET(Rec."No.");
                    recPackingList.RESET;
                    recPackingList.SETRANGE("Order No.", Rec."Document No.");
                    recPackingList.SETRANGE("Order Line No.", Rec."Line No.");
                    recPackingList.SETRANGE("Item Code", Rec."No.");
                    if recItem."Item Type" = recItem."Item Type"::Bulk then begin
                        CLEAR(pgBulkPackingList);
                        pgBulkPackingList.SETTABLEVIEW(recPackingList);
                        pgBulkPackingList.RUN;
                    end else begin
                        CLEAR(pgSmallPackingList);
                        pgSmallPackingList.SETTABLEVIEW(recPackingList);
                        pgSmallPackingList.RUN;
                    end;
                end;
            }
        }
    }
    local procedure UpdateTaxAmount()
    var
        CalculateTax: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTax.CallTaxEngineOnSalesLine(Rec, xRec);
    end;
}