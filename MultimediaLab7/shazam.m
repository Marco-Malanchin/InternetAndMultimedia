[y,Fs] = audioread("music_wav_short_moodle/gravity2.wav");
sound(y,Fs);
clear sound;
load("handel.mat");
filename = 'handel.wav';
audiowrite(filename,y,Fs);
%per questo audio la Fs e' 8192
[a,b] = size(y);
[c,d] = size(Fs);
load("stereo_sample.mat");
filename = 'stereo_saple.wav';
audiowrite(filename,y,Fs);
%per questo audio la Fs e' 8192
M = 1000;
windowshape = [M,1];
step = M/2;
W=fun_windowing(y, windowshape, step);
[A,B] = size(W);
Y = zeros(A, B);       % matrice per salvare le FFT
P = zeros(A, B);
for i = 1:B
    Y(:, i) = fft(W(:, i));   % FFT del frame i-esimo
    P(:, i) = abs(Y(:, i)).^2;
end
P = P(1:A/2, :); %prendo solo le freq positive
nBands = 8; %calcolo quante gruppi di banda fare
Mpos = size(P,1); %capisco quante righe ho
bandSize = floor(Mpos / nBands); %calcolo quante righe deve avere ogni gruppo di banda
bandEnergy = zeros(nBands, size(P,2)); % nBands × K (finestre)
for i = 1:nBands
    startBin = (i-1)*bandSize + 1;%calcolo l'indece iniziale del gruppo di banda
    if i == nBands
        endBin = Mpos;
    else
        endBin = i*bandSize;%calcolo l'indice finale
    end
    % Sommo tutte le potenze in quei bin per ogni frame
    % sum(...,1) = somma per colonna
    bandEnergy(i,:) = sum(P(startBin:endBin, :), 1);%sommo tutte le energie 
end
