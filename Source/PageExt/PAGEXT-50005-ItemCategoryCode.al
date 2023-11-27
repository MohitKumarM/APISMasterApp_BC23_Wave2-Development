pageextension 50005 ItemCategoryCode extends "Item Categories"
{
    layout
    {
        addafter(Description)
        {
            field("Inward QC Required"; Rec."Inward QC Required")
            {
                ApplicationArea = all;
            }
            field("Item Nos."; Rec."Item Nos.")
            {
                ApplicationArea = all;
            }
            field("GAN Tolerance %"; Rec."GAN Tolerance %")
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