% Created by Joe Ellis for Columbia University Computer Vision Course
% Spring 2013

% This function paints the lines on top of an original image from matlab
% given it's hough_transform, and some threshold from that threshold.

function line_image_out = p7(image_in,hough_image_in, hough_thresh)
% scan throught the accumulator array and find the lines that have a high
% enough value to print out lines that work on this image

% This section goes through the code and finds the parameters that are
% within the threshold power
[Accum_rows Accum_cols] = size(hough_image_in);
[rows cols] = size(image_in);

% This is pmax
diagonal = floor(sqrt(rows^2 + cols^2));

% recover the values from the hough_image_in transform space
p = 0:diagonal/Accum_rows:diagonal;
theta = 0:(pi/2)/Accum_cols:pi;
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
            y = ((p(j)-cos(theta(i)).*x))/sin(theta(i)+eps);
            plot(x,y);
        end
    end
end
h = gcf;
%[line_image_out, MAP] = frame2im(h);
 line_image_out = 0;           
            
