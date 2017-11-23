
clc
clf

fnum = 0;

n       = 1000;
A       = [1, -1.35, 0.43];
sigma2  = 4;
noise   = sqrt(sigma2) * randn(n + 100, 1);
y       = filter(1, A, noise);
y       = y(101:end);

fnum = fnum + 1;
figure(fnum)
subplot(211)
plot(y)
subplot(212)
plot(noise)

n_est = floor(2/3*n);
y_est = iddata(y(1:n_est));
y_val = iddata(y(n_est + 1:end));

NN = [1:10]';

V = arxstruc(y_est, y_val, NN);
n_order = selstruc(V, 0);
n_aic = selstruc(V, 'aic');


n_order = zeros([1,100]);
n_aic = zeros([1,100]);
for i=1:100
    noise = sqrt(sigma2) * randn(n + 100, 1);
    y = filter(1, A, noise);
    y = y(101:end);
    y_est = iddata(y(1:n_est));
    y_val = iddata(y(n_est + 1:end));
    V = arxstruc(y_est, y_val, NN);
    n_order(i) = selstruc(V, 0);
    n_aic(i) = selstruc(V, 'aic');
end

fnum = fnum + 1;
figure(fnum)
subplot(211)
hist(n_order)
grid on
ylim([0,100])
title('LS criterion')
subplot(212)
hist(n_aic)
grid on
ylim([0,100])
title('AIC criterion')

ar_model = arx(y, n_order(end));
ar_model.NoiseVariance
ar_model.CovarianceMatrix % Ask about this...
present(ar_model)
















