fid = fopen('input.txt');
            %byr iyr eyr hgt hcl ecl pid cid
mapValid = [ 0   0    0   0  0    0    0   0];
validCounter = 0;
passport = cell(1,8);
while 1

    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    index = strfind(tline, 'byr:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{1})
        passport{1} = tline((index+4):indexValueEnd);
    end
    
    index = strfind(tline, 'iyr:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{2})
        passport{2} = tline((index+4):indexValueEnd);
    end
    
    index = strfind(tline, 'eyr:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{3})
        passport{3} = tline((index+4):indexValueEnd);
    end
    
    index = strfind(tline, 'hgt:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{4})
        passport{4} = tline((index+4):indexValueEnd);
    end
    
    index = strfind(tline, 'hcl:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{5})
        passport{5} = tline((index+4):indexValueEnd);
    end
    
    index = strfind(tline, 'ecl:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{6})
        passport{6} = tline((index+4):indexValueEnd);
    end
    
    index = strfind(tline, 'pid:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{7})
        passport{7} = tline((index+4):indexValueEnd);
    end
     
    index = strfind(tline, 'cid:');
    indexValueEnd = strfind(tline(index:end),' ');
    if isempty(indexValueEnd)
        indexValueEnd = length(tline);
    else
        indexValueEnd = index + indexValueEnd - 2;
    end
    if isempty(passport{8})
        passport{8} = tline((index+4):indexValueEnd);
    end
   
    
    if isempty(tline)
                  %byr iyr eyr hgt hcl ecl pid cid
        %byr
        if ~isempty(passport{1})
            if str2num(passport{1}) >=1920 &&  str2num(passport{1}) <=2002
                mapValid(1) = 1;
            end
        end
        
        %iyr
        if ~isempty(passport{2})
            if str2num(passport{2}) >=2010 &&  str2num(passport{2}) <=2020
                mapValid(2) = 1;
            end
        end
        
        %eyr
        if ~isempty(passport{3})
            if str2num(passport{3}) >=2020 &&  str2num(passport{3}) <=2030
                mapValid(3) = 1;
            end
        end

        %hgt
        if contains(passport{4},'in')
            if length(passport{4}) == 4
                if str2num(passport{4}(1:2)) >= 50 && str2num(passport{4}(1:2)) <= 76
                    mapValid(4) = 1;
                end
            end
        elseif contains(passport{4},'cm')
            if length(passport{4}) == 5
                if str2num(passport{4}(1:3)) >= 150 && str2num(passport{4}(1:3)) <= 193
                    mapValid(4) = 1;
                end
            end
        end
        
        %hcl
        valid51 = contains(passport{5},'#');
        valid52 = 0;
        if length(passport{5}) == 7
            valid52 = 1;
            for i=2:7
                valid52 = valid52 && (passport{5}(i) == '0' || passport{5}(i) == '1' || passport{5}(i) == '2' || passport{5}(i) == '3' || passport{5}(i) == '4' || passport{5}(i) == '5' || passport{5}(i) == '6' || passport{5}(i) == '7' || passport{5}(i) == '8' || passport{5}(i) == '9' ||  ...
                                      passport{5}(i) == 'a' || passport{5}(i) == 'b' || passport{5}(i) == 'c' || passport{5}(i) == 'd' || passport{5}(i) == 'e' || passport{5}(i) == 'f');
            end
        end
        
        if valid51 && valid52
            mapValid(5) = 1;
        end
        
        %eye
        if  length(passport{6}) == 3
            mapValid(6) =   (contains(passport{6},'amb') || ...
                            contains(passport{6},'blu') || ...
                            contains(passport{6},'brn') || ...
                            contains(passport{6},'gry') || ...
                            contains(passport{6},'grn') || ...
                            contains(passport{6},'hzl') || ...
                            contains(passport{6},'oth'));
        end
        % pid
        if ~isempty(passport{7})
            mapValid(7) = length(num2str(passport{7})) == 9;
        end
        
        
        if mapValid(1) && mapValid(2) && mapValid(3) && mapValid(4) && ...
                mapValid(5) && mapValid(6) && mapValid(7) % && mapValid(8)
            validCounter = validCounter + 1;
        end
        mapValid = [ 0   0    0   0  0    0    0   0];
        clear passport;
        passport = cell(1,8);
    end

end
