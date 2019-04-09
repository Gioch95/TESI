function matrix=JamoviPSDtemporale(type)
chan=17;%17 canali
epoch=6;%da 5 secondi
bande=5;%delta,gamma,beta,alpha,theta
%qui ho inserito un \ in più
fs=250;
estensione='*.mat';
%EPOCHE
        FN=zeros(1,chan*bande+1);
GN=FN;
inDirFNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDtemporaleFNSZ\';
inDirGNSZ='C:\Users\gioiachiodi\Documents\MATLAB\PSDtemporaleGNSZ\';
outDirepoche='C:\Users\gioiachiodi\Documents\MATLAB\PSDtemporale\';
cases1=dir(fullfile(inDirFNSZ,estensione));
cases2=dir(fullfile(inDirGNSZ,estensione))
for i=1:length(cases1)
    load(strcat(inDirFNSZ,cases1(i).name));
    FN=[FN;"FNSZ",PSDtemporale(:)'];
end
for i=1:length(cases2)
    load(strcat(inDirGNSZ,cases2(i).name));
    GN=[GN;"GNSZ",PSDtemporale(:)'];
end 
FN(1,:)=[];
GN(1,:)=[];
matrix=[FN;GN];
        
filenameepoche=strcat(outDirepoche,'_Jamovi');
save(strcat(filenameepoche,'PSDtemporale'),'matrix')

end