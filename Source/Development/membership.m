function maximumU = membership( image, x, y )
%Calculate the membershipDegree of a pixel

inputImage = imread(image);

%If RGB convert to greyscale (this is only really for test images) 
if size(inputImage,3) == 3
    iGrey = rgb2gray(inputImage);
    pixelIntensity = double(iGrey(x,y));

else pixelIntensity = double(inputImage(x,y));
end

%Work on Trapmf for the pixel intensities - http://uk.mathworks.com/help/fuzzy/trapmf.html
x = 0:250; % Min & Max x values

param1 = [-1 0 50 95]; %the 4 corners of the trapezium
low = trapmf(x,param1);

param2 = [60 90 150 180];
med = trapmf(x,param2);

param3 = [145 185 260 275];
high = trapmf(x,param3);

figure;
ax1 = axes('Position',[0 0 1 1],'Visible','off');
ax2 = axes('Position',[.3 .1 .6 .8]);

plot(ax2,x,low,'r');
text(20,1.1,'Low','FontWeight','bold','FontSize',12);
hold on;
plot(ax2,x,med,'b');
text(100,1.1,'Medium','FontWeight','bold','FontSize',12);
hold on;
plot(ax2,x,high,'m');
text(200,1.1,'High','FontWeight','bold','FontSize',12);
hold on; 

%Set boundaries of graph
xlim([0 250]);
ylim([0 1.2]); 

%Label Axis
% http://uk.mathworks.com/matlabcentral/answers/3732-how-to-change-the-title-of-a-plot
set(gcf,'NumberTitle','off') %don't show the figure number
set(gcf,'Name','Grey Level Membership') %select the name you want
xlabel('Grey Level Value', 'FontWeight', 'bold');
ylabel('Degree of Membership', 'FontWeight', 'bold');

hold on;


evalLow = evalmf(pixelIntensity, param1, 'trapmf');
evalMed = evalmf(pixelIntensity, param2, 'trapmf');
evalHigh = evalmf(pixelIntensity, param3, 'trapmf');

collectiveU = [evalLow, evalMed, evalHigh];
maximumU = max(collectiveU);

plot(ax2,pixelIntensity,maximumU,'r*'); %plot membership degree
hold on;

plot([pixelIntensity,pixelIntensity],[0,maximumU],'linestyle','-','color','r');
plot([0,pixelIntensity],[maximumU,maximumU],'linestyle','-','color','r');
hold off;

string = sprintf('\\bf Membership \n Degrees \\rm \n \n \\mu_{Low} = %.4f \n \\mu_{Med} = %.4f \n \\mu_{High} = %.4f', evalLow, evalMed, evalHigh);

allEvals = {string};
 
axes(ax1)
text(.025,0.6,allEvals,'FontSize',14)

disp(maximumU);

end

