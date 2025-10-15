%visto che è una funzione di esercitazione e non un compito di Fondamenti
%di informatica non metto controlli per verificare che l'utente inserisca
%valori adeguati
function g = imtran(f)
funzione = input('Che funzione vuoi usare?\n "neg" per effettuare la conversione in negativo dell immagine\n "pot" per effettuare la funzione potenza all immagine\n "log" per effettuare la funzione logaritmo all immagine\n "con" per effettuare la funzione contrasto all immagine\nscelta:', 's'); %'s' parsa l'input come stringa
if funzione == "neg"
    L = 256; %fisso il valore massimo per la conversione in negativo
    f = uint8(f); %converto l'immagine in int8 in caso non lo fosse gia'
    t = NegImg(f, L);
elseif funzione == "pot"
    gamma = input('\ninserisci il valore di gamma:'); %gamma dell elevamento a potenza
    Low = input('\ninserisci il minimo(compreso tra 0 e 255):');
    Low = Low/255; %normalizzo i massimi ed i minimi, l'elevamento a potenza funziona con i double normalizzati nel range [0,1]
    High = input('\ninserisci il valore massimo(compreso tra 0 e 255):');
    High = High/255;
    B = im2double(f);%normalizzo l'immagine
    t = PotImg(B, Low, High, gamma);
elseif funzione == "log"
    c = input('\ninserisci il valore di C che moltiplicherà il logaritmo:');
    R = im2double(f);
    t = LogImg(R,c);
elseif funzione == "con"
    E = input('\ninserisci il valore di E(20):');
    m = input('\ninserisci il valore di m(0.5):');;
    R = im2double(f);
    t = ConImg(R, m, E);
end
g = t;
    