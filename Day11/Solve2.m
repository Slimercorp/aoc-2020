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
            
            if countOccupiedSeatsNewLogic(map,i,j,rowMax,columnMax) == 0 && map(i,j) ~= 2 && map(i,j)~=1
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
            
            if i == 90 && j == 1
                dfgdf = 1;
            end
            
            countOccupied = countOccupiedSeatsNewLogic(map,i,j,rowMax,columnMax);
            if countOccupied > 4
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

function countOccupied = countOccupiedSeatsNewLogic(map,i,j, rowMax, columnMax)
    countOccupied = 0;
    
    %% right
    occupied = false;
    newColumn = j;
    while 1
       newColumn = newColumn + 1;
       
       if newColumn > columnMax
           break;
       end
       
       if map(i,newColumn) == 0
           break;
       end
       
        if map(i,newColumn) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
    
    %% left
    occupied = false;
    newColumn = j;
    while 1
       newColumn = newColumn - 1;
       
       if newColumn < 1
           break;
        end
       
       if map(i,newColumn) == 0
           break;
       end
       
        if map(i,newColumn) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
    
    %% up
    occupied = false;
    newRow = i;
    while 1
       newRow = newRow - 1;
       
       if newRow < 1
           break;
       end
        
       if map(newRow,j) == 0
           break;
       end
       
        if map(newRow,j) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
    
    %% down
    occupied = false;
    newRow = i;
    while 1
       newRow = newRow + 1;
       
       if newRow > rowMax
           break;
       end
       
       if map(newRow,j) == 0
           break;
       end
       
        if map(newRow,j) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
    
    %% left-up
    occupied = false;
    newRow = i;
    newColumn = j;
    while 1
       newRow = newRow - 1;
       newColumn = newColumn - 1;
       
       if newRow < 1 || newColumn < 1
           break;
       end         
       
       if map(newRow,newColumn) == 0
           break;
       end
       
        if map(newRow,newColumn) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
        
    %% right-up
    occupied = false;
    newRow = i;
    newColumn = j;
    while 1
       newRow = newRow - 1;
       newColumn = newColumn + 1;
       
       if newRow < 1 || newColumn > columnMax
           break;
       end     
       
       if map(newRow,newColumn) == 0
           break;
       end
       
        if map(newRow,newColumn) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
    
    %% left-down
    occupied = false;
    newRow = i;
    newColumn = j;
    while 1
       newRow = newRow + 1;
       newColumn = newColumn - 1;
       
       if newRow > rowMax || newColumn < 1
           break;
       end       
       
       if map(newRow,newColumn) == 0
           break;
       end
       
        if map(newRow,newColumn) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
    
    %% right-down
    occupied = false;
    newRow = i;
    newColumn = j;
    while 1
       newRow = newRow + 1;
       newColumn = newColumn + 1;
       
       if newRow > rowMax || newColumn > columnMax
           break;
       end       
       
       if map(newRow,newColumn) == 0
           break;
       end
       
        if map(newRow,newColumn) == 1
           occupied = true;
           break;
        end
    end
    
    if occupied
        countOccupied = countOccupied + 1;
    end
end