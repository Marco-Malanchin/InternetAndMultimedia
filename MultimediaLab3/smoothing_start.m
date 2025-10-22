% Read the Lena image and diplay it
f = imread('lena.jpg');
imshow(f, []);
figure;
%%%%%%%%%%%%%% AVERAGE FILTER %%%%%%%%%%%%%%
% Create an average filter using the function fspecial (check the slides for details)
h = fspecial("average", [3,3]);
% Filter the Lena image with the average filter you created using the
%function imfilter 
b = imfilter(f, h);
imshow(b, []);
figure;

% How does imfilter handle smoothing in edges?
%quando ci sono valori mancanti nella matrice imfilter mette 0 come valore
%mancante, per effettuare questo controllo basta calcolare nel pixel al
%bordo immagine il valore della convoluzione.

%%%%%%%%%%%%%% NON-UNIFORM AVERAGE FILTER %%%%%%%%%%%%%%
% Filters generated with fspecial are uniform. Create a non-uniform average
%filter (i.e., not all elements of the filter have the same weigth)
nh = [0.075 0.125 0.075; 0.125 0.2 0.125; 0.075 0.125 0.075 ];
% la somma degli elementi dentro il fltro deve essere 1 perche' non
% vogliamo cambiare la luminosita' dell immagine ma solo ammorbidirla
% se la somma > 1 immagine piu' chiara, < 1 piu' scura
% Filter the Lena image with the non-uniform filter you created
c = imfilter(f,nh);
% Display using subplot the two filtered versions of Lena that you created
%with the average and non-uniform average filter
imshow(c,[]);
figure;
% Do you notice any difference? Try modifying the filter size and weights

%%%%%%%%%%%%%% GAUSSIAN FILTER %%%%%%%%%%%%%%
% Create a Gaussian filter of size 3𝑥3 and variance 1.5 and visualize it using the function bar3
variance = sqrt(1.5);
g = fspecial("gaussian", 3, variance);
bar3(g);
figure;
% Filter the Lena image with the Gaussian filter 
d = imfilter(f,g);
imshow(d,[]);
figure;

% Display using subplot the two filtered versions of Lena that you created
%with the average and gaussian filter

% Do you notice any difference? Try modifying the filter sizes and the
%variance of the gaussian

%%%%%%%%%%%%%% DENOISING %%%%%%%%%%%%%%
% Create a noisy image by adding salt-and-pepper noise using the imnoise function 
no = imnoise(f);
imshow(no, []);
figure;
% Remove the noise with a median filter
m = medfilt2(no, [7, 7]);
% Display the result of the filtering for different values of filter size 
imshow(m, []);
figure;
% Remove the noise with an average filter
av = fspecial("average", [7,7]);
e = imfilter(no, av);
imshow(e, []);

% Display the result of the denoising by using the median and the gaussian filter 

% Do you notice any difference? Try modifying the filter sizes and the
% noise quantity
%gaussiano funziona meglio