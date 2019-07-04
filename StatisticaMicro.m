
%load('microstati.mat')
load('Valori.mat')
%FN=microstati(1:10,:);%Fnsz
%GN=microstati(11:end,:);%Gnsz
FN=valori(1:10,:);%Fnsz
GN=valori(11:end,:);%Gnsz
%P=zeros(1,max(size(FN)));

p_value2=zeros(1,max(size(FN)));


for i=1:max(size(FN))

    x=FN(:,i);

    y=GN(:,i);

     

   [p,h] = signrank(x,y);%Test non parametrico
    

    

    P(i)=p;
     
     p_value2(i)=p;
     
end
          %save('P_microstates.mat','P')
        
         
          save('p_value2.mat','Student')