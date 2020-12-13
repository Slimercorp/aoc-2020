idBuses = [29; 37; 467; 23; 13; 17; 19; 443; 41];
%offsets = [23; 6; 8; 5; 4; 2; 12; 41];
offsets = [23; 29; 37; 42; 46; 48; 60; 101];
  
%% solve
time = 100000000000000;
while 1
    time = time + idBuses(1);
    found = true;
    for j = 2:length(idBuses)
        idOkay = mod((time + offsets(j-1)),idBuses(j)) == 0;
        if ~idOkay
            found = false;
            break;
        end
    end
    
    if found
        break;
    end
     
end
time