% Created by Joe Ellis for Columbia University Computer Vision Course
% Spring 2013

% This script Runs Problem 1 output
clear all;close all;
currentfig = 1;
% Read in the images
two_objects = imread('two_objects.pgm');
many_objects1 = imread('many_objects_1.pgm');
many_objects2 = imread('many_objects_2.pgm');

% Thesholds for binarizing the images
t1 = 120;
t2 = 100;
t3 = 100;

disp(' Binarizing the Images...');

% Perform function p1
binary2 = p1(two_objects,t1);
binary_many1 = p1(many_objects1,t2);
binary_many2 = p1(many_objects2,t3);


disp('Labeling the images...')
% Perform the sequential labeling algorithm on the two image picture
labels2 = p2(binary2);
labels_many1 = p2(binary_many1);
labels_many2 = p2(binary_many2);
figure(currentfig)
currentfig = currentfig + 1;
imagesc(labels2)

disp('Creating the database...')
% Create the database of the two images
[database2, overlays_out2] = p3(labels2);
figure(currentfig);
currentfig = currentfig + 1;
imagesc(overlays_out2);

disp('Recognizing any objects we find in the other images...');
% This function recongizes objects from the two images
overlays_many1 = p4(labels_many1,database2);
overlays_many2 = p4(labels_many2,database2);

% Output the found objects
figure(currentfig);
currentfig = currentfig + 1;
imagesc(overlays_many1);
figure(currentfig);
currentfig = currentfig + 1;
imagesc(overlays_many2);


