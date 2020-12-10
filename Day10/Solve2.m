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
outputVoltage = sortedNumbers(end) + 3;

%%
