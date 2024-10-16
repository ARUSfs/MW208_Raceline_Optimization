clear
clc
%% Preparacion de la ruta
load("FSG.mat")
route=[spline(1:2:182,Ruta(1:2:end,1),1:0.1:182);spline(1:2:182,Ruta(1:2:end,2),1:0.1:182)]';
kk = interp1(1:length(k),k,1:0.1:182);
track = [route, [anchura(kk,0.7)' anchura(kk,0.7)'].*ones(length(kk),2)];

%% Solucion
[sol,trackData]=minCurvaturePathGenFunction(track,'FSG');

%% Representacion grafica
hold on
plot(azules(:,1),azules(:,2),'b.','MarkerSize',15)
plot(amarillos(:,1),amarillos(:,2),'y.','MarkerSize',15)
legend('Optimal solution','','Reference','Boundaries','Interpreter','latex','Location','east')
axis equal

%% Funciones auxiliares
function dist = anchura(k,dmax)
dist = zeros(1,length(k));
for i=1:length(k)
    kk = mean(k(max(1,i-20):min(length(k),i+20)));
    dist(i) = min(dmax,max(0.5,abs(kk*10)));
end
end