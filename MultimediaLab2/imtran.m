function g = imtran(f,trasf)
if trasf == "neg"
    L = 256; %fisso il valore massimo per la conversione in negativo
    t = NegImg(f, L);
elseif trasf == "pot"
    gamma = 0.75; %gamma dell elevamento a potenza
    Low = 40/255; %normalizzo i massimi ed i minimi, l'elevamento a potenza funziona con i double normalizzati nel range [0,1]
    High = 250/255;
    B = im2double(f);%normalizzo l'immagine
    t = PotImg(B, Low, High, gamma);
elseif trasf == "log"
    c = 45;
    R = im2double(f);
    t = LogImg(R,c);
else
    E = 20;
    m = 0.5;
    R = im2double(f);
    t = ConImg(R, m, E);
end
g = t;
    