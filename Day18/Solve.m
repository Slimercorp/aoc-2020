clear;clc;
fid = fopen('input.txt');
%% read
result = 0;
i = 0;
commands = "";
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    i = i + 1;
    commands(i,1) = tline;        
end

%%
sum = 0;
for i=1:length(commands) 
    result = solveGeneral(char(commands(i)));
    sum = sum + str2num(result);
end

sum
%solveGeneral(char(commands(5)));
%%
function result = solveGeneral(expr)
    indexsOpen = strfind(expr, '(');
    indexsClose = strfind(expr, ')');
    
    %% ищем сколько отдельных скобок
    parts = 0;
    pointer = 0;
    pattern = 0;
    maxPointer = max(max(indexsOpen, indexsClose));
    firstInited = false;
    while pointer < maxPointer
        pointer = pointer + 1;
        if ~isempty(find(pointer == indexsOpen))
            pattern = pattern + 1;
            if ~firstInited
                firstPar = pointer;
                firstInited = true;
            end
        end
        
        if ~isempty(find(pointer == indexsClose))
            pattern = pattern - 1;
            if pattern == 0
                parts = parts + 1;
                borders(parts,1) = firstPar;
                borders(parts,2) = pointer;
                firstInited = false;
            end
        end
        
    end
    
    %% раскрываем скобки
    if parts == 0
        mainExpress = expr;
    else
        for i = 1:parts
            if i == 1
                mainExpress = expr(1:borders(i,1)-1);
            else
                mainExpress = [mainExpress expr(borders(i-1,2)+1:borders(i,1)-1)];
            end
            
            expressNew = expr(borders(i,1)+1:borders(i,2)-1);
            result = solveGeneral(expressNew); %без скобок
            mainExpress = [mainExpress result];
        end
        mainExpress = [mainExpress expr(borders(end,2)+1:end)];
    end
    

    
    result = solveSimplyExpr(mainExpress);

    
end

%%
function result = solveSimplyExpr(expr)
    operand1 = 0;
    operand2 = 0;
    operation = '0';
    oper1ready = false;
    oper2ready = false;

    len = 1;
    index = 0;
    while len<length(expr)
        len = len + index;
        exprNew = expr(len:end);
        
        indexs = strfind(exprNew, ' ');
        
        if ~isempty(indexs)
            index = indexs(1);
            something = exprNew(1:(index-1));
        else
            something = exprNew(1:end);
            index = length(exprNew(1:end));
        end
        
        if isnumeric(str2num(something)) && ~isempty(str2num(something))
            if ~oper1ready
                operand1 = something;
                oper1ready = true;
            elseif ~oper2ready
                operand2 = something;
                oper2ready = true;
            end
        end
        
        if string(something) == '*' || string(something) == '+'
            operation = something;
        end
        
        if oper1ready && oper2ready
            operand1 = num2str(eval([operand1,operation,operand2]));
            oper2ready = false;
        end
        
    end
    
    result = operand1;
end