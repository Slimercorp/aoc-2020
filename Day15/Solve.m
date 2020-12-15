numbers=zeros(30000000,1);
numbers(1:6) = [17;1;3;16;19;0]; i = 6;
%numbers = [0;3;6]; i = 3;
while 1
    
    thereis = false;
    diff = -1;
    for j=i-1:-1:1
        if numbers(j) == numbers(i)
            thereis = true;
            diff = i - j;
            break;
        end
    end
    
    i = i + 1;

    if thereis
        numbers(i) = diff;
    else
        numbers(i) = 0;
    end
    
    if mod(i,100000) == 0
        clc;
        disp(['Прогресс=',num2str(i/30000000*100),'%']);
    end
    
    if i == 30000000
        break;
    end
    
end

numbers(30000000)