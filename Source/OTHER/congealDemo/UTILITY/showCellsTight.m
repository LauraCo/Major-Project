function showCellsTight(ser,figNum,maxnum)
% ser is a cell array of images (possibly of different sizes)
    
figure(figNum);
clf;

row=ceil(sqrt(length(ser))-.000001);
margin=1/(row*10+(row+1));
spacePerRow=11*margin;

for i=1:length(ser)
  curRow=ceil(i/row)-1;
  curCol=mod(i-1,row);
  top=1-(curRow*spacePerRow+margin);
  bot=1-((curRow+1)*spacePerRow);
  left=curCol*spacePerRow+margin;
  right=(curCol+1)*spacePerRow;
  subplot('position',[left,bot,right-left,top-bot]);
  imagesc(ser{i});
  axis off;
  colormap('gray');
end

drawnow;