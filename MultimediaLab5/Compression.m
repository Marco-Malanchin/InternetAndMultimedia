f = imread('lena.jpg');
imwrite(f,'lena100.jpg','Quality',100);
f100 = imread(lena100.jpg);
f90 = imwrite(f,"lena90.jpg",90);
f80 = imwrite(f,"lena80.jpg",80);
f70 = imwrite(f,"lena70.jpg",70);
f60 = imwrite(f,"lena60.jpg",60);
f50 = imwrite(f,"lena50.jpg",50);
f40 = imwrite(f,"lena40.jpg",40);
f30 = imwrite(f,"lena30.jpg",30);
f20 = imwrite(f,"lena20.jpg",20);
f10 = imwrite(f,"lena10.jpg",10);
subplot(2,5,1,1);      % 1 riga, 3 colonne, prima posizione
imshow(f100, []);
title('Compressione 100');
subplot(2,5,1,2);      % 1 riga, 3 colonne, seconda posizione
imshow(f90, []);
title('Compressione 90');
subplot(2,5,1,3);      % 1 riga, 3 colonne, terza posizione
imshow(f80, []);
title('Compressione 80');
subplot(2,5,1,4);      % 1 riga, 3 colonne, terza posizione
imshow(f70, []);
title('Compressione 70');
subplot(2,5,1,5);      % 1 riga, 3 colonne, terza posizione
imshow(f60, []);
title('Compressione 60');
subplot(2,5,2,1);      % 1 riga, 3 colonne, terza posizione
imshow(f50, []);
title('Compressione 50');
subplot(2,5,2,2);      % 1 riga, 3 colonne, terza posizione
imshow(f40, []);
title('Compressione 40');
subplot(2,5,2,3);      % 1 riga, 3 colonne, terza posizione
imshow(f30, []);
title('Compressione 30');
subplot(2,5,2,4);      % 1 riga, 3 colonne, terza posizione
imshow(f20, []);
title('Compressione 20');
subplot(2,5,2,5);      % 1 riga, 3 colonne, terza posizione
imshow(f10, []);
title('Compressione 10');
figure;