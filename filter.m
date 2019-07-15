function EEG=filter(Y)

inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ\';%cartella FNSZ
%inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ\';%cartella GNSZ
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZFilter\';
%outDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZFilter\';
fs=250;

estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
     load(strcat(inDir,cases(i).name));
     filtorder=3*fix(fs/40);
    EEG = pop_eegfilt( EEG,1,40,filtorder,0,[],1);
     pop_eegplot( EEG, 1, 1, 1);
save(strcat(outDir,(strtok(cases(i).name,'.')),'filt.mat'),'EEG')
 close
end
