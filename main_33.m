clearvars
close all
clc

fnum = 0;
load('data.dat')
load('noise.dat')

data = iddata(data);

K = 4;

ar1_model = arx(data, 1);
ar2_model = arx(data, 2);
ar3_model = arx(data, 3);
ar4_model = arx(data, 4);

rar2 = resid(ar2_model, data);
fnum = fnum + 1;
figure(fnum)
plot(rar2, '--k')
hold on
plot(noise, 'b')
title('Noise, AR2')

rar1 = resid(ar1_model, data);
fnum = fnum + 1;
figure(fnum)
plot(rar1, '--k')
hold on
plot(noise, 'b')
title('Noise, AR1')

fnum = fnum + 1;
figure(fnum)
resid(ar1_model, data)
title('Order 1')
fnum = fnum + 1;
figure(fnum)
resid(ar2_model, data)
title('Order 2')
fnum = fnum + 1;
figure(fnum)
resid(ar3_model, data)
title('Order 3')
fnum = fnum + 1;
figure(fnum)
resid(ar4_model, data)
title('Order 4')

present(ar1_model)
present(ar2_model)
present(ar3_model)
present(ar4_model)

am11_model = armax(data, [1,1]);
am22_model = armax(data, [2,2]);

disp('##################')
present(am11_model)
present(am22_model)


