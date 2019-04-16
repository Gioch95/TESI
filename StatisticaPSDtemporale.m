load('_JamoviPSDtemporale.mat')
FN=matrix(1:10,:);%Fnsz
GN=matrix(11:end,:);%Gnsz

n_chan=17;
n_bande=5;
P=zeros(1,85);
  for i=1:max(size(matrix))
    x=FN(:,i);
    y=GN(:,i);
     
    [p,h] = signrank(x,y);
    
    P(1,i)=p;
  end
  save ('P_tmp.mat','P')
    
  %microstati 