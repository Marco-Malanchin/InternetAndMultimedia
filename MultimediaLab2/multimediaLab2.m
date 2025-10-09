A = imread('lena.jpg');%salvo l'immagine
B = double(A); %converto l'immagine in double
C = uint8(A); %la converto pure in byte
imshow(B, []); %mostro l'immagine in double
figure;
imshow(C, []); %mostro l'immagine in uint8
imwrite(C, 'lena.bmp' , 'bmp');
figure;
L = 256;
s = NegImg(C, L);
imshow(s, []);
figure;
gamma = 0.45;
Low = 40;
High = 200;
t = PotImg(C, Low, High, gamma);
imshow(t, []);
