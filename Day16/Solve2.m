fid = fopen('inputCuted2.txt');
%% read
tickets = 0;
i = 0;
ticketsValid = zeros(1,20);
d = 0;
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
    validTicket = true;
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
            validTicket = false;
            break;
        end
    end

    if validTicket
        d = d+1;
        ticketsValid(d,:) = tickets(i,:);
    end
   
end

sum
%% work with valid tickets

%search rule
rulesPosition = 0;
for n = 1:20 %номер правила по порядку
    g = 0;
    for j=1:20 %порядковый номер данных в билете
        ruleValid = true;
        for i=1:length(ticketsValid) %номер билета
            value = ticketsValid(i,j);
            inRange = (value >= rules(n,1) && value <= rules(n,2)) || (value >= rules(n,3) && value <= rules(n,4));
            if ~inRange
                ruleValid = false;
                break;
            end
        end
        
        if ruleValid
            g = g + 1;
            rulesPosition(n,g) = j;
        end
        
    end
end
%%
truePosition = 0;
position = -1;
n = 0;
while 1
    n = n + 1;
    for i = 1:20
        countPositions = 0;
        for j = 1:12
            if rulesPosition(i,j) ~= 0
                countPositions = countPositions + 1;
                position = rulesPosition(i,j);
            end
            
            if countPositions > 1
                break;
            end
            
        end
        
        if countPositions == 1
            truePosition(i,1) = position;
            %clean
            for d=1:20
                for y=1:12
                    if rulesPosition(d,y) == position
                        rulesPosition(d,y) = 0;
                    end
                end
            end
        end
        
    end
    
    
    

end  
