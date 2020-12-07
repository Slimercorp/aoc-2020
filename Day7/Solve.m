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
stringToSearch = string('shiny gold');
step = 0;
iterationsCell=cell(1,1);
listAll = string(zeros(1,1));
stop = false;
while ~stop
    step = step + 1;
    for i = 1:length(stringToSearch)
        list = getBags(M, keyCounter, keyCell, stringToSearch(i));
        
        counterListClean = 0;
        listClean = string(zeros(1,1));
        for j=1:length(list)
            thereis = false;
            
            for k = 1:length(listAll)
                if string(list(j)) == string(listAll(k))
                    thereis = true;
                    break;
                end
            end
            
            if ~thereis
                counterListClean = counterListClean + 1;
                listClean(counterListClean, 1) = list(j);
            end
            
        end
        
        if listClean(1) == '0'
            stop = true;
            break;
        end
        
        if step == 1
            listAll = listClean;
        else
            listAll = [listAll; listClean];
        end
        
    end
    
    stringToSearch = listAll;
    

end

length(listAll)

function list = getBags(M, keyCounter, keyCell, stringToSearch)
    list=string(zeros(1,1));
    counter = 0;
    for i=1:keyCounter
        value = M(keyCell{i});
        if string(value{1}) == string('NO')
            continue;
        else
            
            lengthCell = length(value);

            for j=1:lengthCell
                if string(value{j}(2)) == stringToSearch
                    counter = counter + 1;
                    list(counter, 1) = string(keyCell{i});
                end
            end
            
        end
    end
    
end