f = imread("barbara.jpg");
F=fft2(f);
S=fftshift(log(1+abs(F)));
S=gscale(S);
imshow(S,[]);
figure;
%Generate a Sobel filter with the function fspecial
h=fspecial('sobel');
%that in the frequency domain is
[m,n] = size(F);
H1 = freqz2(h,m,n); 
%Let’s perform the same filtering in the spatial and in the frequency domain. Then,
%compare the results.
%In the spatial domain
gs=imfilter(double(f),h);
%In the frequency domain
F = fft2(double(f));
G = H1 .* F;
gf = real(ifft2(G));
%Compare the results
imshow(gs,[]);
figure;
imshow(gf,[]);
figure;
%Compare the absolute values of the filtered images
absgs = abs(gs);
absgf = abs(gf);
imshow(absgs, []);
figure;
imshow(absgf, []);
figure
