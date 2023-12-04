reportextension 50002 RefreshProdOrderExt extends "Refresh Production Order"
{
    dataset
    {
        modify("Production Order")
        {
            trigger OnAfterAfterGetRecord()
            var
                Location_Loc1: Record Location;
                Location_Loc2: Record Location;
            begin

                "Production Order".TestField("Location Code");

                "Production Order".Refreshed := TRUE;
                "Production Order".MODIFY;

                recProdOrderLine.RESET;
                recProdOrderLine.SETRANGE(Status, "Production Order".Status);
                recProdOrderLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
                IF recProdOrderLine.FINDFIRST THEN BEGIN
                    recProdOrderLine.MODIFYALL("Planning Date", "Production Order"."Planning Date");
                    recProdOrderLine.MODIFYALL("Planning Entry No.", "Production Order"."Planning Entry No.");
                END;

                // recUserSetup.GET(USERID);
                // recUserSetup.TESTFIELD("Default Store Location");
                // recProdOrderComponent.RESET;
                // recProdOrderComponent.SETRANGE(Status, "Production Order".Status);
                // recProdOrderComponent.SETRANGE("Prod. Order No.", "Production Order"."No.");
                // IF recProdOrderComponent.FINDFIRST THEN
                //     recProdOrderComponent.MODIFYALL("Location Code", recUserSetup."Default Store Location");

                recProdOrderComponent.Reset();
                recProdOrderComponent.SetRange(Status, "Production Order".Status);
                recProdOrderComponent.SetRange("Prod. Order No.", "Production Order"."No.");
                IF recProdOrderComponent.FindSet() then begin
                    if Location_Loc1.Get("Location Code") then begin
                        Location_Loc2.Reset();
                        Location_Loc2.SetRange("Associated Plant", Location_Loc1."Associated Plant");
                        Location_Loc2.SetRange("Store Location", true);
                        if not Location_Loc2.FindFirst() then begin
                            Location_Loc2.SetRange("Associated Plant");
                        end;
                        IF Location_Loc2.FindFirst() then
                            recProdOrderComponent.ModifyAll("Location Code", Location_Loc2.Code);
                    end;
                end;
            end;
        }
        // Add changes to dataitems and columns here
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        recProdOrderLine: Record "Prod. Order Line";
        recUserSetup: Record "User Setup";
        recProdOrderComponent: Record "Prod. Order Component";
}