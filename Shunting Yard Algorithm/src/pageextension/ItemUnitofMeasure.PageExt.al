pageextension 53000 "PTE_Item Unit of Measure" extends "Item Units of Measure"
{
    layout
    {
        modify(Cubage)
        {
            Visible = false;
        }
        addlast(Control1)
        {
            field("PTE_Volume Sq. M."; Rec."PTE_Volume Sq. M.")
            {
                ApplicationArea = All;
                DecimalPlaces = 2 : 5;
            }
            field("PTE_Volume Kub. M."; Rec."PTE_Volume Kub. M.")
            {
                ApplicationArea = All;
                DecimalPlaces = 2 : 5;
            }
            field("PTE_Formula"; Rec."PTE_Formula")
            {
                ApplicationArea = All;
            }
            field(PTE_Result; Rec.PTE_Result)
            {
                ApplicationArea = All;
                DecimalPlaces = 2 : 5;
            }
        }
    }
}