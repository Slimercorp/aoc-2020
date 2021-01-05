clear; clc;
input = 523764819;
%input = 389125467;
part1 = 0;
%% decode
sitTemp = num2str(input);
for i=1:length(sitTemp)-1
    index = str2num(sitTemp(i));
    sit(index,1) = str2num(sitTemp(i+1));
end
    
lastValue = str2num(sitTemp(end));
firstValue =  str2num(sitTemp(1));

if part1
    % part1
    steps = 100;
else
    % part2
    maxValue = max(sit);
    for i=maxValue+1:1000000
        sit(lastValue) = i;
        lastValue = i;
    end
    
    steps = 1e7;
end

sit(lastValue) = firstValue;
len = length(sit);
%%
current = str2num(sitTemp(1));

n = 0;
while n<steps

    n = n + 1;
    
    if mod(n,100000) == 0
        clc;
        disp(['Proc = ', num2str(n/steps*100)]);
    end
    
    %% pickup 3 cups
    startCurrent = current;
    currentTemp = current;
    for i = 1:3
        picksUped(1,i) = sit(currentTemp);
        currentTemp = sit(currentTemp);
    end
    
    % break connections
    sit(startCurrent) = sit(currentTemp);

    %% calculate current cup
    dest = current;
    while 1
        dest = dest - 1;
        if dest < 1
            dest = 1000000;
        end
        
        destIndex = find(picksUped == dest);
        
        if isempty(destIndex)
            break;
        end
    end
    
    %% insert pickuped 3 cups
    destAddress = sit(dest);
    
    sit(dest) = picksUped(1,1);
    sit(picksUped(1,3)) = destAddress;
    
    %% new current
    current = sit(current);
    
    
end

current1 = sit(1)
current2 = sit(current1)

current1 * current2