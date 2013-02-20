% This file is created by Joe Ellis for Columbia University Computer Vision
% Spring 2013 -- Homework #2

% Make lines that are on edges only, and not just going through the entire
% image.  Do this with white lines so that they will be easily seen.

function cutlines = p8(image_in,hough_image_in, hough_thresh)
% scan throught the accumulator array and find the lines that have a high
% enough value to print out lines that work on this image

% This section goes through the code and finds the parameters that are
% within the threshold power
[Accum_rows Accum_cols] = size(hough_image_in);
[rows cols] = size(image_in);

% This is pmax
diagonal = floor(sqrt(rows^2 + cols^2));

% recover the values from the hough_image_in transform space
p = -diagonal:2:diagonal;
theta = -pi/2:(pi)/Accum_cols:pi/2;
figure()
imshow(image_in)
hold on;
for j = 1:Accum_rows
    for i = 1:Accum_cols
        if hough_image_in(j,i) > hough_thresh
            % Now we will write the code that we need to draw the lines
            % To get the proper directions let's set x = 1 and solve for y,
            % and then we can set y = 1, and solve for x.
            x = 0:1:3*rows;
            y =((p(j)-cos(theta(i)).*x))/sin(theta(i)+eps);
            plot(x,y);
        end
    end
end
%[line_image_out, MAP] = frame2im(h);
 line_image_out = 0;           
            

