clear; clc;
Player1 = [26
16
33
8
5
46
12
47
39
27
50
10
34
20
23
11
43
14
18
1
48
28
31
38
41];

Player2 = [45
7
9
4
15
19
49
3
36
25
24
2
21
37
35
44
29
13
32
22
17
30
42
40
6];
  

% Player1 = [
% 9
% 2
% 6
% 3
% 1
% ];
% 
% Player2 = [
% 5
% 8
% 4
% 7
% 10];
%%
[winner, stack1Out, stack2Out] = getWinner(Player1, Player2);

sum = 0;
lengthStack1=length(stack1Out);
lengthStack2=length(stack2Out);
if winner == 1
    for i=1:lengthStack1
        sum = sum + stack1Out(lengthStack1-(i-1)) * i;
    end
end

if lengthStack2 ~= 0
    for i=1:lengthStack2
        sum = sum + stack2Out(lengthStack2-(i-1)) * i;
    end
end

%%
function [winner, stack1Out, stack2Out] = getWinner(stack1, stack2)
lastStack1 = zeros(length(stack1),1);
lastStack2 = zeros(length(stack2),1);
winner = -1;
lengthStack1 = length(stack1);
lengthStack2 = length(stack2);
while 1
%% Проверка на неизменность колод карт у Игрока 1 и Игрока 2    
    theSame = true;
    for i=1:length(stack1)
        if lastStack1(i) ~= stack1(i)
            theSame = false;
            break;
        end
    end
    
    if theSame
        for i=1:length(stack2)
            if lastStack2(i) ~= stack2(i)
                theSame = false;
                break;
            end
        end
    end
    
    if theSame
        winner = 1;
        break;
    end
    
    lastStack1 = stack1;
    lastStack2 = stack2;

%%
    playCard1 = stack1(1);
    playCard2 = stack2(1);
        
    if lengthStack1 > playCard1 && lengthStack2 > playCard2
        %рекурсивная игра
        newStack1 = stack1(2:playCard1+1);
        newStack2 = stack2(2:playCard2+1);
        
        [winner,~,~]=getWinner(newStack1, newStack2);
        
        if winner == 1
            player1Win = true;
            player2Win = false;
        elseif winner == 2
            player1Win = false;
            player2Win = true;
        else
            error('Ошибка');
        end
        
    else
        %обычная игра
        if playCard1 > playCard2
            player1Win = true;
            player2Win = false;
        else
            player1Win = false;
            player2Win = true; 
        end
    end
    
    if player1Win
        stack1(1:lengthStack1-1) = stack1(2:lengthStack1);
        stack1(lengthStack1) = playCard1;
        stack1(lengthStack1+1) = playCard2;
        lengthStack1 = lengthStack1 + 1;

        stack2(1:lengthStack2-1) = stack2(2:lengthStack2);
        stack2(lengthStack2) = [];
        lengthStack2 = lengthStack2 - 1;
    else
        stack2(1:lengthStack2-1) = stack2(2:lengthStack2);
        stack2(lengthStack2) = playCard2;
        stack2(lengthStack2+1) = playCard1;
        lengthStack2 = lengthStack2 + 1;

        stack1(1:lengthStack1-1) = stack1(2:lengthStack1);
        stack1(lengthStack1) = [];
        lengthStack1 = lengthStack1 - 1;
    end
    
    if lengthStack1 == 0
        winner = 2;
        stack1Out = stack1;
        stack2Out = stack2;
        break;
    end
    
    if lengthStack2 == 0
        winner = 1;
        stack1Out = stack1;
        stack2Out = stack2;
        break;
    end
end
    
end