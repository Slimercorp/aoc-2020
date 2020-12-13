fid = fopen('input.txt');

% idBuses = [7; 13; 59; 31; 19];
% offsets = [1; 4; 6; 7];

%idBuses = [17; 13; 19];
%offsets = [2; 3];

% idBuses = [67; 7; 59; 61];
% offsets = [1; 2; 3];

% idBuses = [67; 7; 59; 61];
% offsets = [2; 3; 4];

% idBuses = [67; 7; 59; 61];
% offsets = [1; 3; 4];

idBuses = [1789; 37; 47; 1889];
offsets = [1; 2; 3];
%% solve
time = 0;
while 1
    time = time + idBuses(1);
    found = true;
    for j = 2:length(idBuses)
        idOkay = mod((time + offsets(j-1)),idBuses(j)) == 0;
        if ~idOkay
            found = false;
        end
    end
    
    if found
        break;
    end
     
end
time