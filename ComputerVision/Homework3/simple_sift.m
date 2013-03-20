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
if size(img,3) == 3
    img = rgb2gray(img);
end


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
        
        % Now create the patches that we need to extract the 8-D descriptors from 
        grid_Ix(:,:,1) = Ix_patch(1:10,1:10); grid_Iy(:,:,1) = Iy_patch(1:10,1:10);
        grid_Ix(:,:,2) = Ix_patch(1:10,11:20); grid_Iy(:,:,2) = Iy_patch(1:10,11:20);
        grid_Ix(:,:,3) = Ix_patch(1:10,21:30); grid_Iy(:,:,3) = Iy_patch(1:10,21:30);
        grid_Ix(:,:,4) = Ix_patch(1:10,31:40); grid_Iy(:,:,4) = Iy_patch(1:10,31:40);
        grid_Ix(:,:,5) = Ix_patch(11:20,1:10); grid_Iy(:,:,5) = Iy_patch(11:20,1:10);
        grid_Ix(:,:,6) = Ix_patch(11:20,11:20); grid_Iy(:,:,6) = Iy_patch(11:20,11:20);
        grid_Ix(:,:,7) = Ix_patch(11:20,21:30); grid_Iy(:,:,7) = Iy_patch(11:20,21:30);
        grid_Ix(:,:,8) = Ix_patch(11:20,31:40); grid_Iy(:,:,8) = Iy_patch(11:20,31:40);
        grid_Ix(:,:,9) = Ix_patch(21:30,1:10); grid_Iy(:,:,9) = Iy_patch(21:30,1:10);
        grid_Ix(:,:,10) = Ix_patch(21:30,11:20); grid_Iy(:,:,10) = Iy_patch(21:30,11:20);
        grid_Ix(:,:,11) = Ix_patch(21:30,21:30); grid_Iy(:,:,11) = Iy_patch(21:30,21:30);
        grid_Ix(:,:,12) = Ix_patch(21:30,31:40); grid_Iy(:,:,12) = Iy_patch(21:30,31:40);
        grid_Ix(:,:,13) = Ix_patch(31:40,1:10); grid_Iy(:,:,13) = Iy_patch(31:40,1:10);
        grid_Ix(:,:,14) = Ix_patch(31:40,11:20); grid_Iy(:,:,14) = Iy_patch(31:40,11:20);
        grid_Ix(:,:,15) = Ix_patch(31:40,21:30); grid_Iy(:,:,15) = Iy_patch(31:40,21:30);
        grid_Ix(:,:,16) = Ix_patch(31:40,31:40); grid_Iy(:,:,16) = Iy_patch(31:40,31:40);
        
        % Now we need to extract the features for each patch
        for k = 0:15
            sift_desc((k*8)+1:(k*8)+8) = sift_patch(grid_Ix(:,:,k+1),grid_Iy(:,:,k+1),theta);
        end
        
        % Normalize the SIFT descriptor to be unit length
        SIFT(index,:) = normalize_sift(sift_desc);
        
        % Add the index of the functions
        index = index + 1;
    end
end
        
        
        
        
        