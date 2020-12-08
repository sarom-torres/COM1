clear all;
close all;
clc
A = 1;
fm = 1e3;
fc = 10e3;
N = 100;
fs = N*fc;
ts = 1/fs;
t_final = 1;
filtro_pb = 
t = [0:ts:t_final];
y = cos(2*pi*100*t) + cos(2*pi*500*t);
T = length(y);
f = [-fs/2:1:fs/2];
Y = fft(y);
Y = fftshift(Y);
figure(1)
subplot(211)
plot(t,y)
xlim([0 20e-3])
subplot(212)
plot(f,abs(Y)/length(y))
xlim([-15e3 15e3])

