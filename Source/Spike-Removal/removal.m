clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 18;

%===============================================================================
% Read in a color demo image.
folder = '/Users/lauracollins/Git/Major-Project/Source/Spike-Removal';
baseFileName = 'mdb196.pgm';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
img = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(img);
% Display the original color image.
subplot(2, 3, 1);
imshow(img);
axis on;
title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Convert to gray scale.
%grayImage = rgb2gray(img);
%subplot(2, 3, 2);
%imshow(grayImage);
%axis on;
%title('Gray scale Image', 'FontSize', fontSize);

% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(img);
subplot(2, 3, 3); 
bar(grayLevels, pixelCount);
grid on;
title('Histogram of gray image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Threshold to get binary image
binaryImage = img > 225;
subplot(2, 3, 4);
imshow(binaryImage);
axis on;
title('Binary Image', 'FontSize', fontSize);

% Dilate the binary image to tell it what pixels shoudl be used to fill in holes.
binaryImage = imdilate(binaryImage, true(11));
subplot(2, 3, 5);
imshow(binaryImage);
axis on;
title('Dilated Binary Image', 'FontSize', fontSize);
drawnow;

promptMessage = sprintf('Next we will fill the white areas.\nNote: Computing the filled image will take some time.');
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
if strcmpi(button, 'Cancel')
	return;
end
tic

% Extract the individual red, green, and blue color channels.
redChannel = img(:, :, 1);
greenChannel = img(:, :, 2);
blueChannel = img(:, :, 3);
% Fill holes
redChannel = roifill(redChannel, binaryImage);
greenChannel = roifill(greenChannel, binaryImage);
blueChannel = roifill(blueChannel, binaryImage);

% Recombine separate color channels into a single, true color RGB image.
img = cat(3, redChannel, greenChannel, blueChannel);
subplot(2, 3, 6);
imshow(img);
axis on;
title('Fixed Color Image', 'FontSize', fontSize);
toc;
msgbox('Done with demo for arjun');

