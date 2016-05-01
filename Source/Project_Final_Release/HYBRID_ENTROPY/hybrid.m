function entropy = hybrid(meanImg)
% AUTHOR: Laura Collins (lac32) 
% LAST MODIFIED: 07/04/2016
%
% Function to calculate the hybrid entropy of an image based off of the
% work by Pal & Pal, 1992

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

[imgMu, lowMu, highMu] = hybridMembership(meanImg);


lowCount = 0;
highCount = 0;

for i=1:numel(imgMu)
    if lowMu(i) > highMu(i)
        lowCount = lowCount + 1;
    elseif highMu(i) > lowMu(i)
        highCount = highCount + 1;
    end
end



eLow0 = (1 - lowMu).*exp(lowMu);
eLow0 = (1/(lowCount)) * sum(sum(eLow0));

eLow1 = lowMu.*exp(1-lowMu);
eLow1 = (1/(lowCount)) * sum(sum(eLow1));

hybridLow = -(lowCount / (lowCount+highCount))*log10(1 - eLow0);
hybridLow = hybridLow - (highCount / (lowCount+highCount)*log10(eLow1));

entropy = hybridLow; 

end

