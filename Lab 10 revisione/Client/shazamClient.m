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
Nfeatures=4; %aumento le features per essere più preciso


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


SERVERPORT= 50001;

% Manage connection error: if the server is busy, the connection request is
% rejected. The exception can be captured and handled using the TRY-CATCH
% paradigm. Errors raised by instructions in the TRY section are analyzed
% according to the CATCH instructions. 
connectionSuccessful = 0;
% Repeat until connection is accepted
while connectionSuccessful == 0    
    try
        C = tcpclient("localhost", SERVERPORT); % 192.168.122.1
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

% Mappa yfull double [-1,1] in uint16 [0,65535]
yfull = uint16( (yfull + 1) * 32767.5 );

write(C, length(yfull), "uint16");  % Manda al server la lunghezza dello spezzone
write(C, yfull, "uint16");   % Manda al server l'audio
write(C, Fs, "uint16"); % Manda al server la Frequenza di campionamento
index = read(C, 1, "uint8");
l = 0;
y = 0;
fs = 0;
if index == 0
    disp("Canzone non trovata");
    clear C;
else
    disp("Index canzone: " + num2str(index));
    length_nameFile = read(C, 1, "uint8");
    nameFile = read(C, length_nameFile, "char");
    disp("Nome canzone: " + num2str(nameFile));
    
    
    l = read(C, 1, "uint32");
    y = read(C, l, "uint16");

    y = double(y(:));
    y = (y / 32767.5) - 1;
    y = y';

    fs = read(C, 1,"uint16");
    fs = double(fs);
    s=input('Do you want to listen the two audio files (Y/n)?','s'); 
    if isempty(s) || upper(s(1))=='Y'
        disp(['Playing test audio file ', testnamefile,'. Press any key when done...']);
        yfull = double(yfull)/32767.5 - 1;
        sound(yfull,Fs);
        pause
        disp(['Playing best match audio file ', nameFile]);
        
        sound(y,fs);
    end
    clear C;
end