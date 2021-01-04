clear; clc;
fid = fopen('input.txt');
%% read
allergensMap = containers.Map;
keysAllergens = "";
lengthKeysAllergensMap = 0;

ingredientsMap = containers.Map;
keysIngredientsMap = "";
lengthKeysIngredientsMap = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    %% считаем ингредиенты
    index = strfind(tline,"(");
    ingredients = tline(1:index-1); %выделяем текстовую строку ингредиентов
    
    % считаем ингредиенты
    indexsIngr = strfind(ingredients, " ");

    for j = 1:length(indexsIngr)
        if j == 1
            indexFirst = 1;
        else
            indexFirst = indexsIngr(j-1)+1;
        end
        ingredient = ingredients(indexFirst:indexsIngr(j)-1);

        indexTemp = find(keysIngredientsMap == ingredient);
        if isempty(indexTemp) %впервые 
           lengthKeysIngredientsMap = lengthKeysIngredientsMap + 1;
           keysIngredientsMap(lengthKeysIngredientsMap, 1) = ingredient;
           eval(['ingredientsMap(',char(39),ingredient,char(39),') = ',num2str(1),';']);
        else
           eval(['ingredientsMap(',char(39),ingredient,char(39),') = ingredientsMap(',char(39),ingredient,char(39),') + 1;']);
        end
    end
    %% аллергены
    allergens = tline(index+10:end-1); %выделяем текстовую строку аллергенов
    allergens(end+1) = ',';
    indexs = strfind(allergens, ","); %
    
    for i=1:length(indexs)
        if i == 1
            indexFirst = 1;
        else
            indexFirst = indexs(i-1)+2;
        end
        
        allergen = allergens(indexFirst:indexs(i)-1);
        %выделили аллерген, смотрим, для него уже есть данные или нет?
        
        indexTemp = find(keysAllergens == allergen);
        if isempty(indexTemp) %впервые 
            ingredientsStruct = struct;
            indexsIngr = strfind(ingredients, " ");

            for j = 1:length(indexsIngr)
                if j == 1
                    indexFirst = 1;
                else
                    indexFirst = indexsIngr(j-1)+1;
                end
                
                ingredient = ingredients(indexFirst:indexsIngr(j)-1);
                eval(['ingredientsStruct.',ingredient,' = 1;']);
            end
            
            lengthKeysAllergensMap = lengthKeysAllergensMap + 1;
            keysAllergens(lengthKeysAllergensMap) = allergen;
            eval(['allergensMap(',char(39),allergen,char(39),') = ingredientsStruct;']); 
        else
            structAllergen = eval(['allergensMap(',char(39),allergen,char(39),')']);
            indexsIngr = strfind(ingredients, " ");
            
            for j = 1:length(indexsIngr)
                if j == 1
                    indexFirst = 1;
                else
                    indexFirst = indexsIngr(j-1)+1;
                end
                
                ingredient = ingredients(indexFirst:indexsIngr(j)-1);
                if isfield(structAllergen, ingredient)
                    eval(['structAllergen.',ingredient,' = structAllergen.',ingredient,' + 1;']); %increment
                else
                    eval(['structAllergen.',ingredient,' = 1;']); %1 assign
                end
            end
            
            eval(['allergensMap(',char(39),allergen,char(39),') = structAllergen;']); 
        end
           
    end

end

%%

