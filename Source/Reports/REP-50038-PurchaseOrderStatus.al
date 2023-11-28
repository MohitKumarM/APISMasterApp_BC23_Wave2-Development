report 50038 "Purchase Order Status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    caption = 'Purchase Order Status';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(No_; "No.") { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                trigger OnAfterGetRecord()
                var
                begin
                    "Purchase Line".Reset();
                    "Purchase Line".SetRange("Purchase Line"."Document Type", "Purchase Header"."Document Type");
                    "Purchase Line".SetRange("Purchase Line"."Document No.", "Purchase Header"."No.");

                    outstanding_amount := "Purchase Line"."Quantity Received" - "Purchase Line".Quantity;

                    TempExcelBuffer.AddColumn("Purchase Line"."Document Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Header"."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Header"."Pay-to Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Header"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Line".Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Line"."Item Category Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Line"."Unit of Measure", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Line"."Quantity Received", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(outstanding_amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Line"."Unit Cost", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purchase Line"."Expected Receipt Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn("Purchase Line"."GST Group Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

                    TempExcelBuffer.NewRow();
                end;
            }

            trigger OnAfterGetRecord()
            var
            begin
                TempExcelBuffer.NewRow();
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
                    field(posting_date; posting_date)
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
            LayoutFile = './Layout/purchaseOrderStatus.rdl';
        }
    }

    trigger OnPreReport()
    var
    begin
        "Purchase Header".Reset();
        "Purchase Line".Reset();
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Document Type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Purc. Order Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn('Buy-from Vendor No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Supplier Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Product Group Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item Category Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Order Type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Pack Size', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Packing Type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Quantity With Tolerence', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Quantity Without Tolerence', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Quantity Recieved', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Quantity', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Direct Unit Cost Excl. VAT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Expected Receipt Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn('GST Tax Group Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Freight Liability', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    trigger OnPostReport()
    var
    begin
        TempExcelBuffer.CreateNewBook("Purchase Header".TableCaption);
        TempExcelBuffer.WriteSheet(PurchaseHeaderLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    var
        posting_date: Date;
        outstanding_amount: Decimal;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        PurchaseHeaderLbl: Label 'Purchase Header';
        ExcelFileName: Label 'PurchaseLineEntries_%1_%2';
}