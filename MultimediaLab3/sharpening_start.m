% Read the Luna image and diplay it
f = imread("Luna.jpeg"); %leggo l'immagine
imshow(f, []); %mostro l'immagine
title('immagine originale');
figure;
% Create a laplacian kernel (by using fspecial) and apply it to the image Luna by using the function imfilter
la = fspecial("laplacian"); %creo il laplacian filter
fla = imfilter(f, la); %applico il filtro
imshow(fla, []); %mostro l'immagine
title('Laplacian filter');
figure;
% Visualize the result and (if needed) scale (=normalize it) it to make it visible

% Perform the previous operations using the kernel obtained from
% g(𝑥,𝑦)=𝑓(𝑥,𝑦)+𝑐[𝛻^2 (𝑥,𝑦)] (check the laplacian in the slides)
g = [0 -1 0; -1 5 -1; 0 -1 0 ]; %componenti del filtro, visualizzare slide
fg = imfilter(f, g); %applico il filtro
imshow(fg, []);%mostro l'immagine
title('g filter');
figure;
% Read the image Baboon and display it
b = imread('baboon.jpg'); %leggo l'immagine
imshow(b, []);%mostro l'immagine
title('immagine originale');
figure;

% The image is in color, take only the R component or convert it to
% grayscale (does this operation return the same result?)
G = rgb2gray(b);                % Converte in scala di grigi
imshow(G, []);     %mostro l'immagine in scala di grigi
title('immagine originale in scala di grigi');
figure;
% Extract the image edges using the Prewitt operator with the function edge
e = edge(G, 'Prewitt'); %filtro usando Prewitt

% Extract the image edges using the Sobel filter
So = edge(G, "sobel"); %filtro usando Sobel


% Extract the image edges using the Canny filter
Ca = edge(G, "canny");%filtro usando Canny

% Display using subplot the three filtered versions of Baboon that you created
%with the Prewitt, Sobel and Canny filter
subplot(1,3,1);      % 1 riga, 3 colonne, prima posizione
imshow(e, []);
title('Prewitt filter');
subplot(1,3,2);      % 1 riga, 3 colonne, seconda posizione
imshow(So, []);
title('Sobel filter');
subplot(1,3,3);      % 1 riga, 3 colonne, terza posizione
imshow(Ca, []);
title('Canny filter');
figure;

% Create a noisy image by adding salt-and-pepper noise using the imnoise function 
GN = imnoise(G);%aggiungo il salt and pepper noise all immagine in scala di grigi
imshow(GN, []); 
title('immagine in scala di grigi + rumore')
figure;
% Extract the image edges using the Prewitt operator with the function edge. Does the performance of the filter change?
eN = edge(GN, 'Prewitt');
% Try varying the threshold value of the function edge

% Extract the edges from the noisy image using the Sobel filter
SoN = edge(GN, "sobel");

% Extract the edges from the noisy image using the Canny filter
CaN = edge(GN, "canny");


% Display using subplot the three filtered versions of Baboon that you created
%with the Prewitt, Sobel and Canny filter
subplot(1,3,1);      % 1 riga, 3 colonne, prima posizione
imshow(eN, []);
title('Prewitt filter');
subplot(1,3,2);      % 1 riga, 3 colonne, seconda posizione
imshow(SoN, []);
title('Sobel filter');
subplot(1,3,3);      % 1 riga, 3 colonne, terza posizione
imshow(CaN, []); %il peggiore, con il rumore fa ancora più confusione, mentre gli altri riconoscono i bordi tranquillamente  
title('Canny filter');
