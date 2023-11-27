pageextension 50039 "Manufacturing Setup Ext." extends "Manufacturing Setup"
{
    layout
    {
        addafter("Cost Incl. Setup")
        {
            group("Production Planning")
            {
                field("Store Location"; Rec."Store Location")
                {
                    ApplicationArea = All;
                }
                field("Production Location"; Rec."Production Location")
                {
                    ApplicationArea = All;
                }
                field("Loose Honey Code"; Rec."Loose Honey Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Location"; Rec."Packing Location")
                {
                    ApplicationArea = All;
                }
                field("Consumption Template"; Rec."Consumption Template")
                {
                    ApplicationArea = All;
                }
                field("Consumption Batch"; Rec."Consumption Batch")
                {
                    ApplicationArea = All;
                }
                field("Process Add On Routing"; Rec."Process Add On Routing")
                {
                    ApplicationArea = All;
                }
                field("One by One Output Explode"; Rec."One by One Output Explode")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}