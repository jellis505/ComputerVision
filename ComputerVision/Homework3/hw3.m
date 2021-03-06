% Script created for Homework #3 for Columbia Univeristy COmputer Vision
% Course.
% Created by Joe Ellis 

% Close the variables
clear all; close all;

% Read in the image files
bike1 = imread('bikes1.png');
bike2 = imread('bikes2.png');
bike3 = imread('bikes3.png');
graf1 = imread('graf1.png');
graf2 = imread('graf2.png');
graf3 = imread('graf3.png');
leuven1 = imread('leuven1.png');
leuven2 = imread('leuven2.png');
leuven3 = imread('leuven3.png');
wall1 = imread('wall1.png');
wall2 = imread('wall2.png');
wall3 = imread('wall3.png');

% Detect the harris corner features
[bike1_x, bike1_y, bike1_cs] = harrisdetector(rgb2gray(bike1)); 
[bike2_x, bike2_y, bike2_cs] = harrisdetector(rgb2gray(bike2)); 
[bike3_x, bike3_y, bike3_cs] = harrisdetector(rgb2gray(bike3)); 
[graf1_x, graf1_y, graf1_cs] = harrisdetector(rgb2gray(graf1)); 
[graf2_x, graf2_y, graf2_cs] = harrisdetector(rgb2gray(graf2)); 
[graf3_x, graf3_y, graf3_cs] = harrisdetector(rgb2gray(graf3)); 
[leuven1_x, leuven1_y, leuven1_cs] = harrisdetector(rgb2gray(leuven1)); 
[leuven2_x, leuven2_y, leuven2_cs] = harrisdetector(rgb2gray(leuven2)); 
[leuven3_x, leuven3_y, leuven3_cs] = harrisdetector(rgb2gray(leuven3)); 
[wall1_x, wall1_y, wall1_cs] = harrisdetector(rgb2gray(wall1(1:680,1:880,1:3))); 
[wall2_x, wall2_y, wall2_cs] = harrisdetector(rgb2gray(wall2)); 
[wall3_x, wall3_y, wall3_cs] = harrisdetector(rgb2gray(wall3));

% extract the features that are used for the comparison of the images and
% see if we can match them together
match_images(bike1,bike1_x,bike1_y,bike2,bike2_x,bike2_y);
match_images(bike1,bike1_x,bike1_y,bike3,bike3_x,bike3_y);
match_images(graf1,graf1_x,graf1_y,graf2,graf2_x,graf2_y);
match_images(graf1,graf1_x,graf1_y,graf3,graf3_x,graf3_y);
match_images(leuven1,leuven1_x,leuven1_y,leuven2,leuven2_x,leuven2_y);
match_images(leuven1,leuven1_x,leuven1_y,leuven3,leuven3_x,leuven3_y);
match_images(wall1(1:680,1:880,1:3),wall1_x,wall1_y,wall2,wall2_x,wall2_y);
match_images(wall1(1:680,1:880,1:3),wall1_x,wall1_y,wall3,wall3_x,wall3_y);


