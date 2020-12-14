fid = fopen('input.txt');
%% read and create map
M = containers.Map;
keySet = 0;
keySetLength = 0;
mask = "";
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    if tline(1:4) == "mask"
        mask = string(tline(8:end));
        continue;
    end
    
    indexs1 = strfind(tline,'[');
    indexs2 = strfind(tline,']');
    
    memIndex = str2num(tline(indexs1:indexs2));
    value = str2num(tline((indexs2+4):end));
    %%
    memIndexBin = dec2bin(memIndex,36);

    memIndexChangedTemp = memIndexBin;
    driftBits = 0;
    driftBitsLength = 0;
    for i=1:length(mask{1})
        switch mask{1}(i)
            case '1'
                memIndexChangedTemp(i) = '1';
            case '0'
                continue;
            case 'X'
                driftBitsLength = driftBitsLength + 1;
                driftBits(driftBitsLength) = i;
        end
    end
    
    cases = bitshift(1,driftBitsLength);
    for i=1:cases
        caseBin = dec2bin(i-1,driftBitsLength);
        
        for j=1:driftBitsLength
            memIndexChangedTemp(driftBits(j)) = caseBin(j);
        end
        
        key = bin2dec(memIndexChangedTemp);
        thereis = false;
        for j=1:keySetLength
            if keySet(j) == key
                thereis = true;
                break;
            end
        end
        
        if ~thereis
            keySetLength = keySetLength + 1;
            keySet(keySetLength) = key;
        end    
            
        M(string(key)) = value;
    end

end

sum = 0;
for i = 1:keySetLength
    sum = sum + M(string(keySet(i)));
end
sum