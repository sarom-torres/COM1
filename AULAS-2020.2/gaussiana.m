clear all;close all; clc;

x = randn(1,100000);
hist(x,100)
y = x+5;
hold on
hist(y,100)