clear
randn('state',12) % Set initial state for repeatability;
M=1000; % number of simulations
N=100; % number of subintervals
T=1; dt=T/N;
mu=0.5; % drift parameter
r=mu; % drift parameter is the risk-free rate
sigma=1; % volatility parameter

% define time points
for i=1:N+1
    t(i)=(i-1)*dt;
end

% Initialise the expected option price
V0M=[];

% loop of getting the option price
for x0=0:0.1:1;
    S(1)=x0; % give initial value to GBM
    % calculate the expected payoff every time of simulation
    for m=1:M
        % simulate the paths for GBM
        for i=1:N
            S(i+1)=S(i)*exp((mu-0.5*sigma^2)*(t(i+1)-t(i))...
                   +sigma*sqrt(t(i+1)-t(i))*randn);
        end
        S_max(m)=max(S);
        VT(m)=max(0,S_max(m)-S(N+1)); % expected payoff
    end
    % calculate the averaged discounted payoff
    V0M=[V0M exp(-r*T)*sum(VT(1:M))/M];
end

% Generate exact option price (same code with in 'GBM_lookback_exact.m')
sigm=1;
tau=T;
r=0.5;

x=0:0.1:1;
dp=1/(sigm*sqrt(tau))*(r+0.5*sigm^2)*tau;
dm=1/(sigm*sqrt(tau))*(r-0.5*sigm^2)*tau;
V0=(1+sigm^2/2/r)*x*cdf('norm',dp,0,1)+exp(-r*tau)*x*cdf('norm',-dm,0,1)-(sigm^2/2/r)*exp(-r*tau)*x*cdf('norm',-dm,0,1)-x;

% plot the option price against initial value
figure;
plot(x,V0,x,V0M);
xlabel('Initial price of the underlying asset','FontSize',16)
ylabel('Exact and simulated price of lookback option','FontSize',16,'Rotation',90)
legend('Exact price', 'Simulated price','Location','NorthWest')
