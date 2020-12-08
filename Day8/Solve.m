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
accumulator = 0;
n = 0;
minRepeatedCmd = 10;
sequence = "";
stop = false;
lengthMax = 0;
while ~stop
    cmd = cmdList(position,1);
    arg = cmdList(position,2);
    
    n = n + 1;
    sequence = sequence + num2str(cmd);
    
    switch (cmd)
        case 1 %acc
            accumulator = accumulator + arg;
            position = position + 1;

        case 2 %jmp
            position = position + arg;

        case 3 %nop
            position = position + 1;
    end
    accum(n) = accumulator;
    
    lengthSeq = length(sequence{1});
    %% search max length of match
    shift = 1;
    while 1
        lengthToCompare = 3;
        sequenceCuted = string(sequence{1}(shift:lengthSeq));
        lengthSeqCuted = length(sequenceCuted{1});
        while 1
            maxSection = fix(lengthSeqCuted / lengthToCompare);

            if maxSection < 2 || lengthSeqCuted < 2
                break;
            end

            stringToCompare = string(sequenceCuted{1}(1:lengthToCompare));
            
            match = true;
            for i=1:fix(maxSection/2)
                match = match && (string(sequenceCuted{1}(i*lengthToCompare+1:(i+1)*lengthToCompare)) == stringToCompare);
                if ~match
                    break;
                end
            end

            if match
                if lengthToCompare > lengthMax
                    lengthMax = lengthToCompare;
                    lengthMax
                    startLoop = shift
                    endLoop = shift + lengthToCompare
                end
            end

            lengthToCompare = lengthToCompare + 1;

        end
        
        shift = shift + 1;
        
        if shift > lengthSeq
            break;
        end
    end
        
end


%%
accum(endLoop-2)
accum(endLoop-1)
accum(endLoop)
accum(endLoop+1)