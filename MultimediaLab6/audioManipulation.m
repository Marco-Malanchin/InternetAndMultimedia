[y, Fs] = audioread("lz.mp3");
sound(y,Fs);
clear sound;
t = (0:length(y)-1) / Fs;%asse dei tempi dei campioni audio
plot(t, y)
xlabel("Tempo [s]")
ylabel("Ampiezza")
title("Forma d'onda del segnale audio");
figure;
load stereo_sample.mat;
filename = 'stereo_sample.wav';
audiowrite(filename,y,Fs);
[y2, Fs2] = audioread(filename);
left = y2(:,1); %metto tutti i valori del canale di sinistra
right = y2(:,2); %metto tutti i valori del canale di destra
sound(left, Fs);
clear sound;
sound(right,Fs);
clear sound;
time=(1/Fs)*length(y); 
t=linspace(0,time,length(y));
plot(t,y)
xlabel('Time (sec)');
ylabel('Relative signal strength')
figure;
time=(1/Fs)*2000;
t=linspace(0,time,2000);
plot(t,left(1:2000))
xlabel('Time (sec)');
ylabel('Relative signal strength')
N = 1000;            % ritardo in campioni
y_echo = y;          % nuovo segnale: copia di quello originale

for n = N+1:length(y)
    y_echo(n) = y(n) + y(n-N);
end
sound(y_echo, Fs);
clear sound
sound(y,Fs/1.5); %rallento il segnale modificando la frequenza
clear sound;
sound(y,Fs*1.5); %velocizzo il segnale modificando la frequenza
clear sound
diffMono = left - right;
sound(diffMono, Fs);
clear sound;
[S, F, T] = spectrogram(right, Fs);
figure;
imagesc(T, F, 20*log10(abs(S)));      % dai S in dB
axis xy;
xlabel('Tempo [s]');
ylabel('Frequenza [Hz]');
title('Spettrogramma');
colorbar;
[S, F, T] = spectrogram(left, Fs);
figure;
imagesc(T, F, 20*log10(abs(S)));      % dai S in dB
axis xy;
xlabel('Tempo [s]');
ylabel('Frequenza [Hz]');
title('Spettrogramma');
colorbar;
%Design a low-pass filter of order 10 to suppress frequencies larger than 200Hz.
fNorm = 200 / (Fs/2);
[b,a] = butter(10, fNorm, 'low');
AudioLow = filtfilt(b, a, y);
%Display the frequency response of the filter:
freqz(b,a,128,Fs);
%Reproduce the audio file:
sound (AudioLow,Fs);
clear sound;
%You can notice that the low frequencies have been preserved while the high
%frequencies have been removed.
%Design a high-pass filter of order 10 to suppress frequencies smaller than 5KHz.
fNorm = 3000 / (Fs/2);
[b, a] = butter(10, fNorm, 'high');
AudioHigh = filtfilt(b, a, y);
%Display the frequency response of the filter:
freqz(b,a,128,Fs);
%Reproduce the audio file:
sound(AudioHigh,Fs);
clear sound;
%You can notice that the high frequencies have been preserved while the low
%frequencies have been removed.

%Design a low-pass filter of order 10 to suppress frequencies outside the range 500 Hz -
%2500 Hz.
fNorm = [500/(Fs/2), 2500/(Fs/2)];
[b, a] = butter(10, fNorm, 'stop');
AudioBand = filtfilt(b, a, y);
%Display the frequency response of the filter:
freqz(b,a,128,Fs);
%Reproduce the audio file:
sound(AudioBand,Fs);
clear sound
flipped = flipud(y);
sound(flipped,Fs);
clear sound;



