

%inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZedf\';%cartella degli FNSZ
inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZedf\';%cartella degli GNSZ

fs=250;
estensione='*.edf';
cases=dir(fullfile(strcat(inDir,estensione)));
   for i=1:length(cases)
      
        EEG = pop_biosig(strcat(inDir,'\',cases(i).name),'importevent','off','importannot','off');
        
        
        EEG = pop_select(EEG,'channel',{'EEG FP1-REF';'EEG FP2-REF';'EEG F3-REF';'EEG F4-REF';'EEG C3-REF';'EEG C4-REF';'EEG P3-REF';'EEG P4-REF';'EEG O1-REF';'EEG O2-REF';'EEG F7-REF';'EEG F8-REF';'EEG T3-REF';'EEG T4-REF';'EEG T5-REF';'EEG T6-REF';'EEG FZ-REF'});
       
        
        EEG = pop_resample(EEG,fs);%ricampiono gli eeg
        pop_writeeeg(EEG,strcat(inDir,cases(i).name),'TYPE','EDF')
       
    
        
        
       
  end
    
