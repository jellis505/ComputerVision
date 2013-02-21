% Created by Joe Ellis for Columbia University Computer Vision Course
% Spring 2013

% This function takes in a 2-d array with a 5x5 sobel gradient operator
% performed on it and outputs the hough transform and thresholded edge
% image out

function [edge_image_thresh_out, hough_image_out] = p6(edge_image_in, edge_thresh)

[rows cols] = size(edge_image_in);
diagonal = floor(sqrt(rows^2 + cols^2));

% Threshold/Binarize the image
for j = 1:rows
        for i = 1:cols
            if edge_image_in(j,i) >= edge_thresh
                edge_image_thresh_out(j,i) = 255;
            else
                edge_image_thresh_out(j,i) = 0;
            end  
        end
end
%figure(1)
%imshow(edge_image_thresh_out);
divisions_theta = 90;
% Step 1
% We want to quantize out parameter space
% Start with 10 divisions in both row and theta
theta = -pi/2:(pi)/divisions_theta:pi/2;
p = -diagonal:4:diagonal;
divisions_p = length(p);
% Step 2 Create the accumulator array
Accumulator = zeros(length(p),divisions_theta);

% Step 3 For each edge point in the image find if a particular p and theta
% would pass through this edge point

for y = 1:rows
    for x = 1:cols
        if (edge_image_thresh_out(y,x) == 255)
            for j = 1:divisions_theta
                for i = 1:divisions_p
                    if abs(x*cos(theta(j))-y*sin(theta(j))-p(i)) < .25
                        Accumulator(i,j) = Accumulator(i,j) + 1;
                    end
                end
            end
        end
    end
end


% Other Implementation of the work
%x = 0:1:cols;
%y = 0:1:rows;


% Step 3 Find the 

% TESTING REMOVE AT SOME POINT
%Accumulator(:,1) = zeros(divisions,1);


% Step 4
% Normalize the Hough Array Transform
hough_max = max(max(Accumulator));
normalizer = 255/hough_max;
hough_image_out = floor(normalizer*Accumulator);
hough_image_out = fliplr(hough_image_out);
%image(hough_image_out);


% Code for picking out the threshold for each image
%{
percentages = [.25;.04;.03;.02;.01];
maxval = max(max(edge_image_in));

for k = 1:length(percentages)
    for j = 1:rows
        for i = 1:cols
            thresh = maxval*percentages(k);
            if edge_image_in(j,i) >= thresh
                edge_image_thresh_out(j,i) = 255;
            else
                edge_image_thresh_out(j,i) = 0;
            end  
        end
    end
     figure(k);
     imshow(edge_image_thresh_out);
end
edge_image_out = 0; hough_image_out = 0;
%}