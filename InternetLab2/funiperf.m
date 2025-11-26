function funiperf(src,~)
    if src.Connected
        start = tic; %avvio il contatore del tempo solo quando la connessione è stata effetuata
        dataCounter = 0; %conto quanti bytes ho letto
        blocksize = 1000; %leggo 1000 bytes alla volta
        endFlag = false; %flag per uscire dal secondo while una volta trovato il byte finale
        while src.Connected && ~endFlag
            while src.NumBytesAvailable == 0
            end%attendo che ci siano bytes da leggere
            while src.NumBytesAvailable > 0
                minBlock = min(blocksize, src.NumBytesAvailable);%se ci sono meno byte disponibili rispetto che al blocco allora rischierei di aspettare dati che potrebbero non arrivare mai
                data   = read(src, minBlock, "uint8");
                dataCounter = dataCounter + numel(data); %numel conta quanti bytes ho letto e gli aggiungo al counter
                if any(data == 0)%se il byte è 0 allora abbiamo finito la trasmissione
                    time = toc(start);%spengo il timer
                    endFlag = true; %setto vera la flag per far finire il secondo while e calcolare la avgspeed
                    break %esco dal while che legge i byte
                end
            end
        end
        avSpeed = dataCounter/time;%calcolo la velocità in byte/s
        write(src,avSpeed,"double");%spedisco al client il risultato
        disp('velocita calcolata');
    else
        disp('Client disconnesso');
    end
end

