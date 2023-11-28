pageextension 50046 MachineCenterExt extends "Machine Center Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("QC Mandatory"; Rec."QC Mandatory")
            {
                ApplicationArea = All;
            }
            field("Quality Process"; Rec."Quality Process")
            {
                ApplicationArea = All;
            }
            field("QC Type"; Rec."QC Type")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}