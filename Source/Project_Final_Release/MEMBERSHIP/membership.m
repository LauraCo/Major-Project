% Membership function containing 3 fuzzy sets - to be used with Non-Probabilistic
% AUTHOR: Laura Collins (lac32)
% LAST MODIFIED: 08/04/2016

function [imgMu, lowMu, medMu, highMu]  = membership(image_matrix)
%Calculate the membershipDegree of a pixel
imwrite(image_matrix,'mean_image.pgm');

image = imread('mean_image.pgm');   

[rows,columns] = size(image);
imgMu{rows,columns} = [];

%Work on Trapmf for the pixel intensities - http://uk.mathworks.com/help/fuzzy/trapmf.html
x = 0:255; % Min & Max x values

param1 = [-1 0 50 85]; %the 4 corners of the trapezium

param2 = [60 85 170 195];

param3 = [170 205 260 275];


%If RGB convert to greyscale (this is only really for test images) 
if size(image,3) == 3
    image = rgb2gray(image);
end

evalLow = evalmf(x, param1, 'trapmf');
evalMed = evalmf(x, param2, 'trapmf');
evalHigh = evalmf(x, param3, 'trapmf');

pixelIntensity = double(image(1:size(image,1),1:size(image,2))) + 1;

lowMu = evalLow(pixelIntensity);
medMu = evalMed(pixelIntensity);
highMu = evalHigh(pixelIntensity);

temp = bsxfun(@max, lowMu, medMu);
imgMu = bsxfun(@max, temp,highMu);

end