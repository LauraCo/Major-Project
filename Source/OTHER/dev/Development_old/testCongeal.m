function [meanIms, adjSer, finalMean, ent, time] = testCongeal(metric,iterations, filename, path)
%function  testCongeal(metric,iterations, filename, path)

addpath IO
addpath UTILITY
addpath CONGEAL_SUPPORT
addpath DE_LUCA_FUZZY
addpath MEMBERSHIP

tic
ser=loadSeries(strcat(path,filename),1,20);
ser=ser/256;

for i=1:size(ser,3)
  sr(:,:,i)=imresize(ser(:,:,i),.5,'bilinear');
end
sr=max(sr,0);
sr=min(sr,1);

%sr=sr(1:end-6,:,:);

[adjSer,meanIms,transVecs,ent]=binaryCongeal(sr,iterations,7,metric);

time = toc
%figure;
%showSer(meanIms,1);
%imwrite(meanIms(:,:,iterations),strcat(path,'/',metric,'_',iterations,'-final_mean.pgm'),'pgm');
finalMean = meanIms(:,:,iterations);

%fid=fopen(strcat(path,'/entropy.txt'),'w+');
%fprintf(fid,'%f \n',ent);
%fclose(fid);
%figure;
%showSer(adjSer,2);