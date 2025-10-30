f = imread("barbara.jpg"); %leggo l'immagine
F = fft2(f); %faccio la trasformata usando la fft
S = abs(F); %prendo il modulo della trasformata e lo mostro
S=log(1+abs(S)); %logaritmo comprime i valori molto grandi e amplifica quelli piccoli, rendendo visibile l'intero spettro.
imshow(S,[]); %mostro l'immagine

Fc = fftshift(F); %centro lo spettro, la fft non lo fa in automatico, metto al centro le basse frequenze
figure;
imshow(abs(Fc),[]);

S2=log(1+abs(Fc));%come prima comprimo i valori con il logaritmo per rendere visibile tutto lo spettro
figure;
imshow(S2,[]);
figure;

lowPass = F;
[a,b] = size(lowPass);
dist = distmatrix(a,b);
for i = 1 : a
    for j = 1 : b
        if dist(i,j) < 35
            lowPass(i,j) = 1;
        else
            lowPass(i,j) = 0;
        end
    end
end
imshow(lowPass, []);
figure;
filtered = F .* lowPass;
imshow(filtered, []);
figure;
img_rec = real(ifft2(filtered));
imshow(img_rec, []);
figure;
sigma = 30;
H_gau=exp(-(dist.^2)/(2*(sigma^2)));
GaussianFiltered = F .* H_gau;
img_rec_gau = real(ifft2(GaussianFiltered));
imshow(img_rec_gau, []);
figure;
D0 = 35;
n = 3;
H_but=1./(1+(dist./D0).^(2*n));
ButterworthFiltered = F .* H_but;
img_rec_butt = real(ifft2(ButterworthFiltered));
imshow(img_rec_butt, []);



