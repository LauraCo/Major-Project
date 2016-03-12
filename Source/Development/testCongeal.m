function testCongeal(metric,iterations)

addpath IO
addpath UTILITY
addpath CONGEAL_SUPPORT
addpath DE_LUCA_FUZZY
addpath MEMBERSHIP

ser=loadSeries('big_scan.pgm',1,20);
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
figure;
showSer(adjSer,2);