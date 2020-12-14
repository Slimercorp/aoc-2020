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

sortedNumbers = sort(numbers);

inputVoltage = 0;
outputVoltage = sortedNumbers(end);

%%
data = [1:outputVoltage]';
data(:,2) = zeros(length(data(:,1)),1);
data(1,2) = 1;
data(2,2) = 2;
data(3,2) = 4;

for i=1:length(sortedNumbers)
    if sortedNumbers(i) == 1 || sortedNumbers(i) == 2 || sortedNumbers(i) == 3
        continue;
    end
    data(sortedNumbers(i),2) = data(sortedNumbers(i)-1,2) + data(sortedNumbers(i)-2,2) + data(sortedNumbers(i)-3,2);   
end

data(outputVoltage)