    % This function takes a series of images and returns 
% three things, an adjSer which are the congealed images,
% the meanIms, which are arrays of histograms of values,
% and xfrms, an array of transforms mapping the 
%
% Note that the images are not necessary binary, but they
% are congealed under the "binary image model".
function [adjSer,meanIms,transVecs, entropy_count]=binaryCongeal(ser,numIters,par_count,metric)

addpath IO
addpath UTILITY
addpath DE_LUCA_FUZZY

[x,y,imgCount]=size(ser);
meanIms(:,:,1)=mean(ser,3); 
curMean=meanIms(:,:,1);

transVecs=zeros(imgCount,par_count);
oldTransVecs=transVecs;

entropy_count = size(numIters);

for iters=1:numIters       % Until convergence?
    %tic
  fprintf(1,'Iteration %d\n',iters);
  for i=1:imgCount
    %i
    % Change the transformation vector so that the current image
    % is more likely under the current mean.
    transVecs(i,:)=incrTrans(curMean,imgCount,ser(:,:,i),oldTransVecs(i,:),metric);
  end

  transVecs=transVecs-repmat(mean(transVecs,1),[imgCount 1]);
  adjSer=computeXfrmImgs(ser,transVecs);
  curMean=mean(adjSer,3);
  
  if strcmp(metric,'deLuca')
      ent=deLucaFuzzy(curMean);
  elseif  strcmp(metric,'shannon')
      ent=fastEntLookup(curMean);
  elseif  strcmp(metric,'hybrid')
      ent=hybrid(curMean);
  else fprintf(2, 'Error in chosing alignment metric');
  end
  
  
  fprintf(1,'Current entropy: %f\n',ent);
  meanIms(:,:,iters+1)=curMean;
  oldTransVecs=transVecs;
  
  entropy_count(iters) = ent;
  
 %toc
end

