fid = fopen('input.txt');
%% read
timestamp = 1000508;
idBuses = [29; 37; 467; 23; 13; 17; 19; 443; 41];
  
%% solve
time = 0;
i = 1;
events = zeros(2000000, length(idBuses)+1);
events(i, 1) = time;
events(i, 2:(length(idBuses)+1)) = 1;

timeToWait = 0;
idToGo = 0;
while 1
    i = i + 1;
    time = time + 1
    
    events(i,1) = time;
    
    for j=1:length(idBuses)
        if mod(time, idBuses(j)) == 0
            events(i,j+1) = 1;
            if time >= timestamp
                idToGo = idBuses(j);
                timeToWait = time - timestamp;
                break;
            end
        end
    end
end
timeToWait
idToGo
timeToWait * idToGo