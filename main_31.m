
clearvars
close all

fnum = 0;

%% 3.1 Working with time series in Matlab
close all
clc
N = 1000;
sigma2 = 1.5;
cutoff = 20;

A1 = [1, -1.79, 0.84];
C1 = [1, -0.18, -0.11];

A2 = [1, -1.79];
C2 = [1, -0.18, -0.11];

ARMA1 = idpoly(A1, [], C1);
ARMA2 = idpoly(A2, [], C2);

e = sqrt(sigma2) * randn(N, 1);

y1 = filter(ARMA1.c, ARMA1.a, e);
y2 = filter(ARMA2.c, ARMA2.a, e);

fnum = fnum + 1;
figure(fnum)
subplot(211)
plot(y1)
title('ARMA 1')
subplot(212)
plot(y2)
title('ARMA 2')

fnum = fnum + 1;
figure(fnum)
pzmap(ARMA1)
title('Pole-zero plot, ARMA 1')
fnum = fnum + 1;
figure(fnum)
pzmap(ARMA2)
title('Pole-zero plot, ARMA 2')

m = 20;
rtheo = kovarians(ARMA1.c, ARMA1.a, m);
rest = covf(y1, m+1);
fnum = fnum + 1;
figure(fnum)
stem(rtheo*sigma2)
hold on
stem(rest, 'r')
title('Theoretical (blue) and estimated (red) y1 covariance')

% Plotting ACF, PACF, normplot
fnum = fnum + 1;
figure(fnum)
subplot(211)
acf1 = acf(y1, cutoff, 0.05, true, 0, 0);
title('ACF for y')
subplot(212)
pacf1 = pacf(y1, cutoff, 0.05, true, 0);
title('PACF for y')
fnum = fnum + 1;
figure(fnum)
normplot(y1)

data = iddata(y1);

na = 2;
nc = 2;

ar_model = arx(data, [1]);
arma_model = armax(data, [2, 2]);

% present(ar_model)
% disp('%%%%%%%%%%%')
% present(arma_model)

disp('AR: ')
ar_model.a
ar_model.Report.Fit.FPE

disp('ARMA: ')
arma_model.a
arma_model.c
arma_model.Report.Fit.FPE


e_hat = filter( arma_model.a, arma_model.c, y1);

fnum = fnum + 1;
figure(fnum)
subplot(211)
acf1 = acf(e_hat, cutoff, 0.05, true, 0, 0);
title('ACF for residuals')
subplot(212)
pacf1 = pacf(e_hat, cutoff, 0.05, true, 0);
title('PACF for residuals')
fnum = fnum + 1;
figure(fnum)
normplot(e_hat)
title('Normplot of residuals')










