addpath IO
addpath UTILITY
addpath CONGEAL_SUPPORT

ser=loadSeries('train_30_shuf.pbm',1,20);
ser=ser/256;

for i=1:size(ser,3)
  sr(:,:,i)=imresize(ser(:,:,i),.5,'bilinear');
end
sr=max(sr,0);
sr=min(sr,1);

%sr=sr(1:end-6,:,:);

[adjSer,meanIms,transVecs]=binaryCongeal(sr,20,7);

showSer(meanIms,1);
showSer(adjSer,2);
