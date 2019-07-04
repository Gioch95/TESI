%load('_JamoviPSDglobale.mat')
load('PSDglobale.mat')
FN=PSDglobale(1:10,:);%Fnsz
GN=PSDglobale(11:end,:);%Gnsz

n_chan=17;
n_bande=5;
P=zeros(1,5);
  for i=1:min(size(PSDglobale))
    x=FN(:,i);
    y=GN(:,i);
     
    [p,h] = signrank(x,y);
    
    P(1,i)=p;
  end
  save ('P_glob.mat','P')