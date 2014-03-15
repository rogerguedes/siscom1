function rmsValue = rms(vetor)
acumulador=0;
vetorDosQuadrados=vetor.*vetor;
for i=1:size(vetorDosQuadrados,2)
    acumulador = acumulador + vetorDosQuadrados(i);
end
mediaDosQuadrados=acumulador/size(vetorDosQuadrados,2);
rmsValue = sqrt(mediaDosQuadrados);