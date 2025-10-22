% Read the Luna image and diplay it
f = imread("Luna.jpeg");
imshow(f, []);
figure;
% Create a laplacian kernel (by using fspecial) and apply it to the image Luna by using the function imfilter
la = fspecial("laplacian");
fla = imfilter(f, la);
imshow(fla, []);
figure;
% Visualize the result and (if needed) scale (=normalize it) it to make it visible

% Perform the previous operations using the kernel obtained from
% g(𝑥,𝑦)=𝑓(𝑥,𝑦)+𝑐[𝛻^2 (𝑥,𝑦)] (check the laplacian in the slides)
g = [0 -1 0; -1 5 -1; 0 -1 0 ];
fg = imfilter(f, g);
imshow(fg, []);
figure;
% Read the image Baboon and display it
b = imread('baboon.jpg');
imshow(b, []);
figure;

% The image is in color, take only the R component or convert it to
% grayscale (does this operation return the same result?)
G = rgb2gray(b);                % Converte in scala di grigi
imshow(G, []);     
figure;
% Extract the image edges using the Prewitt operator with the function edge
e = edge(G, 'Prewitt');
imshow(e, []);
figure;
% Extract the image edges using the Sobel filter
So = edge(G, "sobel");
imshow(So, []);     
figure;

% Extract the image edges using the Canny filter
Ca = edge(G, "canny");
imshow(Ca, []);     
figure;

% Display using subplot the three filtered versions of Baboon that you created
%with the Prewitt, Sobel and Canny filter

% Create a noisy image by adding salt-and-pepper noise using the imnoise function 
GN = imnoise(G);
imshow(GN, []);     
figure;
% Extract the image edges using the Prewitt operator with the function edge. Does the performance of the filter change?
eN = edge(GN, 'Prewitt');
imshow(eN, []);
figure;

% Try varying the threshold value of the function edge

% Extract the edges from the noisy image using the Sobel filter
SoN = edge(GN, "sobel");
imshow(SoN, []);     
figure;

% Extract the edges from the noisy image using the Canny filter
CaN = edge(GN, "canny");
imshow(CaN, []);   %il peggiore, con il rumore fa ancora più confusione, mentre gli altri riconoscono i bordi tranquillamente  


% Display using subplot the three filtered versions of Baboon that you created
%with the Prewitt, Sobel and Canny filter