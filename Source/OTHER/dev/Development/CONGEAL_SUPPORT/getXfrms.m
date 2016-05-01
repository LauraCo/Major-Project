% Part of the existing code base from the Congealing Demo
% Not modified

function xfrms=getXfrms(transVecs)

[cnt,len]=size(transVecs);

xfrms=zeros(3,3,cnt);
for i=1:cnt
  xfrms(:,:,i)=getXfrm(transVecs(i,:));
end
