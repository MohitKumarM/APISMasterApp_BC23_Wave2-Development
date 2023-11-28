pageextension 50047 StandardTasksExt extends "Standard Tasks"
{
    layout { }

    actions
    {
        addfirst(Processing)
        {
            action(QualityMeasures)
            {
                Caption = 'Quality Measures';
                Image = TaskQualityMeasure;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Standard Task Qlty Measures";
                RunPageLink = "Standard Task Code" = FIELD(Code);
            }
        }
    }
}