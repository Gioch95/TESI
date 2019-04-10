function matrix=JamoviPSDspaziale(type)
chan=17;%17 canali
epoch=6;%da 5 secondi
bande=5;%delta,gamma,beta,alpha,theta
%qui ho inserito un \ in più
fs=250;
estensione='*.mat';
%CHAN
FN=zeros(1,epoch*bande+1);
GN=FN;
inDirFNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDspazialeFNSZ\';
inDirGNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDspazialeGNSZ\';
outDirspz='C:\Users\gioiachiodi\Documents\MATLAB\PSDspaziale\';

cases1=dir(fullfile(inDirFNSZ,estensione));
cases2=dir(fullfile(inDirGNSZ,estensione))
for i=1:length(cases1)
    load(strcat(inDirFNSZ,cases1(i).name));
    FN=[FN;"FNSZ",PSDspaziale(:)'];
end
for i=1:length(cases2)
    load(strcat(inDirGNSZ,cases2(i).name));
    GN=[GN;"GNSZ",PSDspaziale(:)'];
end 
FN(1,:)=[];
GN(1,:)=[];
matrix=[FN;GN];
filenamespz=strcat(outDirchan,'_Jamovi');
save(strcat(filenamechan,'PSDspaziale'),'matrix')

end
%globale 5 colonne
%temporale 19 colonne per ogni banda
%spaziale 5 bande per 6 colonne 
