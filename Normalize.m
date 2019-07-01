[channels, Ln] = size(HbO);

for j = 1:channels
    u = mean(HbO(j, :));
    sd = sqrt(var(HbO(j, :)));
    
    HbO(j, :) = (HbO(j, :) - u)/(2 * sd);
    
    u = mean(HbR(j, :));
    sd = sqrt(var(HbR(j, :)));
    
    HbR(j, :) = (HbR(j, :) - u)/(2 * sd);

end