tableextension 50028 PurhaseQue extends "Purchase Cue"
{
    fields
    {
        field(50023; "Material Issue"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Material Requisition Header" WHERE(Status = FILTER(Release)));
        }
        field(50037; "Issue Material"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" WHERE(Status = FILTER(Released), Refreshed = FILTER(True), "Requested Material Issue" = FILTER(true)));
        }
        field(50024; "Pending Inward Quality"; Integer)
        {
            CalcFormula = Count("Item Ledger Entry" WHERE("Entry Type" = FILTER('Purchase'),
                                                           "Document Type" = FILTER('Purchase Receipt'),
                                                           "Quality Checked" = const(false),
                                                           "QC To Approve" = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Quality to Approve"; Integer)
        {
            CalcFormula = Count("Item Ledger Entry" WHERE("Entry Type" = FILTER('Purchase'),
                                                           "Document Type" = FILTER('Purchase Receipt'),
                                                           "Quality Checked" = const(false),
                                                           "QC To Approve" = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Pending Output QC"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FILTER('OUTPUTAPP'),
                                                           "Journal Batch Name" = FILTER('DEFAULT')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50027; "Posted QC"; Integer)
        {
            CalcFormula = Count("Quality Header" WHERE(Posted = const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "Production Planning"; Integer)
        {
            CalcFormula = Count("Item Budget Entry" WHERE("Analysis Area" = FILTER(Sales), "Budget Name" = FILTER('')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Prod. Order to Refresh"; Integer)
        {
            CalcFormula = Count("Production Order" WHERE(Status = FILTER(Released), Refreshed = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50036; "Select Honey Batch"; Integer)
        {
            CalcFormula = Count("Production Order" WHERE(Status = FILTER(Released), Refreshed = FILTER(true), "Order Type" = FILTER(Production), "Requested Material Issue" = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; "Output Journal"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FILTER('OUTPUT'), "Journal Batch Name" = FILTER('DEFAULT')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "Output Posting"; Integer)
        {
            CalcFormula = Count("Item Journal Line" WHERE("Journal Template Name" = FILTER('OUTPUTPOST'), "Journal Batch Name" = FILTER('DEFAULT')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Material Requisition"; Integer)
        {
            CalcFormula = Count("Material Requisition Header" WHERE(Status = FILTER('Open')));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}