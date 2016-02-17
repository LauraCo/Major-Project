function entropy = deLucaFuzzy(meanImg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

imgMu = membership(meanImg);

persistent entTable;
if size(entTable)==0
  fprintf(1,'Computing entropy lookup table...');
  entTable= -(imgMu.*ln(imgMu)+(1-imgMu).*ln(1-imgMu));
  fprintf(1,'done.\n');
end

ent= sum(sum(entTable(floor(meanImg*9999.999999+1))));
entropy=ent/numel(meanImg);   % Return mean pixel entropy. %LAC32 - NUMEL is usually faster than PROD

end

