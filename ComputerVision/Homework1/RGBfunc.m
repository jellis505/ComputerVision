%%%%%%%%%%%%%%%%%%%%%%
% Created by Joe Ellis for Columbia University Computer Vision Spring 13
% Homework #1 Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R,G,B] = RGBfunc(picfile,currentfig)
% Inputs
% picfile = the relative filename of the picture
% currentfig = the figure that the image should be outputted to

% Outputs
% R, G, B Channels of the new image
    % Code starts here
    pic = imread(picfile,'JPEG');
    % Change the image to double
    pic_double = pic;
    
    % Get the RGB channels from the new image
    R = pic_double(:,:,1);
    G = pic_double(:,:,2);
    B = pic_double(:,:,3);
    
    %Get the size of the image
    % This does not need to be done for this excercise
    %[x y z] = size(pic_double);
    
    % Set the new pic up to be the right size
    % This does not need to be done for this excercise
    % newpic = zeros(x,y,z);
    
    % Swap the Red and Blue Channels and Output the Image
    newpic(:,:,1) = B;
    newpic(:,:,2) = G;
    newpic(:,:,3) = R;
    
    % Show the image
    figure(currentfig);
    imshow(newpic)
    imwrite(newpic,'swap_image.jpg','JPEG');
end