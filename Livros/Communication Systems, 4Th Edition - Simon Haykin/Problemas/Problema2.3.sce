xdel(winsid())
clear
clc
fs=10;
fc=100*fs
//t=[0:0.00001:%pi/6];
//t=linspace(0,2*%pi,100);
t=linspace(0,1/fs,10000);
portadora=cos(2*%pi*fc*t);
sinal=cos(2*%pi*fs*t);
sinalModulado=sinal+portadora;
figure();
plot(t,sinalModulado,'Yellow');
plot(t,portadora,'red');
plot(t,sinal,'blue');
xgrid
n=10000;
serie = zeros(1,size(t,2));
//figure();
for i=1:n
    novaIteracao = ( ((-1)^(i-1))/(2*i-1) ) * cos(2*%pi*fc*t*(2*i-1)/100);
    serie=serie+novaIteracao;
    gT=1/2 + (2/%pi)*serie;
end
plot(t,gT,'cyan');
xgrid;
//input("aperte enter para a proxima iteracao");
//close
