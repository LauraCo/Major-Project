function [meanIms, adjSer, finalMean, ent, time] = testCongeal(metric,iterations, filename, path)

%  Part of the existing code base from the Congealing Demo
%      MODIFIED BY: Laura Collins (lac32) 
%      LAST MODIFIED: 08/04/2016
   

addpath IO
addpath UTILITY
addpath CONGEAL_SUPPORT
addpath NON_PROB_ENTROPY
addpath MEMBERSHIP
addpath GUI

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

time = toc;

finalMean = meanIms(:,:,iterations);

fid=fopen(strcat(path,'/entropy.txt'),'w+');
fprintf(fid,'%f \n',ent);
fclose(fid);
%figure;
%showSer(adjSer,2);

%figure;
%showSer(meanIms,1);
imwrite(meanIms(:,:,iterations),strcat(path,'/',metric,'_',iterations,'-final_mean.pgm'),'pgm');
