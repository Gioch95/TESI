%%Apertura del Database
inDir='C:\Users\gioiachiodi\Desktop\Tesi\v1.2.1\edf\dev_test\01_tcp_ar\065\00006546';
%inDir='C:\Users\gioiachiodi\Desktop\Tesi\v1.2.1\edf\dev_test\03_tcp_ar_a\065\00006546';
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ\';%cartella degli FNSZ
%outDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ\';%cartella degli GNSZ

filter='s*';
session=dir(fullfile(inDir,filter));
fs=250;
for j=1:length(session)
    estensione='*.edf';
   cases=dir(fullfile(strcat(inDir,'\',session(j).name),estensione));
   for i=1:length(cases)
        EEG = pop_biosig(strcat(strcat(inDir,'\',session(j).name),'\',cases(i).name), 'importevent','off','importannot','off');
        
        
        EEG = pop_select(EEG,'channel',{'EEG FP1-REF';'EEG FP2-REF';'EEG F3-REF';'EEG F4-REF';'EEG C3-REF';'EEG C4-REF';'EEG P3-REF';'EEG P4-REF';'EEG O1-REF';'EEG O2-REF';'EEG F7-REF';'EEG F8-REF';'EEG T3-REF';'EEG T4-REF';'EEG T5-REF';'EEG T6-REF';'EEG FZ-REF'});
        EEG = pop_resample(EEG,fs);%ricampiono gli eeg
        
        
        EEG.filename = strcat(outDir,(strtok(session(j).name,'.')),(strtok(cases(i).name,'.')),'FNSZ.mat');
        save(EEG.filename,'EEG');
    end
end
   
