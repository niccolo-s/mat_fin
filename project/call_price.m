function [price]=call_price(K,T,S0,rf,d,u)
aux=0;
rf_day=(rf)^(1/365);
rf_att= (rf)^(1/12);
pi_u= (rf_att - d )/(u-d);
pi_d=1-pi_u;
M=floor(T/30);
for k=0:M
    aux=aux+nchoosek(M,k)*pi_u^k*pi_d^(M-k)*call_payoff(S0*u^k*d^(M-k),K);
end
price=(1/rf_day)^T*aux;