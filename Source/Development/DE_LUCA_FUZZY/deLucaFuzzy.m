function entropy = deLucaFuzzy(meanImg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

imgMu = membership(meanImg);


%disp(imgMu);


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

