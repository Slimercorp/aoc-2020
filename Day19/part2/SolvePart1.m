clear; clc;

fid = fopen('rules.txt');
%% rules row
result = 0;
A(36,1) = "b";
A(44,1) = "a";

while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    indexsSemi = strfind(tline,':');
    index = str2num(tline(1:indexsSemi(1)-1))+1;
    
    if index == 9
        dfgdfg=1;
    end
    
    
    indexsPalka = strfind(tline,'|');
    if ~isempty(indexsPalka)
        part1 = tline((indexsSemi(1)+2):(indexsPalka(1)-2));
        index3 = strfind(part1," ");
        
        if isempty(index3)
            A(index,1) = num2str(str2num(part1) + 1);
        else
            A(index,1) = num2str(str2num(part1(1:index3-1)) + 1);
            A(index,2) = num2str(str2num(part1(index3+1:end)) + 1);    
        end
        
        part2 = tline((indexsPalka(1)+2:end));
        index3 = strfind(part2," ");
        
        if isempty(index3)
            A(index,3) = num2str(str2num(part2) + 1);
        else
            A(index,3) = num2str(str2num(part2(1:index3-1)) + 1);
            A(index,4) = num2str(str2num(part2(index3+1:end)) + 1);    
        end
    else
        part1 = tline((indexsSemi(1)+2):end);
        index3 = strfind(part1," ");
        
        if isempty(index3)
            A(index,1) = num2str(str2num(part1) + 1);
        else
            A(index,1) = num2str(str2num(part1(1:index3-1)) + 1);
            A(index,2) = num2str(str2num(part1(index3+1:end)) + 1);    
        end
        

    end
end
save('rawRules.mat','A');
clear all;