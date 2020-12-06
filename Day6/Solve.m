fid = fopen('input.txt');
counterMain = 0;
counterLocal = 0;
localCellOfQuestions = cell(26,1);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    for i=1:length(tline)
        thereis = false;
        
        %ищем номер вопроса в базе данных группы, кто нибудь уже отвечал на
        %него положительно?
        for j=1:26
            if localCellOfQuestions{j} == tline(i)
                thereis = true;
                break;
            end
        end
        
        %если не отвечал никто, помещаем в базу данных отмеченных
        %положительно на вопрос группой и увеличиваем счетчик на 1
        if ~thereis
            for j=1:26
                if isempty(localCellOfQuestions{j})
                    localCellOfQuestions{j} = tline(i);
                    break;
                end
            end
            counterLocal = counterLocal + 1;
        end
        
    end
    
    if isempty(tline)
        counterMain = counterMain + counterLocal;
        counterLocal = 0;
        clear localCellOfQuestions;
        localCellOfQuestions = cell(26,1);
    end
end

counterMain