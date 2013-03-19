% This function was created to find the dominant orientation of an image
% patch to calculate the SIFT desctiptor

% Created by Joe Ellis

function theta = find_orientation(I_x,I_y)

% Take the image patches and turn them into vectors
Ix = I_x(:);
Iy = I_y(:);

% Create the bins and then find the middle of them
bins = linspace(0,2*pi-0.1428,45) + 0.1428/2;
scores = zeros(1,length(bins));

% Now we want to find the magnitude and orientation of each bin value
orientations = atan(Ix,Iy) + pi;
magnitudes = sqrt((Ix.^2)+(Iy.^2));

% Now loop through the entire matrix and find the value that each bin shoul
% d be given to and then apply that to the values

for j = 1:length(orientations)
    [bogus,idx] = min(abs(theta-orientations(j)));
    scores(idx) = scores(idx) + magnitudes(j);
end

% Now we want to find the max of the scores and what element it is
[max_val, idx] = max(scores);

% Now return the orientation that corresponds to the max score
theta = bins(idx);

