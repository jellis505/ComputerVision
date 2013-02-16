% Created by Joe Ellis for Columbia Computer Vision Course
% Spring 2013 -- Homework #2
% Implement the sequential labeling algorithm that segments the binary
% image into several connected regions
% function binary_out = p1(gray_in,thresh_val);
% Output
    % binary_out = the binarized output matrix
% Input 
    % gray_in = the input grayscale image
    % thresh_val = Threshold value for binarization
function labels_out = p2(binary_in)

[rows cols] = size(binary_in);
labels_out = zeros(rows,cols);
% Start the raster scanning two rows in... assume that the first column and
% top row of the images are background
newlabel = 1;
num = 2;
donothing = 0;
equivalencemat = zeros(1,2);


for j = 2:rows
    for i = 2:cols
        % This portion we will have six different labels for hte possible
        % combinations
        if (binary_in(j,i) == 0)
            labels_out(j,i) = 0;
        elseif (binary_in(j,i) == 255) && (binary_in(j-1,i) == 0) && (binary_in(j-1,i-1) == 0) && (binary_in(j,i-1) == 0)
            labels_out(j,i) = newlabel;
            newlabel = newlabel + 1;
        elseif (binary_in(j,i) == 255) && (labels_out(j-1,i-1) ~= 0)
            labels_out(j,i) = labels_out(j-1,i-1);
        elseif (binary_in(j,i) == 255) && (binary_in(j-1,i) == 255) && (binary_in(j-1,i-1) == 0) && (binary_in(j,i-1) == 0)
            labels_out(j,i) = labels_out(j-1,i);
        elseif (binary_in(j,i) == 255) && (binary_in(j-1,i) == 0) && (binary_in(j-1,i-1) == 0) && (binary_in(j,i-1) == 255)
            labels_out(j,i) = labels_out(j,i-1);
        elseif (binary_in(j,i) == 255) && (binary_in(j-1,i-1) == 0) && (binary_in(j-1,i) == 255) && (binary_in(j,i-1) == 255)
            if labels_out(j-1,i) == labels_out(j,i-1)
                labels_out(j,i) = labels_out(j-1,i);
            else
                
                % Smaller structure
                smaller = min(labels_out(j-1,i),labels_out(j,i-1));
                bigger = max(labels_out(j-1,i),labels_out(j,i-1));
                labels_out(j,i) = smaller;
                equivalencemat(num,1) = smaller;
                equivalencemat(num,2) = bigger;
                num = num +1;
            end
        end
    end
end


% Go back through the matrix to create the labels
[equiv_row equiv_col] = size(equivalencemat);

% Now we are going to go back through the labeling algorithm and every time
% that we see a label that equal to another then we change them


k = equiv_row;
while k >= 2
    finder = equivalencemat(k,2);
    replacer = equivalencemat(k,1);
    for j = 1:rows
        for i = 1:cols
            if labels_out(j,i) == finder;
                labels_out(j,i) = replacer;
            end
        end
    end
    k = k -1;
end  

% Create unique labels for each element
unique_labels = unique(labels_out);
for j = 1:length(unique_labels)
    umat(j,1) = j -1;
    umat(j,2) = unique_labels(j);
end

% Apply unique labels to this labelled image
for k = 1:length(umat)
    for j = 1:rows
        for i = 1:cols
            if labels_out(j,i) == umat(k,2)
                labels_out(j,i) = umat(k,1);
            end
        end
    end
end

end


    
    
                