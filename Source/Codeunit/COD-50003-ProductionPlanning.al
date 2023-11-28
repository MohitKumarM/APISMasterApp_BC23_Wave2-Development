codeunit 50003 "Production Planning"
{
    trigger OnRun()
    begin
    end;

    procedure CalculateRequirement(FromDate: Date; ToDate: Date)
    var
        recSalesHeader: Record "Sales Header";
        recSalesLine: Record "Sales Line";
        recPlanningLines: Record "Item Budget Entry";
        intEntryNo: Integer;
        cdOldItem: Code[20];
        decStockInHand: Decimal;
        recItem: Record "Item";
        recPlanningLinesSource: Record "Item Budget Entry";
    begin
        recPlanningLines.RESET;
        recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
        recPlanningLines.SETRANGE("Budget Name", '');
        IF recPlanningLines.FINDFIRST THEN
            recPlanningLines.DELETEALL;

        recPlanningLines.RESET;
        IF recPlanningLines.FINDLAST THEN
            intEntryNo := recPlanningLines."Entry No."
        ELSE
            intEntryNo := 0;

        recSalesHeader.RESET;
        recSalesHeader.SETRANGE("Document Type", recSalesHeader."Document Type"::Order);
        recSalesHeader.SETRANGE("Order Date", 0D, ToDate);
        IF recSalesHeader.FINDFIRST THEN
            REPEAT
                recSalesLine.RESET;
                recSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
                recSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
                recSalesLine.SETRANGE(Type, recSalesLine.Type::Item);
                recSalesLine.SETFILTER("No.", '<>%1', '');
                recSalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
                IF recSalesLine.FINDFIRST THEN
                    REPEAT
                        recPlanningLines.RESET;
                        recPlanningLines.SETRANGE("Budget Name", '');
                        recPlanningLines.SETRANGE(Date, ToDate);
                        recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
                        recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::Customer);
                        recPlanningLines.SETRANGE("Source No.", recSalesHeader."Sell-to Customer No.");
                        recPlanningLines.SETRANGE("Item No.", recSalesLine."No.");
                        IF recPlanningLines.FINDFIRST THEN BEGIN
                            recPlanningLines.Quantity += recSalesLine."Outstanding Quantity";
                            recPlanningLines."Order Quantity" += recSalesLine."Outstanding Quantity";
                            recPlanningLines.MODIFY;
                        END ELSE BEGIN
                            recPlanningLines.INIT;
                            intEntryNo += 1;
                            recPlanningLines."Entry No." := intEntryNo;
                            recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Sales;
                            recPlanningLines."Budget Name" := '';
                            recPlanningLines.Date := ToDate;
                            recPlanningLines."Source Type" := recPlanningLines."Source Type"::Customer;
                            recPlanningLines.VALIDATE("Source No.", recSalesHeader."Sell-to Customer No.");
                            recPlanningLines.VALIDATE("Item No.", recSalesLine."No.");
                            recPlanningLines.Quantity := recSalesLine."Outstanding Quantity";
                            recPlanningLines."Order Quantity" := recSalesLine."Outstanding Quantity";
                            recPlanningLines."Calculation Date" := TODAY;
                            recPlanningLines.INSERT;
                        END;
                    UNTIL recSalesLine.NEXT = 0;
            UNTIL recSalesHeader.NEXT = 0;

        recPlanningLinesSource.RESET;
        recPlanningLinesSource.SETRANGE("Analysis Area", recPlanningLinesSource."Analysis Area"::Sales);
        recPlanningLinesSource.SETFILTER("Budget Name", '<>%1', '');
        recPlanningLinesSource.SETRANGE(Date, FromDate, ToDate);
        IF recPlanningLinesSource.FINDFIRST THEN
            REPEAT
                recSalesHeader.RESET;
                recSalesHeader.SETRANGE("Document Type", recSalesHeader."Document Type"::Order);
                recSalesHeader.SETRANGE("Order Date", FromDate, ToDate);
                recSalesHeader.SETRANGE("Sell-to Customer No.", recPlanningLinesSource."Source No.");
                IF recSalesHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        recSalesLine.RESET;
                        recSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
                        recSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
                        recSalesLine.SETRANGE(Type, recSalesLine.Type::Item);
                        recSalesLine.SETRANGE("No.", recPlanningLinesSource."Item No.");
                        IF NOT recSalesLine.FINDFIRST THEN BEGIN
                            recPlanningLines.RESET;
                            recPlanningLines.SETRANGE("Budget Name", '');
                            recPlanningLines.SETRANGE(Date, ToDate);
                            recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
                            recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::Customer);
                            recPlanningLines.SETRANGE("Source No.", recPlanningLinesSource."Source No.");
                            recPlanningLines.SETRANGE("Item No.", recPlanningLinesSource."Item No.");
                            IF recPlanningLines.FINDFIRST THEN BEGIN
                                recPlanningLines.Quantity += recPlanningLinesSource.Quantity;
                                recPlanningLines.MODIFY;
                            END ELSE BEGIN
                                recPlanningLines.INIT;
                                intEntryNo += 1;
                                recPlanningLines."Entry No." := intEntryNo;
                                recPlanningLines."Budget Name" := '';
                                recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Sales;
                                recPlanningLines.Date := ToDate;
                                recPlanningLines."Source Type" := recPlanningLines."Source Type"::Customer;
                                recPlanningLines.VALIDATE("Source No.", recPlanningLinesSource."Source No.");
                                recPlanningLines.VALIDATE("Item No.", recPlanningLinesSource."Item No.");
                                recPlanningLines.Quantity := recPlanningLinesSource.Quantity;
                                recPlanningLines."Calculation Date" := TODAY;
                                recPlanningLines.INSERT;
                            END;
                        END;
                    UNTIL recSalesHeader.NEXT = 0;
                END ELSE BEGIN
                    recPlanningLines.RESET;
                    recPlanningLines.SETRANGE("Budget Name", '');
                    recPlanningLines.SETRANGE(Date, ToDate);
                    recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
                    recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::Customer);
                    recPlanningLines.SETRANGE("Source No.", recPlanningLinesSource."Source No.");
                    recPlanningLines.SETRANGE("Item No.", recPlanningLinesSource."Item No.");
                    IF recPlanningLines.FINDFIRST THEN BEGIN
                        recPlanningLines.Quantity += recPlanningLinesSource.Quantity;
                        recPlanningLines.MODIFY;
                    END ELSE BEGIN
                        recPlanningLines.INIT;
                        intEntryNo += 1;
                        recPlanningLines."Entry No." := intEntryNo;
                        recPlanningLines."Budget Name" := '';
                        recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Sales;
                        recPlanningLines.Date := ToDate;
                        recPlanningLines."Source Type" := recPlanningLines."Source Type"::Customer;
                        recPlanningLines.VALIDATE("Source No.", recPlanningLinesSource."Source No.");
                        recPlanningLines.VALIDATE("Item No.", recPlanningLinesSource."Item No.");
                        recPlanningLines.Quantity := recPlanningLinesSource.Quantity;
                        recPlanningLines."Calculation Date" := TODAY;
                        recPlanningLines.INSERT;
                    END;
                END;
            UNTIL recPlanningLinesSource.NEXT = 0;

        cdOldItem := '';
        recPlanningLines.RESET;
        recPlanningLines.SETCURRENTKEY("Analysis Area", "Budget Name", "Item No.", Date);
        recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
        recPlanningLines.SETRANGE("Budget Name", '');
        recPlanningLines.SETRANGE(Date, ToDate);
        IF recPlanningLines.FINDFIRST THEN
            REPEAT
                IF cdOldItem <> recPlanningLines."Item No." THEN BEGIN
                    recItem.RESET;
                    recItem.SETRANGE("No.", recPlanningLines."Item No.");
                    recItem.FINDFIRST;
                    recItem.CALCFIELDS(Inventory, recItem."Qty. on Prod. Order");

                    decStockInHand := recItem."Qty. on Prod. Order" + recItem.Inventory;
                END;

                IF decStockInHand <> 0 THEN BEGIN
                    IF recPlanningLines.Quantity > decStockInHand THEN BEGIN
                        recPlanningLines."Stock Adjusted" := decStockInHand;
                        recPlanningLines."Remaining Qty. to Produce" := recPlanningLines.Quantity - recPlanningLines."Stock Adjusted";
                        recPlanningLines.MODIFY;
                        decStockInHand := 0;
                    END ELSE BEGIN
                        recPlanningLines."Stock Adjusted" := recPlanningLines.Quantity;
                        recPlanningLines."Remaining Qty. to Produce" := 0;
                        recPlanningLines.MODIFY;
                        decStockInHand := decStockInHand - recPlanningLines.Quantity;
                    END;
                END ELSE BEGIN
                    recPlanningLines."Remaining Qty. to Produce" := recPlanningLines.Quantity;
                    recPlanningLines.MODIFY;
                END;

                cdOldItem := recPlanningLines."Item No.";
            UNTIL recPlanningLines.NEXT = 0;
    end;

    procedure CalculateProcurement(FromDate: Date; ToDate: Date)
    var
        recPlanningLines: Record "Item Budget Entry";
        intEntryNo: Integer;
        recSalesHeader: Record "Sales Header";
        recSalesLine: Record "Sales Line";
        recPlanningLinesSource: Record "Item Budget Entry";
        recItem: Record "Item";
        recProdBOMLines: Record "Production BOM Line";
    begin
        recPlanningLines.RESET;
        recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Purchase);
        recPlanningLines.SETRANGE("Budget Name", '');
        IF recPlanningLines.FINDFIRST THEN
            recPlanningLines.DELETEALL;

        recPlanningLines.RESET;
        IF recPlanningLines.FINDLAST THEN
            intEntryNo := recPlanningLines."Entry No."
        ELSE
            intEntryNo := 0;

        recSalesHeader.RESET;
        recSalesHeader.SETRANGE("Document Type", recSalesHeader."Document Type"::Order);
        recSalesHeader.SETRANGE("Order Date", 0D, ToDate);
        IF recSalesHeader.FINDFIRST THEN
            REPEAT
                recSalesLine.RESET;
                recSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
                recSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
                recSalesLine.SETRANGE(Type, recSalesLine.Type::Item);
                recSalesLine.SETFILTER("No.", '<>%1', '');
                recSalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
                IF recSalesLine.FINDFIRST THEN
                    REPEAT
                        recItem.GET(recSalesLine."No.");
                        IF recItem."Production BOM No." <> '' THEN BEGIN
                            recProdBOMLines.RESET;
                            recProdBOMLines.SETRANGE("Production BOM No.", recItem."Production BOM No.");
                            recProdBOMLines.SETRANGE(Type, recProdBOMLines.Type::Item);
                            recProdBOMLines.SETFILTER("No.", '<>%1', '');
                            IF recProdBOMLines.FINDFIRST THEN
                                REPEAT
                                    recPlanningLines.RESET;
                                    recPlanningLines.SETRANGE("Budget Name", '');
                                    recPlanningLines.SETRANGE(Date, ToDate);
                                    recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Purchase);
                                    recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::" ");
                                    recPlanningLines.SETRANGE("Source No.", '');
                                    recPlanningLines.SETRANGE("Item No.", recProdBOMLines."No.");
                                    IF recPlanningLines.FINDFIRST THEN BEGIN
                                        recPlanningLines.Quantity += recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                        recPlanningLines."Order Quantity" += recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                        recPlanningLines.MODIFY;
                                    END ELSE BEGIN
                                        recPlanningLines.INIT;
                                        intEntryNo += 1;
                                        recPlanningLines."Entry No." := intEntryNo;
                                        recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Purchase;
                                        recPlanningLines."Budget Name" := '';
                                        recPlanningLines.Date := ToDate;
                                        recPlanningLines."Source Type" := recPlanningLines."Source Type"::" ";
                                        recPlanningLines.VALIDATE("Source No.", '');
                                        recPlanningLines.VALIDATE("Item No.", recProdBOMLines."No.");
                                        recPlanningLines.Quantity := recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                        recPlanningLines."Order Quantity" := recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                        recPlanningLines."Calculation Date" := TODAY;
                                        recPlanningLines.INSERT;
                                    END;
                                UNTIL recProdBOMLines.NEXT = 0;
                        END;
                    UNTIL recSalesLine.NEXT = 0;
            UNTIL recSalesHeader.NEXT = 0;

        recPlanningLinesSource.RESET;
        recPlanningLinesSource.SETRANGE("Analysis Area", recPlanningLinesSource."Analysis Area"::Sales);
        recPlanningLinesSource.SETFILTER("Budget Name", '<>%1', '');
        recPlanningLinesSource.SETRANGE(Date, FromDate, ToDate);
        IF recPlanningLinesSource.FINDFIRST THEN
            REPEAT
                recItem.GET(recPlanningLinesSource."Item No.");
                IF recItem."Production BOM No." <> '' THEN BEGIN
                    recProdBOMLines.RESET;
                    recProdBOMLines.SETRANGE("Production BOM No.", recItem."Production BOM No.");
                    recProdBOMLines.SETRANGE(Type, recProdBOMLines.Type::Item);
                    recProdBOMLines.SETFILTER("No.", '<>%1', '');
                    IF recProdBOMLines.FINDFIRST THEN
                        REPEAT
                            recPlanningLines.RESET;
                            recPlanningLines.SETRANGE("Budget Name", '');
                            recPlanningLines.SETRANGE(Date, ToDate);
                            recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Purchase);
                            recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::" ");
                            recPlanningLines.SETRANGE("Source No.", '');
                            recPlanningLines.SETRANGE("Item No.", recProdBOMLines."No.");
                            IF recPlanningLines.FINDFIRST THEN BEGIN
                                recPlanningLines.Quantity += recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                recPlanningLines."Order Quantity" += recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                recPlanningLines.MODIFY;
                            END ELSE BEGIN
                                recPlanningLines.INIT;
                                intEntryNo += 1;
                                recPlanningLines."Entry No." := intEntryNo;
                                recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Purchase;
                                recPlanningLines."Budget Name" := '';
                                recPlanningLines.Date := ToDate;
                                recPlanningLines."Source Type" := recPlanningLines."Source Type"::" ";
                                recPlanningLines.VALIDATE("Source No.", '');
                                recPlanningLines.VALIDATE("Item No.", recProdBOMLines."No.");
                                recPlanningLines.Quantity := recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                recPlanningLines."Order Quantity" := recSalesLine."Outstanding Quantity" * recProdBOMLines.Quantity;
                                recPlanningLines."Calculation Date" := TODAY;
                                recPlanningLines.INSERT;
                            END;
                        UNTIL recProdBOMLines.NEXT = 0;
                END;

            /*
              recSalesHeader.RESET;
              recSalesHeader.SETRANGE("Document Type", recSalesHeader."Document Type"::Order);
              recSalesHeader.SETRANGE("Order Date", FromDate, ToDate);
              recSalesHeader.SETRANGE("Sell-to Customer No.", recPlanningLinesSource."Source No.");
              IF recSalesHeader.FINDFIRST THEN BEGIN
                REPEAT
                  recSalesLine.RESET;
                  recSalesLine.SETRANGE("Document Type", recSalesHeader."Document Type");
                  recSalesLine.SETRANGE("Document No.", recSalesHeader."No.");
                  recSalesLine.SETRANGE(Type, recSalesLine.Type::Item);
                  recSalesLine.SETRANGE("No.", recPlanningLinesSource."Item No.");
                  IF NOT recSalesLine.FINDFIRST THEN BEGIN
                    recPlanningLines.RESET;
                    recPlanningLines.SETRANGE("Budget Name", '');
                    recPlanningLines.SETRANGE(Date, ToDate);
                    recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
                    recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::Customer);
                    recPlanningLines.SETRANGE("Source No.", recPlanningLinesSource."Source No.");
                    recPlanningLines.SETRANGE("Item No.", recPlanningLinesSource."Item No.");
                    IF recPlanningLines.FINDFIRST THEN BEGIN
                      recPlanningLines.Quantity += recPlanningLinesSource.Quantity;
                      recPlanningLines.MODIFY;
                    END ELSE BEGIN
                      recPlanningLines.INIT;
                      intEntryNo += 1;
                      recPlanningLines."Entry No." := intEntryNo;
                      recPlanningLines."Budget Name" := '';
                      recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Sales;
                      recPlanningLines.Date := ToDate;
                      recPlanningLines."Source Type" := recPlanningLines."Source Type"::Customer;
                      recPlanningLines.VALIDATE("Source No.", recPlanningLinesSource."Source No.");
                      recPlanningLines.VALIDATE("Item No.", recPlanningLinesSource."Item No.");
                      recPlanningLines.Quantity := recPlanningLinesSource.Quantity;
                      recPlanningLines."Calculation Date" := TODAY;
                      recPlanningLines.INSERT;
                    END;
                  END;
                UNTIL recSalesHeader.NEXT = 0;
              END ELSE BEGIN
                recPlanningLines.RESET;
                recPlanningLines.SETRANGE("Budget Name", '');
                recPlanningLines.SETRANGE(Date, ToDate);
                recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Sales);
                recPlanningLines.SETRANGE("Source Type", recPlanningLines."Source Type"::Customer);
                recPlanningLines.SETRANGE("Source No.", recPlanningLinesSource."Source No.");
                recPlanningLines.SETRANGE("Item No.", recPlanningLinesSource."Item No.");
                IF recPlanningLines.FINDFIRST THEN BEGIN
                  recPlanningLines.Quantity += recPlanningLinesSource.Quantity;
                  recPlanningLines.MODIFY;
                END ELSE BEGIN
                  recPlanningLines.INIT;
                  intEntryNo += 1;
                  recPlanningLines."Entry No." := intEntryNo;
                  recPlanningLines."Budget Name" := '';
                  recPlanningLines."Analysis Area" := recPlanningLines."Analysis Area"::Sales;
                  recPlanningLines.Date := ToDate;
                  recPlanningLines."Source Type" := recPlanningLines."Source Type"::Customer;
                  recPlanningLines.VALIDATE("Source No.", recPlanningLinesSource."Source No.");
                  recPlanningLines.VALIDATE("Item No.", recPlanningLinesSource."Item No.");
                  recPlanningLines.Quantity := recPlanningLinesSource.Quantity;
                  recPlanningLines."Calculation Date" := TODAY;
                  recPlanningLines.INSERT;
                END;
              END;
            */
            UNTIL recPlanningLinesSource.NEXT = 0;

        recPlanningLines.RESET;
        recPlanningLines.SETCURRENTKEY("Analysis Area", "Budget Name", "Item No.", Date);
        recPlanningLines.SETRANGE("Analysis Area", recPlanningLines."Analysis Area"::Purchase);
        recPlanningLines.SETRANGE("Budget Name", '');
        recPlanningLines.SETRANGE(Date, ToDate);
        IF recPlanningLines.FINDFIRST THEN
            REPEAT
                recItem.RESET;
                recItem.SETRANGE("No.", recPlanningLines."Item No.");
                recItem.FINDFIRST;
                recItem.CALCFIELDS(Inventory, recItem."Qty. on Prod. Order");

                recPlanningLines."Stock Adjusted" := recItem.Inventory + recItem."Qty. on Purch. Order";
                recPlanningLines."Remaining Qty. to Produce" := recPlanningLines.Quantity - recPlanningLines."Stock Adjusted";
                recPlanningLines.MODIFY;
            UNTIL recPlanningLines.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"System Action Triggers", 'GetNotificationStatus', '', true, false)]
    procedure GetNotificationStatus(NotificationId: Guid; var IsEnabled: Boolean)
    begin
        WorkDate(Today);
    end;
}
