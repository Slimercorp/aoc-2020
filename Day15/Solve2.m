container = zeros(30000000,1);
container(18) = 1;
container(2) = 2;
container(4) = 3;
container(17) = 4;
container(20) = 5;
container(1) = 6;
nextValue = 0;
i = 6;
while 1
    
    thereis = container(nextValue+1) ~= i && container(nextValue+1) ~= 0;
    
    if ~thereis
        container(nextValue+1) = i;
        nextValue = 0;
    else
        pos = container(nextValue+1);
        container(nextValue+1) = i;
        if pos == i
            nextValue = 0;
        else
            nextValue = i - pos;
        end
    end
       
    i = i + 1;
    
    if mod(i,100000) == 0
        clc;
        disp(['Прогресс=',num2str(i/30000000*100),'%']);
    end
    
    if i == 30000000
        break;
    end
end

nextValue