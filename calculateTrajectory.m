clear
clc
%% Preparacion de la ruta
circuito = jsondecode(fileread("FSG24.json"));
FSG24_cones
azules = cones(1:ceil(height(cones)/2)+1,:);
amarillos = cones(ceil(height(cones)/2)+2:end,:);

route = [circuito.x circuito.y];
tracklimit_right = interpolate_cones([amarillos(:,1:2); amarillos(1,1:2)],height(route));
tracklimit_left = interpolate_cones([azules(:,1:2); azules(1,1:2)],height(route));
min_width = 1;
twr = min_dist(route,tracklimit_right)-min_width;
twl = min_dist(route,tracklimit_left)-min_width;
track = [route,[twr twl]];

%% Solucion
[sol,trackData]=minCurvaturePathGenFunction(track);

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

function final_cones = interpolate_cones(cones,nseg)
stepLengths = sqrt(sum(diff(cones,[],1).^2,2));
stepLengths = [0; stepLengths]; % add the starting point
cumulativeLen = cumsum(stepLengths);
finalStepLocs = linspace(0,cumulativeLen(end), nseg);
final_cones = interp1(cumulativeLen, cones, finalStepLocs);
end

function d=min_dist(v1,v2)
d = zeros(length(v1),1);
for k=1:length(v1)
    d(k) = min(hypot(v2(:,1)-v1(k,1),v2(:,2)-v1(k,2)));
end
end