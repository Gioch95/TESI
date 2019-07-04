%load('_JamoviPSDtemporale.mat')
load('PSDtmp')
FN=PSDtmp(1:10,:);%Fnsz
GN=PSDtmp(11:end,:);%Gnsz

n_chan=17;
n_bande=5;
P=zeros(1,85);
  for i=1:max(size(PSDtmp))
    x=FN(:,i);
    y=GN(:,i);
     
    [p,h] = signrank(x,y);
    
    P(1,i)=p;
  end
  save ('P_tmp.mat','P')
    
  %microstati sui file 30secondi
  %ridurre i codici 