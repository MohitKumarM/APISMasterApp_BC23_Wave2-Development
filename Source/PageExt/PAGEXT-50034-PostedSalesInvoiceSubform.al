pageextension 50034 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Line")
        {
            action("Packing List")
            {
                Image = PickLines;
                ApplicationArea = All;
                trigger OnAction()
                var
                    recItem: Record Item;
                    PostedPackingList: Record "Posted Packing List";
                    PostedBulkPackingList: Page "Posted Drum Packing List";
                    PostedSmallPackingList: Page "Posted Bottling Packing List";
                begin
                    Rec.TESTFIELD(Type, Type::Item);
                    Rec.TESTFIELD("No.");
                    recItem.GET(Rec."No.");
                    PostedPackingList.RESET;
                    PostedPackingList.SETRANGE("Order No.", Rec."Document No.");
                    PostedPackingList.SETRANGE("Order Line No.", Rec."Line No.");
                    PostedPackingList.SETRANGE("Item Code", Rec."No.");
                    if recItem."Item Type" = recItem."Item Type"::Bulk then begin
                        CLEAR(PostedBulkPackingList);
                        PostedBulkPackingList.SETTABLEVIEW(PostedPackingList);
                        PostedBulkPackingList.RUN;
                    end else begin
                        CLEAR(PostedSmallPackingList);
                        PostedSmallPackingList.SETTABLEVIEW(PostedPackingList);
                        PostedSmallPackingList.RUN;
                    end;
                end;
            }
        }
    }
}