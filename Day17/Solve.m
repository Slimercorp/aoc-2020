fid = fopen('inputCuted2.txt');
%% read
map = zeros(500,500,500);
x = 250; y = 250; z = 250;

map(250,252,250) = 1; map(250,253,250) = 1; map(250,255,250) = 1; map(250,257,250) = 1; 
map(251,250,250) = 1; map(251,251,250) = 1; map(251,256,250) = 1; 
map(252,254,250) = 1; map(252,255,250) = 1; map(252,256,250) = 1; map(252,257,250) = 1; 
map(253,250,250) = 1; map(253,253,250) = 1; map(253,254,250) = 1;
map(254,250,250) = 1; map(254,253,250) = 1; map(254,255,250) = 1; map(254,256,250) = 1; 
map(255,251,250) = 1; map(255,254,250) = 1; 
map(256,250,250) = 1; map(256,251,250) = 1; map(256,255,250) = 1; map(256,256,250) = 1; 
map(257,251,250) = 1; map(257,255,250) = 1; 

xMin = 249; xMax = 258;
yMin = 249; yMax = 258;
zMin = 249; zMax = 251;

map2 = map;
for n=1:6
    for i=xMin-2:xMax+2
        for j=yMin-2:yMax+2
            for k=zMin-2:zMax+2
               if map(i,j,k) == 1
                   acitiveNeigb = getActiveNeigb(map,i,j,k);
                   if ~(acitiveNeigb == 2 || acitiveNeigb == 3)
                       map2(i,j,k) = 0;
                   end
               else
                   acitiveNeigb = getActiveNeigb(map,i,j,k);
                   if acitiveNeigb == 3
                       map2(i,j,k) = 1;
                       
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
                   end
                   
               end
            end
        end
    end
    
   map = map2;
end
%%
sum5 = 0;
for i=1:500
    for j=1:500
        for k=1:500
            if map(i,j,k) == 1
                sum5 = sum5 + 1;
            end
        end
    end
end
sum5

%%
function active = getActiveNeigb(map, x,y,z)
    active = 0;
    for i=x-1:x+1
        for j=y-1:y+1
            for k=z-1:z+1
                
               if i == x && j == y && k == z
                   continue;
               end
               
               if map(i,j,k) == 1
                   active = active + 1;
               end
               
            end
        end
    end
end