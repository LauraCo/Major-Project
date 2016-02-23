function entropy = deLucaFuzzy(meanImg)
% Function implementing De Luca & Termini's Fuzzy Entropy algorithm

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

imgMu = membership(meanImg);

persistent entTable;
if size(entTable)==0
  fprintf(1,'Computing entropy lookup table...');
  entTable= imgMu.*log(imgMu)+(1-imgMu).*log(1-imgMu);
  fprintf(1,'done.\n');
end

%WORKS UP TO HERE

ent= (sum(sum(entTable(floor(meanImg*9999.999999+1))))); %LAC32 - -K x the sum of the ent, which has been normalised
entropy=ent/numel(meanImg);   % Return mean pixel entropy. %LAC32 - NUMEL is usually faster than PROD

end

