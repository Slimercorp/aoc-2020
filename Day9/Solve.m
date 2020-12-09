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
for i=(preambulaLength+1):length(numbers)
    checkNumber = numbers(i);
    
    preambulaStartIndex = i - preambulaLength;
    preambulaEndIndex = i-1;
    
    found = false;
    for j=preambulaStartIndex:(preambulaEndIndex-1)
        for k = (j+1):preambulaEndIndex
            sum = numbers(j) + numbers(k);
            if sum == checkNumber
                found = true;
            end
        end
    end
    
    if ~found
        i
        checkNumber
        disp('Found!');
        break;
    end
end