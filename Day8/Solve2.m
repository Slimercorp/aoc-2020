fid = fopen('input.txt');
k = 0;
cmdList = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    %657 - acc
    %233 - jmp
    %777 - nop
    
    cmd = tline(1:3);
    arg = tline(5:end);
    
    k = k + 1;
    switch (cmd)
        
        case 'acc'
            cmdList(k,1) = 1;
            cmdList(k,2) = str2num(arg);
            
        case 'jmp'
            cmdList(k,1) = 2;
            cmdList(k,2) = str2num(arg);
            
        case 'nop'
            cmdList(k,1) = 3;
            cmdList(k,2) = str2num(arg);
    end
   
end

%% execute
position = 1;
positionPrev = 1;
accumulator = 0;
n = 0;
stop = false;
lineChange = 1;
found = false;
while ~stop
    cmd = cmdList(position,1);
    arg = cmdList(position,2);
    
    n = n + 1;
    
    if (position == lineChange)
       if cmd == 2
           cmd = 3;
       elseif cmd == 3
           cmd = 2;
       end
    end
           
     switch (cmd)
        case 1 %acc
            accumulator = accumulator + arg;
            positionPrev = position;
            position = position + 1;
            
        case 2 %jmp
            positionPrev = position;
            position = position + arg;

        case 3 %nop
            positionPrev = position;
            position = position + 1;
    end
 
    if ((positionPrev == length(cmdList)) && position ~= (length(cmdList) + 1)) || (n > 10000)
        lineChange = lineChange + 1
        n = 0;
        accumulator = 0;
        position = 1;
        positionPrev = 1;
    end
    
    if lineChange > length(cmdList)
        stop = true;
    end
    
    if position == (length(cmdList) + 1)
        stop = true;
        found = true;
    end
end

found
accumulator
