% Created by Joe Ellis for Columbia Computer Vision Course
% Spring 2013 -- Homework #2
function newimage = DrawStuff(oldimage,data, color)
% Add the sections of the outputting on the labels
    % Draw the Center Points
    newimage = oldimage;
    for j = -1:1
        for i = -1:1
            newimage(data.center(2) + j,data.center(1) + i) = color;
        end
    end
    
    % Draw a line for a couple of pixels with the orientation
    radiusmax = 20;
    r = 1:1:radiusmax;
    for j = 1:length(r)
        xadd = floor(r(j)*cos(data.Theta));
        yadd = floor(r(j)*sin(data.Theta));
        newimage(data.center(2) + yadd,data.center(1)+xadd) = color;
    end
    
    % Draw a circle for the points
    angles = 0:(2*pi/100):2*pi;
    for j = 1:length(angles)
        xadd = floor(radiusmax*cos(angles(j)));
        yadd = floor(radiusmax*sin(angles(j)));
        newimage(data.center(2) + yadd,data.center(1)+xadd) = color;
    end 