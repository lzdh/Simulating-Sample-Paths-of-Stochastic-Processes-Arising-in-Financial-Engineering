randn('state',12)% Set initial state for repeatability;
% give values to all the parameters
n=200; % number of subintervals
mu=0.5; sigma=1;
lambda=20;
a=0; b=2;
tau=0; X=1;
temp=[0]; % this is for saving jump times

% loop for sampling the jump path
for i=1:n
    %generate exponential distributed random variables
    R=exprnd(1/lambda);
    %generate the jump which is lognormally distributed
    M=a+b*randn;
    %generate jump times
    tau=tau+R;
    %define a time array for saving two values at jump times
    temp=[temp, tau, tau];
    %the value just before the jumps
    X_temp=X(end)+(mu-0.5*sigma^2)*R+sigma*sqrt(R)*randn;
    %define the process with values just before and after the jumps
    X=[X, X_temp, X_temp+M];
end

%plot the figures
figure
plot(temp,X,'-k')
xlabel('tau','FontSize',16)
ylabel('X','FontSize',16)

figure
plot(temp,exp(X),'-k')
xlabel('tau','FontSize',16)
ylabel('S','FontSize',16)
