function Y=30secondi(filename)
load('F.mat');%matrice con 10 righe di FNSZ e due colonne
%load('G.mat');%matrice con 10 righe di GNSZ e due colonne
inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ\';
%inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ\';
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ 30 secondi\';
%outDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ 30 secondi\';
fs=250;

estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
 load(strcat(inDir,cases(i).name));

   
 for j=1:(max(size(F))) 
  %for j=1:(max(size(G)))      
    if strncmpi(cases(i).name,F(j,1),37)==1 
        %if strncmpi(cases(i).name,G(j,1),37)==1
              T=F{j,2};
              %T=G{j,2};
              T1=fs*T;
              x=30*fs;
             Y=EEG.data(:,T1-x:T1-1);
    end%a è la struttura %b è la matrice canalixcampioni %tempo di start seizure %x sono i 30 secondi
        save(strcat(outDir,(strtok(cases(i).name,'.')),'30.mat'),'Y')
 end
end
end

 