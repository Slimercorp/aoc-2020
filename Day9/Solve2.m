fid = fopen('input.txt');
%% read
numbers = 0;
i = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    i = i + 1;
    numbers(i,1) = str2num(tline);
   
end

%% solve
preambulaLength = 25;
invalidNumber = 0;
for i=(preambulaLength+1):length(numbers)
    checkNumber = numbers(i);
    
    preambulaStartIndex = i - preambulaLength;
    preambulaEndIndex = i-1;
    
    found = false;
    for j=preambulaStartIndex:(preambulaEndIndex-1)
        for k = (j+1):preambulaEndIndex
            sum3 = numbers(j) + numbers(k);
            if sum3 == checkNumber
                found = true;
            end
        end
    end
    
    if ~found
        i
        invalidNumber = checkNumber;
        disp('Found!');
        break;
    end
end

%% solve2
startIndex = 0;
endIndex = 0;
stopGeneral = false;
stop = false;
for i=1:length(numbers)
    length1 = 2;
    while ~stop
        
        sum2 = sum(numbers(i:(i+length1)));
        
        if sum2 == invalidNumber
            startIndex = i;
            endIndex = i+length1;
            disp('Found');
            stopGeneral = true;
            break;
        end
        
        if sum2 > invalidNumber
            break;
        else
           length1 = length1 + 1; 
        end
    end
    
    
    if stopGeneral
        break;
    end
end

minValue = min(numbers(startIndex:endIndex));
maxValue = max(numbers(startIndex:endIndex));

minValue + maxValue
