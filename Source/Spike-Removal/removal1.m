img = imread('mdb196.pgm');

subplot(1, 3, 1);
imshow(img, []);
title('Original Grayscale Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));


h = imfreehand();
wait(h)  % waits for user to specify region of interest 
mask = createMask(h);  % Binary mask with 1's inside ROI

subplot(1, 3, 2);
imshow(binaryImage);
title('Image selected', 'FontSize', fontSize);

insideMasked = img;
insideMasked(mask) = 0;
subplot(1, 3, 3);
imshow(insideMasked);
title('Masked Inside Region', 'FontSize', fontSize);