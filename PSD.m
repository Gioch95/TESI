function [pxx,f,B]=PSD(Y,B)
load('B')

%matrice 3 dimensioni con zeros
inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ 30 secondi\';
%inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ 30 secondi\'
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZPSD\';
%outDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZPSD\';
fs=250;
estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
     load(strcat(inDir,cases(i).name));%ciclo for per ogni canale
    %si prendono epoche di 5 secondi;
     for j=1:6 %secondi epoche
         for k=1:(min(size(Y)))%chan
            
             
     %MATRICE (epoche,chan,bande)
     [pxx,f]=pwelch(Y(k,(j-1)*fs*5+1:j*fs*5)',[],0,[],fs);%j-1
    
     %matrice con epoche,canali, bande mat[epoch,chan,bande]
     %si calcola la psd; %frequenze di taglio delle singole bande 
     %si calcolano le bande di frequenza delle onde;
     
    
     
     
     
     %delta 1-4 Hz
     Deltapwr=sum(pxx(1:5));   
     %Theta 4-8 Hz
     Thetapwr= sum(pxx(6:9));
     
     %Alpha 8-13 Hz
     Alphapwr= sum(pxx(10:14));
    
     %Beta 13-30 Hz
     Betapwr= sum(pxx(15:31));
      
     %Gamma 30-40 Hz
     Gammapwr= sum(pxx(32:41));
     
    
   % per_powerDelta = 100*(pbandDelta/ptot);
     Totalbandpwr=Deltapwr+Thetapwr+Alphapwr+Betapwr+Gammapwr;
     B(j,k,1)=(Deltapwr/Totalbandpwr);
     B(j,k,2)=(Thetapwr/Totalbandpwr);
     B(j,k,3)=(Alphapwr/Totalbandpwr);
     B(j,k,4)=(Betapwr/Totalbandpwr);
     B(j,k,5)=(Gammapwr/Totalbandpwr);
    
    
         end
    
     end
     save(strcat(outDir,(strtok(cases(i).name,'.')),'PSD.mat'),'B')
end
 
    
    
end