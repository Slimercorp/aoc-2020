fid = fopen('input.txt');
%% create map
M = containers.Map('KeyType','char','ValueType','any');
row = 0;
keyCounter = 0;
keyCell = cell(1,1);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    else
        row = row + 1;
    end
    
    %% bags handle
    index = strfind(tline,'bags');
    key = tline(1:index(1)-2);
    keyCounter = keyCounter + 1;
    keyCell{keyCounter,1} = key;
        
    indexNoOther = strfind(tline,'no other');
    if isempty(indexNoOther)
        valueLength = length(index)-1;
        value = cell(valueLength,1);
        value{1} = string(zeros(2,1));
        value{1}(1) = tline(index(1)+13);
        value{1}(2) = tline((index(1)+15):(index(2)-2));

        if valueLength > 1
            for i=2:valueLength
                value{i} = string(zeros(2,1));
                value{i}(1) = tline(index(i)+6);
                value{i}(2) = tline((index(i)+8):(index(i+1)-2));
            end
        end 
        
    else
        value = cell(1,1);
        value{1} = 'NO';
    end

    M(key) = value;
end

%% solve
stringToSearch = string('bright turquoise');
list = M(stringToSearch);