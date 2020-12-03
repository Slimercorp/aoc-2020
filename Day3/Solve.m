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
timeToExpand = rowMax * slope; 
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

%% count trees
column = 1;
trees = 0;
for i=1:rowMax
    if map(i,column) == 1
        trees = trees + 1;
    end
    column = column + 3;
end
trees