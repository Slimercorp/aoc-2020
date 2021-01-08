clear; clc;
load('part1.mat');
%% clean borders
for i=1:length(data)
    frame = data{i}.frame;
    data{i}.frame = frame(2:9,2:9);
end

%% build image
fullMap=zeros(96,96);
for i=1:12
    for j=1:12
        frame = data{puzzleMap(i,j)}.frame;
        flipVert = extendedData(i,j).flipVert;
        flipHor = extendedData(i,j).flipHor;
        rotate = extendedData(i,j).rotate;
        frameChanged = getChangedFrame8(frame, flipVert, flipHor, rotate);
        
        fullMap((i-1)*8+1:i*8,(j-1)*8+1:j*8) = frameChanged;
    end
end

%% search orientation, count monsters and mark their on map
maxMonsters = 0;
changeData = struct('flipVert', 0, ...
                         'flipHor', 0, ...
                         'rotate', 0);
for flipVert = 0:1
    for flipHor = 0:1
        for rotate = 0:3
            ok = true;
            fullMapChanged = getChangedFrame96(fullMap, flipVert, flipHor, rotate);
            
            [countedMonsters,fullMapMarked] = countAndMarkMonstersOnFrame(fullMapChanged);

            if countedMonsters > maxMonsters
                fullMapWithMonsters = fullMapMarked;
                maxMonsters = countedMonsters;
                changeData = struct('flipVert', flipVert, ...
                         'flipHor', flipHor, ...
                         'rotate', rotate);
            end
        end
    end
end

%% output to file
fid = fopen('output.txt','w');
for i=1:96
    for j=1:96
        if fullMapWithMonsters(i,j) == 5
            fwrite(fid,'.');
        end
        
        if fullMapWithMonsters(i,j) == 9
            fwrite(fid,'#');
        end
        
        if fullMapWithMonsters(i,j) == 7
            fwrite(fid,'O');
        end
    end
    fwrite(fid,newline );
end

%%
counter = 0;
for i=1:96
    for j=1:96
        if fullMapWithMonsters(i,j) == 9
            counter = counter + 1;
        end
    end
end

counter

function frameOut = getChangedFrame8(frame, flipVert, flipHor, rotate)
    frameOut = frame;
    
    if flipVert
        frameOut = getFlipVertFrame8(frameOut);
    end
    
    if flipHor
        frameOut = getFlipHorFrame8(frameOut);
    end
    
    if rotate ~= 0
        frameOut = getRotateFrame(frameOut, rotate);
    end

end

function frameOut = getChangedFrame96(frame, flipVert, flipHor, rotate)
    frameOut = frame;
    
    if flipVert
        frameOut = getFlipVertFrame96(frameOut);
    end
    
    if flipHor
        frameOut = getFlipHorFrame96(frameOut);
    end
    
    if rotate ~= 0
        frameOut = getRotateFrame(frameOut, rotate);
    end

end


function [countedMonsters,mapChanged] = countAndMarkMonstersOnFrame(map)

    height = 3;
    countedMonsters = 0;
    lenMonster = 20;

    for i=height:96
        for j=1:(96-lenMonster)
                % part1
                if ~(map(i-1,j) == 9)
                    continue;
                end
                
                if ~(map(i,j+1) == 9)
                    continue;
                end
                
                % part2
                if ~(map(i,j+4) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+5) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+6) == 9)
                    continue;
                end
                
                if ~(map(i,j+7) == 9)
                    continue;
                end
                
                % part3
                if ~(map(i,j+10) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+11) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+12) == 9)
                    continue;
                end
                
                if ~(map(i,j+13) == 9)
                    continue;
                end
                
                %part4
                if ~(map(i,j+16) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+17) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+18) == 9)
                    continue;
                end
                
                if ~(map(i-2,j+18) == 9)
                    continue;
                end
                
                if ~(map(i-1,j+19) == 9)
                    continue;
                end
                
                countedMonsters = countedMonsters + 1;
                
                %mark part1
                map(i-1,j) = 7;
                map(i,j+1) = 7;
                
                %mark part2
                map(i,j+4) = 7;
                map(i-1,j+5) = 7;
                map(i-1,j+6) = 7;
                map(i,j+7) = 7;
                
                %mark part3
                map(i,j+10) = 7;
                map(i-1,j+11) = 7;               
                map(i-1,j+12) = 7;
                map(i,j+13) = 7;
                
                %mark part4
                map(i,j+16) = 7;
                map(i-1,j+17) = 7;
                map(i-1,j+18) = 7;
                map(i-2,j+18) = 7;
                map(i-1,j+19) = 7;
                
        end
    end
mapChanged = map;

end


function frameOut = getFlipHorFrame96(frame)
    frameOut = zeros(96,96);
    for i=1:96
        frameOut(i,:) = frame(97-i,:);
    end
end

function frameOut = getFlipVertFrame96(frame)
    frameOut = zeros(96,96);
    for i=1:96
        frameOut(:,i) = frame(:,97-i);
    end
end

function frameOut = getRotateFrame(frame, times)
    frameOut = rot90(frame, times);
end

function frameOut = getFlipHorFrame8(frame)
    frameOut = zeros(8,8);
    for i=1:8
        frameOut(i,:) = frame(9-i,:);
    end
end

function frameOut = getFlipVertFrame8(frame)
    frameOut = zeros(8,8);
    for i=1:8
        frameOut(:,i) = frame(:,9-i);
    end
end