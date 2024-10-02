filename="/Users/feder/OneDrive - Politecnico di Milano/FINANZA MATEMATICA I/laboratori/extra/data.xlsx";
data=readmatrix(filename);
today=365;
u=data(today,3);
d=data(today,2);
rf=data(today,4);
S0=data(today,5);
T=1095;
K=22;
price=call_price(K,T,S0,rf,d,u)

%% come evolve il prezzo del titolo?
% prezzo da day=365 in poi per vedere l'andamento della call, con i
% parametri del giorno dopo riprezziamo;
maturity=730;
trend=[];
for i=[today:maturity]
    u=data(i,3);
    d=data(i,2);
    rf=data(i,4);
    S0=data(i,5);
    trend=[trend,call_price(K,T,S0,rf,d,u)];
end

plot(trend)

%% profitto
profit=diff(trend);  % la loss è giorno per giorno p(t i+1) = p(ti )
loss=-profit;
figure(1)
grid('on')
title('Loss')
plot(loss)
legend('loss')

%% verifichiamo la gaussianità delle loss
kurtosis(loss)

%% calcoliamo il VaR 
% consideriamo il 365 giorni precedenti, calcolo le variazioni istante i e i+1, le
% riapplico al valore di oggi e riprezzo. Calcolo il percentile di ordine
% 5% della Loss

dati=data(1:today-1,1:5);
noise=diff(dati);
m=size(noise);
trend1=[];
for i=1:m(1)
    u=data(365,3)+noise(i,3);
    d=data(365,2)+noise(i,2);
    rf=data(365,4)+noise(i,4);
    S0=data(365,5)+noise(i,5);
    trend1=[trend1,call_price(K,T,S0,rf,d,u)];
end
% calcoliamo il var al giorno today
q=quantile(-trend1+price,0.95)

%% contiamo quante volte abbiamo sforato VaR
cont=0;
for i=1:length(loss)
    if loss(i)>q
        cont=cont+1;
    end
end
cont
