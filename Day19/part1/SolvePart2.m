%%
clear all; clc;
load('rules.mat');
fid2 = fopen('msgs.txt');
count = 0;
n = 0;
while 1
    n = n + 1
    tline = fgetl(fid2);
    if ~ischar(tline)
        break;
    end
    
    for i = 1:length(rules)
        if rules(i) == tline
            count = count + 1;
            break;
        end
    end
end

count