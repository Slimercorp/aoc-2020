clear; clc;
fid = fopen('input.txt');
%% read
commands = 0;
row = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    row = row + 1;
    
    i = 1;
    k = 0;
    len = length(tline);
    
    % e = 4
    % se = 5
    % sw = 6
    % w = 7
    % nw = 8
    % ne = 9
    while 1
        switch (tline(i))
            case 'e'
                i = i + 1;
                k = k + 1;
                commands(row,k) = 4;
            case 'w'
                i = i + 1;
                k = k + 1;
                commands(row,k) = 7;
            case 's'
                if tline(i+1) == 'e'
                    i = i + 2;                    
                    k = k + 1;
                    commands(row,k) = 5;
                elseif tline(i+1) == 'w'
                    i = i + 2;                    
                    k = k + 1;
                    commands(row,k) = 6;
                else
                    error('Ошибка');
                end
                
            case 'n'
                if tline(i+1) == 'e'
                    i = i + 2;                    
                    k = k + 1;
                    commands(row,k) = 9;
                elseif tline(i+1) == 'w'
                    i = i + 2;                    
                    k = k + 1;
                    commands(row,k) = 8;
                else
                    error('Ошибка');
                end
        end
        
        if i>len
            break;
        end
                
    end
    
end

commands(:,end+1) = 0;
%%
map = zeros(5000,5000);
for n=1:size(commands,1)
    i = 2500;
    j = 2500;
    
    % e = 4
    % se = 5
    % sw = 6
    % w = 7
    % nw = 8
    % ne = 9
    for m=1:size(commands,2)
        if commands(n,m) ~= 0
            switch commands(n,m)
                case 4 %восток
                    j = j + 2;
                case 5 %юго восток
                    j = j + 1;
                    i = i + 1;
                case 6 %юго запад
                    j = j - 1;
                    i = i + 1;
                case 7 %запад
                    j = j - 2;
                case 8 %северо запад
                    j = j - 1;
                    i = i - 1;
                case 9 %северо восток
                    i = i - 1;
                    j = j + 1;
            end
            
        else
            if map(i,j) == 1
                map(i,j) = 0;
            else
                map(i,j) = 1;
            end
            
            break;
        end
    end
end
%%
sum(map,'all')
%%
n = 1;
while n<101
    mapNew = map;
    for i=3:4995
        for j=3:4995
           count = getNgbBlack(map, i, j);
           
           if map(i,j) == 0
               if count == 2
                   mapNew(i,j) = 1;
               end
           else
               if count == 0 || count > 2
                   mapNew(i,j) = 0;
               end
           end
        end
    end
    
    map = mapNew;
    
    disp(['Day = ', num2str(n),' black tiles = ', num2str(sum(map,'all'))]);
    n = n + 1;
end

%%
function count = getNgbBlack(map, i, j)
count = 0;

%восток
if map(i,j+2) == 1
    count = count + 1;
end

%юго восток
if map(i+1,j+1) == 1
    count = count + 1;
end

%юго запад
if map(i+1,j-1) == 1
    count = count + 1;
end

%запад
if map(i,j-2) == 1
    count = count + 1;
end

%северо запад
if map(i-1,j-1) == 1
    count = count + 1;
end

%северо восток
if map(i-1,j+1) == 1
    count = count + 1;
end

end