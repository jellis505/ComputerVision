% This function extracts a SIFT descriptor from a given patch.  It is only
% one of the grids that SIFT is extracted from therefore the output is an
% 8-dimensional vector
% Created by Joe Ellis for the Columbia Computer Vision Class

function scores = sift_patch(I_x,I_y,theta)

% Take the image patches and turn them into vectors
Ix = I_x(:);
Iy = I_y(:);

% Create the bins and then find the middle of them
bins = linspace(0,2*pi-0.7854,8) + 0.7854/2;
scores = zeros(1,length(bins));

% Now we want to find the magnitude and orientation of each bin value
orientations = atan2(Ix,Iy) + pi - theta;
magnitudes = sqrt((Ix.^2)+(Iy.^2));

% Now loop through the entire matrix and find the value that each bin shoul
% d be given to and then apply that to the values

for j = 1:length(orientations)
    [bogus,idx] = min(abs(bins-orientations(j)));
    scores(idx) = scores(idx) + magnitudes(j);
end

% Now we will return the value scores which is the SIFT descriptor for the
% given image path.

