function testCongeal(metric,iterations, filename)

addpath IO
addpath UTILITY
addpath CONGEAL_SUPPORT
addpath DE_LUCA_FUZZY
addpath MEMBERSHIP

ser=loadSeries(filename,1,20);
ser=ser/256;

for i=1:size(ser,3)
  sr(:,:,i)=imresize(ser(:,:,i),.5,'bilinear');
end
sr=max(sr,0);
sr=min(sr,1);

%sr=sr(1:end-6,:,:);

[adjSer,meanIms,transVecs]=binaryCongeal(sr,iterations,7,metric);


figure;
showSer(meanIms,1);
%imwrite(meanIms(:,:,5),'final_mean.pgm','pgm');
figure;
showSer(adjSer,2);