fid = fopen('input.txt');
%% read
result = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    command = tline;
    commandMod = command;
    %% modify
    
    indexs = strfind(command,'+');
    commandMod(
    for i=1:length(indexs)
        commandMod(indexs(i)-1) = ')';
        commandMod(indexs(i)+1) = '(';
    end
    
    result(i,1) = eval(commandMod);
    
   
    
%     parts = "";
%     
%     
%     while 1
%        index = strfind(tline,'(');
%        index2 = strfind(tline,')');
%        
%        for j=1:length(index)
%            part(j) = tline(index(1):index2(1));
%        end
%     end
%     
    
   
end
