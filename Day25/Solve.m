clear; clc;
doorPublicKey = 13233401;
cardPublicKey = 6552760;
%% test
%doorPublicKey = 5764801;
%cardPublicKey = 17807724;

%% ищем loop size
n = 0;
value = 1;
while 1
    n = n + 1;
    
    value = value * 7;
    value = mod(value, 20201227);
    
    if value == doorPublicKey
        break;
    end
end

doorLoopSize = n

n = 0;
value = 1;
while 1
    n = n + 1;
    
    value = value * 7;
    value = mod(value, 20201227);
    
    if value == cardPublicKey
        break;
    end
end

cardLoopSize = n

%% test
%cardLoopSize = 8;
%doorLoopSize = 11;
%%
n = 0;
value = 1;
while n<doorLoopSize
    n = n + 1;
    
    value = value * cardPublicKey;
    value = mod(value, 20201227);
end

value

value = 1;
n = 0;
while n<cardLoopSize
    n = n + 1;
    
    value = value * doorPublicKey;
    value = mod(value, 20201227);
end
value
    