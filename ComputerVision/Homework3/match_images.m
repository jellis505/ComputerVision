% This function finds the image matches between two points, and then
% creates a new image that displays the images and their best matches
% Created by Joe Ellis for Computer Vision Class at Columbia University

function match_images(img1,x1,y1,img2,x2,y2)

%% SIFT
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
    if (best_min/second_min) < 0.7
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


%% Image-Patch-Matching
% Now extract the window patches
featsize = 11;
[win_x1, win_y1, window1] = extractwindowfeats(img1,x1,y1,featsize);
[win_x2, win_y2, window2] = extractwindowfeats(img2,x2,y2,featsize);

index = 1;
for j = 1:length(win_x1)
    % Here we need to find the best match between points using the
    % normalized cross correlation
    patch = window1(:,:,j);
    
    % Correlation scores
    scores = zeros(1,size(window2,3));
    for i = 1:size(window2,3)
        % Now we have to get a score for each window patch normalized cross
        % corrleation
        
        % This is the sum of the absolute differences in the two patches
        %scores(i) = sum(sum(abs(patch - window2(:,:,i))));
        
        % This is the normalized cross correlation in 2-D
        score = normxcorr2(patch,window2(:,:,i));
        scores(i) = score(featsize,featsize);
    end
    
    %Find the best_min distance fit of the points
    [best_max best_idx] = max(scores);
    scores(best_idx) = -1; % Really big number so that we don't rechoose it
    
    % Find the second best min
    second_max  = max(scores);
    
    % Compare the mins and if they are very unambiguous count them as a
    % match
    if (abs(best_max)/abs(second_max)) > 1.33
        match_win(index,1) = win_x1(j);
        match_win(index,2) = win_y1(j);
        match_win(index,3) = win_x2(best_idx);
        match_win(index,4) = win_y2(best_idx);
        index = index + 1;
    end
end

% Now that we have the matches let's do the part where we draw the images
figure
SBS = [img1 img2];
imshow(SBS);
hold on;
title('Patch Comparison Point Matching Between Images');

% This is the offset we have to do to draw the lines between the points in
% the images
y_offset = size(img1,1);
x_offset = size(img1,2);

disp('The number of matches found is')
disp(size(match_win,1))

for j = 1:size(match_win,1);
    line([match_win(j,1),x_offset+match_win(j,3)],[match_win(j,2),match_win(j,4)]);
end
        
        
    
    


    
    
    



