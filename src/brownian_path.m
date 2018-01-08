%randn(?state?,12) %Set initial state for repeatability;
T=1;N=500;dt=T/N; %choose time interval as 1 and divide it into 500 subintervals
mu=0.5;
sigma=1;
dB=zeros(1,N); %initialize dB with zeros
B=zeros(1,N); %initialize B with zeros
dB(1)=mu*dt+sigma*sqrt(dt)*randn; %first approximation
B(1)=dB(1);
for j=2:N %increment loop
    dB(j)=mu*dt+sigma*sqrt(dt)*randn;
    B(j)=B(j-1)+dB(j);
end
plot([0:dt:T],[0,B],'r-') %plot the path
xlabel('t','FontSize',16)
ylabel('B(t)','FontSize',16,'Rotation',0)
