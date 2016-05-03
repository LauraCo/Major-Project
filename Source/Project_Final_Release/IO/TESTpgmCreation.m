% AUTHOR: Laura Collins (lac32)
% LAST MODIFIED: 25/05/16

function tests = pgmCreationTest
tests = functiontests(localfunctions);
end

function setup(testCase)
% User edit this path
pgm2bigPgm(strcat(pwd,'IO/scans/'));
end



% Test 1 - test is pgm format

function testImageType(testCase)
% User edit this path
file = fopen(strcat(pwd,'/IO/scans/big_scan.pgm'),'r');
ln1=fgetl(file);
assertEqual(testCase,ln1, 'P5');
end

% Test 2 - test insertion of comment for load function to read
function testCommentInsertion(testCase)
% User edit this path
file = fopen(strcat(pwd,'/IO/scans/big_scan.pgm'),'r');
ln1 = fgetl(file);
ln2=fgetl(file);

assertSubstring(testCase,ln2,'#');
end

% Test 3 - test image dimensions are set correctly
function testImageSize(testCase)
% User edit this path
bigFile = fopen(strcat(pwd,'/IO/scans/big_scan.pgm'),'r');

ln1 = fgetl(bigFile);
ln2=strsplit(fgetl(bigFile));
bigImgHeight = str2double(ln2{2});
bigImgWidth = str2double(ln2{3});

% User edit this path
sampleImage = imread(strcat(pwd,'/IO/scans/sample-1.pgm'));
[sampleHeight,sampleWidth,dim] = size(sampleImage);

assertEqual(testCase, bigImgHeight, sampleHeight);
assertEqual(testCase, bigImgWidth, sampleWidth);

end

% Test 4 - test is grey-scale
function testGreyScale(testCase)
% User edit this path
file = fopen(strcat(pwd,'/IO/scans/sample-1.pgm'));

ln1 = fgetl(file);
ln2 = fgetl(file);
ln3 = fgetl(file);
ln4 = fgetl(file);

assertEqual(testCase, ln4, '255');

end