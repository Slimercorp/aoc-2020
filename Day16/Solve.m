fid = fopen('inputCuted2.txt');
%% read
tickets = 0;
i = 0;
sum = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    i = i + 1;
    
    semi = strfind(tline,',');
    lastIndex = 1;
    for j=1:length(semi)
        tickets(i,j) = str2num(tline(lastIndex:(semi(j)-1)));
        lastIndex = semi(j)+1;
    end
    tickets(i,j+1) = str2num(tline(lastIndex:end));
        
    %% sum
    if i ~= 1
        for j = 1:20
            valid = false;
            value = tickets(i,j);
            for k=1:length(rules)
                if (value > rules(k,1) && value < rules(k,2)) || (value > rules(k,3) && value < rules(k,4))
                    valid = true;
                    break;
                end
            end

            if ~valid
                sum = sum + value;
            end
            
                
        end
    end

    
   
end

sum