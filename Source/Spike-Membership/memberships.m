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
%Evalmmf - http://chmielowski.eu/POLITECHNIKA/Dydaktyka/AUTOMATYKA/AutoLab/Matlab/TOOLBOX/FUZZY/FUZZY/EVALMMF.M

x = 0:250;
param1 = [-1 0 50 95];
u1=trapmf(x,param1); % first membership function, gaussian type
param2 = [60 90 150 180];
u2=trapmf(x,param2); 
param3 = [145 185 260 275];
u3=trapmf(x,param3);
u_reuniune=max(u1,u2);  % compute the membership degrees for the union using the "MAX" operator
another_union=max(u_reuniune,u3);


figure;
subplot(2,1,1); % breaks the figure in two windows
                % the current plot appears in the upper window
plot (x,u1,'r');hold on
plot (x,u2,'m'); hold on
plot (x,u3,'b'); hold off
xlim([0 250]);
ylim([-0.1 1.2]);
xlabel('Grey Level Value', 'FontWeight', 'bold');
ylabel('Degree of Membership', 'FontWeight', 'bold');
hold on;

subplot (2,1,2) % the current plot appears in the lower window
plot(x, another_union,'color','g','linewidth',2)

%x = linspace(-20,20,300);

xlim([0 250]);
ylim([-0.1 1.2]);
xlabel('Grey Level Value', 'FontWeight', 'bold');
ylabel('Degree of Membership', 'FontWeight', 'bold');
grid;

%http://www.bel.utcluj.ro/dce/didactic/sln/lab_eng/2MultimiFuzzy_eng/html/FuzzySets.html
hold on;
x1 = double(intensityValue);
u1 = evalmf(x1,param1,'trapmf');
u2 = evalmf(x1,param2,'trapmf');
u3 = evalmf(x1,param3,'trapmf');

collective_u = [u1, u2, u3];

max_u = max(collective_u);

plot(x1,max_u,'r*');
hold on;
plot([x1,x1],[0,max_u],'linestyle','-','color','r');
plot([0,x1],[max_u,max_u],'linestyle','-','color','r');
hold off;

disp(max_u);
%dfl = defuzz(x,another_union,'lom');
%disp(dfl);

