f = imread('lena.jpg');
imwrite(f,'lena100.jpg','Quality',100);
f100 = imread('lena100.jpg');
imwrite(f,'lena90.jpg','Quality',90);
f90 = imread('lena90.jpg');
imwrite(f,'lena80.jpg','Quality',80);
f80 = imread('lena80.jpg');
imwrite(f,'lena70.jpg','Quality',70);
f70 = imread('lena70.jpg');
imwrite(f,'lena60.jpg','Quality',60);
f60 = imread('lena60.jpg');
imwrite(f,'lena50.jpg','Quality',50);
f50 = imread('lena50.jpg');
imwrite(f,'lena40.jpg','Quality',40);
f40 = imread('lena40.jpg');
imwrite(f,'lena30.jpg','Quality',30);
f30 = imread('lena30.jpg');
imwrite(f,'lena20.jpg','Quality',20);
f20 = imread('lena20.jpg');
imwrite(f,'lena10.jpg','Quality',10);
f10 = imread('lena10.jpg');
subplot(2,5,1);      % 1 riga, 3 colonne, prima posizione
imshow(f100, []);
title('Compressione 100');
subplot(2,5,2);      % 1 riga, 3 colonne, seconda posizione
imshow(f90, []);
title('Compressione 90');
subplot(2,5,3);      % 1 riga, 3 colonne, terza posizione
imshow(f80, []);
title('Compressione 80');
subplot(2,5,4);      % 1 riga, 3 colonne, terza posizione
imshow(f70, []);
title('Compressione 70');
subplot(2,5,5);      % 1 riga, 3 colonne, terza posizione
imshow(f60, []);
title('Compressione 60');
subplot(2,5,6);      % 1 riga, 3 colonne, terza posizione
imshow(f50, []);
title('Compressione 50');
subplot(2,5,7);      % 1 riga, 3 colonne, terza posizione
imshow(f40, []);
title('Compressione 40');
subplot(2,5,8);      % 1 riga, 3 colonne, terza posizione
imshow(f30, []);
title('Compressione 30');
subplot(2,5,9);      % 1 riga, 3 colonne, terza posizione
imshow(f20, []);
title('Compressione 20');
subplot(2,5,10);      % 1 riga, 3 colonne, terza posizione
imshow(f10, []);
title('Compressione 10');

qualities = [100 90 80 70 60 50 40 30 20 10];

for q = qualities
    img = eval(sprintf('f%d', q));   % prende f100, f90, f80, ecc.
    
    ps = psnr(img, f); %più è alto più l'immagine ricostruita assomiglia all originale
    ss = ssim(img, f); %più si avvicina a 1 più le immagini si assomigliano in struttura contrasto e luminanza
    
    fprintf("Quality %3d -> PSNR = %.2f dB  |  SSIM = %.4f\n", q, ps, ss);
end