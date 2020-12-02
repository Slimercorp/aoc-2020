for i=1:length(input)
    for j=1:length(input)
        for k=1:length(input)
            if (input(i) + input(j) + input(k)) == 2020
                input(i) * input(j) * input(k)
                break;
            end
        end
    end
end