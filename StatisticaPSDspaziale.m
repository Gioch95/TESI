%load('_JamoviPSDspaziale.mat')
load('PSDspz.mat')
FN=PSDspz(1:10,:);%Fnsz
GN=PSDspz(11:end,:);%Gnsz

n_epoche=6;
n_bande=5;
P=zeros(1,30);

        for i=1:max(size(PSDspz))
    x=FN(:,i);
    y=GN(:,i);
     
    [p,h] = signrank(x,y);
    
    P(1,i)=p;
        end
        save('P_spz.mat','P')
        %sono n_epoche*n_bande (per ogni epoca ci sono 5 bande)