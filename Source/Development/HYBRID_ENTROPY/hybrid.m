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

eLowMed0 = (1 - medMu).*exp(lowMu); % Likelihood of receiving medium 
eLowMed0 = sum(1/numel(lowMu+medMu)*sum(eLowMed0));

eLowMed1 = (1 - lowMu).*exp(medMu); % Likelihood of receiving medium 
eLowMed1 = sum(1/numel(lowMu+medMu)*sum(eLowMed1));

%Trapezium B - Medium grey-level values

eMedHigh0 = (1 - highMu).*exp(medMu);
eMedHigh0 = sum(1/numel(medMu+highMu)*sum(eMedHigh0));

eMedHigh1 = (1 - medMu).*exp(highMu);
eMedHigh1 = sum(1/numel(medMu+highMu)*sum(eMedHigh1));


%eLowMed0 = lowMu.*exp((1 - medMu) - lowMu);
%eLowMed0 = sum(1/numel(lowMu)*sum(eLowMed0));

%eLowMed1 = ((1 - medMu) - lowMu).*exp(lowMu); % Likelihood of receiving medium 
%eLowMed1 = sum(1/numel(lowMu)*sum(eLowMed1));


%Trapezium B - Medium grey-level values

%eMedHigh0 = medMu.*exp((1 - highMu) - medMu);
%eMedHigh0 = sum(1/numel(medMu)*sum(eMedHigh0));

%eMedHigh1 = ((1 - highMu) - medMu).*exp(medMu);
%eMedHigh1 = sum(1/numel(medMu)*sum(eMedHigh1));





%hybridLow = -lowCount / (lowCount+medCount).*log10(1 - eLowMed0) - (medCount / (lowCount+medCount).*log10(eLowMed1));
%hybridMed = -medCount / (lowCount+medCount+highCount).*log10(1 - eMedHigh0) - ((lowCount+highCount) / (lowCount+medCount+highCount).*log10(eMedHigh1)); % 0.243414

hybridLow = -lowCount / (lowCount+medCount).*log10(1 - eLowMed0) - (medCount / (lowCount+medCount).*log10(eLowMed1));
hybridMed = -medCount / (medCount+highCount).*log10(1 - eMedHigh0) - (highCount / (medCount+highCount).*log10(eMedHigh1)); % 0.242960

%if isnan(hybridHigh)
%    hybridHigh = 0;
%end

totalHybrid = hybridLow + hybridMed;
entropy = totalHybrid / 2; %For 2 comparisons

end

