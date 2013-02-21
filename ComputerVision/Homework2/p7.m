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
p = -diagonal:4:diagonal;
theta = -pi/2:(pi)/Accum_cols:pi/2; theta = theta + 0.01*pi;
figure()
imshow(image_in)
hold on;
for j = 1:Accum_rows
    for i = 1:Accum_cols
        if hough_image_in(j,i) > hough_thresh
            % We only want to draw the line if this line is the max line in
            % it's respective area.  Therefore we use the code below.
            %{
            if i == 1
                 Get_Mat = hough_image_in(j-2:j+2,i:i+2);
                 max_of_mat = max(max(Get_Mat));
                 if max_of_mat == hough_image_in(j,i)
                     use_point = 1;
                 end
            elseif i == 2
                 Get_Mat = hough_image_in(j-2:j+2,i-1:i+2);
                 max_of_mat = max(max(Get_Mat));
                 if max_of_mat == hough_image_in(j,i)
                     use_point = 1;
                 end
            elseif i == Accum_rows - 1
                 Get_Mat = hough_image_in(j-2:j+2,i-2:i+1);
                 max_of_mat = max(max(Get_Mat));
                 if max_of_mat == hough_image_in(j,i)
                     use_point = 1;
                 end
            elseif i == Accum_rows
                 Get_Mat = hough_image_in(j-2:j+2,i-2:i);
                 max_of_mat = max(max(Get_Mat));
                 if max_of_mat == hough_image_in(j,i)
                     use_point = 1;
                 end
            else
                 Get_Mat = hough_image_in(j-2:j+2,i-2:i+2);
                 max_of_mat = max(max(Get_Mat));
                 if max_of_mat == hough_image_in(j,i)
                     use_point = 1;
                 end
            end
            %}
                % Now we will write the code that we need to draw the lines
                % To get the proper directions let's set x = 1 and solve for y,
                % and then we can set y = 1, and solve for x.
                x = -2*rows:1:2*rows;
                y =((p(j)-cos(theta(i)+eps).*x))/sin(theta(i)+eps);
                plot(x,y);
        end
    end
end
h = getframe;
[line_image_out, MAP] = frame2im(h);           
   
end
