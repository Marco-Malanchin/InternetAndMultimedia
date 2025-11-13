% Create Target Track
% 
% Creat two test audio clips, one clear and one noisy, by picking a random
% sequence of given duration from a random audio file and saving it as it
% is (clear) and with an additive gaussian noise (noisy)
 
clear all

% -----------------
% INPUT parameters
% -----------------
% Path of the source audio library
pathprefixLIBRARY = '../music_wav_short/';
% Path of the target audio library
pathprefixTEST = '../music_wav_test/';
% Time duration of the target audio clips
Duration = 2.5; % seconds
% noise power = signal_power*noisefactor
noisefactor=0.2; 

% ----------------------------
% Pick a random audio file 
% ----------------------------
% If target audio library folder does not exist, create it!
if ~exist(pathprefixTEST,'dir')
    mkdir('.',pathprefixTEST);
end

% Read all files from directory
allfiles=dir(strcat(pathprefixLIBRARY,'*.wav'));
% Number of wav files in the directory
numfiles = size(allfiles,1);
% pick random file
pickrnd =randi(numfiles);
% extract file name
testmusicfiles = deblank(allfiles(pickrnd).name);
disp(['Picked track: ',testmusicfiles])

% get target audio file name
filename = strcat(pathprefixLIBRARY,testmusicfiles);


% read target audio file 
[testy,testFs] = audioread(deblank(filename));

% turn stereo tracks into mono
if size(testy,2)>1, testy=mean(testy,2); end

% compute time duration of audio track 
totaltime=length(testy)/testFs;


% ----------------------------
% Extract a random clip from the audio file, add noise, and save it
% ----------------------------

% Compute the number of samples corresponding to a time "Duration"
nsamples = round(Duration*testFs);

% Choose a random starting time
starting = randi(length(testy)-nsamples+1);

% Extract the clip from the original track and save it as a WAV file
% with prefix "clean_" 
yex = testy(starting:starting+nsamples-1);

% Create the name of the target "clean" clip
clearclip = strcat(pathprefixTEST,'clear_',testmusicfiles);
% Check if the name is already been taken. In case, add a progressive
% number in front of it
number = 1;
prenum='';
while exist(clearclip,'file')
    prenum=num2str(number);
    clearclip = strcat(pathprefixTEST,'clear_',prenum,testmusicfiles);
    number=number+1;
end
% Save the clip as WAV file
disp(['Saving ',clearclip])
audiowrite(clearclip,yex,testFs)
% Add noise to the clip and save it as a WAV file with prefix "noisy_"
yexnoisy=yex+randn(size(yex))*sqrt(mean(yex.^2)*noisefactor);
noisyclip = strcat(pathprefixTEST,'noisy_',prenum,testmusicfiles);
disp(['Saving ',noisyclip])
audiowrite(noisyclip,yexnoisy,testFs);
