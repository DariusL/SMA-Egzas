function isvestines
    clc,clear all,close all

    global F X
    syms F X
    F = sin(2*X)/((X+1)^2);

    DF = diff(F,X);

    a = 1;
    b = 3; 
    nnn = 25; % intervalas
    dx = (b-a)/(nnn-1);
    xxx = a:dx:b; % vaizdavimo tasku skaicius ir abscises

    N = 5;  % formules tasku skaicius    
    figure(1)
    hold on
    grid on
    plot(xxx,eval(subs(F,X,sym(xxx))),'b-*');

    fff = eval(subs(F,X,sym(xxx)));
    DFnum = Diferencijavimas(fff,N)/((N-1)*dx);

    plot(xxx,DFnum,'r-*','Linewidth',2);
    plot(xxx,eval(subs(DF,X,sym(xxx))),'g-')
    legend('duota funkcija','diferencijuota skaitiskai','diferencijuota analitiskai')

end
% 
function Isvestine=Diferencijavimas(f,N)
    ww=[-25/3, 16, -12, 16/3, -1;
                     -1, -10/3, 6, -2, 1/3;
                1/3, -8/3, 0, 8/3, -1/3;
                -1/3, 2, -6, 10/3, 1;
                1, -16/3, 12, -16, 25/3];

    n=length(f);
    mid=(N+1)/2-1;
    for i=1:n 
        if i<mid+1
            Isvestine(i)=ww(i,1:N)*f(1:N)' ;
        elseif i > n-mid
            Isvestine(i)=ww(N+i-n,1:N)*f(n-N+1:n)';
        else
            Isvestine(i)=ww(mid+1,1:N)*f(i-mid:i+mid)';
        end
    end
end