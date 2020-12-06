clear all;close all; clc;

A = 1;
k= 5; #numero bits do quantizador 
L = 2^k; #numero de niveis do quantizador
f = 1e3;
fs = 100*f;
t_final = 1;
t = [0:1/fs:t_final];
freq = [-fs/2:1/t_final:fs/2];
y = A*sin(2*pi*f*t);
plot(t,y);

Vpp = 2*A;
passo = Vpp/L;
y_aux = y/passo;
y_round = round(y_aux); #arredonda
y_int = y_round + L/2; #desloca para valores de 0 a 8

for i=1:length(y_int)#para não ter 4 bits
  if y_int(i) == L
   y_int(i)=(L-1); 
  end
end
plot(y_int)
y_bin = dec2bin(y_int);

#recuperando o sinal
y_rec = bin2dec(y_bin); #sinal recuperado
y_rec2 = y_rec-(L/2);
y_rec3 = y_rec2*passo;

Y = fftshift(fft(y)/length(y));
Y_REC3 = fftshift(fft(y_rec3)/length(y));
figure(1)
subplot(211)
plot(freq,Y)
subplot(212)
plot(freq,abs(Y_REC3))


figure(2)
subplot(211)
plot(t,y)
xlim([0 1e-3])
subplot(212)
plot(t,transpose(y_rec3))
xlim([0 1e-3])
##
##figure(3)
##plot(t,y)
##hold on
##plot(t,y_rec3)

