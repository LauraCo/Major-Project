function [imgMu, lowMu, highMu]  = hybridMembership(image_matrix)
%Calculate the membershipDegree of a pixel

% ARRAY HERE WITH ROWS AND COLUMNS SAME AS MEANIMG

imwrite(image_matrix,'mean_image.pgm');

image = imread('mean_image.pgm');   

[rows,columns] = size(image);
imgMu{rows,columns} = [];

%Work on Trapmf for the pixel intensities - http://uk.mathworks.com/help/fuzzy/trapmf.html
x = 0:255; % Min & Max x values

param1 = [-1 0 100 155]; %the 4 corners of the trapezium
low = trapmf(x,param1);

param3 = [100 155 260 275];
high = trapmf(x,param3);

%figure;
ax1 = axes('Position',[0 0 1 1],'Visible','off');
ax2 = axes('Position',[.3 .1 .6 .8]);

%plot(ax2,x,low,'r');
text(20,1.1,'Low','FontWeight','bold','FontSize',12);
hold on;
%plot(ax2,x,med,'b');
text(100,1.1,'Medium','FontWeight','bold','FontSize',12);
hold on;
%plot(ax2,x,high,'m');
text(200,1.1,'High','FontWeight','bold','FontSize',12);
hold on; 

%Set boundaries of graph
xlim([0 250]);
ylim([0 1.2]); 

%Label Axis
% http://uk.mathworks.com/matlabcentral/answers/3732-how-to-change-the-title-of-a-plot
set(gcf,'NumberTitle','off') %don't show the figure number
%set(gcf,'Name','Grey Level Membership') %select the name you want
%COMMENTED OUT UNTIL CAN FIX FIGURE ISSUE
%xlabel('Grey Level Value', 'FontWeight', 'bold');
%ylabel('Degree of Membership', 'FontWeight', 'bold');

hold on;

%If RGB convert to greyscale (this is only really for test images) 
if size(image,3) == 3
    image = rgb2gray(image);
end

evalLow = evalmf(x, param1, 'trapmf');
evalHigh = evalmf(x, param3, 'trapmf');


%evaluation = [evalLow, evalMed, evalHigh];

% http://www.mathworks.com/matlabcentral/answers/4402-traversing-an-image-matrix-columnwise
% Somehow on this forum for column traversal, the long-winded way of
% looping an image works better than short-handed calling the rows and
% columns
%for i = 1:size(image,1)
%    for j = 1:size(image,2)

%i = 1:size(image,1);
%j = 1:size(image,2);

pixelIntensity = double(image(1:size(image,1),1:size(image,2))) + 1;

lowMu = evalLow(pixelIntensity);
highMu = evalHigh(pixelIntensity);

imgMu = bsxfun(@max, lowMu, highMu);

       
      
        %plot(ax2,pixelIntensity,maximumU,'r*'); %plot membership degree
        %hold on;

        %plot([pixelIntensity,pixelIntensity],[0,maximumU],'linestyle','-','color','r');
        %plot([0,pixelIntensity],[maximumU,maximumU],'linestyle','-','color','r');
        %hold off;

        %string = sprintf('\\bf Membership \n Degrees \\rm \n \n \\mu_{Low} = %.4f \n \\mu_{Med} = %.4f \n \\mu_{High} = %.4f', evalLow, evalMed, evalHigh);

        %allEvals = {string};

        %axes(ax1)
        %text(.025,0.6,allEvals,'FontSize',14)

%disp(image);

%figure;

%imshow(image);

%disp(imgMu);

%dlmwrite('image.txt',image);
%dlmwrite('memberships.txt',imgMu);

end