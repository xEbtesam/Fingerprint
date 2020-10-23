
%%========================================================%%
%  Names: Ebtesam Aloboud              %               %
%%========================================================%%

%% ====================Initialization=====================%%
% Close images and clear the workspace, if there are any active contents
clear; 
close all; 
clc;
%%========================================================%%

% INPUT: load the image to be processed
%M = imread('mammogram.tif'); %Mammogram image (Medical image)
M = imread('Images/finger.png'); % finger
%M = imread('moon.tif'); % moon
%M = imread('pollen.tif'); % pollen

% Convert image from int to double for processing
I = double(M);
I = uint8(normalizeImRange(I));

% Filter the image with sobel filter
% ------------------------------------
[Gx, Gy] = imgradientxy(I,'prewitt');

% The gradient
% =================
Jx = Gx.^2 - Gy.^2;
Jy = 2 .* Gx .* Gy; 

% Filter the image with Gaussian filter
% -------------------------------------
w1 = fspecial('gaussian', [3,3], 5); % Gaussian filter
Jx = imfilter(Jx, w1, 'replicate');
Jy = imfilter(Jy, w1, 'replicate');

% The Magnitude of gradient 
% =================
J = sqrt(Jx .^2 + Jy.^2);

%The Direction of gradient 
% =================
orient = 0.5 * atan2(Jy,Jx)+ pi/2;


%print the image with the orientation map 
% =================
lineSize = 20;
[rows, cols] = size(orient);

 % orientation lines size
len = 0.8 * lineSize; 

% Subsample the orientation data 
 s_orient = orient(lineSize:lineSize:rows-lineSize,lineSize:lineSize:cols-lineSize);

xoff = len/2*cos(s_orient);
yoff = len/2*sin(s_orient);    

imshow(I); 
hold on

% Determine placement of orientation vectors
[x,y] = meshgrid(lineSize:lineSize:cols-lineSize, lineSize:lineSize:rows-lineSize);
    
x = x-xoff;
y = y-yoff;

% Orientation vectors
u = xoff*2;
v = yoff*2;

quiver(x,y,u,v,0,'.','linewidth',1, 'color','r');


