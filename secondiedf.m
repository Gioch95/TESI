%load('F.mat');%matrice con 10 righe di FNSZ e due colonne
load('G.mat');%matrice con 10 righe di GNSZ e due colonne

%inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZedf\';
inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZedf\';
%inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZedf30s\';
%inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZedf30s\';
estensione='*.edf';
cases=dir(fullfile(inDir,estensione));
fs=250;
load('x.mat')
for i=1:length(cases)
    
     EEG = pop_biosig(strcat(inDir,cases(i).name));
 
 %for j=1:(max(size(F))) 
  for j=1:(max(size(G)))      
    %if strncmpi(cases(i).name,F(j,1),18)==1 
        if strncmpi(cases(i).name,G(j,1),18)==1
              %T=F{j,2};
              T=G{j,2};
             T1=fs*T;
              y=30*fs;
             EEG.data=EEG.data(:,T1-y:T1-1);
         EEG.chanlocs=x;
        end%a è la struttura %b è la matrice canalixcampioni %tempo di start seizure %x sono i 30 secondi
        pop_writeeeg(EEG,strcat(inDir,cases(i).name),'TYPE','EDF');
    %filename = strcat(outDir,(strtok(cases(i).name,'.')),'fnsz30s');
        %filename = strcat(outDir,(strtok(cases(i).name,'.')),'gnsz30s');
    %save(filename,'EEG');

 end
end