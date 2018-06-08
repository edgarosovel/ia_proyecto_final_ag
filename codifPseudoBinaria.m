%% Codificicación Pseudobinaria de un rango de valores
%% cubre los casos  0 ..+ valor
%%                  0 ..- valor
%%              -valor..+ valor
%% Entradas
%% valorIni - valor inicial del rango
%% valorFin - valor final del rango
%% Salida
%% Código - estructura que contiene los valores de cada
%%          posición para representar el rango
%%          contiene:
%%              signo - bandera booleana
%%              valIni - Valor inicial de donde parte el intervalo
%%              datos - valores numéricos de cada posición
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ codigo ] = codifPseudoBinaria (valorIni, valorFin)
    codigo.signo = false;
    codigo.valIni = 0;
    codigo.datos(1)=0;
    bandSigno = false; %% Es un rango de puros negativos
    if (valorFin<valorIni)%%  se asegura que valorIni < valorFin
        temp = valorFin;
        valorFin= valorIni;
        valorIni = temp;
    end
    if (valorIni == (valorFin*-1)) %% caso 3
        codigo.signo= true;
        valorIni= 0;
    else
        valorFin = valorFin - valorIni;
        codigo.valIni = valorIni;
        if (valorFin <0 ) %%caso 2
            bandSigno = true; %% si es un rango de puros negativos
            valorFin = abs(valorFin);
        end
    end
    valorEntero = floor(valorFin);
    valorDecimal = valorFin - valorEntero;
    parteEntera = 0;
    parteDecimal= 0;
    if (valorEntero > 0 )
        parteEntera(1)=1;
        valorSig = 2;
        valorEntero = valorEntero - 1;
        i=2;
        while((valorEntero -  valorSig ) >= 0 )
            parteEntera(i)=valorSig;
            valorEntero = valorEntero - valorSig;
            valorSig = valorSig* 2;
            i= i+1;
        end
        if (valorEntero > 0 )
            parteEntera(i)= valorEntero;
            parteEntera = sort(parteEntera);
        end
    end
    if (valorDecimal > 0)
        valor = 0.5;
        while (valor >=valorDecimal)
            valor= valor/2;
        end
        parteDecimal(1)= valor;
        valorDecimal = valorDecimal - valor;
        valorSig = valor/2;
        i = 2;
        epsilon = 0.0001;
        while ((valorDecimal > epsilon) && (valorSig>epsilon))
            if ((valorDecimal-valorSig) > epsilon)
                parteDecimal(i)= valorSig;
                valorDecimal = valorDecimal - valorSig;
                i=i+1;
            end
            valorSig = valorSig / 2;
        end
        if (valorDecimal > 0 )
            parteDecimal(i) = valorDecimal;
            parteDecimal = sort(parteDecimal);
        end
    end
    if(size(parteEntera,2)>1)
        if (size(parteDecimal,2)>1)
            codigo.datos= horzcat(parteDecimal, parteEntera);
        else
            codigo.datos = parteEntera;
        end
    else
        if(size(parteDecimal,2)>1)
            codigo.datos = parteDecimal;
        end
    end
    if(bandSigno)
        codigo.datos = codigo.datos*-1;
    end
    codigo.datos = transpose(sort(codigo.datos,'descend'));
end
