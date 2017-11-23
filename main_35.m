close all
clearvars
clc

clear all
cutoff = 40;
alpha = 0.05;
fnum = 0;

load svedala

y = svedala;

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y);
title('Data')
subplot(312)
acf(y, cutoff, alpha, true, 0, 0);
title('ACF of y')
subplot(313)
pacf(y, cutoff, alpha, true, 0);
title('PACF of y')

% Deseasonalizing
A24 = [1, zeros(1,23), -1];
y_s = filter(A24, 1, y);
y_s(1:24) = [];

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_s);
title('Data, S=24')
subplot(312)
acf(y_s, cutoff, alpha, true, 0, 0);
title('ACF, S=24')
subplot(313)
pacf(y_s, cutoff, alpha, true, 0);
title('PACF, S=24')

% Attempt: AR1

data = iddata(y_s);
model_init = idpoly([1, 0], [], []);
model_armax = pem(data, model_init);

present(model_armax)
y_f = filter(model_armax.a, 1, y_s);

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_f);
title('Residuals, AR1, S=24')
subplot(312)
acf(y_f, cutoff, alpha, true, 0, 0);
title('ACF, residuals AR1, S=24')
subplot(313)
pacf(y_f, cutoff, alpha, true, 0);
title('PACF, residuals AR1, S=24')

% Attempt: AR2

model_init = idpoly([1, 0, 0], [], []);
model_armax = pem(data, model_init);

present(model_armax)
y_f = filter(model_armax.a, 1, y_s);

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_f);
title('Residuals, AR2, S=24')
subplot(312)
acf(y_f, cutoff, alpha, true, 0, 0);
title('ACF, residuals AR2, S=24')
subplot(313)
pacf(y_f, cutoff, alpha, true, 0);
title('PACF, residuals AR2, S=24')

% Attempt: ARMA(2,24);

model_init = idpoly([1, 0, 0], [], [1, zeros(1, 24)]);
model_init.Structure.c.Free = [zeros(1,24), 1];
model_armax = pem(data, model_init);

present(model_armax)
y_f = filter(model_armax.a, model_armax.c, y_s);

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_f);
title('Residuals, ARMA(2,24) S=24')
subplot(312)
acf(y_f, cutoff, alpha, true, 0, 0);
title('ACF, residuals ARMA(2,24), S=24')
subplot(313)
pacf(y_f, cutoff, alpha, true, 0);
title('PACF, residuals ARMA(2,24), S=24')

fnum = fnum + 1;
figure(fnum)
normplot(y_f)




