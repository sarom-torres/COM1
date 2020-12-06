clc
close all
clear all
# este código não está genérico! É necessário
# vincular os eixos 't' e 'f' com os parâmetros
# do código.

f1 = 1e3;
f2 = 3e3;
N = 100;
fs = N*f1;
ts = 1/fs;
FPB = [zeros(1,24e3) ones(1,2001) zeros(1,24e3)];
fpb = fir1(300,(2000*2)/fs);
t_final = 0.5;
t = [0:ts:t_final];
y = 1*cos(2*pi*f1*t) +(1*cos(2*pi*f2*t));
T = length(y);
f = [-fs/2:2:fs/2];
Y = fft(y);
Y = fftshift(Y);
Rx = abs(Y).*FPB;
#rx = filter(fpb, 1, y); # representa o processo de convolução 
rx = conv(fpb,y);
figure(1)
subplot(211)
plot(t,y)
xlim([0 5*(1/f1)])
subplot(212)
plot(f,abs(Y)/length(y))

figure(2)
subplot(311)
plot(f,FPB)
axis([-10e3 10e3 0 1.5])
subplot(312)
plot(f,abs(Y)/length(y))
xlim([-10e3 10e3])
subplot(313)
plot(f,Rx)
xlim([-10e3 10e3])

figure(3)
freqz(fpb)

figure(4)
subplot(211)
stem(fpb)
subplot(212)
plot(t,rx(1,150:end-151))
xlim([0 5*(1/f1)])