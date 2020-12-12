fid = fopen('input.txt');
%% read
numbers = 0;
i = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    i = i + 1;
    command = tline(1);
    value = tline(2:end);
    
    switch command
        case 'N'
            list(i,1) = 1;
            list(i,2) = str2num(value);
        case 'S'
            list(i,1) = 2;
            list(i,2) = str2num(value);
        case 'E'
            list(i,1) = 3;
            list(i,2) = str2num(value);
        case 'W'
            list(i,1) = 4;
            list(i,2) = str2num(value);
        case 'L'
            list(i,1) = 5;
            list(i,2) = str2num(value);
        case 'R'
            list(i,1) = 6;
            list(i,2) = str2num(value);
        case 'F'
            list(i,1) = 7;
            list(i,2) = str2num(value);
    end
end

%% solve
N = 0;
E = 0;

NW = 1;
EW = 10;

for i=1:length(list)
    command = list(i,1);
    value = list(i,2);
    switch command
        case 1
            NW = NW + value;
        case 2
            NW = NW - value;
        case 3
            EW = EW + value;
        case 4
            EW = EW - value;
        case 5
            oldCoord = [NW; EW; 0];
            R = eul2rotm([-value*pi/180 0 0]);
            newCoord = R * oldCoord;
            NW = newCoord(1);
            EW = newCoord(2);
        case 6
            oldCoord = [NW; EW; 0];
            R = eul2rotm([value*pi/180 0 0]);
            newCoord = R * oldCoord;
            NW = newCoord(1);
            EW = newCoord(2);
        case 7
            N = N + NW * value;
            E = E + EW * value;
        otherwise
            dgfd = 1;
    end
end

abs(N) + abs(E)