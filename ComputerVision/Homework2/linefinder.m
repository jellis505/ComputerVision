% Created by Joe Ellis for Columbia University Computer Vision Course
% Spring 2013

% This script Runs Problem 1 output
clear all;close all;
currentfig = 1;
% Read in the images
simple1 = imread('hough_simple_1.pgm');
simple2 = imread('hough_simple_2.pgm');
complex = imread('hough_complex_1.pgm');

% Detect the gradient in the images
edge_simple1 = p5(simple1);
edge_simple2 = p5(simple2);
edge_complex = p5(complex);

% Theshold for the edge images
t_s1 = .3*(max(max(edge_simple1)));
t_s2 = .3*(max(max(edge_simple2)));
t_c = .2*(max(max(edge_complex)));

% This section performs the hough transform and uses the threshold
% binarization of the images to do so
[edge_thresh_s1 hough_s1] = p6(edge_simple1,t_s1);
[edge_thresh_s2 hough_s2] = p6(edge_simple2,t_s2);
[edge_thresh_c hough_c] = p6(edge_complex,t_c);
figure(); imshow(edge_thresh_s1);
figure(); imshow(edge_thresh_s2);
figure(); imshow(edge_thresh_c);


% This section finds the lines from the hough transform
t_h_s1 = 104;
t_h_s2 = 60;
t_h_c = 145;

% This section outputs the lines of the hough transform
line_simple1 = p7(simple1,hough_s1,t_h_s1);
line_simple2 = p7(simple2,hough_s2,t_h_s2);
line_complex = p7(complex,hough_c,t_h_c);

% Resize the edges to be slightly wider for the cutting portion
cutthresh = .25;
t_s1 = (cutthresh*t_s1); t_s2 = (cutthresh*t_s2); t_c = (cutthresh*t_c);
edgethreshs1 = p1(edge_simple1,t_s1);
edgethreshs2 = p1(edge_simple2,t_s2);
edgethreshc = p1(edge_complex,t_c);

% This section of the graph plots the images with cutlines
cutlines_s1 = p8(simple1,hough_s1,104,edgethreshs1);
cutlines_s2 = p8(simple2,hough_s2,60,edgethreshs2);
cutlines_c = p8(complex,hough_c,145,edgethreshc);

%Write out all of the images to files in the directory
imwrite(edge_thresh_s1,'images\edge_thresh_s1.pgm');
imwrite(edge_thresh_s2,'images\edge_thresh_s2.pgm');
imwrite(edge_thresh_c,'images\edge_thresh_c.pgm');
imwrite(line_simple1,'images\line_simple1.jpg');
imwrite(line_simple2,'images\line_simple2.jpg');
imwrite(line_complex,'images\line_complex.jpg');
imwrite(cutlines_s1,'images\cutlines_s1.pgm');
imwrite(cutlines_s2,'images\cutlines_s2.pgm');
imwrite(cutlines_c,'images\cutlines_c.pgm');





