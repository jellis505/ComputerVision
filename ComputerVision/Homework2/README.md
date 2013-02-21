Columbia University Spring 2013 -- Computer Vision 2013
Created by Joe Ellis -- Homework #2
=======================================================

Infomation about functions and execution of the programs for Homework #2;

'''All Output Images can be Seen in the folder titled images'''

p1.m
=======
Threshold Values for binarizing the images can be seen below
two_objects=120
many_objects_1=100;
many_objects_2 = 100;

p2.m
=======
Sequential labeling algorithm is performed within this function.

p3.m
=======
A database of the labeled images is created using the properties that can be seen below.
*label=[numeric id]
*center=[x_center y_center], this is a two dimensional array element
*min_moment=[value], minimum moment of inertia of the object
*orientation=[angle], the direction and orientation of the object
*roundness=[val], The roundedness of the object also known as E.

p4.m
=======
For this comparison i assumed that the best way to perform this problem would be to use roundedness,
because it is the most robust to changes in scale and orientation of the images.  All of the other features
are scale dependent where as roundedness stays the same for all scales and orientations of the image.
Roundedness is only altered if the objects are not seen from a forward facing angle.
If we were given the knowledge that scale stayed constant throughout the search test set other features would 
have been utilized.
My metric was simply the absolute difference in the roundedness measures of each object to the test image.
The first implementation of the algorithm currently commented out that searches for the minimum distance between
the search object and the test object and then matches the best fit.  This is assuming the object is within the 
data only once or we want to find a "best fit"
The second implementation of the algorithm assigns any object above a certain threshold to that image, the threshold value can be seen below.
Threshold = 0.03

DrawStuff.m
=======
This is the function that was used to manually draw the circle and line of orientation for showing the images that were matched.
The function is passed the labeled matrix, the data point to draw on, and the color or "label" of which to draw this material on.
The algorithms used can be seen in the code.


test_objects.m
========
Demonstrates the object detector that was created for problem 1.  All outputs are generated simply by 
using this script.

p5.m
========
I chose to use the 5x5 sobel edge detector, because i thought that the gradients it prodcued were robust enough
for this application.  However, the 3x3 edge detector is also implemented, and simply changing the mask which is used
can give different results for different use type scenarios that may be preferable.

p6.m
========
I chose the resolution for my accumulator array to be 400 by 90.
Therefore I had two degrees of resolution for each theta bin, and I chose what would be euqivalent to four pixels on the diameter
rows for this resolution.
I used a simple voting scheme that if the value of the equation x*sin(theta)-y*cos(theta)+p < .25 then that particular cell received one vote
Through tuning of this procedure with thresholds the results were quite accurate.
Edge Thresholds can be seen below.
hough_simple1 = .3*(maximum value in edge magnitude image)
hough_simple2 = .3*(maximum value in edge magnitude image)
hough_complex = .2*(maximum value in edge magnitude image)

p7.m
========
The lines are then drawn onto the image after scanning through the hough accumulator array
The plot function was used instead of the line function, becauase I thought the lines that it drew 
were slightly cleaner but these two functions are interchangeable.  One simply operates on two vectors and one 
on two points.
* There are three lines that are detected by my implementation of the hough transform that probably should not be on the image.
I did not want to take them out using any cheap fixes, so I left them in the image.
Threshold Values can be seen below
hough_simple_1 = 112
hough_simple_2 = 60
hough_simple_3 = 145

p8.m
========
To find the edge segments and not plot these portions of the line I recalculated the edge threshold image with 
a value of .25*(original edge threshold) for each image.  This was to widen the detected edges within the image.
This was shown to add robustness to this algorithm and improve the lines that were found, because without this small
angle errors would result in lines begin cut short or not drawn as you will see shortly.
I then went through each hough line that was created and array of x indices that spanned the image in x that were 
.005 apart.  Then I solved for the y points for each corresponding x.  I then floored both x and y, so that they could be applied
to the pixels within the image, and if x and y were in the image plane AND the thresholded edge image indicated there was a line at 
(x,y) the pixel value was changed to 255, and in this way disconnected white line segments were drawn throughout the image.  
 
