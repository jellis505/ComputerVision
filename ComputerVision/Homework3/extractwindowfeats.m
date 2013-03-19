% This function extracts windows from the image around the points that are
% found by the harris detector
% Created by Joe Ellis for the Computer Vision Class at Columbia University

function [pos_x,pos_y,windowfeat] = extractwindowfeats(img,x,y,featsize)

% Inputs:
%   img = the grayscale image
%   x = the x corrdinates of the detected features
%   y = the y coordiantes of the detected features
%   featsize = the size of the window must be odd 
% Outputs:
%   pos_x = the outputted x position of the window feature
%   pos_y = the outputted y position of the window feature
%   windowfeat = the outputted window feature position

% Get the size of the image
rows = size(img,1);
cols = size(img,2);

% Get the values of the sides of the image
sides = (featsize-1)/2;

% Now go through the image and extract the features at points that are not
% to close to the edges of the image
index = 1;
for j = 1:length(x)
    x_min = min(x(j),cols - x(j));
    y_min = min(y(j),rows - y(j));
    if (x_min > featsize) && (y_min > featsize)
        pos_x(index) = x(j);
        pos_y(index) = y(j);
        windowfeat(:,:,index) = img(y(j)-sides:y(j)+sides,x(j)-sides:x(j)+sides);
        index = index+1;
    end
end
    