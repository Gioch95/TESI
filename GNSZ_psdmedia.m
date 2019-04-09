function C=GNSZ_psdmedia(B)
chan=17;%19 canali
epoch=6;%da 5 secondi
bande=5;%delta,gamma,beta,alpha,theta

inDirGNSZ='C:\Users\gioiachiodi\Documents\MATLAB\GNSZPSD\'%segnale non filtrato

outDirGNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDMEDIAGLOBLOCGNSZ\';
outDirGNSZ1='C:\Users\gioiachiodi\Documents\MATLAB\PSDchanGNSZ\';
outDirGNSZ2='C:\Users\gioiachiodi\Documents\MATLAB\PSDepochGNSZ\';
outDirGNSZ3='C:\Users\gioiachiodi\Documents\MATLAB\PSDmediaGNSZ\';
fs=250;


estensione='*.mat';

cases2=dir(fullfile(inDirGNSZ,estensione));
Lungh1=length(cases2);
PSDepoch=zeros(epoch,bande);
PSDchan=zeros(chan,bande);
PSDmedia=zeros(1,bande);
PSDepochtot=0;
PSDchantot=0;
PSDmediatotale=0;

for i=1:Lungh1
load(strcat(inDirGNSZ,cases2(i).name));
PSDepoch=squeeze(sum(B,1))/epoch;%media delle epoche diviso il totale delle epoche
PSDchan=squeeze(sum(B,2))/chan;%media dei canali diviso il totale dei canali
PSDmedia=squeeze(sum(PSDepoch))/chan;
filenmepoch=strcat(outDirGNSZ2,'_epoche',strtok(cases2(i).name,'.'),'PSDepoch');
filenmchan=strcat(outDirGNSZ1,'_chan',strtok(cases2(i).name,'.'),'PSDchan');
filenmmedia=strcat(outDirGNSZ3,'_media',strtok(cases2(i).name,'.'),'PSDmedia');
save(filenmepoch,'PSDepoch')
save(filenmchan,'PSDchan')
save(filenmmedia,'PSDmedia')
PSDepochtot=PSDepochtot+PSDepoch;
PSDchantot=PSDchantot+PSDchan;
PSDmediatotale=PSDmediatotale+PSDmedia;
end
PSDepochtot=PSDepochtot/Lungh1;
PSDchantot=PSDchantot/Lungh1;
PSDmediatotale=PSDmediatotale/Lungh1;
filename=strcat(outDirGNSZ,'_totale');
save(strcat(filename,type,'PSDepochtot'),'PSDepochtot')
save(strcat(filename,type,'PSDchantot'),'PSDchantot')
save(strcat(filename,type,'PSDmediatotale'),'PSDmediatotale')
end
