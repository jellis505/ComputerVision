% This function extracts SIFT features for each point on the image that is
% given by the harris corner detector algorithm
% Created by Joe Ellis for the Computer Vision Class at Columbia University

function [pos_x, pos_y, SIFT] = simple_sift(img,x,y)

% Input 
%   x = the x position of the detected harris corners
%   pos_y = the y position of the detected harris corners
%   img = THe grayscale image that the features will be taken from 

% output 
%   pos_x = the final found x position of the SIFT descriptors
%   pos_y = the final found y position of the SIFT descriptors
%   SIFT = the sift descriptor for the detected feature at the given points

% Find the gradients of the image using the sobel operator
Sy = fspecial('sobel');
Sx = Sy';
I_x = conv2(double(img),Sx,'same');
I_y = conv2(double(img),Sy,'same');

% This is the size of the SIFT feature right here
windowsize = 41;
sides = 20;

% Get the size of the images 
rows = size(img,1);
cols = size(img,2);

% Now Find the dominant orientation of the feature point if the point is
% not really close to the edge of the image
index = 1;
for j = 1:length(x)
    x_min = min(x(j),cols - x(j));
    y_min = min(y(j),rows - y(j));
    if (x_min > sides) && (y_min > sides)
        pos_x(index) = x(j);
        pos_y(index) = y(j);
        
        % Now we need to find the dominant orientation of the grid around
        % the point
        Ix_patch = I_x(y(j)-sides:y(j)+sides,x(j)-sides:x(j)+sides);
        Iy_patch = I_y(y(j)-sides:y(j)+sides,x(j)-sides:x(j)+sides);
        theta = find_orientation(Ix_patch,Iy_patch);
        
        % Now we need to extract the features for each point 
        
        
        