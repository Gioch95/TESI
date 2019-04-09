function C=FNSZ_psdmedia(B)
chan=17;%19 canali
epoch=6;%da 5 secondi
bande=5;%delta,gamma,beta,alpha,theta
inDirFNSZ='C:\Users\gioiachiodi\Documents\MATLAB\FNSZPSD\';

outDirFNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDMEDIAGLOBLOCFNSZ\';
outDirFNSZ1='C:\Users\gioiachiodi\Documents\MATLAB\PSDtemporaleFNSZ\';
outDirFNSZ2='C:\Users\gioiachiodi\Documents\MATLAB\PSDspazialeFNSZ\';
outDirFNSZ3='C:\Users\gioiachiodi\Documents\MATLAB\PSDmediaglobaleFNSZ\';
fs=250;


estensione='*.mat';
cases1=dir(fullfile(inDirFNSZ,estensione));
Lungh=length(cases1);

PSDspaziale=zeros(epoch,bande);
PSDtemporale=zeros(chan,bande);
PSDmediaglobale=zeros(1,bande);
PSDspazialetot=0;
PSDtemporaletot=0;
PSDmediatotale=0;

for i=1:Lungh
load(strcat(inDirFNSZ,cases1(i).name));
PSDtemporale=squeeze(sum(B,1))/epoch;
PSDspaziale=squeeze(sum(B,2))/chan;%media dei canali diviso il totale dei canali
PSDmediaglobale=squeeze(sum(PSDtemporale))/chan;
filenmepoch=strcat(outDirFNSZ2,'_psdspaziale',strtok(cases1(i).name,'.'),'PSDspaziale');
filenmchan=strcat(outDirFNSZ1,'_psdtemporale',strtok(cases1(i).name,'.'),'PSDtemporale');
filenmmedia=strcat(outDirFNSZ3,'_psdmedia',strtok(cases1(i).name,'.'),'PSDmediaglobale');
save(filenmepoch,'PSDspaziale')
save(filenmchan,'PSDtemporale')
save(filenmmedia,'PSDmediaglobale')
PSDspazialetot=PSDspazialetot+PSDspaziale;
PSDtemporaletot=PSDtemporaletot+PSDtemporale;
PSDmediatotale=PSDmediatotale+PSDmediaglobale;
end
PSDspazialetot=PSDspazialetot/Lungh;
PSDtemporaletot=PSDtemporaletot/Lungh;
PSDmediatotale=PSDmediatotale/Lungh;
filename=strcat(outDirFNSZ,'_totale');
save(strcat(filename,'PSDspazialetot'),'PSDspazialetot')
save(strcat(filename,'PSDtemporaletot'),'PSDtemporaletot')
save(strcat(filename,'PSDmediatotale'),'PSDmediatotale')
end