clear; clc;
%input = 523764819;
input = 389125467;
sitTemp = num2str(input);

for i=1:length(sitTemp)
    sit(i) = str2num(sitTemp(i));
end

maxValue = max(sit);
value = maxValue;
for i=length(sit):1000000
    value = value + 1;
    sit(i) = value;
end

len = length(sit);
picksUped = [-1 -1 -1];
%%
current = sit(1);
currentIndex = 1;

n = 0;
while n<10000000   
    n = n + 1;
    if (mod(n,100) == 0)
        disp(['N = ',num2str(n)]);
    end
    
    %% pickup 3 cups
    for i = 1:3
        indexNeed = currentIndex + i;
        if indexNeed > len
            indexNeed = indexNeed - len;
        end
        picksUped(1,i) = sit(indexNeed);
    end
    
    % clean
    for i = 1:3
        index = find(sit == picksUped(1,i));
        sit(index) = [];
    end
    
    %% calculate current cup
    dest = current;
    while 1
        dest = dest - 1;
        if dest < 1
            dest = 9;
        end
        
        destIndex = find(sit == dest);
        
        if ~isempty(destIndex)
            break;
        end
    end
    
    %% insert pickuped 3 cups
    sitNew = [sit(1:destIndex) picksUped sit(destIndex+1:end)];
    sit = sitNew;
    %% new current
    currentIndex = find(sit == current);
    currentIndex = currentIndex + 1;
    if currentIndex > len
        currentIndex = currentIndex - len;
    end
    current = sit(currentIndex);
    
    
end

index = find(sit == 1);
sit(index+1)
sit(index+2)

sit(index+1) * sit(index+2)
