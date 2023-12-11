pageextension 50016 InventerySetup extends "Inventory Setup"
{
    layout
    {
        addafter("Automatic Cost Adjustment")
        {
            field("Material Issue Entry Template"; Rec."Material Issue Entry Template")
            {
                ApplicationArea = all;
            }
            field("Material Issue Entry Batch"; Rec."Material Issue Entry Batch")
            {
                ApplicationArea = all;
            }
            field("Output Approval Template"; Rec."Output Approval Template")
            {
                ApplicationArea = all;
            }
            field("Output Approval Batch"; Rec."Output Approval Batch")
            {
                ApplicationArea = all;
            }
            field("Output Posting Template"; Rec."Output Posting Template")
            {
                ApplicationArea = all;
            }
            field("Output Posting Batch"; Rec."Output Posting Batch")
            {
                ApplicationArea = all;
            }
            field("Quality Nos."; Rec."Quality Nos.")
            {
                ApplicationArea = all;
            }
            field("QC Entry Template"; Rec."QC Entry Template")
            {
                ApplicationArea = all;
            }
            field("QC Entry Batch"; Rec."QC Entry Batch")
            {
                ApplicationArea = all;
            }
        }
        addafter("Inventory Pick Nos.")
        {
            field("Receive Nos."; Rec."Receive Nos.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}