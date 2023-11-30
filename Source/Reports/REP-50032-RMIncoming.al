report 50032 "RM Incoming"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");
            RequestFilterFields = "Posting Date";

            column(Document_No_; "Document No.") { }
            column(Supplier; '') { }//New Field
            column(SNo; SRNO) { }
            column(Month; ConvertDate("Posting Date")) { }
            column(Arrival_Date; "Posting Date") { }
            column(Gate_Entry; PostedGateEntyHdr_Rec."Gate Entry No.") { }
            column(Gate_Dt; PostedGateEntyHdr_Rec."Posting Date") { }
            column(Unloading_Dt; '') { }//New field
            column(Vehicle_No; PostedGateEntyHdr_Rec."Vehicle No.") { }
            column(Party_Name; PRH_Rec."Buy-from Vendor Name") { }
            column(Invoice_No; PRH_Rec."Pay-to Vendor No.") { }//PIN
            column(Bill_Date; "Posting Date") { }
            column(Unit_Price__LCY_; "Unit Price (LCY)") { }
            column(No_Tins; '') { }//New field
            column(No_Buck; '') { }//New field
            column(No_Cains; '') { }//New field
            column(No_Drums; '') { }//New field
            column(Total_Units; '') { }//New field
            column(Unit; 'Nos') { }
            column(Factory_Net; Quantity) { }
            column(Factory_Tare; '') { }
            column(Factory_Gross; '') { }//New field
            column(Inv_Net_Wt; '') { }//New field
            column(Factory_Out_Side_Wt; '') { }//New field
            column(Shortage_Excess; '') { }//New field
            column(Final_Weight; '') { }//New field
            column(Amt_as_per_bill; '') { }
            column(Vendor_State; Vendor_Rec."State Code") { }
            column(Loaded_from; PRH_Rec."Buy-from County") { }
            column(Amount; '') { }
            column(IGST_18; '') { }
            column(Other_Charges; "Job Line Amount (LCY)") { }
            column("Transporter_Name"; '') { }//
            column(GR_No; PRH_Rec."Vendor Order No.") { }
            column(GR_Date; PRH_Rec."Document Date") { }
            column(T_Freight; '') { }//New field
            column(Adv_Freight; '') { }//New field
            column(B_Freight; '') { }//New field
            column(GAN_No; "Document No.") { }
            column(PO_Nomber; "Order No.") { }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Purch. Rcpt. Line";
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = sorting("Document No.", "Document Type", "Document Line No.");

                column(Lot_No; "Lot No.") { }
                column(Document_Line_No_; "Document Line No.") { }
            }
            trigger OnAfterGetRecord()
            begin

                SRNO += 1;
                if PRH_Rec.Get("Document No.") then;
                if Vendor_Rec.get("Buy-from Vendor No.") then;

                PostedGateEntyLine_Rec.Reset();
                PostedGateEntyLine_Rec.SetRange("Source No.", "Order No.");
                if PostedGateEntyLine_Rec.FindFirst() then;

                if PostedGateEntyHdr_Rec.get(PostedGateEntyLine_Rec."Entry Type", PostedGateEntyLine_Rec."Gate Entry No.") then;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; '')
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = '.\ReportLayouts\RMIncoming.rdl';

        }
    }
    procedure ConvertDate(DateP: Date): Text
    var
        MonthTxt: Text;
        Month: Text;
        Year: Integer;
        Day: Integer;
    begin
        Day := DATE2DMY(DateP, 2);
        /*  MonthTxt := COPYSTR(DateP, 4, 3);
         EVALUATE(Day, COPYSTR(DateP, 1, 2));
         EVALUATE(Year, COPYSTR(DateP, 8, 4)); */
        CASE Day OF
            1:
                Month := 'Jan';
            2:
                Month := 'Feb';
            3:
                Month := 'Mar';
            4:
                Month := 'Apr';
            5:
                Month := 'May';
            6:
                Month := 'Jun';
            7:
                Month := 'Jul';
            8:
                Month := 'Aug';
            9:
                Month := 'Sep';
            10:
                Month := 'Oct';
            11:
                Month := 'Nov';
            12:
                Month := 'Dec';
        END;
        EXIT(Month);
    end;


    var
        SRNO: Integer;
        PRH_Rec: Record "Purch. Rcpt. Header";
        PRL_Rec: Record "Purch. Rcpt. Line";
        Vendor_Rec: Record Vendor;
        PurchaseHeader: Record "Purchase Header";
        GateEntryLine_Rec: Record "Gate Entry Line";
        GateEntryHdr_Rec: Record "Gate Entry Header";
        PostedGateEntyHdr_Rec: Record "Posted Gate Entry Header";
        PostedGateEntyLine_Rec: Record "Posted Gate Entry Line";
}