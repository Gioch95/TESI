function C=mediaglobaletotale(B)
chan=19;%19 canali
epoch=6;%da 5 secondi
bande=5;%delta,gamma,beta,alpha,theta
inDirFNSZ='C:\Users\gioiachiodi\Documents\MATLAB\FNSZPSD\';

outDirFNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDMEDIAGLOBLOCFNSZ\';
outDirFNSZ1='C:\Users\gioiachiodi\Documents\MATLAB\PSDchanFNSZ\';
outDirFNSZ2='C:\Users\gioiachiodi\Documents\MATLAB\PSDepochFNSZ\';
outDirFNSZ3='C:\Users\gioiachiodi\Documents\MATLAB\PSDmediaFNSZ\';
fs=250;


estensione='*.mat';
cases1=dir(fullfile(inDirFNSZ,estensione));
Lungh=length(cases1);

PSDepoch=zeros(epoch,bande);
PSDchan=zeros(chan,bande);
PSDmedia=zeros(1,bande);
PSDepochtot=0;
PSDchantot=0;
PSDmediatotale=0;
for j=1:2
    switch j
        case 1
            type='FN';
        case 2
            type='GN';
    
end
for i=1:Lungh
load(strcat(inDirFNSZ,cases1(i).name));
PSDepoch=squeeze(sum(B,1))/epoch;%media delle epoche diviso il totale delle epoche
PSDchan=squeeze(sum(B,2))/chan;%media dei canali diviso il totale dei canali
PSDmedia=squeeze(sum(PSDepoch))/chan;
filenmepoch=strcat(outDirFNSZ2,'_epoche',strtok(cases1(i).name,'.'),'PSDepoch');
filenmchan=strcat(outDirFNSZ1,'_chan',strtok(cases1(i).name,'.'),'PSDchan');
filenmmedia=strcat(outDirFNSZ3,'_media',strtok(cases1(i).name,'.'),'PSDmedia');
save(filenmepoch,'PSDepoch')
save(filenmchan,'PSDchan')
save(filenmmedia,'PSDmedia')
PSDepochtot=PSDepochtot+PSDepoch;
PSDchantot=PSDchantot+PSDchan;
PSDmediatotale=PSDmediatotale+PSDmedia;
end
PSDepochtot=PSDepochtot/Lungh;
PSDchantot=PSDchantot/Lungh;
PSDmediatotale=PSDmediatotale/Lungh;
filename=strcat(outDirFNSZ,'_totale');
save(strcat(filename,type,'PSDepochtot'),'PSDepochtot')
save(strcat(filename,type,'PSDchantot'),'PSDchantot')
save(strcat(filename,type,'PSDmediatotale'),'PSDmediatotale')
end