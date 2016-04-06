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

%eLowMed0 = (1 - medMu).*exp(lowMu); % Likelihood of receiving medium 
eLowMed0 = (1 - lowMu).*exp(lowMu);
eLowMed0 = sum(1/(lowCount + medCount)*sum(eLowMed0));


%eLowMed1 = (1 - lowMu).*exp(medMu); % Likelihood of receiving medium 
eLowMed1 = (1 - medMu).*exp(medMu);
eLowMed1 = sum(1/(lowCount + medCount)*sum(eLowMed1));

%Trapezium B - Medium grey-level values

%eMedHigh0 = (1 - highMu).*exp(medMu);
eMedHigh0 = (1 - medMu).*exp(medMu);
eMedHigh0 = 1/(medCount + highCount).*sum(sum(eMedHigh0));

%eMedHigh1 = (1 - medMu).*exp(highMu);
eMedHigh1 = (1 - highMu).*exp(highMu);
eMedHigh1 = sum(1/(medCount + highCount)*sum(eMedHigh1));




hybridLow = -(lowCount / (lowCount+medCount)).*log10(1 - eLowMed0);
hybridLow = hybridLow - (medCount / (lowCount+medCount).*log10(eLowMed1));

hybridMed = -(medCount / (medCount+highCount)).*log10(1 - eMedHigh0);
hybridMed = hybridMed - (highCount / (medCount+highCount).*log10(eMedHigh1));

totalHybrid = hybridLow + hybridMed;
entropy = totalHybrid / 2; %For 2 comparisons

end

