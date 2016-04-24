% Script to generate trapeziums
% AUTHOR: Laura Collins (lac32)
% LAST MODIFIED: 07/04/2016

%Work on Trapmf for the pixel intensities - http://uk.mathworks.com/help/fuzzy/trapmf.html
x = 0:255; % Min & Max x values

param1 = [-1 0 50 85]; %the 4 corners of the trapezium
low = trapmf(x,param1);

param2 = [60 85 170 195];
med = trapmf(x,param2);

param3 = [170 205 260 275];
high = trapmf(x,param3);

%figure;
%ax1 = axes('Position',[0 0 1 1],'Visible','off');
ax2 = axes();

plot(ax2,x,low,'r');
text(20,1.1,'Low','FontWeight','bold','FontSize',16);
hold on;
plot(ax2,x,med,'b');
text(120,1.1,'Medium','FontWeight','bold','FontSize',16);
hold on;
plot(ax2,x,high,'m');
text(220,1.1,'High','FontWeight','bold','FontSize',16);
hold on; 

%Set boundaries of graph
xlim([0 250]);
ylim([0 1.2]); 

%Label Axis
% http://uk.mathworks.com/matlabcentral/answers/3732-how-to-change-the-title-of-a-plot
set(gcf,'NumberTitle','off') %don't show the figure number
set(gcf,'Name','Grey Level Membership') %select the name you want
%COMMENTED OUT UNTIL CAN FIX FIGURE ISSUE
xlabel('Grey Level Value', 'FontWeight', 'bold','FontSize',16);
ylabel('Degree of Membership', 'FontWeight', 'bold','FontSize',16);

hold on;



%evaluation = [evalLow, evalMed, evalHigh];

% http://www.mathworks.com/matlabcentral/answers/4402-traversing-an-image-matrix-columnwise
% Somehow on this forum for column traversal, the long-winded way of
% looping an image works better than short-handed calling the rows and
% columns
%for i = 1:size(image,1)
%    for j = 1:size(image,2)

%i = 1:size(image,1);
%j = 1:size(image,2);


       
      
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


%imshow(image);

%disp(imgMu);

%dlmwrite('image.txt',image);
%dlmwrite('memberships.txt',imgMu);

