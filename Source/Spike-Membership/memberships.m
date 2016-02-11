function [ output_args ] = memberships( input_args )
%MEMBERSHIPS Summary of this function goes here
%   Detailed explanation goes here

Irgb = imread('me.jpeg');

%Standard NTSC conversion formula
IGrey = 0.2989*Irgb(:,:,1)+0.5870*Irgb(:,:,2)+0.1140*Irgb(:,:,3);

BW = im2bw(IGrey, 0.4);

%Plot the images side by side
%http://www.mathworks.com/matlabcentral/answers/101806-how-can-i-insert-my-matlab-figure-fig-files-into-multiple-subplots
subplot(1,3,1), subimage(Irgb),title('Original Image')
subplot(1,3,2), subimage(IGrey), title('Greyscale Image')
subplot(1,3,3), subimage(BW), title('Black & White Image')

figure;
subplot(1,2,2), subimage(IGrey), title('Greyscale Image')
subplot(1,2,1), imhist(IGrey) %http://uk.mathworks.com/help/images/ref/imhist.html


