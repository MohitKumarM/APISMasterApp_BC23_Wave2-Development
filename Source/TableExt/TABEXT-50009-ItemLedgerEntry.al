tableextension 50009 ItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Deal No."; Code[20])
        {
            TableRelation = "Deal Master" WHERE(Status = FILTER(Release));
        }
        field(50002; "Packing Type"; Option)
        {
            OptionCaption = ' ,Drums,Tins,Buckets,Cans';
            OptionMembers = " ",Drums,Tins,Buckets,Cans;
        }
        field(50003; "Qty. in Pack"; Decimal) { }
        field(50004; "Deal Line No."; Integer)
        {
            TableRelation = "Deal Dispatch Details"."Line No." WHERE("Sauda No." = FIELD("Deal No."),
                                                                      "GAN Created" = FILTER(false));
        }
        field(50005; "Dispatched Qty. in Kg."; Decimal)
        {
            Editable = false;
        }
        field(50006; Flora; Code[20])
        {
            Editable = false;
            TableRelation = "New Product Group".Code WHERE("Item Category Code" = FILTER(''));
        }
        field(50007; "Tare Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "QC To Approve"; Boolean) { }
        field(50009; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(50010; "Vehicle No."; Code[20]) { }
        field(50011; "Purchaser Code"; Code[20]) { }
        field(50012; "Purchaser Name"; Text[50]) { }
        field(50017; "Starting Date Time"; DateTime) { }
        field(50018; "Ending Date Time"; DateTime) { }
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
        field(50024; "Barcode Generated"; Boolean) { }
        field(50025; "Container Trasfer Stage"; Option)
        {
            OptionMembers = " ","Issued RM","RM Consumed";
        }
        field(50026; "Can"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Trade Type"; Option)
        {
            OptionMembers = " ","General Trade","Modern Trade";
        }
        field(50031; "Production Sub Type"; Option)
        {
            OptionMembers = " ","FG Bulk Exp. w/o processing","FG Bulk Exp. w/o filter","FG Bulk Exp. Filtered","FG Small Exp. Filtered","FG Bulk Dom w/o filter","FG Bulk Dom Filter","FG Small Dom Filtered",Pouring;
        }
        field(60000; "Approved Quantity"; Decimal) { }
        field(60001; "Rejected Quantity"; Decimal) { }
        field(60002; "Quality Checked"; Boolean) { }
        field(60006; "ByProduct Entry"; Boolean) { }
        field(60009; "Prod. Order Line No."; Integer) { }
        field(60010; "Machine Center No."; Code[20])
        {
            TableRelation = "Machine Center";
        }
        field(60011; "Output for Customer"; Code[10])
        {
            TableRelation = Customer;
        }
        Field(60012; "Item to Produce 1"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        Field(60013; "Quantity to Produce 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(60014; "Production Location"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        Field(60015; "Item to Produce 2"; Code[10])

        {
            DataClassification = ToBeClassified;
        }
        Field(60016; "Item to Produce 3"; Code[10])

        {
            DataClassification = ToBeClassified;
        }
        Field(60017; "Item to Produce 4"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        Field(60018; "Quantity to Produce 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(60019; "Quantity to Produce 3"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        Field(60020; "Quantity to Produce 4"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "Moisture (%)"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Color (MM)"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "HMF (PPM)"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70003; TRS; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70004; Sucrose; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70005; FG; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        Field(70006; "Convesion Packing Type"; Option)
        {
            OptionMembers = ,Drums,Tins,Buckets,Cans;
        }
        Field(70007; "Customer Details"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        Field(70008; "No. of Drums / Tins / Cans"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        Field(70009; "Quantity to Move"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}