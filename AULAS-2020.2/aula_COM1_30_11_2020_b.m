clear all;
close all;
clc

f_info = 1e3;
fc = 20e3;
N = 100;
fs = N*fc;
ts = 1/fs;
Ai = 2;
Ac = 1;
t_final = 0.5;
t = [0:ts:t_final];
info =Ai*cos(2*pi*f_info*t);
c = Ac*cos(2*pi*fc*t);
sinal_modulado = info.*c;
sinal_demod = sinal_modulado.*c;
filtro_pb = [zeros(1,499e3) ones(1,2001) zeros(1,499e3)];
f = [-fs/2:2:fs/2];
INFO = fft(info);
INFO = fftshift(INFO);
C = fft(c);
C = fftshift(C);
S = fft(sinal_modulado);
S = fftshift(S);
R = fft(sinal_demod);
R = fftshift(R);

R_pb = abs(R).*filtro_pb;

r_pb = ifftshift(R_pb);
r_pb = ifft(r_pb);

figure(1)
subplot(311)
plot(t,info)
xlim([0 2/f_info])
subplot(312)
plot(t,c)
xlim([0 2/f_info])
subplot(313)
plot(t,sinal_modulado)
xlim([0 2/f_info])

figure(2)
subplot(311)
plot(f,abs(INFO)/length(c))
xlim([-25e3 25e3])
subplot(312)
plot(f,abs(C)/length(c))
xlim([-25e3 25e3])
subplot(313)
plot(f,abs(S)/length(c))
xlim([-25e3 25e3])

figure(3)
plot(t,info)
xlim([0 2/f_info])
hold on
plot(t,sinal_modulado)
xlim([0 2/f_info])
T = length(info);

figure(4)
subplot(411)
plot(t,sinal_demod)
xlim([0 2/f_info])
subplot(412)
plot(f,abs(R))
xlim([-50e3 50e3])
subplot(413)
plot(f,R_pb)
xlim([-50e3 50e3])
subplot(414)
plot(t,r_pb)
xlim([0 2/f_info])
P_tx = (1/T)*sum(sinal_modulado.^2)
