function entropy = deLucaFuzzy(meanImg)
% Function implementing De Luca & Termini's Fuzzy Entropy algorithm

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

[imgMu, lowMu, medMu, highMu] = membership(meanImg);

%imageEnt = cell(size(imgMu,1),size(imgMu,2));

    pixelEnt = -(imgMu(1:numel(imgMu)).*log10(imgMu(1:numel(imgMu)))+(1-imgMu(1:numel(imgMu))).*log10(1-imgMu(1:numel(imgMu))));
    
    pixelEnt(isnan(pixelEnt))= 0;

    imageEnt = num2cell(pixelEnt);

ent = 1/numel(imgMu)*sum(cellfun(@sum, imageEnt));
entropy=sum(ent);
end

