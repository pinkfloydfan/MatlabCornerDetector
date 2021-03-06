clear
clc

% size of window for the Lucas Kanade algorithm
windowSize = 1;
% threshold for detecting a corner - is ridiculously high atm
cornerThreshold = -2e-12;



im = imread('pyramids.png');
figure
grayscale = rgb2gray(im);
imgsize = size(im);

ypixelcount = imgsize(2);
xpixelcount = imgsize(1);

% calculate the offsets required for the window function to fit within the
% image
xbounds = xpixelcount - floor(windowSize/2);
ybounds = ypixelcount - floor(windowSize/2);
startCounter = floor(windowSize/2)+1;

% empty arrays that will later be filled with pixels that are above
% threshold
cornerX = [];
cornerY = [];

% empty matrix that stores the cornerness of each pixel
cornerness = zeros(size(grayscale));

%[I_x, I_y] = sobel(grayscale); -- todo: implement my own gradient function

% calculate image derivatives
[I_x, I_y] = imgradientxy(grayscale);

%I_x = imgaussfilt(I_x, 2);
%I_y = imgaussfilt(I_y, 2);

% as an sanity check to see if edge detection works
magnitude = (I_x.^2 + I_y.^2).^0.5;

Ix2 = I_x.^2; 
Iy2 = I_y.^2;
Ixy = I_x.*I_y;

%cornerness = (Ix2.*Iy2-Ixy.^2)-0.01*((Ix2+Iy2).^2);

% loop through each pixel, and calls the window function to calculate the
% cornerness at the pixel
for j=startCounter:ybounds
    for i=startCounter:xbounds
        
        h = window(Ix2, Iy2, Ixy, i, j, windowSize, "");

        %h = cornerness(i,j);
        cornerness(i,j) = h;
        
        % if the cornerness exceeds a certain threshold write its
        % coordinates down
        if h < cornerThreshold 
           cornerX(end+1) = i;
           cornerY(end+1) = j;
        end
        
        

     end
end  

figure
imshow(im);
hold on
scatter(cornerY, cornerX, 'r*');
hold off



I_x_8bit = uint8(255 * mat2gray(normalizeImage(I_x)));
I_y_8bit = uint8(255 * mat2gray(normalizeImage(I_y)));

magnitude_8bit = uint8(255 * mat2gray(magnitude));


figure
imshow(I_x_8bit);
title('I_x')

figure
imshow(I_y_8bit);
title('I_y')

figure
imshow(magnitude_8bit);
title('magnitude')



