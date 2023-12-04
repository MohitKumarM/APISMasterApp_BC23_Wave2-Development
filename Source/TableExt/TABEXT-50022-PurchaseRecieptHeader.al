tableextension 50022 PurchaseReceiept extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Order Type"; Option)
        {
            OptionCaption = ' ,Honey,Packing Material,Other';
            OptionMembers = " ",Honey,"Packing Material",Other;
            DataClassification = ToBeClassified;
        }
        field(50001; "Invoice Type Old"; Option)
        {
            OptionCaption = 'Trading';
            OptionMembers = Trading;
            DataClassification = ToBeClassified;
        }
        field(50002; "Short Close Comment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Order Approval Pending"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Gate Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Freight Liability"; Option)
        {
            OptionCaption = ' ,Supplier,Buyer';
            OptionMembers = " ",Supplier,Buyer;
            DataClassification = ToBeClassified;
        }
        field(50006; "Waybill No."; Code[20])
        {
            Caption = 'E-Way Bill';
            DataClassification = ToBeClassified;
        }
        field(50007; "GAN Approval Pending"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "GR / LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "GR / LR Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Gate Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Vendor Invoice Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Shipping Vendor"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
        }
        field(50017; "Transit Insurance"; Option)
        {
            OptionCaption = ' ,Buyer Scope,Supplier Scope';
            OptionMembers = " ","Buyer Scope","Supplier Scope";
            DataClassification = ToBeClassified;
        }
        field(50018; "Valid Till"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Creation Tin&Drum&Bucket Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Activity Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Activity City"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Activity State"; Code[20])
        {

        }
        field(50023; "Sales Channel"; Enum "Sales Channel") { }

        field(80002; "GST Dependency Type"; Option)
        {
            OptionMembers = " ","Buy-from Address","Order Address","Location Address";
            DataClassification = ToBeClassified;
        }
        field(90002; "Product Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "New Product Group".Code;
        }
    }
}