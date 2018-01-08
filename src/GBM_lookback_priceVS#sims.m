close all
clear all
randn('state',12)
M=10000;
N=400; % number of subintervals
T=2; dt=T/N;
mu=0.5;
r=mu;
sigma=1;

for i=1:N+1
    t(i)=(i-1)*dt;
end
S(1)=1;

for m=1:M
    for i=1:N
        S(i+1)=S(i)*exp((mu-0.5*sigma^2)*(t(i+1)-t(i))+sigma*sqrt(t(i+1)-t(i))*randn);
    end
    S_max(m)=max(S);
    VT(m)=max(0,S_max(m)-S(N+1));
end

for m=1:M
    V0(m)=exp(-r*T)*sum(VT(1:m))/m;
end

figure
plot(1:M,V0,'-k')
xlabel('N: number of simulations','FontSize',16)
ylabel('Option price','FontSize',16,'Rotation',90)

% figure
%  plot(1:M,S_max, '*')
% xlabel('N: number of simulations','FontSize',16)
% ylabel('The maximum value of the GBM','FontSize',16,'Rotation',90)
% 
% figure 
% plot(1:M,VT,'.')
% xlabel('N: number of simulations','FontSize',16)
% ylabel('Expected payoff','FontSize',16,'Rotation',90)