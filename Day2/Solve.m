fid = fopen('input.txt');
validCounter = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    indexs1 = find(tline == '-');
    indexs2 = find(tline == ' ');
    minValue = str2num(tline(1:indexs1(1)-1));
    maxValue = str2num(tline(indexs1(1)+1:indexs2(1)-1));

    charToLimit = tline(indexs2(1)+1);
    
    indexs3 = find(tline == ':');
    
    string = tline((indexs3(1)+2):end);
    
    counter = 0;
    for i=1:length(string)
        if string(i) == charToLimit
            counter = counter + 1;
        end
    end
    
    if counter >= minValue && counter <= maxValue
        validCounter = validCounter + 1;
    end
   
end