f = imread("BarbaraNoise.bmp");%é una immagine con rumore salt and pepper, il miglior modo di togliere il rumore è un filtro mediano
m = medfilt2(f, [5, 5]); %applico il filtro mediano
imshow(m, []);
figure;
%provo un altro metodo
F = fft2(f);
[a,b] = size(F);
dist = distmatrix(a,b);
sigma = 30;
H_gau=exp(-(dist.^2)/(2*(sigma^2)));
High_gau = 1 - H_gau;
GaussianFilteredHigh = F .* High_gau;
img_rec_gau = real(ifft2(GaussianFilteredHigh));
imshow(img_rec_gau, []);
figure;
GaussianFilteredLow = GaussianFilteredHigh .* H_gau;
img_rec_gauLow = real(ifft2(GaussianFilteredLow));
imshow(img_rec_gauLow, []);
figure;
H_gau2=exp(-(dist.^2)/(2*(sigma^2)));
High_gau2 = 1 - H_gau;
GaussianFiltered2 = GaussianFilteredLow .* High_gau2;
img_rec_gau2 = real(ifft2(GaussianFiltered2));
imshow(img_rec_gau2, []);



