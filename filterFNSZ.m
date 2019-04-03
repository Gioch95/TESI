function EEGOUT=filterFNSZ(Y)

inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ\';
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZFilter\';%qui ho inserito un \ in più
fs=250;

estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
     load(strcat(inDir,cases(i).name));
      filtorder=3*fix(fs/30);
    EEG = pop_eegfilt( EEG,1,30,filtorder,0,[],1);
     pop_eegplot( EEG, 1, 1, 1);
save(strcat(outDir,(strtok(cases(i).name,'.')),'filt.mat'),'EEG')
    
  
end
