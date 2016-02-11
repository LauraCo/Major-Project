function [ output_args ] = memberships( input_args )
%MEMBERSHIPS Summary of this function goes here
%   Detailed explanation goes here

Irgb = imread('me.jpeg');

%tandard NTSC conversion formula
IGrey = 0.2989*Irgb(:,:,1)+0.5870*Irgb(:,:,2)+0.1140*Irgb(:,:,3);

BW = im2bw(IGrey, 0.4);

subplot(1,3,1), subimage(Irgb)
subplot(1,3,2), subimage(IGrey)
subplot(1,3,3), subimage(BW)



