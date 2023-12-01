reportextension 50001 CalcConsumptionExt extends "Calc. Consumption"
{
    dataset
    {
        modify("Production Order")
        {
            trigger OnBeforePreDataItem()
            begin
                IF cdOrderNo <> '' THEN
                    "Production Order".SETRANGE("No.", cdOrderNo);
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    var
        cdOrderNo: Code[20];
        CalcBasedOn1: Option "Actual Output","Expected Output";

    procedure SetOrderNo(InputOrderNo: Code[20]; InputCalcBasedOn: Option "Actual Output","Expected Output")
    begin
        cdOrderNo := InputOrderNo;
        CalcBasedOn1 := InputCalcBasedOn;
    end;
}