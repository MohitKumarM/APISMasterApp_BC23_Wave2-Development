tableextension 50029 GateInwrdEntry extends "Gate Entry Line"
{
    fields
    {
        modify("Source Type")
        {
            trigger OnBeforeValidate()
            begin
                Clear("Party No.");
                Clear("Source No.");
                Clear("Source No.1");
                Clear("Source Name");
                Clear(Description);
            end;
        }
        field(50000; "Party No."; Code[20])
        {
            TableRelation = if ("Source Type" = filter('Purchase Order')) Vendor
            else
            if ("Source Type" = filter('Sales Return Order')) Customer
            else
            if ("Source Type" = filter('Transfer Receipt')) Location
            else
            if ("Source Type" = filter('Sales Shipment')) Customer
            else
            if ("Source Type" = filter('Purchase Return Shipment')) Vendor
            else
            if ("Source Type" = filter('Transfer Shipment')) Location;
            DataClassification = ToBeClassified;
        }
        field(50001; "Source No.1"; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = CustomerContent;
            trigger OnLookup()
            begin
                GateEntryHeader.Get("Entry Type", "Gate Entry No.");
                case "Source Type" of
                    "Source Type"::"Sales Shipment":
                        begin
                            SalesShipHeader.Reset();
                            SalesShipHeader.FilterGroup(2);
                            SalesShipHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            if Rec."Party No." <> '' then
                                SalesShipHeader.SetRange("Sell-to Customer No.", Rec."Party No.");
                            SalesShipHeader.FilterGroup(0);
                            if Page.RunModal(0, SalesShipHeader) = Action::LookupOK then
                                Validate("Source No.1", SalesShipHeader."No.");
                        end;
                    "Source Type"::"Sales Return Order":
                        begin
                            SalesHeader.Reset();
                            SalesHeader.FilterGroup(2);
                            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Return Order");
                            SalesHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            if Rec."Party No." <> '' then
                                SalesHeader.SetRange("Sell-to Customer No.", Rec."Party No.");
                            SalesHeader.FilterGroup(0);
                            if Page.RunModal(0, SalesHeader) = Action::LookupOK then
                                Validate("Source No.1", SalesHeader."No.");
                        end;
                    "Source Type"::"Purchase Order":
                        begin
                            PurchHeader.Reset();
                            PurchHeader.FilterGroup(2);
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            if Rec."Party No." <> '' then
                                PurchHeader.SetRange("Buy-from Vendor No.", rec."Party No.");
                            PurchHeader.FilterGroup(0);
                            if Page.RunModal(0, PurchHeader) = Action::LookupOK then
                                Validate("Source No.1", PurchHeader."No.");
                        end;
                    "Source Type"::"Purchase Return Shipment":
                        begin
                            ReturnShipHeader.Reset();
                            ReturnShipHeader.FilterGroup(2);
                            ReturnShipHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            if Rec."Party No." <> '' then
                                ReturnShipHeader.SetRange("Buy-from Vendor No.", Rec."Party No.");
                            ReturnShipHeader.FilterGroup(0);
                            if Page.RunModal(0, ReturnShipHeader) = Action::LookupOK then
                                Validate("Source No.1", ReturnShipHeader."No.");
                        end;
                    "Source Type"::"Transfer Receipt":
                        begin
                            TransHeader.Reset();
                            TransHeader.FilterGroup(2);
                            TransHeader.SetRange("Transfer-to Code", GateEntryHeader."Location Code");
                            TransHeader.FilterGroup(0);
                            if Page.RunModal(0, TransHeader) = Action::LookupOK then
                                Validate("Source No.1", TransHeader."No.");
                        end;
                    "Source Type"::"Transfer Shipment":
                        begin
                            TransShptHeader.Reset();
                            TransShptHeader.FilterGroup(2);
                            TransShptHeader.SetRange("Transfer-from Code", GateEntryHeader."Location Code");
                            TransShptHeader.FilterGroup(0);
                            if Page.RunModal(0, TransShptHeader) = Action::LookupOK then
                                Validate("Source No.1", TransShptHeader."No.");
                        end
                end;
            end;

            trigger OnValidate()
            begin
                if "Source Type" = "Source Type"::" " then
                    Error(SourceTypeErr, FieldCaption("Line No."), "Line No.");

                if "Source No.1" <> "Source No.1" then
                    "Source Name" := '';

                if "Source No.1" = '' then begin
                    "Source Name" := '';
                    exit;
                end;

                case "Source Type" of
                    "Source Type"::"Sales Shipment":
                        begin
                            SalesShipHeader.Get("Source No.1");
                            "Source Name" := CopyStr(SalesShipHeader."Bill-to Name", 1, MaxStrLen("Source Name"));
                        end;
                    "Source Type"::"Sales Return Order":
                        begin
                            SalesHeader.Get(SalesHeader."Document Type"::"Return Order", "Source No.1");
                            "Source Name" := CopyStr(SalesHeader."Bill-to Name", 1, MaxStrLen("Source Name"));
                        end;
                    "Source Type"::"Purchase Order":
                        begin
                            PurchHeader.Get(PurchHeader."Document Type"::Order, "Source No.1");
                            "Source Name" := CopyStr(PurchHeader."Pay-to Name", 1, MaxStrLen("Source Name"));
                        end;
                    "Source Type"::"Purchase Return Shipment":
                        begin
                            ReturnShipHeader.Get("Source No.1");
                            "Source Name" := CopyStr(ReturnShipHeader."Pay-to Name", 1, MaxStrLen("Source Name"));
                        end;
                    "Source Type"::"Transfer Receipt":
                        begin
                            TransHeader.Get("Source No.1");
                            "Source Name" := CopyStr(TransHeader."Transfer-from Name", 1, MaxStrLen("Source Name"));
                        end;
                    "Source Type"::"Transfer Shipment":
                        begin
                            TransShptHeader.Get("Source No.1");
                            "Source Name" := CopyStr(TransShptHeader."Transfer-to Name", 1, MaxStrLen("Source Name"));
                        end
                end;
                Validate("Source No.", "Source No.1");
            end;
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        SalesShipHeader: Record "Sales Shipment Header";
        TransHeader: Record "Transfer Header";
        SalesHeader: Record "Sales Header";
        ReturnShipHeader: Record "Return Shipment Header";
        TransShptHeader: Record "Transfer Shipment Header";
        GateEntryHeader: Record "Gate Entry Header";
        SourceTypeErr: Label 'Source Type must not be blank in %1 %2.', Comment = ' %1= FieldCaption("Line No."),  %2 = "Line No."';
}