function shazam(src,~)
    %----------------
    % Initialization
    %----------------
    % Path to the LIBRARY sound tracks (i.e., music database)
    pathprefixLIBRARY = './MusicLibrary/MusicLibrary/';
    
    % standard duration of a test clip [seconds]
    cliptime =2.5; 
    % Duration of an audio chunk (Seconds)
    chunktime = 100e-3; 
    % Fraction of overlapping between consecutive windows
    overlapfraction= 0.5; 
    % Number of features to be extracted per window
    Nfeatures=4; %aumento il numero di features per essere più preciso

    if src.Connected
        disp("sono connesso");
        while src.Connected
            % Read selected audio track
            length_y = read(src, 1, "uint16");  % Legge la lunghezza dell'audio
            yfull = read(src, length_y, "uint16");  % Legge l'audio
            Fs = read(src, 1, "uint16");    % Legge la Frequenza di campionamento
            
            yfull = double(yfull)/32767.5 - 1;
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
            FFeatures=fun_GetAudioFeatures(W,Nfeatures);    %$$$
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
            %disp (bestscore);
            [best,ibest]=min(bestscore);

            % media degli score escludendo il best
            media = 0;
            for k=1:size(ttargetfile,1)
                if k ~= ibest
                    media = media + bestscore(k);
                end           
            end

            media = media/(size(ttargetfile,1) - 1);
            
            % verifichiamo che la traccia presa sia corretta
            %calcolo il secondo miglior score
            bestscore(ibest)= Inf;
            [secondBest, secondibest] = min(bestscore);
            ratio = best / secondBest;
            delta = secondBest - best;
            rel_diff = delta / secondBest;   % quanto il best è migliore del secondo
            normBest = best / media; %quanto il migliore è grande rispetto alla media
            disp('best = '), disp(best);
            disp('secondBest = '), disp(secondBest);
            disp('media = '), disp(media);
            disp('rel_diff = '), disp(rel_diff);
            disp('normBest = '), disp(normBest);
            % creo un flag che usero per capire se la canzone trovata e
            % giusta
            flag = 0; %per non essere classificato il best deve essere piccolo rispetto alla media(falso positivo) e avere poca differenza con il secondo
            if normBest  < 0.12
                if rel_diff < 0.05
                    flag = 1;
                end
            end
            %restituisco al client il risultato
            if flag %se la flag è attiva allora non ho trovato una canzone valida
                index = 0;
                write(src, index, "uint8");
            else
                bestrange = bestmatch(ibest)*wstep+(0:Ntot-1);
                disp(['Best match found: ',ttargetfile(ibest).name])
                            
                write(src, ibest, "uint8");
                nameBest = char(ttargetfile(ibest).name);
                length_nameBest = length(nameBest);
                write(src, length_nameBest, "uint8");
                write(src, nameBest, "char");
                nameFile = strcat(pathprefixLIBRARY,ttargetfile(ibest).name);
                [y, Fs] = audioread(nameFile);
                disp(Fs);
                length_y = length(y);
                y = uint16( (y + 1) * 32767.5 );

                write(src, length_y, "uint32");
                write(src, y, "uint16");
                write(src, Fs, "uint16");
                
            end
        end
    else
        disp("aspetto la connessione");
    end
end