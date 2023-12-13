page 50054 "Item Trial"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = Item;
    ApplicationArea = ALL;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                grid(Lines)
                {
                    GridLayout = Rows;

                    group("1")
                    {
                        ShowCaption = false;
                        field(dtFromDate; dtFromDate)
                        {
                            Caption = 'From Date Filter';

                            trigger OnValidate()
                            var
                            begin
                                UpdateValues();
                            end;
                        }
                        field(dtToDate; dtToDate)
                        {
                            Caption = 'To Date Filter';

                            trigger OnValidate()
                            begin
                                UpdateValues;
                            end;
                        }
                    }
                    group("2")
                    {
                        ShowCaption = false;
                        field(cdGlobal1Filter; cdGlobal1Filter)
                        {
                            CaptionClass = '1,3,1';
                            Caption = 'Global 1 Filter';
                            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

                            trigger OnValidate()
                            begin
                                UpdateValues();
                            end;
                        }
                        field(cdGlobal2Filter; cdGlobal2Filter)
                        {
                            CaptionClass = '1,3,2';
                            Caption = 'Global 2 Filter';
                            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

                            trigger OnValidate()
                            begin
                                UpdateValues();
                            end;
                        }
                    }
                    group("3")
                    {
                        ShowCaption = false;

                        field(cdLocationFilter; cdLocationFilter)
                        {
                            Caption = 'Location Filter';
                            TableRelation = Location;

                            trigger OnValidate()
                            begin
                                UpdateValues;
                            end;
                        }
                    }
                }
            }
            repeater("Lines_")
            {
                Editable = false;
                field("No."; Rec."No.") { }
                field(Description; Rec.Description) { }
                field("No. 2"; Rec."No. 2") { }
                field("Customer Code"; Rec."Customer Code")
                {
                    Editable = false;
                }
                field("Item Category Code"; Rec."Item Category Code") { }
                field("Product Group Code"; Rec."New Product Group Code") { }
                field("Net Weight Per (Kg)"; Rec."Net Weight Per (Kg)") { }
                field("Pack Size"; Rec."Pack Size") { }
                field("Reorder Point"; Rec."Reorder Point") { }
                field("Base Unit of Measure"; Rec."Base Unit of Measure") { }
                field("Opening Quantity"; Rec."Opening Quantity") { }
                field("Inward Quantity"; Rec."Inward Quantity") { }
                field("Outward Quantity"; Rec."Outward Quantity") { }
                field(Inventory; Rec.Inventory)
                {
                    Caption = 'Closing Quantity';
                }
                field(blnMaterialReq; blnMaterialReq)
                {
                    Caption = 'Material Required';
                    Editable = false;
                }
                field("Opening Value"; Rec."Opening Value") { }
                field("Inward Value"; Rec."Inward Value") { }
                field("Outward Value"; Rec."Outward Value") { }
                field("Closing Value"; Rec."Closing Value") { }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Apply Filters")
            {
                Caption = 'Apply Filters';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                begin

                    IF dtFromDate <> 0D THEN BEGIN
                        Rec.SETFILTER("Date Filter", '%1..%2', dtFromDate, dtToDate);
                        Rec.SETFILTER("Opening Date Filter", '%1..%2', 0D, dtFromDate - 1);
                    END;
                    Rec.SETFILTER("Global Dimension 1 Filter", cdGlobal1Filter);
                    Rec.SETFILTER("Global Dimension 2 Filter", cdGlobal2Filter);
                    Rec.SETFILTER("Location Filter", cdLocationFilter);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        dtFromDate: Date;
        dtToDate: Date;
        cdGlobal1Filter: Code[20];
        cdGlobal2Filter: Code[20];
        cdLocationFilter: Code[20];
        blnMaterialReq: Boolean;

    procedure UpdateValues()
    var
    begin
        IF dtFromDate <> 0D THEN BEGIN
            Rec.SETFILTER("Date Filter", '%1..%2', dtFromDate, dtToDate);
            Rec.SETFILTER("Opening Date Filter", '%1..%2', 0D, dtFromDate - 1);
        END;
        Rec.SETFILTER("Global Dimension 1 Filter", cdGlobal1Filter);
        Rec.SETFILTER("Global Dimension 2 Filter", cdGlobal2Filter);
        Rec.SETFILTER("Location Filter", cdLocationFilter);
        CurrPage.UPDATE;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CALCFIELDS(Inventory);
        IF Rec."Reorder Point" > Rec.Inventory THEN
            blnMaterialReq := TRUE
        ELSE
            blnMaterialReq := FALSE;
    end;
}
