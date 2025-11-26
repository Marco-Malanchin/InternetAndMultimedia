clear all
% Script to check the Shazam functions

%----------------
% Initialization
%----------------
% Path to the LIBRARY sound tracks (i.e., music database)
pathprefixLIBRARY = 'TESTaudiotraces/';
% Path to the TEST sound clips (music clips to be searched in the LIBRARY
% for best matching) 
pathprefixTEST= 'TESTaudiotraces/';
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


SERVERPORT= 50000;

% Manage connection error: if the server is busy, the connection request is
% rejected. The exception can be captured and handled using the TRY-CATCH
% paradigm. Errors raised by instructions in the TRY section are analyzed
% according to the CATCH instructions. 
connectionSuccessful = 0;
% Repeat until connection is accepted
while connectionSuccessful == 0    
    try
        C = tcpclient("192.168.122.1", SERVERPORT);
        connectionSuccessful = 1;
    % If a connection error is raised execute the following instructions
    catch ME  
        if strcmp(ME.identifier, 'MATLAB:networklib:tcpclient:cannotCreateObject')
            connectionSuccessful = 0;
            disp('wait')
        end
    end
end
disp('Connected to server')
% Specify byte ordering as "Little-Endian" 
% Same setting should be applied to the server side.
% Note: this is irreleant if data are represented as single bytes (uint8 or
% int8, char), while it is fundamental when using multi-byte formats
% (uint16, int16, double, ...)
C.ByteOrder = 'little-endian';

% Set waiting time to complete read and write operations
% If this time elapses before all data are transmitted, the client will
% stop the transmission anyway
C.Timeout = 60;
write(C, length(yfull), "uint16");
write(C, yfull, "uint8");
write(C, Fs, "uint16");
index = read(C, 1, "uint8");
l = 0;
y = 0;
fs = 0;
if index == 0
    disp("Canzone non trovata");
else
    disp("Index canzone: ", index);
    nameFile = read(C, 1, "char");
    disp("Nome canzone: ", nameFile);
    l = read(C, 1, "uint32");
    y = read(C, l, "uint8");
    fs = read(C, C.NumBytesAvailable,"uint16");
    s=input('Do you want to listen the two audio files (Y/n)?','s'); 
    if isempty(s) || upper(s(1))=='Y'
        disp(['Playing test audio file ', testnamefile,'. Press any key when done...']);
        sound(yfull,Fs);
        pause
        disp(['Playing best match audio file ', ttargetfile(ibest).name]);
        sound(y(length(yfull)),fs);
    end
end


