addpath IO
addpath UTILITY
addpath CONGEAL_SUPPORT
addpath DE_LUCA_FUZZY
addpath MEMBERSHIP

ser=loadSeries('toy_example.pgm',1,20);
ser=ser/256;

for i=1:size(ser,3)
  sr(:,:,i)=imresize(ser(:,:,i),.5,'bilinear');
end
sr=max(sr,0);
sr=min(sr,1);

%sr=sr(1:end-6,:,:);

[adjSer,meanIms,transVecs]=binaryCongeal(sr,10,7);

figure;
showSer(meanIms,1);
figure;
showSer(adjSer,2);