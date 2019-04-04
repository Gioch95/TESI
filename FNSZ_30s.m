function Y=FNSZ_30s(filename)
load('C.mat');
inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ\';
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ 30 secondi\';%qui ho inserito un \ in più
fs=250;

estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
 load(strcat(inDir,cases(i).name));

   for j=1:(max(size(C.t))) 
    if strncmpi(cases(i).name,C.t(j,1),37)==1 %controllo dopo
              T=C.t{j,2};
              T1=fs*T;
              x=30*fs;
             Y=EEG.data(:,T1-x:T1-1);
    end%a è la struttura %b è la matrice canalixcampioni %tempo di start seizure %x sono i 30 secondi
        save(strcat(outDir,(strtok(cases(i).name,'.')),'30.mat'),'Y')
   end
          
end
end
%visualizzazione dei tracciati 
%filtraggio
%psd

   
