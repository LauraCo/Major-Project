function entropy = deLucaFuzzy(meanImg)
% Function implementing De Luca & Termini's Fuzzy Entropy algorithm

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

imgMu = membership(meanImg);

dlmwrite('imgMu.txt',imgMu);

%imageEnt = [];

%for i=1:size(imgMu)
    
   % if imgMu{i}==1
  %      pixelEnt = 0;
 %   else

 %   pixelEnt = (imgMu{i}.*log10(imgMu{i})+(1-imgMu{i}).*log10(1-imgMu{i}));
%    end
 %   imageEnt{i} = pixelEnt;
   
%end


%dlmwrite('imageEnt.txt',imageEnt);

persistent entTable;
if size(entTable)==0
  fprintf(1,'Computing entropy lookup table...');  
  for i=1:size(imgMu)
      if imgMu{i}==1
        entTable = 0;
      else
          entTable= (imgMu{i}.*log10(imgMu{i})+(1-imgMu{i}).*log10(1-imgMu{i}));
      end    
  end
  fprintf(1,'done.\n');
end

dlmwrite('entTable.txt',entTable);


%WORKS UP TO HERE

%ent= (sum(sum(entTable(floor(meanImg*9999.999999+1))))); %LAC32 - -K x the sum of the ent, which has been normalised

ent = 1/numel(imgMu)*(sum(entTable));
entropy=ent/numel(meanImg);   % Return mean pixel entropy. %LAC32 - NUMEL is usually faster than PROD

end

