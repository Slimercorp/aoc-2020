slope = 3;

%% count rows
fid = fopen('input.txt');
rowMax = 0;
columnMax = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    else
        rowMax = rowMax + 1;
        if length(tline) > columnMax
            columnMax = length(tline);
        end
    end

end
%% create map
fid2 = fopen('input.txt');

slope1 = 1;
slope2 = 3;
slope3 = 5;
slope4 = 7;

maxSlope = max([slope1 slope2 slope3 slope4]);


timeToExpand = rowMax * maxSlope; 
map = zeros(rowMax,columnMax * timeToExpand) + 99; %расширяем карту вправу сразу в timeToExpand раза, заполняем ее 99 на всякий
row = 0;

while 1
    tline = fgetl(fid2);
    if ~ischar(tline)
        break;
    else
        row = row + 1;
    end
    
    rowTemp = 0;
    for i=1:length(tline)
        if (tline(i) == '.')
            rowTemp(i) = 0;
        end
        
        if (tline(i) == '#')
            rowTemp(i) = 1;
        end
    end
    
    for i = 1:timeToExpand
        map(row,columnMax*(i-1)+1:columnMax*i) = rowTemp;
    end
   
end

%% count trees slope1
column = 1;
trees1 = 0;
for i=1:rowMax
    if map(i,column) == 1
        trees1 = trees1 + 1;
    end
    column = column + 1;
end

%% count trees slope2
column = 1;
trees2 = 0;
for i=1:rowMax
    if map(i,column) == 1
        trees2 = trees2 + 1;
    end
    column = column + 3;
end
%% count trees slope3
column = 1;
trees3 = 0;
for i=1:rowMax
    if map(i,column) == 1
        trees3 = trees3 + 1;
    end
    column = column + 5;
end
%% count trees slope4
column = 1;
trees4 = 0;
for i=1:rowMax
    if map(i,column) == 1
        trees4 = trees4 + 1;
    end
    column = column + 7;
end

%% count trees slope5
column = 1;
trees5 = 0;
row = 1;
while 1
    if map(row,column) == 1
        trees5 = trees5 + 1;
    end
    
    column = column + 1;
    
    if row == rowMax
        break;
    elseif (row + 1) == rowMax
            row = row + 1;
    elseif (row + 2) <= rowMax
        row = row + 2;
    end
    
        
end

trees1 * trees2 * trees3 * trees4 * trees5

