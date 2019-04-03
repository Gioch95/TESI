function Y=seizurestime30(T,fs)
load('T.mat');
inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ\';
outDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ 30 secondi\';%qui ho inserito un \ in più
fs=250;

estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
 load(strcat(inDir,cases(i).name));

   for j=1:(max(size(T))) 
    if strncmpi(cases(i).name,T(j,1),37)==1 %controllo dopo
              T0=T{j,2};
              T1=fs*T0;
              x=30*fs;
             Y=EEG.mydata(:,T1-x:T1-1);
    end%a è la struttura %b è la matrice canalixcampioni %tempo di start seizure %x sono i 30 secondi
        save(strcat(outDir,(strtok(cases(i).name,'.')),'30.mat'),'Y')
   end
          
end
end
