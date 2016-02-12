function [ output_args ] = Mammogram( input_args )
%MEMBERSHIPS Summary of this function goes here
%   Detailed explanation goes here

%J Suckling et al (1994): The Mammographic Image Analysis Society Digital Mammogram Database Exerpta Medica. International Congress Series 1069 pp375-378.
mamIm = imread('mdb001.pgm');

figure;
subplot(1,2,1), subimage(mamIm), title('Greyscale Image')
subplot(1,2,2), imhist(mamIm, 255) %http://uk.mathworks.com/help/images/ref/imhist.html


