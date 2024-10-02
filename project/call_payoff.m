function [out]=call_payoff(s,k)
if s>k
    out=s-k;
else
    out=0;
end


