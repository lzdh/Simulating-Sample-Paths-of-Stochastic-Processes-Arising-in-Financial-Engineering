sigm=1;
tau=1;
r=0.5;

x=0:0.1:1; %the initial asset price takes value from 0 to 1 and increases by 0.1
dp=1/(sigm*sqrt(tau))*(r+0.5*sigm^2)*tau; % expression of delta plus
dm=1/(sigm*sqrt(tau))*(r-0.5*sigm^2)*tau; % expression of delta minus

% the expression of option price i.e. (51) at initiation
V0=(1+sigm^2/2/r)*x*cdf('norm',dp,0,1)+exp(-r*tau)*x*cdf('norm',-dm,0,1)- ...
    (sigm^2/2/r)*exp(-r*tau)*x*cdf('norm',-dm,0,1)-x;

figure;
plot(x,V0)
xlabel('Initial price of the underlying asset','FontSize',16)
ylabel('Exact price of lookback option','FontSize',16,'Rotation',90)
V0(end)