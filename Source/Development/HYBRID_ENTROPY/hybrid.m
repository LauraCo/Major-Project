function entropy = hybrid(meanImg)
%HYBRID Summary of this function goes here
%   Detailed explanation goes here

addpath /Users/lauracollins/Git/Major-Project/Source/Development/MEMBERSHIP 

[imgMu, lowMu, medMu, highMu] = membership(meanImg);

lowCount = 0;
medCount = 0;
highCount = 0;

if lowMu(1:numel(imgMu)) > medMu(1:numel(imgMu)) && highMu(1:numel(imgMu))
    lowCount = lowCount + 1;
elseif medMu > lowMu && highMu
    medCount = medCount + 1;
elseif highMu > lowMu && medMu
    highCount = highCount + 1;
end


%Trapezium A - Low grey-level values

eLow0 = (1 - lowMu).*exp(lowMu);
eLow0 = 1/size(lowMu)*sum(eLow0);

eLow1 = lowMu.*exp(1 - lowMu);
eLow1 = 1/size(lowMu)*sum(eLow1);

%Trapezium B - Medium grey-level values

eMed0 = (1 - medMu).*exp(medMu);
eMed0 = 1/size(medMu)*sum(eMed0);

eMed1 = medMu.*exp(1 - medMu);
eMed1 = 1/size(medMu)*sum(eMed1);

%Trapezium C - High grey-level values

eHigh0 = (1 - highMu).*exp(highMu);
eHigh0 = 1/size(highMu)*sum(eHigh0);

eHigh1 = highMu.*exp(1 - highMu);
eHigh1 = 1/size(highMu)*sum(eHigh1);

hybridLow = -(lowCount / size(lowMu).*log10(1 - eLow0) - (lowCount / size(lowMu).*log10(eLow1)));
hybridMed = -(medCount / size(medMu).*log10(1 - eMed0) - (medCount / size(medMu).*log10(eMed1)));
hybridHigh = -(highCount / size(highMu).*log10(1 - eHigh0) - (highCount / size(highMu).*log10(eHigh1)));

totalHybrid = hybridLow + hybridMed + hybridHigh;
entropy = totalHybrid / 3; %For 3 trapeziums

end

