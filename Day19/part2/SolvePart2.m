%% rules handle
load('rawRules.mat');
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
        
        if lengthPart2 == 3
            index1 = str2num(A(i,3));
            index2 = str2num(A(i,4));
            index3 = str2num(A(i,5));
            
            lenIndex1 = getLengthIndexNewMatrix(index1,NewA);
            lenIndex2 = getLengthIndexNewMatrix(index2,NewA);
            lenIndex3 = getLengthIndexNewMatrix(index3,NewA);
            
            for f=1:lenIndex1
                for v=1:lenIndex2
                    for m=1:lenIndex3
                        tempLen = tempLen + 1;
                        NewA(i,tempLen) = NewA(index1,f) + NewA(index2,v) + NewA(index3,m);
                    end
                end
            end
            
        end
        
        availableIndex = [availableIndex; i];
        
    end
    
    if skipped == 131
        break;
    end
    
end
save('almostAllRules.mat','NewA');
clear all;
%%
function [lengthPart1,lengthPart2] = getLengthIndex(i,A)
    lengthPart1 = 0;
    lengthPart2 = 0;
    for j = 1:5
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