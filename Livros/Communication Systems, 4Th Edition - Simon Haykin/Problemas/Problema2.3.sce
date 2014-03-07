xdel(winsid())
clear
clc
freqBandaBase=10;
freqDeMod=10*freqBandaBase
//t=[0:0.00001:%pi/6];
//t=linspace(0,2*%pi,100);
t=linspace(0,1/freqBandaBase,10*freqDeMod);
portadora=cos(2*%pi*freqDeMod*t);
sinalBandaBase=cos(2*%pi*freqBandaBase*t);
sinalModulado=sinalBandaBase+portadora;
figure();
plot(t,sinalModulado,'Yellow');
plot(t,portadora,'red');
plot(t,sinalBandaBase,'blue');
xgrid
n=10000;
serie = zeros(1,size(t,2));
//figure();
for i=1:n
    novaIteracao = ( ((-1)^(i-1))/(2*i-1) ) * cos(2*%pi*freqDeMod*t*(2*i-1));
    serie=serie+novaIteracao;
    gT=1/2 + (2/%pi)*serie;
end
plot(t,gT,'cyan');
xgrid;
//input("aperte enter para a proxima iteracao");
//close
