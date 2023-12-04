pageextension 50039 "Manufacturing Setup Ext." extends "Manufacturing Setup"
{
    layout
    {
        addafter("Cost Incl. Setup")
        {
            group("Production Planning")
            {
                field("Loose Honey Code"; Rec."Loose Honey Code")
                {
                    ApplicationArea = All;
                }
                field("Bucket Item Code"; Rec."Bucket Item Code")
                {
                    ApplicationArea = All;
                }
                field("Can Item Code"; Rec."Can Item Code")
                {
                    ApplicationArea = All;
                }
                field("Drum Item Code"; Rec."Drum Item Code")
                {
                    ApplicationArea = All;
                }
                field("Tin Item Code"; Rec."Tin Item Code")
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
                field("Store to Prod. Template"; Rec."Store to Prod. Template")
                {
                    ApplicationArea = all;
                }
                field("Store to Prod. Batch"; Rec."Store to Prod. Batch")
                {
                    ApplicationArea = all;
                }
                field("Prod. to Store Template"; Rec."Prod. to Store Template")
                {
                    ApplicationArea = all;
                }
                field("Prod. to Store Batch"; Rec."Prod. to Store Batch")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}