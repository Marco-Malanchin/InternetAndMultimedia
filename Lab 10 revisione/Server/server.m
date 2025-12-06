clear all
clc

% 1. The server opens a TCP socket on port number 23456 and waits for a new 
% connection request. 
SERVERPORT = 50001;

% Create server socket listening to port SERVERPORT.  
S = tcpserver('::', SERVERPORT);

disp('Server ready, waiting for connections...')

% Specify byte ordering as "Little-Endian" 
% Same setting should be applied to the client side
S.ByteOrder = 'little-endian';

% Link the function to be invoked any time the connection state changes
% (i.e., a new client connects, or the connected one gets disconneted)
% The linked function will implement all the steps required to provide the
% service. 
S.ConnectionChangedFcn = @shazam;