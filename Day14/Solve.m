fid = fopen('input.txt');
%% read and create map
map = zeros(100000,1);
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
    
    valueBin = dec2bin(uint64(value));
    valueChanged = '';
    
    k = length(valueBin);
    for i = 36:-1:1
        if k > 0
            valueChanged(i) = valueBin(k);
            k = k - 1;
        else
            valueChanged(i) = '0';
        end
    end
    valueChangedTemp = valueChanged;
    for i=1:length(mask{1})
        switch mask{1}(i)
            case '1'
                valueChangedTemp(i) = '1';
            case '0'
                valueChangedTemp(i) = '0';
            case 'X'
                continue;
        end
    end
    map(memIndex) = bin2dec(valueChangedTemp);
    
   
end

sum(map)