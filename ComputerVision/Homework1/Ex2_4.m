% Excercise 2.4 -- Szeliski Computer Vision
% Columbia University -- Computer Vision Course -- Spring 2013
% Created by Joe Ellis
clear all;
%% Part 1
% First we solve for delta_zi with respect to the focal distance of 100mm
f = 100 %focal length -- all calculations done in mm
zi = 105:1:150; %image distance from lens 
delta_zi = f - zi;

% Solve for the focus distance
z0_inv = (1/f) - (1./zi);    %Inverse vector of focus distances
z0 = z0_inv.^-1;    % Vector of Focus Distances

% Plot the Focus Distance with respect to Delta zi
figure(1)
plot(delta_zi,z0);
xlabel('Delta zi')
ylabel('Focus Distance (z0)');
title('Focus Distance vs. Delta zi');

%% Part 2
% Compute the depth of the field min and max focus distances for a given zo
% as a function of:
%   confusion diameter (c)
%   focal length (f)
%   f-stop Number (N) = (f/d)
% All values will be calculated in the same distance units (arbitrary)
z0 = 100;    % desired image plane
f = 50; %focal length
d = 100; % Aperature Diameter
N = f/d;    % f-number
z0_prime = 80:1:120;
c = zeros(length(z0_prime),1);
for j = 1:length(z0_prime)
    c(j) = 15; %Allowable Confusion Circle
end

% Calculate the delta between z0 and z0_prime
delz = (z0_prime-z0);
% Now calculate the blur circle
b = d*abs((f*(delz))./(z0_prime.*(z0-f)));


% Plot the blur circle against the change from the desired focus distance
figure(2)
plot(delz,b,delz,c);
xlabel('Distance from Desired Image Plane')
ylabel('Blur Circle');
title('Allowable Blur Circle')
legend('Calcualted Blur Circle','Allowable Blur Circle');

%% Part 3
% We want create the graph seen in Figure 2.20 b
f = [4,8,16,24,32] ;  %The focal length
c = .02;  %This is the allowable blur circle
z0 = 40:10:120;   %The point of the image
d = 4;     %This is the diameter of the lens

% Through algebraic manipulation I was able to solve for the z0prime that
% would work be acceptable given a confusion circle
for j = 1:length(f)
    z0prime(:,j) = (z0)./((c.*(z0-f(j))+f(j)*d)./(f(j)*d));
    dof(:,j) = (z0'-z0prime(:,j));
end

figure(3)
plot(z0',dof(:,1),z0',dof(:,2),z0',dof(:,3),z0',dof(:,4),z0',dof(:,5));
legend ('f = 4','f=8','f=16','f=24','f=32');
xlabel('Object Distance z0');
ylabel('Depth of Field')
title('Recreation of Figure 2.20b')



