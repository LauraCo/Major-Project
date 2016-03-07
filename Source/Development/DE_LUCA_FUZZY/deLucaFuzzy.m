function entropy = deLucaFuzzy(meanImg)
% Function implementing De Luca & Termini's Fuzzy Entropy algorithm

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

imgMu = membership(meanImg);

imageEnt = cell(14,14);

for i=1:numel(imgMu)
 if isequal(imgMu{i},1)
      pixelEnt = 0;
 else

    pixelEnt = -(imgMu{i}.*log10(imgMu{i})+(1-imgMu{i}).*log10(1-imgMu{i}));
 end
  imageEnt{i} = pixelEnt;
end

%ent= (sum(sum(imageEnt(floor(meanImg*9999.999999+1))))); %LAC32 - -K x the sum of the ent, which has been normalised

ent = 1/numel(imgMu)*sum(cellfun(@sum, imageEnt));
entropy=sum(ent)/numel(meanImg);   % Return mean pixel entropy. %LAC32 - NUMEL is usually faster than PROD

end

