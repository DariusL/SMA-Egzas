
% Greiciausio nusileidimo metodas

function greiciausiasNusileidimas
    clc,close all
    scrsz = get(0,'ScreenSize')

    x=[-5:0.25:5];y=[-6:0.25:6];
    Z=pavirsius(@target,x,y);
    fig1=figure(1);set(fig1,'Position',[50 scrsz(4)/1.8 scrsz(3)/3 scrsz(4)/3]);
    hold on,grid on,axis equal,axis([min(x) max(x) min(y) max(y) 0 5]);view([1 1 1]);xlabel('x'),ylabel('y');
    mesh(x,y,Z(:,:,1)','FaceAlpha',0.2);contour(x,y,Z(:,:,1)',[0 0],'LineWidth',1.5);
    xx=axis;
    fill([xx(1),xx(1),xx(2),xx(2)],[xx(3),xx(4),xx(4),xx(3)],'c','FaceAlpha',0.2);


    contour(x,y,Z(:,:,1)');
    xlabel('x'),ylabel('y')
    colorbar;

    eps=1e-5
    step=0.5
    itmax=10
    x=[6;4];
    plot3(x(1),x(2),0,'g*');
    for iii=1:itmax

        grad=gradient(x);
        fff=target(x);
        for j=1:100  % ejimas pagal mazejimo krypti
            deltax=grad/norm(grad)*step; 
            x=x-deltax';
                % vizualizavimas:
                plot3(x(1),x(2),0,'ro');
                h = findobj(gca,'Type','line');
                pause(0.05);delete(h(1));    
                plot3(x(1),x(2),0,'ko');
            fff1=target(x);
            if fff1 > fff, x=x+deltax';break,end
            fff=fff1;
        end


        tikslumas=norm(fff);
        fprintf(1,'\n iteracija %d  tikslumas %g',iii,tikslumas);
        if tikslumas < eps
            fprintf(1,'\n sprendinys x =');
            fprintf(1,'  %g',x);
            break
        elseif iii == itmax
            fprintf(1,'\n ****tikslumas nepasiektas. Paskutinis artinys x =');
            fprintf(1,'  %g',x);
            break
        end

    step=step/2;
    end
end

%   Lygciu sistemos funkcija 
function fff=f(x)
    fff=[x(1)^2+x(2)^2-2;
         x(1)^2-x(2)^2];
end
    
%  Jakobio matrica
function dfff=df(x)
        dfff=[2*x(1), 2*x(2);
              2*x(1), -2*x(2)];
end
    
%     Tikslo funkcija
function rez=target(x)
    rez=f(x)'*f(x)/2;
end
    
    % Gradientas
function rez=gradient(x)
    rez=f(x)'*df(x);
end
    
function Z=pavirsius(funk,x,y)
    for i=1:length(x)
        for j=1:length(y)
            Z(i,j)=funk([x(i),y(j)]);
        end
    end
end