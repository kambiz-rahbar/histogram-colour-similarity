% measure colour similarity in range of [0, 1] based on intensity hostogram
% kambiz.rahbar@gmail.com, 2019.
%
% based on paper
% J.R.R.Uijlings, K.E.A.van de Sande, T.Gevers, A.W.M.Smeulders,"Selective
% Search for Object Recognition, " International Journal of Computer
% Vision, September 2013, Volume 104, Issue 2, pp 154–171
%

clc
clear
close all

img1 = imread('peppers.png');
img2 = imread('autumn.tif');
img3 = imread('saturn.png');
img4 = imread('fabric.png');

s_colour1 = measure_colour_similarity(img1,img1);
s_colour2 = measure_colour_similarity(img1,img2);
s_colour3 = measure_colour_similarity(img1,img3);
s_colour4 = measure_colour_similarity(img1,img4);


% show the results
figure(1);
subplot(2,2,1);
imshow(img1);
title('image #1');

subplot(2,2,2); 
imshow(img2);
title('image #2');

subplot(2,2,3); 
imshow(img3);
title('image #3');

subplot(2,2,4); 
imshow(img4);
title('image #4');


fprintf('colour similarity between image #1 and itself: %f\n',s_colour1);
fprintf('colour similarity between image #1 and image #2: %f\n',s_colour2);
fprintf('colour similarity between image #1 and image #3: %f\n',s_colour3);
fprintf('colour similarity between image #1 and image #4: %f\n',s_colour4);



%%
function [s_colour] = measure_colour_similarity(img1, img2)
% measure colour similarity in range of [0, 1];

% calculate colour similarity vector for image #1 and #2
c1 = calculate_colour_similarity_vector(img1);
c2 = calculate_colour_similarity_vector(img2);

s_colour = sum(min(c1,c2)) / 3;
end

function [c] = calculate_colour_similarity_vector(img)

% we needs all colour channels
if size(img,3)==1
    img(:,:,2) = img;
    img(:,:,3) = img(:,:,1);
end

% get RGB channels data
red_channel = img(:,:,1);
green_channel = img(:,:,2);
blue_channel = img(:,:,3);

% calculate colour histograms for each channel using 25 bins
red_hist = histcounts(red_channel(:),25);
green_hist = histcounts(green_channel(:),25);
blue_hist = histcounts(blue_channel(:),25);

% normalize each histograms
normalized_red_hist = red_hist/sum(red_hist(:));
normalized_green_hist = green_hist/sum(green_hist(:));
normalized_blue_hist = blue_hist/sum(blue_hist(:));

% calculate colour similarity vector
c = [normalized_red_hist normalized_green_hist normalized_blue_hist];
end
