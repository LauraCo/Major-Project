function entropy = hybrid(meanImg)
%HYBRID Summary of this function goes here
%   Detailed explanation goes here

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

%Trapezium A - Low grey-level values

eLow0 = (1 - lowMu).*exp(lowMu);
eLow0 = (1/(lowCount)) * sum(sum(eLow0));

eLow1 = lowMu.*exp(1-lowMu);
eLow1 = (1/(lowCount)) * sum(sum(eLow1));



%Trapezium B - Medium grey-level values


%eMed0 = (1 - medMu).*exp(medMu);
%eMed0 = (1/medCount) * sum(sum(eMed0));

%eMed1 = medMu.*exp(1-medMu);
%eMed1 = (1/medCount) * sum(sum(eMed1));

%Trapezium C - High grey-level values

%eHigh0 = (1 - highMu).*exp(highMu);
%eHigh0 = (1/highCount) * sum(sum(eHigh0));

%eHigh1 = highMu.*exp(1-highMu);
%eHigh1 = (1/highCount) * sum(sum(eHigh1));



hybridLow = -(lowCount / (lowCount+highCount))*log10(1 - eLow0);
hybridLow = hybridLow - (highCount / (lowCount+highCount)*log10(eLow1));

%hybridMed = -(medCount / (medCount+highCount))*log10(1 - eMed0);
%hybridMed = hybridMed - (highCount / (medCount+highCount)*log10(eMed1)); % Do I compare this to low trapezium, high trapezium or both??

%hybridHigh = -(highCount / (lowCount+highCount))*log10(1 - eHigh0);
%hybridHigh = hybridHigh - (lowCount / (lowCount+highCount)*log10(eHigh1));

%if isnan(hybridHigh)
%    hybridHigh = 0;
%end

%fprintf(1,'Hybrid Low %f\n',hybridLow);
%fprintf(1,'Hybrid Med %f\n',hybridMed);
%fprintf(1,'Hybrid High %f\n',hybridHigh);

%totalHybrid = hybridLow + hybridHigh;
entropy = hybridLow; 

end

