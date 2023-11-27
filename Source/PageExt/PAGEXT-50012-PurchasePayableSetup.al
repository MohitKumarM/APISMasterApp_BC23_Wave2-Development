pageextension 50012 PurchasePayableSetupN1 extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Calc. Inv. Discount")
        {
            field("Deal Tolerance"; Rec."Deal Tolerance")
            {
                ApplicationArea = all;
            }
            field("Raw Honey Item"; Rec."Raw Honey Item")
            {
                ApplicationArea = all;
            }
            field("Tin Item"; Rec."Tin Item")
            {
                ApplicationArea = all;
            }
            field("Drum Item"; Rec."Drum Item")
            {
                ApplicationArea = all;
            }
            field("Bucket Item"; Rec."Bucket Item")
            {
                ApplicationArea = all;
            }
            field("CAN Item"; Rec."CAN Item")
            {
                ApplicationArea = all;
            }
            field("OK Store Location"; Rec."OK Store Location")
            {
                ApplicationArea = all;
            }
        }
        addafter(Archiving)
        {
            group("PO Instruction")
            {
                field("Purchase Order Instruction"; Rec."PO Terms & Conditions")
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
            }
        }
        addafter("Return Order Nos.")
        {
            field("Honey Order Nos."; Rec."Honey Order Nos.")
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