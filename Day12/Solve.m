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
yaw = 90*pi/180;

for i=1:length(list)
    command = list(i,1);
    value = list(i,2);
    switch command
        case 1
            N = N + value;
        case 2
            N = N - value;
        case 3
            E = E + value;
        case 4
            E = E - value;
        case 5
            yaw = wrapTo2Pi(yaw - value*pi/180);
        case 6
            yaw = wrapTo2Pi(yaw + value*pi/180);
        case 7
            switch (yaw*180/pi)
                case 0
                    N = N + value;
                case 90
                    E = E + value;
                case 180
                    N = N - value;
                case 270
                    E = E - value;
                case 360
                    N = N + value;
                otherwise
                    dfgdfg=1;
            end
        otherwise
            dgfd = 1;
    end
end

abs(N) + abs(E)