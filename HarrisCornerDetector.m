clear
clc

im = imread('pyramids.png');
figure
grayscale = rgb2gray(im);
imgsize = size(im);
windowSize = 1;

cornerThreshold = -1000000000;

ypixelcount = imgsize(2);
xpixelcount = imgsize(1);

xbounds = xpixelcount - floor(windowSize/2);
ybounds = ypixelcount - floor(windowSize/2);

startCounter = floor(windowSize/2)+1;

cornerX = [];
cornerY = [];

cornerness = zeros(size(grayscale));

%[I_x, I_y] = sobel(grayscale);

[I_x, I_y] = imgradientxy(grayscale);

%I_x = imgaussfilt(I_x, 2);
%I_y = imgaussfilt(I_y, 2);

magnitude = (I_x.^2 + I_y.^2).^0.5;

Ix2 = I_x.^2; 
Iy2 = I_y.^2;
Ixy = I_x.*I_y;

%cornerness = (Ix2.*Iy2-Ixy.^2)-0.01*((Ix2+Iy2).^2);

for j=startCounter:ybounds
    for i=startCounter:xbounds
        
        h = window(Ix2, Iy2, Ixy, i, j, windowSize);

        %h = cornerness(i,j);
        cornerness(i,j) = h;
        
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



