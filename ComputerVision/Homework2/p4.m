% Created by Joe Ellis for Columbia Computer Vision Course
% Spring 2013 -- Homework #2
% Now you have all the tools needed to develop the object recognition system. Write a 
% function named p4 that recognizes objects from the database:
function overlays_out = p4(labels_in,database_in)

% Create a database from the labels_in image
[test_db dummy] = p3(labels_in);
color = length(test_db) + 2;
overlays_out = labels_in;
% Find the percentage difference for the roundness and Emin measures
% between the database_in images, and the test_db

metric = zeros(length(test_db),length(database_in));
for j = 1:length(test_db)
    for i = 1:length(database_in)
        diff_round = abs(test_db(j).Roundedness - database_in(i).Roundedness);
        metric(j,i) = diff_round;
    end
end

% Find the corresponding found objects for each database_input
for j = 1:length(database_in)
    [c,index] = min(metric(:,j)); clear c;
    overlays_out = DrawStuff(overlays_out,test_db(index),color);
end

imagesc(overlays_out);

end
    