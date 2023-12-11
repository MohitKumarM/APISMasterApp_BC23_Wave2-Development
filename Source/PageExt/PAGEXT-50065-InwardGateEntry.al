pageextension 50065 InwardGateEntry extends "Inward Gate Entry"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify("Po&st")
        {
            trigger OnAfterAction()
            var
                GateEntryLine: Record "Gate Entry Line";
                PurchaseHeader: Record "Purchase Header";
            begin
                GateEntryLine.Reset();
                GateEntryLine.SetRange("Entry Type", GateEntryLine."Entry Type"::Inward);
                GateEntryLine.SetRange("Gate Entry No.", Rec."No.");
                GateEntryLine.SetRange("Source Type", GateEntryLine."Source Type"::"Purchase Order");
                if GateEntryLine.FindSet() then
                    repeat
                        if PurchaseHeader.get(GateEntryLine."Source No.") then begin
                            PurchaseHeader."Release Honey PO" := true;
                            PurchaseHeader.Modify();
                        end;
                    until GateEntryLine.Next() = 0;
            end;
        }
    }

    var
        myInt: Integer;
}