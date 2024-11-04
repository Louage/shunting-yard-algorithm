codeunit 53000 "PTE_Shunting Yard Algorithm"
{
    [TryFunction]
    procedure CalculateFormula(Formula: Text; SourceRecordRef: RecordRef; var CalculatedValue: Decimal);
    var
        DataTypeManagement: Codeunit "Data Type Management";
        SourceFieldRef: FieldRef;
        FieldValue: Decimal;
        EndPos: Integer;
        StartPos: Integer;
        FieldName: Text;
    begin
        Formula := DelChr(Formula, '=', ' ');
        StartPos := StrPos(Formula, '{{');
        while StartPos <> 0 do begin
            EndPos := StrPos(Formula, '}}');
            if EndPos = 0 then
                Error('Invalid formula');

            FieldName := CopyStr(Formula, StartPos + 2, EndPos - StartPos - 2);
            if not DataTypeManagement.FindFieldByName(SourceRecordRef, SourceFieldRef, FieldName) then
                Error('Field %1 does not exist', FieldName);
            if not (SourceFieldRef.Type in [FieldType::Decimal, FieldType::Integer]) then
                Error('Field %1 is not a numeric field', FieldName);
            FieldValue := SourceFieldRef.Value;
            Formula := DelStr(Formula, StartPos, EndPos - StartPos + 2);
            Formula := InsStr(Formula, Format(FieldValue, 0, 9), StartPos);
            StartPos := StrPos(Formula, '{{');
        end;
        CalculatedValue := 0;
        CalculatedValue := EvaluateExpression(Formula);
    end;

    procedure EvaluateExpression(Expression: Text): Decimal
    var
        OperatorStack: List of [Text];
        OutputQueue: List of [Text];
        Tokens: List of [Text];
        Token: Text;
        NumericToken: Decimal;
        ResultStack: List of [Decimal];
        Operand1: Decimal;
        Operand2: Decimal;
    begin
        // Step 1: Convert to Reverse Polish Notation using Shunting Yard algorithm
        Tokens := SplitExpression(Expression);
        foreach Token in Tokens do begin
            if IsNumeric(Token) then
                OutputQueue.Add(Token);
            if IsOperator(Token) then begin
                while (OperatorStack.Count > 0)
                    and (IsOperator(Peek(OperatorStack)))
                    and (OperatorPrecedence(Peek(OperatorStack)) >= OperatorPrecedence(Token[1])) do
                    OutputQueue.Add(Pop(OperatorStack));
                OperatorStack.Add(Token[1]);
            end;
            if Token = '(' then
                OperatorStack.Add(Token[1]);
            if Token = ')' then begin
                while (OperatorStack.Count > 0) and (Peek(OperatorStack) <> '(') do
                    OutputQueue.Add(Pop(OperatorStack));
                if (OperatorStack.Count > 0) and (Peek(OperatorStack) = '(') then
                    Pop(OperatorStack);
            end;
        end;
        while OperatorStack.Count > 0 do
            OutputQueue.Add(Pop(OperatorStack));

        // Step 2: Evaluate the RPN expression
        foreach Token in OutputQueue do begin
            if IsNumeric(Token) then begin
                Evaluate(NumericToken, Token, 9);
                ResultStack.Add(NumericToken);
            end;
            if IsOperator(Token) then begin
                Operand2 := PopDecimal(ResultStack);
                Operand1 := PopDecimal(ResultStack);
                case Token[1] of
                    '+':
                        ResultStack.Add(Operand1 + Operand2);
                    '-':
                        ResultStack.Add(Operand1 - Operand2);
                    '*':
                        ResultStack.Add(Operand1 * Operand2);
                    '/':
                        ResultStack.Add(Operand1 / Operand2);
                end;
            end;
        end;
        exit(PopDecimal(ResultStack));
    end;

    procedure IsNumeric(Value: Text): Boolean
    var
        Number: Decimal;
    begin
        exit(Evaluate(Number, Value));
    end;

    procedure IsOperator(Value: Text): Boolean
    begin
        case Value of
            '+', '-', '*', '/':
                exit(true);
            else
                exit(false);
        end;
    end;

    procedure Peek(var Stack: List of [Text]) Peekvalue: Text
    begin
        if Stack.Count = 0 then
            exit;
        if Stack.Get(Stack.Count, Peekvalue) then
            exit;
        Error('Stack is empty');
    end;

    procedure OperatorPrecedence(Operator: Text): Integer
    begin
        case Operator of
            '+', '-':
                exit(1);
            '*', '/':
                exit(2);
            else
                exit(0);
        end;
    end;

    procedure Pop(var Stack: List of [Text]): Text
    var
        TopItem: Text;
    begin
        TopItem := Stack.Get(Stack.Count);
        Stack.RemoveAt(Stack.Count);
        exit(TopItem);
    end;

    procedure PopDecimal(var Stack: List of [Decimal]): Decimal
    var
        TopItem: Decimal;
    begin
        TopItem := Stack.Get(Stack.Count);
        Stack.RemoveAt(Stack.Count);
        exit(TopItem);
    end;

    procedure SplitExpression(Expression: Text): List of [Text]
    var
        Result: List of [Text];
        CurrentNumber: Text;
        i: Integer;
    begin
        for i := 1 to StrLen(Expression) do
            if IsOperator(Expression[i]) or (Expression[i] in ['(', ')']) then begin
                if CurrentNumber <> '' then begin
                    Result.Add(CurrentNumber);
                    CurrentNumber := '';
                end;
                Result.Add(Expression[i]);
            end else
                CurrentNumber += Expression[i];
        if CurrentNumber <> '' then
            Result.Add(CurrentNumber);
        exit(Result);
    end;

}