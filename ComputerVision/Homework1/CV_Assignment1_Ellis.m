%
% Overview:
%   This assignment is designed to acclimate you to the basics of data
%   manipulation and image processing in Matlab.
% 
% Resources:
%   The best resource you have is the Matlab help file. (Help > Product Help)
%   It is an excelent searchable database of Matlab commands.  
%   Also, http://www.mathworks.com/products/matlab/ and
%   http://www.mathworks.com/products/image/ have function lists (left hand
%   column of the page) broken down by topic and use.
%
% What to turn in:
%   This m file is itself a matlab script.  Provided below is a framework
%   for the assignment.  Please code your answers in the space after the 
%   question. Turn in this m file renamed "HW1_yourUNI.m"  where yourUNI is
%   your Columbia UNI ID. BE SURE TO 
%   INCLUDE YOUR OUTPUT IMAGES AND FUNCTIONS when you turn in the assignment.  
%   The best way is to zip up the m file and images and post them as one 
%   attachment to CourseWorks. Any written answers can be included at the end of that 
%   question as a comment.
%
% IMPORTANT!
%   Please COMMENT your code if it is not obvious what is going on.  Use
%   descriptive variables.  Also, try not to use for loops except for
%   problem 2.  As you will see, they are a generally slow and waste your
%   time. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
% Keep track of the figures to output too so that we don't overwrite a
% figure
currentfig = 1;

% Problem 1 - Basic Image Processing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   1A - Load image "glacier.jpg" into memory
pic = imread('glacier.jpg');    %Reads in the glacier image

%   1B - Display that image
figure(currentfig); currentfig = currentfig+1;   %Sets up the figure for output
imshow('glacier.jpg');  %Displays the figure in the specified area

%   1C - Resize the image to 300x225px (you may use MATLAB to do this)
pic2 = imresize(pic, [300 225]);    % This function resizes the image 

%   1D - Make the resized image grayscale. Use both the mean of the color
%   channels and the following formula to create grayscale images
%    0.2989 * Red + 0.5870 * Green + 0.1140 * Blue.  Don't use rgb2gray!
% gray_mean = mean(pic2,3);   %This is the mean of the third dimenstion of 
                            %matrix at each point
gray_mean = ((pic2(:,:,1)+pic2(:,:,3)+pic2(:,:,3))/3);
gray_formula = pic2(:,:,1)*0.2989+pic2(:,:,2)*0.5870+pic2(:,:,3)*0.1140;
%   1E - Display both resized, grayscale images. In a comment answer which
%   image seems like a better grayscale conversion.
figure(2); currentfig = currentfig + 1; imshow(gray_mean);
figure(3); currentfig = currentfig + 1;imshow(gray_formula);
% The gray_scale image created with the formula seems better.

%   1F - Save the images as "glacier_mean.jpg"  and "glacier_formula.jpg"
imwrite(gray_mean,'glacier_mean.jpg','JPEG')
imwrite(gray_formula,'glacier_formula.jpg','JPEG')

% Problem 2 - Vectors and Matrices %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   2A - Given the vector V = (24,-98,22,6,7,91,37,6,8), in one
%   line of code do:
%       a) reverse the order of V
%       b) compute the dot product of V
%       c) compute the squares of the elements of V
%       d) plot V
V = [24 -98 22 6 7 91 37 6 8];
rev_V = fliplr(V);  %a
dot_V = V*V';   %b
V_square = V.^2;    %c
figure (currentfig); currentfig = currentfig+1; plot(V);    %d

%   2B - Given the matrix M = (41,77,13;2,0,-37;11,69,100) in one
%   line of code
%       a) transpose this M
%       b) multiply each element of M by 5
%       c) compute M * M^{-1}
%       d) Compute the size of matrix M
%       e) Create a new matrix where the columns 1 and 3 of matrix M are
%   swapped. Call this matrix Mswap. Swap rows 2 and 3 of Mswap. 
M = [41 77 13;2 0 -37; 11 69 100];
TransposeM = M';    %a
FivetimesM = 5*M;      %b
m_invM = M/M;
[Mrow Mcol] = size(M);
Mswap = fliplr(M); Mflip = [Mswap(1,:);Mswap(3,:);Mswap(2,:)];
% Problem 3 - Saving Time %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   3A - Create a new matrix R where R is 900 x 900 and contains random 
%        values from 0 to 1
R = rand(900);

%   3B - Write a for loop to multiply each element of R by itself
tic 
for j = 1:900
    for i = 1:900
        R2(j,i) = R(j,i)*R(j,i);
    end
end
toc
%   3C - Write code which does the same as 3B -without- using a for loop
tic
R3 = R.*R;
toc
%   3D - Using the commands 'tic' and 'toc', find the execution time of the 
%        methods in 3B and 3C. Which method is faster?

% 3B Execution Time: Elapsed time is 0.366675 seconds.
% 3C Execution Time: Elapsed time is 0.002165 seconds.

% Problem 4 - Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Create a function that takes in 'glacier.jpg', converts its values to
%   doubles, and outputs individual rescaled R, G and B channels. Additionally, 
%   have the function output a new image which swaps the red and blue channels.
%   Call the function below.

[R,G,B] = RGBfunc('glacier.jpg',currentfig);