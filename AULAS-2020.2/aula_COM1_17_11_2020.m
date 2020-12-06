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
t = [0:ts:t_final];

y = A*cos(2*pi*fm*t);
c = 10*exp(j*2*pi*t*fc);
s = y.*c;

T = length(y);
f = [-fs/2:1:fs/2];

Y = fft(y);
Y = fftshift(Y);

C = fft(c);
C = fftshift(C);

S = fft(s);
S = fftshift(S);

%FILTROS
wn1 = (2e3)*2/fs;
filtro_PB = fir1(50,wn1,'low');
st_filt_PB = filter(filtro_PB,1,s);

figure(1)
subplot(211)
plot(t,y)
axis([0 2*(1/fm) -1.2*A 1.2*A])
subplot(212)
plot(f,abs(Y)/length(y))
xlim([-15e3 15e3])
figure(2)
subplot(311)
plot(t,real(c),'y')
xlim([0 2*(1/fc)])
hold on
plot(t,imag(c))
hold off
subplot(312)
plot(t,real(s))
xlim([0 50*(1/fc)])
subplot(313)
plot(t,imag(s))
xlim([0 50*(1/fc)])
figure(3)
subplot(311)
plot(f,abs(Y))
xlim([-15e3 15e3])
subplot(312)
plot(f,abs(C))
xlim([-15e3 15e3])
subplot(313)
plot(f,abs(S))
xlim([-15e3 15e3])



