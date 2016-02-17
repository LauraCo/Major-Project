function entropy = deLucaFuzzy( meanImg )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


persistent entTable;
if size(entTable)==0
  fprintf(1,'Computing entropy lookup table...');
  mu = membership();
  entTable= -(mu.*ln(mu)+(1-mu).*ln(1-mu));
  fprintf(1,'done.\n');
end

ent= sum(sum(entTable(floor(meanImg*9999.999999+1))));
entropy=ent/prod(size(meanImg));   % Return mean pixel entropy.

end

