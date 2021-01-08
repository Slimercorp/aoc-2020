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

    for i=height:96
        j = 1;

        part1 = false;
        part2 = false;
        part3 = false;
        part4 = false;
        while 1
            
            if j>96 || j+1 > 96
                break;
            end
                
            if ~part1 && map(i-1,j) == 9 && map(i,j+1) == 9
                part1Start = j;
                part1 = true;
                j = j + 2;
            end
            
            if j>96 || j+1 > 96 || j+2 > 96 || j+3 > 96
                break;
            end
            
            if part1 && ~part2 && map(i,j) == 9 && map(i-1,j+1) == 9 && map(i-1,j+2) == 9 && map(i,j+3) == 9
                part2Start = j;
                part2 = true;
                j = j + 4;
            end
            
            if j>96 || j+1 > 96 || j+2 > 96 || j+3 > 96
                break;
            end
            
            if part1 && part2 && ~part3 && map(i,j) == 9 && map(i-1,j+1) == 9 && map(i-1,j+2) == 9 && map(i,j+3) == 9
                part3 = true;
                part3Start = j;
                j = j + 4;
            end
            
            if j>96 || j+1 > 96 || j+2 > 96 || j+3 > 96
                break;
             end
            
            if part1 && part2 && part3 && ~part4 && map(i,j) == 9 && map(i-1,j+1) == 9 && map(i-1,j+2) == 9 && map(i-2, j+2) == 9 && map(i-1,j+3) == 9
                part4 = true;
                part4Start = j;
                j = j + 4;
            end
            
            if part1 && part2 && part3 && part4
                countedMonsters = countedMonsters + 1;
                part1 = false;
                part2 = false;
                part3 = false;
                part4 = false;
                
                %mark part1
                map(i-1,part1Start) = 7;
                map(i,part1Start+1) = 7;
                
                %mark part2
                map(i,part2Start) = 7;
                map(i-1,part2Start+1) = 7;
                map(i-1,part2Start+2) = 7;
                map(i,part2Start+3) = 7;
                
                %mark part3
                map(i,part3Start) = 7;
                map(i-1,part3Start+1) = 7;               
                map(i-1,part3Start+2) = 7;
                map(i,part3Start+3) = 7;
                
                %mark part4
                map(i,part4Start) = 7;
                map(i-1,part4Start+1) = 7;
                map(i-1,part4Start+2) = 7;
                map(i-2,part4Start+2) = 7;
                map(i-1,part4Start+3) = 7;
            else
                j = j + 1;
            end
            
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