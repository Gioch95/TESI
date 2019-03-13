function EEGOUT=filterFNSZ(fs,Y)

inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ 30 secondi\';
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZFilter\';%qui ho inserito un \ in più
fs=250;

estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
     load(strcat(inDir,cases(i).name));
     EEG.mydata=Y;
     locutoff= 10;
     hicutoff= 40;
    EEGOUT = eegfilt( EEG.mydata, fs, locutoff, hicutoff);
save(strcat(outDir,(strtok(cases(i).name,'.')),'filt.mat'),'EEGOUT')

end