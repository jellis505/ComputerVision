% Created by Joe Ellis for Columbia Computer Vision Course
% Spring 2013 -- Homework #2
% Write a MATLAB function named p3 that takes a labeled image and computes object 
% attributes, and generates the objects database:
% The generated object database should be an array of structs which includes a field for 
% each of the objects with the following values:
    %i. object_label, the index label of the object
    %ii. x_position of the center, y_position of the center,
    %iii. min_moment, the minimum moment of inertia,
    %iv. orientation, the angle (in degrees) between the axis of minimum inertia 
    %   and the vertical axis,
    %   v. roundness, the roundness of the object.
function [database_out , overlays_out] = p3(labels_in)

% Get an array of all the label values in p3
labels = unique(labels_in);
[rows cols] = size(labels_in);
overlays_out = labels_in;

% pick out a color for drawing
color = max(labels) + 1;
% Find the following values for each label
for k = 2:length(labels)
    
    % Save the object label in the image 
    object_label = labels(k);
    
    % Get the Center of Area
    total_x = 0;
    total_y = 0;
    Area = 0;
    for j = 1:rows
        for i = 1:cols
            if labels_in(j,i) == labels(k)
                total_x = total_x + i;
                total_y = total_y + j;
                Area = Area + 1;
            end
        end
    end
    x_center = round(total_x/Area);
    y_center = round(total_y/Area);
    
    % Find the min moment of inertia
    % Solve for a, b and c
    a = 0; b = 0; c = 0;
    for j = 1:rows
        for i = 1:cols
            if labels_in(j,i) == labels(k)
                xprime = i - x_center;
                yprime = j- y_center;
                a = a + xprime^2;
                b = b + 2*xprime*yprime;
                c = c + yprime^2;
            end
        end
    end
    
    % Solve for theta(1)
    theta1 = (atan2(b,a-c))/2;
    theta2 = theta1 + (pi/2);
    
    %Solve for Emin and Emax
    Emin = a*sin(theta1)^2 - b*sin(theta1)*cos(theta1) + c*cos(theta1)^2;
    Emax = a*sin(theta2)^2 - b*sin(theta2)*cos(theta2) + c*cos(theta2)^2;
    
    % Roundness 
    Roundedness = Emin/Emax;
    
    % Create the Data Structure Array
    database_out(k-1) = struct('object_label',object_label,'center',[x_center y_center],...
                                'Emin',Emin,'Roundedness',Roundedness,'Theta',theta1');
    
    % Draw the stuff on the labeled output
    overlays_out = DrawStuff(overlays_out,database_out(k-1),color);
                            
end
end
    
                
    
    
