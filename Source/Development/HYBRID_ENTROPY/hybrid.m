function entropy = hybrid(meanImg)
%HYBRID Summary of this function goes here
%   Detailed explanation goes here

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

[imgMu, lowMu, medMu, highMu] = membership(meanImg);

lowCount = 0;
medCount = 0;
highCount = 0;

for i=1:numel(imgMu)
    if lowMu(i) > medMu(i) && lowMu(i) > highMu(i)
        lowCount = lowCount + 1;
    elseif medMu(i) > lowMu(i) && medMu(i) > highMu(i)
        medCount = medCount + 1;
    elseif highMu(i) > lowMu(i) && highMu(i) > medMu(i)
        highCount = highCount + 1;
    end
end

%Trapezium A - Low grey-level values

eLow0 = (1 - lowMu).*exp(lowMu);
eLow0 = sum(1/numel(lowMu)*sum(eLow0));

eLow1 = lowMu.*exp(1 - lowMu);
eLow1 = sum(1/numel(lowMu)*sum(eLow1));

%Trapezium B - Medium grey-level values

eMed0 = (1 - medMu).*exp(medMu);
eMed0 = sum(1/numel(medMu)*sum(eMed0));

eMed1 = medMu.*exp(1 - medMu);
eMed1 = sum(1/numel(medMu)*sum(eMed1));

%Trapezium C - High grey-level values

eHigh0 = (1 - highMu).*exp(highMu);
eHigh0 = sum(1/numel(highMu)*sum(eHigh0));

eHigh1 = highMu.*exp(1 - highMu);
eHigh1 = sum(1/numel(highMu)*sum(eHigh1));

hybridLow = -(lowCount / numel(lowMu).*log10(1 - eLow0) - (lowCount / numel(lowMu).*log10(eLow1)));
hybridMed = -(medCount / numel(medMu).*log10(1 - eMed0) - (medCount / numel(medMu).*log10(eMed1)));
hybridHigh = -(highCount / numel(highMu).*log10(1 - eHigh0) - (highCount / numel(highMu).*log10(eHigh1)));

if isnan(hybridHigh)
    hybridHigh = 0;
end

totalHybrid = hybridLow + hybridMed + hybridHigh;
entropy = totalHybrid / 3; %For 3 trapeziums

end

