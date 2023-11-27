table 50015 "Material Receive Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "Material Receive Header";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(4; "Item Name"; Text[50])
        {
        }
        field(5; "Unit of Measure"; Code[10])
        {
        }
        field(6; "Purchase Order Qty"; Decimal)
        {
        }
        field(7; "Receive Qty"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Receive Qty" > "Remaining Qty" THEN
                    ERROR('You can only receive %1 quantity.', "Remaining Qty");
            end;
        }
        field(8; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(9; "Purchase Order No."; Code[20])
        {
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(11; IsInbound; Boolean)
        {
        }
        field(12; "Remaining Qty"; Decimal)
        {
        }
        field(13; "Total Tracking Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = CONST(50018),
                                                                           "Source ID" = FIELD("Document No."),
                                                                           "Source Ref. No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Purchase Order Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        recReceiveHeader.GET("Document No.");
        recReceiveHeader.TESTFIELD(Status, recReceiveHeader.Status::Open);
    end;

    trigger OnModify()
    begin

        recReceiveHeader.GET("Document No.");
        recReceiveHeader.TESTFIELD(Status, recReceiveHeader.Status::Open);
    end;

    var
        recReceiveHeader: Record "Material Receive Header";


    procedure OpenItemTrackingLines()
    var
        ReserveMatRecLine: Codeunit "Purch. Line-Reserve";
    begin
        TESTFIELD("Item No.");
        TESTFIELD("Receive Qty");

        CallItemTracking(Rec);
    end;


    procedure CallItemTracking(var ReceiveLine: Record "Material Receive Line")
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: Page "Item Tracking Lines";
        RunMode1: Enum "Item Tracking Run Mode";
    begin
        InitTrackingSpecification(ReceiveLine, TrackingSpecification);
        // 15800 ItemTrackingForm.SetFormRunMode(0);
        ItemTrackingForm.SetRunMode(RunMode1);
        // 15800 ItemTrackingForm.SetSource(TrackingSpecification, TODAY);
        ItemTrackingForm.SetSourceSpec(TrackingSpecification, today);
        ItemTrackingForm.SetInbound(TRUE);
        ItemTrackingForm.RUNMODAL;
    end;


    procedure InitTrackingSpecification(var ReceiveLine: Record "Material Receive Line"; var TrackingSpecification: Record "Tracking Specification")
    begin
        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Material Receive Line";
        TrackingSpecification."Item No." := ReceiveLine."Item No.";
        TrackingSpecification."Location Code" := ReceiveLine."Location Code";
        TrackingSpecification.Description := ReceiveLine."Item Name";
        //TrackingSpecification."Variant Code" := "Variant Code";
        //TrackingSpecification."Source Subtype" := "Document Type";
        TrackingSpecification."Source ID" := ReceiveLine."Document No.";
        TrackingSpecification."Source Batch Name" := '';
        TrackingSpecification."Source Prod. Order Line" := 0;
        TrackingSpecification."Source Ref. No." := ReceiveLine."Line No.";
        TrackingSpecification."Quantity (Base)" := ReceiveLine."Receive Qty";
        TrackingSpecification."Qty. to Invoice (Base)" := ReceiveLine."Receive Qty";
        TrackingSpecification."Qty. to Invoice" := ReceiveLine."Receive Qty";
        TrackingSpecification."Quantity Invoiced (Base)" := ReceiveLine."Receive Qty";
        TrackingSpecification."Qty. per Unit of Measure" := 1;
        //TrackingSpecification."Bin Code" := "Bin Code";
        TrackingSpecification."Qty. to Handle (Base)" := ReceiveLine."Receive Qty";
        TrackingSpecification."Quantity Handled (Base)" := ReceiveLine."Receive Qty";
        TrackingSpecification."Qty. to Handle" := ReceiveLine."Receive Qty";
    end;
}

