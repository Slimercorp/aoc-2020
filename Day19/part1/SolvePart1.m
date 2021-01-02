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

%% rules handle
availableIndex = [36; 44];
NewA(36, 1) = "b";
NewA(44, 1) = "a";
NewA(36, 4) = "";
NewA(36, 4) = NewA(36, 3);
while 1 
    skipped = 0;
    for i=1:length(A)
        
        if ~isempty(find(availableIndex == i, 1))
            skipped = skipped + 1;
            continue;
        end
            
            
        canDecode = true;
        for j = 1:4
            if ~ismissing(A(i,j))
                indexKnown = false;
                for k = 1:length(availableIndex)
                    if availableIndex(k) == str2num(A(i,j))
                        indexKnown = true;
                        break;
                    end
                end
                
                canDecode = canDecode && indexKnown;
                
                if ~canDecode
                    break;
                end
                
            end
        end
        
        if ~canDecode
            continue;
        end
        
        [lengthPart1,lengthPart2] = getLengthIndex(i,A);
        
        tempLen = 0;
        if lengthPart1 == 1
            index1 = str2num(A(i,1));
            
            lenIndex1 = getLengthIndexNewMatrix(index1,NewA);
            
            for f=1:lenIndex1
                tempLen = tempLen + 1;
                NewA(i,tempLen) = NewA(index1,f);
            end
        end
        
        if lengthPart1 == 2
            index1 = str2num(A(i,1));
            index2 = str2num(A(i,2));
            
            lenIndex1 = getLengthIndexNewMatrix(index1,NewA);
            lenIndex2 = getLengthIndexNewMatrix(index2,NewA);
            
            for f=1:lenIndex1
                for v=1:lenIndex2
                    tempLen = tempLen + 1;
                    NewA(i,tempLen) = NewA(index1,f) + NewA(index2,v);
                end
            end
            
        end
        
        if lengthPart2 == 1
            index1 = str2num(A(i,3));
            
            lenIndex1 = getLengthIndexNewMatrix(index1,NewA);

            for f=1:lenIndex1
                tempLen = tempLen + 1;
                NewA(i,tempLen) = NewA(index1,f);
            end
        end
        
        if lengthPart2 == 2
            index1 = str2num(A(i,3));
            index2 = str2num(A(i,4));
            
            lenIndex1 = getLengthIndexNewMatrix(index1,NewA);
            lenIndex2 = getLengthIndexNewMatrix(index2,NewA);
            
            for f=1:lenIndex1
                for v=1:lenIndex2
                    tempLen = tempLen + 1;
                    NewA(i,tempLen) = NewA(index1,f) + NewA(index2,v);
                end
            end
            
        end
        
        availableIndex = [availableIndex; i];
    end
    
    if skipped >= length(A)-1
        break;
    end
    
end
rules = (NewA(1,:))';
save('rules.mat','rules');
clear all;
%%
function [lengthPart1,lengthPart2] = getLengthIndex(i,A)
    lengthPart1 = 0;
    lengthPart2 = 0;
    for j = 1:4
        if ~ismissing(A(i,j))
            if j<3
                lengthPart1 = lengthPart1 + 1;
            else
                lengthPart2 = lengthPart2 + 1;
            end
        end
    end
end

function [length] = getLengthIndexNewMatrix(i,A)
    length = 0;
    sizeColumn = size(A, 2);
    for j = 1:sizeColumn
        if ~ismissing(A(i,j))
            length = length + 1;
        end
    end
end