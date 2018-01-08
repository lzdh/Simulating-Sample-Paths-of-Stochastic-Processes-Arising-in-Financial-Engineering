randn('state',12)
M=100; % number of simulations
N=200; % number of subintervals
T=1; % total length of the time interval
dt=T/N; % time increment
mu=0.5; % drift parameter of GBM
sigma=1; % volatility parameter of GBM
S(1)=1; % initial value of GBM

% define each time point
for i=1:N+1
    t(i)=(i-1)*dt;
end

% calculating the expected payoffs
for m=1:M
    % generate a path of GBM
    for i=1:N
        S(i+1)=S(i)*exp((mu-0.5*sigma^2)*(t(i+1)-t(i))+sigma*sqrt(t(i+1)-t(i))*randn);
    end

    %Asian option
    S_av(m)=sum(S)/(N+1); % the average value of the path
    VT(m)=max(0,S(N+1)-S_av(m)); % the payoffs
end

% calculate the discounted average of payoffs as the number of simulations increases
for m=1:M
    V0(m)=exp(-r*T)*sum(VT(1:m))/m;
end

figure
plot(1:M,V0,'-k')
xlabel('N: number of simulations','FontSize',16)
ylabel('Option price','FontSize',16,'Rotation',90)

figure
plot(1:M,S_av, '*')
xlabel('N: number of simulations','FontSize',16)
ylabel('Average value of GBM','FontSize',16,'Rotation',90)

figure 
plot(1:M,VT,'.')
xlabel('N: number of simulations','FontSize',16)
ylabel('Expected payoff','FontSize',16,'Rotation',90)
