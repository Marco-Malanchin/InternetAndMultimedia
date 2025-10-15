A = imread('lena.jpg');%salvo l'immagine
B = double(A); %converto l'immagine in double
C = uint8(A); %la converto pure in byte
imshow(B, []); %mostro l'immagine in double
figure;
imshow(C, []); %mostro l'immagine in uint8
imwrite(C, 'lena.bmp' , 'bmp');
figure;
L = 256; %fisso il valore massimo per la conversione in negativo
s = NegImg(C, L);
imshow(s, []);
figure;
gamma = 0.75; %gamma dell elevamento a potenza
Low = 40/255; %normalizzo i massimi ed i minimi, l'elevamento a potenza funziona con i double normalizzati nel range [0,1]
High = 250/255;
B = im2double(C);%normalizzo l'immagine
t = PotImg(B, Low, High, gamma);
imshow(t, []);
figure;
c = 45;
F = imread('transform.jpg');
R = im2double(F);
l = LogImg(R,c);
imshow(l, []);
figure;
E = 20;
m = 0.5;
g = ConImg(B, m, E);
imshow(g, []);
figure;
D = imread('lena.jpg');
x = imtran(D, "pot");
imshow(x, []);
figure;
k = DecBinaria(C);
figure;
tom = imhist(B);
bar(tom);
figure;
mm = imhist(s);
bar(mm);



