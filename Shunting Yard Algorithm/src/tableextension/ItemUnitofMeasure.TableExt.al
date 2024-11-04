tableextension 53000 "PTE_Item Unit of Measure" extends "Item Unit of Measure"
{
    fields
    {

        modify(Length)
        {
            Caption = 'Length mm';
            trigger OnAfterValidate()
            begin
                if Rec.Length <> xRec.Length then
                    CalculateFormula();
            end;
        }
        modify(Width)
        {
            Caption = 'Width mm';
            trigger OnAfterValidate()
            begin
                if Rec.Width <> xRec.Width then
                    CalculateFormula();
            end;
        }
        modify(Height)
        {
            Caption = 'Height mm';
            trigger OnAfterValidate()
            begin
                if Rec.Height <> xRec.Height then
                    CalculateFormula();
            end;
        }
        modify(Weight)
        {
            Caption = 'Weight kg';
            trigger OnAfterValidate()
            begin
                if Rec.Weight <> xRec.Weight then
                    CalculateFormula();
            end;
        }
        modify(Cubage)
        {
            trigger OnAfterValidate()
            begin
                if Rec.Cubage <> xRec.Cubage then
                    CalculateFormula();
            end;
        }

        field(50000; "PTE_Volume Sq. M."; Decimal)
        {
            Caption = 'Surface m²';
            ToolTip = 'Specifies the value of the Volume m² field.';
            DataClassification = CustomerContent;
        }
        field(50001; "PTE_Volume Kub. M."; Decimal)
        {
            Caption = 'Volume m³';
            ToolTip = 'Specifies the value of the Volume m³ field.';
            DataClassification = CustomerContent;
        }
        field(50002; "PTE_Formula"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Formula';
            ToolTip = 'Set a Formula Text with exact field names between double currly brackets {{Field Name}}. The interpretation of the value will be in the result field.';
            InitValue = '{{Length}} * {{Width}} * {{Height}} * 0.78 / 1000000';
            trigger OnValidate()
            begin
                CalculateFormula();
            end;
        }
        field(50003; PTE_Result; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Result';
            ToolTip = 'Specifies the result value of the formula field.';
        }
    }
    var
        ShuntingYardAlgorithm: Codeunit "PTE_Shunting Yard Algorithm";
        DefaultFormulaLbl: Label '{{Length}} * {{Width}} * {{Height}} * 0.78 / 1000000', Locked = true;

    local procedure CalculateFormula()
    var
        RecRef: RecordRef;
    begin
        if "PTE_Formula" = '' then
            PTE_Result := 0
        else begin
            if "PTE_Formula" = 'default' then
                "PTE_Formula" := DefaultFormulaLbl;
            RecRef.GetTable(Rec);
            if ShuntingYardAlgorithm.CalculateFormula("PTE_Formula", RecRef, Rec.PTE_Result) then;
        end;
    end;

}