clear; clc;
fid = fopen('input.txt');
%% read
i = 0;
array = [];
data = cell(1);
rowFile = 0;
while 1
    rowFile = rowFile + 1;
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    indexs = strfind(tline,'Tile');
    if isempty(indexs)    
        if isempty(tline)
            continue;
        end
        
        row = 0;
        for j=1:length(tline)
            if tline(j) == '.'
                row(j) = 5;
            elseif tline(j) == '#'
                row(j) = 9;
            else
                row(j) = 0;
            end
        end
        
        if isempty(array)
            array = row;
        else
            array = [array; row];
        end
    else
        if rowFile ~= 1
            i = i + 1;
            frameStruct = struct('id', numberMsg, ...
                                 'frame', array);
            data{i,1} = frameStruct;
        end
        
        lengthTline = length(tline);
        numberMsg = str2num(tline(lengthTline-5:lengthTline-1));
        array = [];
    end

end

%%
puzzleMap = zeros(250,250);
usedIds = 15;

puzzleMap(125,125) = usedIds;
extendedData(125,125) = struct('flipVert', 0, ...
                           'flipHor', 0, ...
                            'rotate', 0);

while 1
    for i=2:249
        for j=2:249
            
            if puzzleMap(i,j) ~= 0 && checkNeigb(puzzleMap,i,j) < 4
                checkId = 1;
                while 1
                    checkId = checkId + 1;

                    if checkId > length(data)
                        break;
                    end

                    indexs = find(usedIds == checkId);
                    if ~isempty(indexs)        
                        continue;
                    end

                    %проверяем через функцию подходит ли к текущему квадрату i,j выбранный
                    %квадрат checkId. Функция проверяет совпадение с каждой из 4-рех
                    %сторон, полностью поворачивая и вращая квадрат. На выходе сообщение
                    %подошло или нет, а если подошло, то в каком положении и на какой
                    %стороне
                    frame1 = data{puzzleMap(i,j)}.frame;
                    flipVert1 = extendedData(i,j).flipVert;
                    flipHor1 = extendedData(i,j).flipHor;
                    rotate1 = extendedData(i,j).rotate;
                    frame1RotatedFlipped = getChangedFrame(frame1, flipVert1, flipHor1, rotate1);

                    frame2 = data{checkId}.frame;
                    [ok, posOriginal, flipVert, flipHor, rotate] = checkFrames(frame1RotatedFlipped, frame2);

                    % по данному сообщению мы ставим его в нужное положение и переходим на
                    % его клетку, записываем его номер в уже использованные квадраты.
                    
                    if ok
                      tempI = i;
                      tempJ = j;
                      switch (posOriginal)
                          case 1
                              tempJ = tempJ -1;
                          case 2
                              tempI = tempI + 1;
                          case 3
                              tempJ = tempJ + 1;
                          case 4
                              tempI = tempI -1;
                      end

                      puzzleMap(tempI,tempJ) = checkId;
                      extendedData(tempI,tempJ) = struct('flipVert', flipVert, ...
                                                 'flipHor', flipHor, ...
                                                 'rotate', rotate);

                      usedIds = [usedIds; checkId];
                      clc;
                      disp(['Совпадений ',num2str(length(usedIds)),'/',num2str(length(data))]);
                    end
                    
                end
            end
        end                    
    end
                
    %проверяем не все ли кадры мы использовали, если да, то прерываем цикл.    
    if length(usedIds) == length(data)
        break;
    end 
    
    
end

% после изменений начального id в data от 1 до 15 и анализу заполнения
% puzzleMap в максимуме 122/143 (видимо баг какой то) было видно, что
% границы пазла это фрагменты которые хранятся в data под номерами 117, 64,
% 135, 23. Остается только получить id frame этих кадров и перемножить. Не
% заполняется  полностью puzzleMap скорее всего из-за какого то бага.
% Возможно его надо будет найти для второй части


%%
function [ok, posOriginal, flipVert, flipHor, rotate] = checkFrames(frame1, frame2)
    % ok - подошло или нет
    % posOriginal - 1 - слева, 2 - снизу, 3 - справа, 4 - сверху
    % flipVert - проверяемый кадр сначала перевернули относительно
    % вертикали 0/1
    % flipHor - проверяемый кадр сначала перевернули относительно
    % горизонтали 0/1
    % rotate - кадр перевернули на 90 градусов против часовой стрелки, сколько
    % раз 0 - 0 раз, 1 - 1 раз и т.д.

    for posOriginal=1:4 
        
        switch (posOriginal)
            case 1
                rowForCompare1 = frame1(:,1);
            case 2
                rowForCompare1 = frame1(10,:);    
            case 3
                rowForCompare1 = frame1(:,10);
            case 4
                rowForCompare1 = frame1(1,:);                
        end
        
        for flipVert = 0:1
            for flipHor = 0:1
                for rotate = 0:3
                    ok = true;
                    frame2Changed = getChangedFrame(frame2, flipVert, flipHor, rotate);
                    
                    switch (posOriginal)
                        case 1
                            rowForCompare2 = frame2Changed(:,10);
                        case 2
                            rowForCompare2 = frame2Changed(1,:);  
                        case 3
                            rowForCompare2 = frame2Changed(:,1);
                        case 4
                            rowForCompare2 = frame2Changed(10,:);                
                    end
                    
                    for i=1:10
                        if rowForCompare1(i) ~= rowForCompare2(i)
                            ok = false;
                            break;
                        end
                    end
                    
                    if ok
                        return;
                    end
                    
                end
            end
        end
        
    end
end


function frameOut = getChangedFrame(frame, flipVert, flipHor, rotate)
    frameOut = frame;
    
    if flipVert
        frameOut = getFlipVertFrame(frame);
    end
    
    if flipHor
        frameOut = getFlipHorFrame(frame);
    end
    
    if rotate ~= 0
        frameOut = getRotateFrame(frame, rotate);
    end

end

function frameOut = getFlipVertFrame(frame)
    frameOut = zeros(10,10);
    for i=1:10
        frameOut(:,i) = frame(:,11-i);
    end
end

function frameOut = getFlipHorFrame(frame)
    frameOut = zeros(10,10);
    for i=1:10
        frameOut(i,:) = frame(11-i,:);
    end
end

function frameOut = getRotateFrame(frame, times)
    frameOut = rot90(frame, times);
end

function neigb = checkNeigb(puzzleMap,i,j)
    neigb = 0;
    %низ
    if puzzleMap(i+1,j) ~= 0
        neigb = neigb + 1;
    end
    
    %верх
    if puzzleMap(i-1,j) ~= 0
        neigb = neigb + 1;
    end
    
    %слева
    if puzzleMap(i,j-1) ~= 0
        neigb = neigb + 1;
    end
    
    %справа
    if puzzleMap(i,j+1) ~= 0
        neigb = neigb + 1;
    end
    
end