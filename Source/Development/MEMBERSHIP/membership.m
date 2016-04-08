function [imgMu, lowMu, medMu, highMu]  = membership(image_matrix)
%Calculate the membershipDegree of a pixel

% ARRAY HERE WITH ROWS AND COLUMNS SAME AS MEANIMG

imwrite(image_matrix,'mean_image.pgm');

image = imread('mean_image.pgm');   

[rows,columns] = size(image);
imgMu{rows,columns} = [];

%Work on Trapmf for the pixel intensities - http://uk.mathworks.com/help/fuzzy/trapmf.html
x = 0:255; % Min & Max x values

param1 = [-1 0 50 85]; %the 4 corners of the trapezium
low = trapmf(x,param1);

param2 = [60 85 170 195];
med = trapmf(x,param2);

param3 = [170 205 260 275];
high = trapmf(x,param3);

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