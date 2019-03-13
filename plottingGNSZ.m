function x=plottingGNSZ(fs, y)
inDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ 30 secondi\';
%outDir='C:\Users\gioiachiodi\Documents\MATLAB\GNSZ 30 secondi\';
estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
fs=250;
for i=1:length(cases)
 load(strcat(inDir,cases(i).name));
 
 t=(1:max(size(Y)))/fs;
 figure
 plot(t,Y)
 
 
end
end