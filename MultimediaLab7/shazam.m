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
W=fun_windowing(y, windowshape, step);




