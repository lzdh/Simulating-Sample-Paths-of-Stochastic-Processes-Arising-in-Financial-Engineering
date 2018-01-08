clear all;
clear all;
randn('state',11)
m=8;
N=2^m;
h=N;%number of time indices
T=1; dt=T/N;     %choose time interval of length 1 and divide it into
                  %N equal subintervals
for n=1:N
    Z(n)=randn;;   %generate N standard random variables
end
for i=1:N+1       %since Matlab requires the index of every variable
    t(i)=(i-1)*dt; %to be positive, here define the time index from 1
end                %to N+1 of total still N time points.


j_max=1; %the number of midpoints that need to be sampled at each step
B(h+1)=1%sqrt(t(h))*Z(h); %Sample the rightmost point
B(1)=0;   %define the first point of BM as 0

for k=1:m  %there are 8 steps of simulation
    i_min=h/2; 
    i=i_min+1;    %the point to be sampled
    l=1;r=h+1;
    for j=1:j_max  %there are j_max midpoints at each step

        a=((t(r)-t(i))*B(l)+(t(i)-t(l))*B(r))/(t(r)-t(l));
        b=sqrt((t(i)-t(l))*(t(r)-t(i))/(t(r)-t(l)));
        B(i)=a+b*Z(i);  %expression of recursion
        i=i+h;
        l=l+h;
        r=r+h;
    end
    j_max=2*j_max; %the midpoints of next step is twice of it is
                    %at last step
    h=i_min;
end
plot(t,B,'-');
xlabel('t','FontSize',16)
ylabel('B(t)','FontSize',16,'Rotation',0)    
