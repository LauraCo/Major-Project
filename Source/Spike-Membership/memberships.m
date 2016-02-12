function [ output_args ] = memberships( input_args )
%MEMBERSHIPS Summary of this function goes here
%   Detailed explanation goes here

Irgb = imread('me.jpeg');


%Standard NTSC conversion formula
IGrey = 0.2989*Irgb(:,:,1)+0.5870*Irgb(:,:,2)+0.1140*Irgb(:,:,3);
[rows,cols] = size(IGrey);

BW = im2bw(IGrey, 0.4);

%Plot the images side by side
%http://www.mathworks.com/matlabcentral/answers/101806-how-can-i-insert-my-matlab-figure-fig-files-into-multiple-subplots
subplot(1,3,1), subimage(Irgb),title('Original Image')
subplot(1,3,2), subimage(IGrey), title('Greyscale Image')
subplot(1,3,3), subimage(BW), title('Black & White Image')

figure;
subplot(1,2,1), subimage(IGrey), title('Greyscale Image')
subplot(1,2,2), imhist(IGrey) %http://uk.mathworks.com/help/images/ref/imhist.html

%figure; 
%subplot(1,2,1), subimage(BW), title('Black & White Image')
%subplot(1,2,2), imhist(BW)

intensityValue = IGrey(80, 230); %Intensity value of a particular pixel
disp(intensityValue); 

%Work on Trapmf for the pixel intensities - http://uk.mathworks.com/help/fuzzy/trapmf.html
% Adapted from Octave website - http://octave.sourceforge.net/fuzzy-logic-toolkit/function/trapmf.html
x = 0:255;
params = [-1 0 50 95];
y1 = trapmf(x, params);
params1 = [60 90 150 180];
y2 = trapmf(x, params1);
params2 = [145 185 260 275];
y3 = trapmf(x, params2);
figure;
plot(x, y1,x, y2,x, y3)
hold on; %hold this drawn line on the graph


xlim([0 255]);
ylim([-0.1 1.2]);
xlabel('Greyscale Value', 'FontWeight', 'bold');
ylabel('Degree of Membership', 'FontWeight', 'bold');
grid;

%http://www.bel.utcluj.ro/dce/didactic/sln/lab_eng/2MultimiFuzzy_eng/html/FuzzySets.html

u1 = evalmf(intensityValue,params1,'trapmf'); 
sprintf( 'x1=%1.2f has the membership degree u1=%1.2f',intensityValue,u1);
disp(u1);
plot(intensityValue,u1,'r*');
plot([intensityValue,intensityValue],[0,u1],'linestyle','-','color','r');
plot([0,intensityValue],[u1,u1],'linestyle','-','color','r');
hold off;

