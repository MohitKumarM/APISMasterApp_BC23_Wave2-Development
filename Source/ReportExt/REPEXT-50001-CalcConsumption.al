reportextension 50001 CalcConsumptionExt extends "Calc. Consumption"
{
    dataset
    {
        // Add changes to dataitems and columns here
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