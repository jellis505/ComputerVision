% Created by Joe Ellis for Columbia Computer Vision Course
% Spring 2013 -- Homework #2
% This function creates a binary image from a grayscale image and a given
% threshold value
% function binary_out = p1(gray_in,thresh_val);
% Output
    % binary_out = the binarized output matrix
% Input 
    % gray_in = the input grayscale image
    % thresh_val = Threshold value for binarization

function binary_out = p1(gray_in, thresh_val)

[rows cols] = size(gray_in);
binary_out = zeros(rows,cols);

for j = 1:1:rows
    for i = 1:1:cols
        if (gray_in(j,i) > thresh_val)
            binary_out(j,i) = 255;
        else
            binary_out(j,i) = 0;
        end
    end
end
   

            