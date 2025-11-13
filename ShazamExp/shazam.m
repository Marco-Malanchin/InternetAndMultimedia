% Script to check the Shazam functions
clear all

%----------------
% Initialization
%----------------
% Path to the LIBRARY sound tracks (i.e., music database)
pathprefixLIBRARY = 'music_wav_short/';
% Path to the TEST sound clips (music clips to be searched in the LIBRARY
% for best matching) 
pathprefixTEST= 'music_wav_test/';
% standard duration of a test clip [seconds]
cliptime =2.5; 
% Duration of an audio chunk (Seconds)
chunktime = 100e-3; 
% Fraction of overlapping between consecutive windows
overlapfraction= 0.5; 
% Number of features to be extracted per window
Nfeatures=2; 


%------------------------
% PICK a clip from the TEST folder
%------------------------
testfiles = dir(strcat(pathprefixTEST,'*wav'));

for ifile=1:size(testfiles,1)
    disp([num2str(ifile),': ',testfiles(ifile).name])
end
selection = input('Pick a file: ','s');
testnamefile = testfiles(str2double(selection)).name;
% Read selected audio track
namefile = strcat(pathprefixTEST,testnamefile);
[yfull,Fs]=audioread(namefile);

% lenght of the extracted clip of "cliptime" seconds
Ntot= round(Fs*cliptime);

if Ntot>length(yfull) 
    error(['Test file is too short... a minimum of ',num2str(cliptime),' seconds is required'])
end

% Extract first "cliptime" seconds from the audio signals
y = yfull(1:Ntot); 

% Size of the spectrogram windowing function
n = round(Fs*chunktime);

% chunktime - steptime = overlapping 
steptime = (1-overlapfraction)*chunktime; 
wstep = ceil(Fs*steptime);

% Spectrogram windowing function
windowshape = hamming(n); 

% Windowing audio clip
% The function returns a matrix n x K, where n is the window size and K the
% number of windows that can be extracted from the clip. W(:,j) contains
% the samples in the j-th window, multiplied by the windowing function
% "windowshape". The first window is aligned with the beginning of the
% clip, the others are slid to the right at steps of wstep samples 
W = fun_windowing(y,windowshape,wstep);

% Extract signature 
FFeatures=fun_GetAudioFeatures(W,Nfeatures);
kmax = size(FFeatures,2);

%-------------------------------------------
%% Search clip in the LIBRARY audio tracks
%-------------------------------------------

ttargetfile = dir([pathprefixLIBRARY,'/*wav']);
% Initialize the bestscore vector that stores the least mse of the
% matching between test clip and target audio track
bestscore=Inf*ones(size(ttargetfile,1),1);

% Initialize the bestmatch vector that stores the offest of the best match
% of the test audio file in each target test file 
bestmatch =ones(size(ttargetfile,1),1);

% Try all target audio tracks
disp('Extracting features from LIBRARY tracks... it may take some time... ')
for k=1:size(ttargetfile,1)
    
    % Pick a target audio file from the LIBRARY
   testname =  strcat(pathprefixLIBRARY,ttargetfile(k).name);
   % Read target audio file 
   [zz,Fs]=audioread(testname);
   % Extract features from target file
   WWz = fun_windowing(zz,windowshape,wstep);   
   TFFeatures=fun_GetAudioFeatures(WWz,Nfeatures);
   
   % Find best matching between test clip features and target features (for
   % all possible offsets)
   totoffsetsteps = size(TFFeatures,2)-kmax+1;
   aggregatemse = zeros(totoffsetsteps,1); 
   for zoffset=1:totoffsetsteps
       aggregatemse(zoffset)= sum(sum((TFFeatures(:,zoffset:zoffset+kmax-1) - FFeatures).^2));
   end
   % bestscore stores the best MSE for this file
   % bestmatch stores the index of the window corresponding to the best
   % match for this file
   [bestscore(k),bestmatch(k)]=min(aggregatemse);
   
end
%%
[best,ibest]=min(bestscore);
bestrange= bestmatch(ibest)*wstep+(0:Ntot-1);
disp(['Test audio clip taken from: ',testnamefile])
disp(['Best match found: ',ttargetfile(ibest).name])

%%
s=input('Do you want to listen the two audio files (Y/n)?','s'); 
if isempty(s) || upper(s(1))=='Y'
    disp(['Playing test audio file ', testnamefile,'. Press any key when done...']);
    sound(y,Fs);
    pause
    disp(['Playing best match audio file ', ttargetfile(ibest).name]);
    testname =  strcat(pathprefixLIBRARY,ttargetfile(ibest).name);
    [zz,Fs]=audioread(testname);
    sound(zz(min(bestrange,length(zz))),Fs);
end