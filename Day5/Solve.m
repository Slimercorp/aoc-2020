fid = fopen('input.txt');
maxId = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    rowRaw = tline(1:7);
    columnRaw=tline(8:10);
    
    rowMax = 127;
    rowMin = 0;
    for i=1:length(rowRaw)
        if rowRaw(i) == 'F'
            rowMax = rowMin + fix((rowMax-rowMin) / 2);
        elseif rowRaw(i) == 'B'
            rowMin = rowMin + round((rowMax-rowMin) / 2);
        end
    end
    
    if rowMax ~= rowMin
        error;
    else
        row = rowMax;
    end
    
        
    columnMax = 7;
    columnMin = 0;
    for i=1:length(columnRaw)
        if columnRaw(i) == 'L'
            columnMax = columnMin + fix((columnMax-columnMin) / 2);
        elseif columnRaw(i) == 'R'
            columnMin = columnMin + round((columnMax-columnMin) / 2);
        end
    end
    
    if columnMax ~= columnMin
        error;
    else
        column = columnMax;
    end
    
    id = row * 8 + column;
    
    if id > maxId
        maxId = id;
    end
    

end

maxId
