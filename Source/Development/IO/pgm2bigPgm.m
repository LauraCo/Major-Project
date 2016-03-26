function s = pgm2bigPgm(pathname)

%    filename = strcat('/Users/lauracollins/Git/Major-Project/Source/Development/all-mias/sample/',scanDirectory(i).name);
%    I = imread(filename);
%    figure, imshow(I);

scanDirectory = dir(fullfile(pathname, '*.pgm'));
noOfScans = length(scanDirectory);

filename = strcat(pathname,'/',scanDirectory(1).name);
file=fopen(filename,'r');

if file == -1
  error('Author:Function:OpenFile', 'Cannot open folder: %s', filename);
end

ln1=fgetl(file);
ln2=strsplit(fgetl(file));


if find(strcmp('#', ln2))
    ln2(1) = []; % http://blogs.mathworks.com/videos/2010/03/30/deleting-an-element-from-a-cell-array/
end

squareImageSize = str2double(ln2);

sers=zeros(squareImageSize(1),squareImageSize(2),noOfScans);

for i = 1:noOfScans

    scan = fopen(strcat(pathname,'/',scanDirectory(i).name));

    im=(fread(scan,[squareImageSize(1),squareImageSize(2)],'uchar'));
    sers(:,:,i) = im;
end

outfname=sprintf('%s/big_scan.pgm', pathname);
s=sers(:,:,:);
saveSeries(outfname,s);
