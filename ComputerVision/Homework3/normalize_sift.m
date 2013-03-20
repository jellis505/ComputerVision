% This function normalizes a raw SIFT vector in the simple_sift
% implementation of the feature matching functions
% Created by Joe Ellis 

function norm_sift = normalize_sift(raw_sift)

% input 
%   raw_sift = the raw sift feature pre normalization
% output 
%   norm_sift = the normalized sift descriptor

% normalize the raw_sift into a unit vector
norm_sift = raw_sift/norm(raw_sift);

% now find all the elements that are greater than 0.2 and cut them back to
% 0.2
idgreater = (norm_sift > 0.2);
norm_sift(idgreater) = 0.2;

% Now renormalize the vector to a unit vector
norm_sift = norm_sift/norm(norm_sift);
