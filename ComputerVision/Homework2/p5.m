% Created by Joe Ellis for Columbia University Computer Vision Course
% Spring 2013

% This function finds the edge points of an image using the squared
% gradient operator.

function edge_image_out = p5(image_in)
% input: image_in is the gray_scale image of the image that is going to
% have it's edges found.
% output: edge_image_out = Find the edges in the image;

% Set up the sobel masks
sobel3x = [-1 0 1; -2 0 2; -1 0 1];
sobel5x = [-1 -2 0 2 1;-2 -3 0 3 2;-3 -5 0 5 3; -2 -3 0 3 2;-1 -2 0 2 1];
sobel3y = -sobel3x';
sobel5y = -sobel5x';

[rows cols] = size(image_in);
edge3 = zeros(rows,cols);
edge5 = zeros(rows,cols);

% Implement the 3x3 sobel operator
for j = 2:rows-1
    for i = 2:cols-1
        image_mat = double(image_in(j-1:j+1,i-1:i+1));
        x_mat = sobel3x.*image_mat;
        gradientx = sum(sum(x_mat));
        y_mat = sobel3y.*image_mat;
        gradienty = sum(sum(y_mat));
        edge3(j,i) = sqrt(gradientx^2 + gradienty^2);
    end
end
%imagesc(edge3);

for j = 3:rows-2
    for i = 3:cols-2
        image_mat = double(image_in(j-2:j+2,i-2:i+2));
        x_mat = sobel5x.*image_mat;
        gradientx = sum(sum(x_mat));
        y_mat = sobel5y.*image_mat;
        gradienty = sum(sum(y_mat));
        edge5(j,i) = sqrt(gradientx^2 + gradienty^2);
    end
end
%figure()
%imagesc(edge5);
edge_image_out = edge5;


