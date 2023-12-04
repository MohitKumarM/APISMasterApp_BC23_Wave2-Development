tableextension 50011 ItemJournalLine extends "Item Journal Line"
{
    fields
    {
        field(50000; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Deal No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Deal Master" WHERE(Status = FILTER(Release));
        }
        field(50002; "Packing Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
        }
        field(50003; "Qty. in Pack"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Deal Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Deal Dispatch Details"."Line No." WHERE("Sauda No." = FIELD("Deal No."),
                                                                      "GAN Created" = FILTER(false));
        }
        field(50005; "Dispatched Qty. in Kg."; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; Flora; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
        }
        field(50010; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Purchaser Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Purchaser Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Customer Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Prod. Date for Expiry Calc"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Starting Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Ending Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "New Product Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(50020; "Tin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Drum"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Bucket"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "MFG. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Container Trasfer Stage"; Option)
        {
            OptionMembers = " ","Issued RM","RM Consumed";
        }
        field(50025; "Trade Type"; Option)
        {
            OptionMembers = " ","General Trade","Modern Trade";
        }
        field(50026; "Can"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Production Sub Type"; Option)
        {
            OptionMembers = " ","FG Bulk Exp. w/o processing","FG Bulk Exp. w/o filter","FG Bulk Exp. Filtered","FG Small Exp. Filtered","FG Bulk Dom w/o filter","FG Bulk Dom Filter","FG Small Dom Filtered",Pouring;
        }
        field(60000; "Temp Message Control"; Boolean) { }
        field(60006; "ByProduct Item Code"; Code[20])
        {
            TableRelation = Item;
        }
        field(60007; "ByProduct Qty."; Decimal)
        {
            MinValue = 0;
        }
        field(60008; "ByProduct Entry"; Boolean) { }
        field(60009; "Prod. Order Line No."; Integer) { }
        field(60010; "Machine Center No."; Code[20])
        {
            TableRelation = "Machine Center";
        }
        field(60011; "Source Template Code"; Code[20])
        {
            TableRelation = "Item Journal Template";
        }
        field(60012; "Source Batch Name"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Source Template Code"));
        }
        field(60013; "Output for Customer"; Code[10])
        {
            TableRelation = Customer;
        }
        field(60014; "QC Required"; Boolean) { }
        field(70000; "Moisture (%)"; Text[10]) { }
        field(70001; "Color (MM)"; Text[10]) { }
        field(70002; "HMF (PPM)"; Text[10]) { }
        field(70003; TRS; Text[10]) { }
        field(70004; Sucrose; Text[10]) { }
        field(70005; FG; Text[10]) { }
        //Ending---
    }
}