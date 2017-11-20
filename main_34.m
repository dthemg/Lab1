clearvars
close all
clc
fnum = 0;
cutoff = 50;

% et = randn(600, 1);
% A = [1, -1.5, 0.7];
% C = [1, zeros(1,11), -0.5];
A12 = [1, zeros(1, 11), -1];
% A_star = conv(A12, A);
% y = filter(C, A_star, et);
% y = y(100:end);
load('ourData.mat');

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y);
title('Simulated y')
subplot(312)
acf(y, cutoff, 0.05, true, 0, 0);
title('ACF of y')
subplot(313)
pacf(y, cutoff, 0.05, true, 0);
title('PACF of y')

fnum = fnum + 1;
figure(fnum)
normplot(y)
title('Normplot of y')

y_s = filter(A12, 1, y);
data = iddata(y_s);

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_s);
title('Simulated deseasonalized y')
subplot(312)
acf(y_s, cutoff, 0.05, true, 0, 0);
title('ACF of deseasonalized  y')
subplot(313)
pacf(y_s, cutoff, 0.05, true, 0);
title('PACF of deseasonalized y')

model_init = idpoly([1,0,0], [], []);
model_armax = pem(data, model_init);

y_f = filter(model_armax.a, 1, y_s);

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_f);
title('Simulated deseasonalized AR y')
subplot(312)
acf(y_f, cutoff, 0.05, true, 0, 0);
title('ACF of deseasonalized  AR y')
subplot(313)
pacf(y_f, cutoff, 0.05, true, 0);
title('PACF of deseasonalized AR y')

fnum = fnum + 1;
figure(fnum)
normplot(y_f)
title('Normplot deseasonalized AR y')

model_init = idpoly([1,0,0], [], [1, zeros(1, 12)]);
model_init.Structure.c.Free = [zeros(1, 12), 1];
model_armax = pem(data, model_init);

y_p = filter(model_armax.a, model_armax.c, y_s);

fnum = fnum + 1;
figure(fnum)
subplot(311)
plot(y_p);
title('Simulated deseasonalized ARMA y')
subplot(312)
acf(y_p, cutoff, 0.05, true, 0, 0);
title('ACF of deseasonalized  ARMA y')
subplot(313)
pacf(y_p, cutoff, 0.05, true, 0);
title('PACF of deseasonalized ARMA y')

fnum = fnum + 1;
figure(fnum)
normplot(y_p)
title('Normplot of ARMA y')

disp('####################')
present(model_armax)









