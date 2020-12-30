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
    for i=1:length(A)
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
        
        if lengthPart1 == 1
            index1 = str2num(A(i,1));
            
            [lengthIndex1Part1,lengthIndex1Part2] = getLengthIndex(index1,NewA);
            
            NewA(i,1) = NewA(index1,1);
        end
        
        if lengthPart1 == 2
            index1 = str2num(A(i,1));
            index2 = str2num(A(i,2));
            
            [lengthIndex1Part1,lengthIndex1Part2] = getLengthIndex(index1,NewA);
            [lengthIndex2Part1,lengthIndex2Part2] = getLengthIndex(index2,NewA);
            
            NewA(i,1) = NewA(index1,1) + NewA(index2,1);
        end
        
        if lengthPart2 == 1
            index1 = str2num(A(i,3));
            
            [lengthIndex1Part1,lengthIndex1Part2] = getLengthIndex(index1,A);
            
            NewA(i,2) = NewA(index1,1);
        end
        
        if lengthPart2 == 2
            index1 = str2num(A(i,3));
            index2 = str2num(A(i,4));
            
            [lengthIndex1Part1,lengthIndex1Part2] = getLengthIndex(index1,A);
            [lengthIndex2Part1,lengthIndex2Part2] = getLengthIndex(index2,A);
            
            NewA(i,2) = NewA(index1,1) + NewA(index2,1);
        end
        
        availableIndex = [availableIndex; i];
        
        
        
       
    end
    
end

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