fid = fopen('input.txt');
            %byr iyr eyr hgt hcl ecl pid cid
mapValid = [ 0   0    0   0  0    0    0   0];
validCounter = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    mapValid(1) = mapValid(1) ||  contains(tline,'byr');
    mapValid(2) = mapValid(2) ||  contains(tline,'iyr');
    mapValid(3) = mapValid(3) ||  contains(tline,'eyr');
    mapValid(4) = mapValid(4) ||  contains(tline,'hgt');
    mapValid(5) = mapValid(5) ||  contains(tline,'hcl');
    mapValid(6) = mapValid(6) ||  contains(tline,'ecl');
    mapValid(7) = mapValid(7) ||  contains(tline,'pid');
    mapValid(8) = mapValid(8) ||  contains(tline,'cid');
    
    if isempty(tline)
        if mapValid(1) && mapValid(2) && mapValid(3) && mapValid(4) && ...
                mapValid(5) && mapValid(6) && mapValid(7) % && mapValid(8)
            validCounter = validCounter + 1;
        end
        mapValid = [ 0   0    0   0  0    0    0   0];
    end

end
