% This function finds the image matches between two points, and then
% creates a new image that displays the images and their best matches

% Created by Joe Ellis for Computer Vision Class at Columbia University

function match_images(img1,x1,y1,img2,x2,y2)

% Let's do the SIFT matching portion of this work right here
[sift_x1,sift_y1,SIFT1] = simple_sift(img1,x1,y1);
[sift_x2,sift_y2,SIFT2] = simple_sift(img2,x2,y2);

% Now perform the matching from the SIFT point in image one to each of the
% SIFT points in image2.
index = 1;
for j = 1:length(sift_x1)
    
    % Find the distances of the points from each other in euclidean
    % distance
    distances = pdist2(SIFT1(j,:),SIFT2);
    
    %Find the best_min distance fit of the points
    [best_min best_idx] = min(distances);
    distances(best_idx) = 100000000000000000000; % Really big number so that we don't rechoose it
    
    % Find the second best min
    second_min  = min(distances);
    
    % Compare the mins and if they are very unambiguous count them as a
    % match
    if (best_min/second_min) < 0.8
        match(index,1) = sift_x1(j);
        match(index,2) = sift_y1(j);
        match(index,3) = sift_x2(best_idx);
        match(index,4) = sift_y2(best_idx);
        index = index + 1;
    end
end

% Now that we have the matches let's do the part where we draw the images
figure
SBS = [img1 img2];
imshow(SBS);
hold on;
title('Simple-SIFT Point Matching Between Images');

% This is the offset we have to do to draw the lines between the points in
% the images
y_offset = size(img1,1);
x_offset = size(img1,2);

disp('The number of matches found is')
disp(size(match,1))

for j = 1:size(match,1);
    line([match(j,1),x_offset+match(j,3)],[match(j,2),match(j,4)]);
end


    
    
    



