N=200; % number of subintervals
k=4; % number of principal components
t=1/N:1/N:1;
% generate the covariance matrix
C=zeros(N);
for i=1:N
    for j=1:N
        C(i,j)=min([i,j])/N;
    end
end
% get the eigenvalues and eigenvectors of the covariance matrix
[V,D]=eig(C);
% initiate B with a 200-row, 1-column zero vector
B=zeros(N,1);
% main loop for sampling a path
for i=1:k
    %D(N-i+1,N-i+1) means the eigenvalues taking from the largest one,
    %V(:,N-i+1) means the corresponding eigenvectors.
    B=B+randn*sqrt(D(N-i+1,N-i+1))*V(:,N-i+1);
end
% plot B against time t
figure;
plot(t,B,'.-')