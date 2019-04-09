function C=GNSZ_psdmedia(B)
chan=17;%19 canali
epoch=6;%da 5 secondi
bande=5;%delta,gamma,beta,alpha,theta

inDirGNSZ='C:\Users\gioiachiodi\Documents\MATLAB\GNSZPSD\'%segnale non filtrato

outDirGNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDMEDIAGLOBLOCGNSZ\';
outDirGNSZ1='C:\Users\gioiachiodi\Documents\MATLAB\PSDtemporaleGNSZ\';
outDirGNSZ2='C:\Users\gioiachiodi\Documents\MATLAB\PSDspazialeGNSZ\';
outDirGNSZ3='C:\Users\gioiachiodi\Documents\MATLAB\PSDmediaglobaleGNSZ\';
fs=250;


estensione='*.mat';

cases2=dir(fullfile(inDirGNSZ,estensione));
Lungh1=length(cases2);
PSDspaziale=zeros(epoch,bande);
PSDtemporale=zeros(chan,bande);
PSDmediaglobale=zeros(1,bande);
PSDspazialetot=0;
PSDtemporaletot=0;
PSDmediatotale=0;

for i=1:Lungh1
load(strcat(inDirGNSZ,cases2(i).name));
PSDtemporale=squeeze(sum(B,1))/epoch;%media delle epoche diviso il totale delle epoche
PSDspaziale=squeeze(sum(B,2))/chan;%media dei canali diviso il totale dei canali
PSDmediaglobale=squeeze(sum(PSDtemporale))/chan;
filenmepoch=strcat(outDirGNSZ2,'_psdspaziale',strtok(cases2(i).name,'.'),'PSDspaziale');
filenmchan=strcat(outDirGNSZ1,'_psdtemporale',strtok(cases2(i).name,'.'),'PSDtemporale');
filenmmedia=strcat(outDirGNSZ3,'_psdmedia',strtok(cases2(i).name,'.'),'PSDmediaglobale');
save(filenmepoch,'PSDspaziale')
save(filenmchan,'PSDtemporale')
save(filenmmedia,'PSDmediaglobale')
PSDspazialetot=PSDspazialetot+PSDspaziale;
PSDtemporaletot=PSDtemporaletot+PSDtemporale;
PSDmediatotale=PSDmediatotale+PSDmediaglobale;
end
PSDspazialetot=PSDspazialetot/Lungh1;
PSDtemporaletot=PSDtemporaletot/Lungh1;
PSDmediatotale=PSDmediatotale/Lungh1;
filename=strcat(outDirGNSZ,'_totale');
save(strcat(filename,'PSDspazialetot'),'PSDspazialetot')
save(strcat(filename,'PSDtemporaletot'),'PSDtemporaletot')
save(strcat(filename,'PSDmediatotale'),'PSDmediatotale')
end