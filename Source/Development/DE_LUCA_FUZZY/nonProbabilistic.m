function entropy = nonProbabilistic(meanImg)
% AUTHOR: Laura Collins (lac32)
% LAST MODIFIED: 08/04/16
% Function implementing De Luca & Termini's Non-Probabilistic Fuzzy Entropy algorithm
% Changed name 08/04/16 to reflect algorithm's true name

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

[imgMu, lowMu, medMu, highMu] = membership(meanImg);

%imageEnt = cell(size(imgMu,1),size(imgMu,2));

    pixelEnt = -(imgMu(1:numel(imgMu)).*log10(imgMu(1:numel(imgMu)))+(1-imgMu(1:numel(imgMu))).*log10(1-imgMu(1:numel(imgMu))));
    
    pixelEnt(isnan(pixelEnt))= 0;

    imageEnt = num2cell(pixelEnt);

ent = 1/numel(imgMu)*sum(cellfun(@sum, imageEnt));
entropy=sum(ent);
end

