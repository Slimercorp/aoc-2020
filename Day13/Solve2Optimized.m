idBuses = [29; 37; 467; 23; 13; 17; 19; 443; 41];
offsets = [23; 29; 37; 42; 46; 48; 60; 101];




%% solve length 2
time = [3747239727.00000];
steps = 0;
k = 1;
dif = 0;
idBusesTemp = idBuses;
while 1
    time = time + [2547045553.00000];
    found = true;
    for j = 2:length(idBusesTemp)
        idOkay = mod((time + offsets(j-1)),idBusesTemp(j)) == 0;
        if ~idOkay
            found = false;
            break;
        end
    end

    if found
        k = k + 1;
        if k == 1
            steps(k,1) = time;
        end
        steps(k,1) = time
        dif(k,1) = steps(k,1) - steps(k-1,1)
       %break;
    end

end
time