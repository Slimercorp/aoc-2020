fid = fopen('inputCuted2.txt');
%% read
map = zeros(40,40,40,40);

map(20,22,20,20) = 1; map(20,23,20,20) = 1; map(20,25,20,20) = 1; map(20,27,20,20) = 1; 
map(21,20,20,20) = 1; map(21,21,20,20) = 1; map(21,26,20,20) = 1; 
map(22,24,20,20) = 1; map(22,25,20,20) = 1; map(22,26,20,20) = 1; map(22,27,20,20) = 1; 
map(23,20,20,20) = 1; map(23,23,20,20) = 1; map(23,24,20,20) = 1;
map(24,20,20,20) = 1; map(24,23,20,20) = 1; map(24,25,20,20) = 1; map(24,26,20,20) = 1; 
map(25,21,20,20) = 1; map(25,24,20,20) = 1; 
map(26,20,20,20) = 1; map(26,21,20,20) = 1; map(26,25,20,20) = 1; map(26,26,20,20) = 1; 
map(27,21,20,20) = 1; map(27,25,20,20) = 1; 

xMin = 19; xMax = 28;
yMin = 19; yMax = 28;
zMin = 19; zMax = 21;
dMin = 19; dMax = 21;

map2 = map;
for n=1:6
    for i=xMin-2:xMax+2
        for j=yMin-2:yMax+2
            for k=zMin-2:zMax+2
               for h=dMin-2:dMax+2
                   if map(i,j,k,h) == 1
                       acitiveNeigb = getActiveNeigb(map,i,j,k,h);
                       if ~(acitiveNeigb == 2 || acitiveNeigb == 3)
                           map2(i,j,k,h) = 0;
                       end
                   else
                       acitiveNeigb = getActiveNeigb(map,i,j,k,h);
                       if acitiveNeigb == 3
                           map2(i,j,k,h) = 1;

                           if i<xMin
                               xMin = i;
                           end

                           if i>xMax
                               xMax = i;
                           end 

                           if j<yMin
                               yMin = j;
                           end

                           if j>yMax
                               yMax = j;
                           end 

                           if k<zMin
                               zMin = k;
                           end

                           if k>zMax
                               zMax = k;
                           end   
                           
                           if h<dMin
                               dMin = h;
                           end

                           if h>dMax
                               dMax = h;
                           end  
                       end

                   end
               end
            end
        end
    end
    
   map = map2;
end
%%
sum5 = 0;
for i=1:40
    for j=1:40
        for k=1:40
            for h=1:40
                if map(i,j,k,h) == 1
                    sum5 = sum5 + 1;
                end
            end
        end
    end
end
sum5

%%
function active = getActiveNeigb(map, x,y,z,d)
    active = 0;
    for i=x-1:x+1
        for j=y-1:y+1
            for k=z-1:z+1
                for h=d-1:d+1

                   if i == x && j == y && k == z && h == d
                       continue;
                   end

                   if map(i,j,k,h) == 1
                       active = active + 1;
                   end
                end
            end
        end
    end
end