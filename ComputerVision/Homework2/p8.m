% Created by Joe Ellis for Columbia University Computer Vision Course
% Spring 2013

% This function paints the lines on top of an original image from matlab
% given it's hough_transform, and some threshold from that threshold.

function cutlines = p8(image_in,hough_image_in, hough_thresh, edge_thresh)
% scan throught the accumulator array and find the lines that have a high
% enough value to print out lines that work on this image

% This section goes through the code and finds the parameters that are
% within the threshold power
[Accum_rows Accum_cols] = size(hough_image_in);
[rows cols] = size(image_in);

% This is pmax
diagonal = floor(sqrt(rows^2 + cols^2));

% recover the values from the hough_image_in transform space
p = -diagonal:4:diagonal;
theta = -pi/2:(pi)/Accum_cols:pi/2; theta = theta + 0.01*pi;
hold on;
for j = 1:Accum_rows
    for i = 1:Accum_cols
        if hough_image_in(j,i) > hough_thresh
                % Now we will write the code that we need to draw the lines
                % To get the proper directions let's set a bunch of calues of x,
                % and then we can solve for y.
                x = -2*rows:.005:2*rows;
                y =((p(j)-cos(theta(i)+eps).*x))/sin(theta(i)+eps);
                y = floor(y); x = floor(x);
                for k = 1:length(x)
                    if  (0<y(k)) && (y(k)<rows) && (0<x(k)) && (x(k)<cols) 
                            if (edge_thresh(y(k),x(k)) == 255)
                                image_in(y(k),x(k)) = 255;
                            end
                    end
                end
        end     
    end
end
cutlines = image_in; figure(); imshow(cutlines);   
end
        
            
