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
 param1 = [-1 0 50 95];
 y1 = trapmf(x, param1);
 param2 = [60 90 150 180];
 y2 = trapmf(x, param2);

 param3 = [145 185 260 275];
  y3 = trapmf(x, param3);
  figure;
  plot(x, y1)

 hold on; %hold this drawn line on the graph
 plot(x, y2)

 hold on; %hold this drawn line on the graph
  plot(x, y3)
 
  xlim([0 255]);
  ylim([-0.1 1.2]);
  xlabel('Greyscale Value', 'FontWeight', 'bold');
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

%max_u = 0.0;
 %if u1 > max_u
  %   max_u = u1;
 %end
 %if u2 > max_u
   %  max_u = u2;
 %end
 %if u3 > max_u
  %   max_u = u3;
 %end

plot(x1,max_u,'r*');
hold on;
plot([x1,x1],[0,max_u],'linestyle','-','color','r');
plot([0,x1],[max_u,max_u],'linestyle','-','color','r');
hold off;

%dfl = defuzz(x,another_union,'lom');
%disp(dfl);

