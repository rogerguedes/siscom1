function sfi = rf_stage(s,t,f,FI,Frf)

[B,A] = butter(1,[0.0965 0.1103],'stop'); %filtro rejeita banda em 150 kHz
Y = filter(B,A,s);
v= s-Y; %filtro passa-banda (compelmento do rejeita banda)
plot(f,abs(fftshift(fft(v))));

Fos = FI + Frf;
c = cos(2*pi*Fos*t);

sfi = v.*c;
[B,A] = butter(4,[0.3379 0.3517],'stop');
Y = filter(B,A,sfi);
sfi= sfi-Y;