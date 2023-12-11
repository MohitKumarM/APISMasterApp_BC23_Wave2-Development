pageextension 50028 InwardGateEntrySub extends "Inward Gate Entry SubForm"
{
    layout
    {
        modify("Source No.")
        {
            Visible = false;
        }

        addafter("Source Type")
        {
            field("Party No."; Rec."Party No.")
            {
                ApplicationArea = all;
            }
            field("Source No.1"; Rec."Source No.1")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}