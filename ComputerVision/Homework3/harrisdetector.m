% Harris_Detector.m
% This function takes an image in and then finds the corresponding harris
% feature points within the images.  It will return the corner strength of
% the points within the images

function [cs_x,cs_y,cs_image] = harrisdetector(img)

% inputs:
%   img = The image that we will detect the harris points in 

% Output:
%   cs_image = The corner strength of the images

% Create the gaussian mask, and sobel filters
G = fspecial('gaussian',3,1);
Sy = fspecial('sobel');
Sx = Sy';

% Get the size of the image
rows = size(img,1);
cols = size(img,2);

% Solve for the gradients of the images
Grad_x = conv2(double(img),Sx,'same');
Grad_y = conv2(double(img),Sy,'same');

% Now go through the image and calculate the sobel gradients at each pixel
% point.
%{
for j = 2:rows-1
    for i = 2:cols-1
        patch = img(j-1:j+1,i-1:i+1);
        conv2(Sx,double(patch))
        patch
        Sx
        Grad_x(j,i) = conv2(Sx,double(patch));
        Grad_y(j,i) = conv2(Sy,double(patch));
    end
end
%}

%{
% Now we will calculate the Harris Matrices at each point
I_xx = Grad_x*(Grad_x');
I_xy = Grad_x*(Grad_y');
I_yy = Grad_y*(Grad_y');

% Now convolve the images with the gaussians
F_xx = conv2(I_xx,G,'same');
F_xy = conv2(I_xy,G,'same');
F_yy = conv2(I_yy,G,'same');

cs_image = ((F_xx.*F_yy)-F_xy)./(F_xx + F_yy + eps); 

%}

cs_image = zeros(rows,cols);

for j = 2:rows-1
    for i = 2:cols-1
        % Calculate the product images
        I_x = Grad_x(j-1:j+1,i-1:i+1);
        I_y = Grad_y(j-1:j+1,i-1:i+1);
        
        % Now calculate the H matrix product images
        I_xx = I_x*(I_x');
        I_xy = I_x*(I_y');
        I_yy = I_y*(I_y');
        
        % Now weight the functions with the gaussian weighting kernel
        F_xx = conv2(G,I_xx,'valid');
        F_xy = conv2(G,I_xy,'valid');
        F_yy = conv2(G,I_yy,'valid');
        
        cs_image(j,i) = (F_xx*F_yy - F_xy)/(F_xx + F_yy + eps);
    end
end

[cs_y, cs_x] = nonmaxsuppts(cs_image,2,.3*max(cs_image(:))); 











