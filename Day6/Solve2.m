fid = fopen('input.txt');
counterMain = 0;
answersOfFirstMan = cell(26,1);
inited = false;
row = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    else
        row = row + 1;
    end
    
    if ~inited
        for i=1:length(tline)
            answersOfFirstMan{i} = tline(i);
        end 
        
        inited = true;
    else
        for i=1:26
            
            if isempty(answersOfFirstMan{i})
                continue;
            end
            
            if isempty(tline)
                break;
            end
  
            thereis = false;
            for j=1:length(tline)
                if answersOfFirstMan{i} == tline(j)
                    thereis = true;
                    break;
                end
            end
            
            if ~thereis
                answersOfFirstMan{i} = [];
            end
            
        end
    end
    
    if isempty(tline)
        counterLocal = 0;
        for i=1:26
            if ~isempty(answersOfFirstMan{i})
                counterLocal = counterLocal + 1;
            end
        end
        
        counterMain = counterMain + counterLocal;

        clear answersOfFirstMan;
        answersOfFirstMan = cell(26,1);
        inited = false;
    end
end

counterMain