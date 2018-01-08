% set all the coefficients and initial value
n=500; % number of subintervals
T=5; dt=T/n; mu=0.5; sigma=1;
lambda=2;  a=0; b=2;
X(1)=1;
% define every time point
for i=1:n+1
    t(i)=(i-1)*dt;
end
% main loop of simulating X(t)
for i=1:n
    N=poissrnd(lambda*dt); % generate Poisson random variable with coefficient lambda*dt
    M=0; %the situation when N=0
    %the situation when N is not 0
    if N ~= 0
        M=a*N+b*sqrt(N)*randn; %M has lognormal distribution
    end
    %recursion of X
    X(i+1)=X(i)+(mu-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn+M;
end
% to plot X against t
figure
plot(t,X,'-k')
xlabel('t','FontSize',16)
ylabel('X(t)','FontSize',16,'Rotation',90)
% to plot S against t
figure
plot(t,exp(X),'-k')
xlabel('t','FontSize',16)
ylabel('S(t)','FontSize',16,'Rotation',90)
