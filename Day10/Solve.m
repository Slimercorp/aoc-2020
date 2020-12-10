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

%% solve
for i=2:length(sortedNumbers)
    diff(i-1,1) = sortedNumbers(i) - sortedNumbers(i-1);
end

indexsOne = find(diff == 1);
indexsThree = find(diff == 3);

(length(indexsOne) + 1) * (length(indexsThree) + 1)