%    filename = strcat('/Users/lauracollins/Git/Major-Project/Source/Development/all-mias/sample/',scanDirectory(i).name);
%    I = imread(filename);
%    figure, imshow(I);

scanDirectory = dir('/Users/lauracollins/Git/Major-Project/Source/Development/all-mias/sample1/*.pgm');
noOfScans = length(scanDirectory);

filename = strcat('/Users/lauracollins/Git/Major-Project/Source/Development/all-mias/sample1/',scanDirectory(1).name);
file=fopen(filename,'r');

ln1=fgetl(file);
ln2=strsplit(fgetl(file));
squareImageSize = str2double(ln2);


sers=zeros(squareImageSize(1),squareImageSize(2),noOfScans);

for i = 1:noOfScans
    scan = fopen(strcat('/Users/lauracollins/Git/Major-Project/Source/Development/all-mias/sample1/',scanDirectory(i).name));
    im=(fread(scan,[squareImageSize(1),squareImageSize(2)],'uchar'));
    sers(:,:,i) = im;
end


outfname=sprintf('/Users/lauracollins/Git/Major-Project/Source/Development/all-mias/sample1/big_scan.pgm');
s=sers(:,:,:);
saveSeries(outfname,s);
