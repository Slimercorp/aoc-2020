fid = fopen('input.txt');
%% read and create map
numbers = 0;
row = 0;
map = [1 1];
column = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    row = row + 1;
    columnMax = length(tline);
    for j=1:columnMax
        if tline(j) == 'L'
            map(row, j) = 0;
        elseif tline(j) == '.'
            map(row,j) = 2;
        end
    end
   
end

rowMax = row;
%% simulate
thereisChange = true;
iterations = 0;
map2 = map;
while thereisChange
    iterations = iterations + 1;
    thereisChange = false;
    countChanges = 0;

    %% occupy free seats
    for i=1:rowMax
        for j=1:columnMax
            
            if i == 55 && j == 55
                dfgdf = 1;
            end
            
            if countOccupiedSeatsAround(map,i,j,rowMax,columnMax) == 0 && map(i,j) ~= 2 && map(i,j)~=1
                map2(i,j) = 1;
                thereisChange = true;
                countChanges = countChanges + 1;
            end
        end
    end
    map = map2;
    %% free occupy seats
    for i=1:rowMax
        for j=1:columnMax
            
            if map(i,j) ~= 1
                continue;
            end
            
            if countOccupiedSeatsAround(map,i,j,rowMax,columnMax) > 3
                map2(i,j) = 0;
                thereisChange = true;
                countChanges = countChanges + 1;
            end
        end
    end
    map = map2;
    countChanges
    
end

iterations

%% count
countOccupy = 0;
for i=1:rowMax
    for j=1:columnMax
        if map(i,j) == 1
            countOccupy = countOccupy + 1;
        end
    end
end
countOccupy
%%
function countOccupied = countOccupiedSeatsAround(map,i,j, rowMax, columnMax)
    countOccupied = 0;
    for k = -1:1
        for l=-1:1
            row = i + k;
            column = j + l;
            if row <= 0 || column <=0 || row > rowMax || column > columnMax || ((row == i) && (column == j))
                continue;
            end
            
            if map(row,column) == 1
                countOccupied = countOccupied + 1;
            end
        end
    end
end