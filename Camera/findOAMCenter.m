function [ points ] = findOAMCenter( vid, nPoints )
%FINDOAMCENTER Takes a snapshot and lets the user click in the center.
%   If nPoints (optional, default = 1) is specified then several points can
%   be selected.
%   The result is a 2 x NPOINTS matrix; each
%   row is [X Y] for one point.

img = getsnapshot(vid);

%%Find the centroid to suggest the center
centroid = regionprops(true(size(img)), img,  'WeightedCentroid');

%%Display the graph for user selection
if nargin < 2
    nPoints = 1;
end
points = zeros(2, nPoints);

imshow(img);     

k = 0;

hold on;           % and keep it there while we plot

plot(centroid(1).WeightedCentroid(1),centroid(1).WeightedCentroid(2),'ro');

while 1
    [xi, yi, but] = ginput(1);      % get a point
    if ~isequal(but, 1)             % stop if not button 1
        break
    end
    
    k = k + 1;
    points(k,1) = xi;
    points(k,2) = yi;

    plot(xi, yi, 'go');         % first point on its own

    if isequal(k, nPoints)
        break
    end
end

hold off;

if k < size(points)
    points = points(1:k, :);
end

points = round(points);

end
