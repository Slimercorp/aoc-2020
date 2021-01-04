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

    
lengthPlayer1 = length(Player1);
lengthPlayer2 = length(Player2);
%%
i = 0;
while 1
    i = i + 1
    playCard1 = Player1(1);
    playCard2 = Player2(1);
        
    if playCard1 > playCard2
        Player1(1:lengthPlayer1-1) = Player1(2:lengthPlayer1);
        Player1(lengthPlayer1) = playCard1;
        Player1(lengthPlayer1+1) = playCard2;
        lengthPlayer1 = lengthPlayer1 + 1;
        
        Player2(1:lengthPlayer2-1) = Player2(2:lengthPlayer2);
        Player2(lengthPlayer2) = [];
        lengthPlayer2 = lengthPlayer2 - 1;
    else
        Player2(1:lengthPlayer2-1) = Player2(2:lengthPlayer2);
        Player2(lengthPlayer2) = playCard2;
        Player2(lengthPlayer2+1) = playCard1;
        lengthPlayer2 = lengthPlayer2 + 1;
        
        Player1(1:lengthPlayer1-1) = Player1(2:lengthPlayer1);
        Player1(lengthPlayer1) = [];
        lengthPlayer1 = lengthPlayer1 - 1;
    end
    
    if lengthPlayer1 == 0 || lengthPlayer2 == 0
        break;
    end
end

sum = 0;
if lengthPlayer1 ~= 0
    for i=1:lengthPlayer1
        sum = sum + Player1(lengthPlayer1-(i-1)) * i;
    end
end

if lengthPlayer2 ~= 0
    for i=1:lengthPlayer2
        sum = sum + Player2(lengthPlayer2-(i-1)) * i;
    end
end
