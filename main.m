source('functions.m')
source('data.m')
source('draw.m')


ponto = [3 4];
raio = getRadius(dados,ponto,6);

u(dados,base,[1 2])

hold on;
scatter(dados(:,1),dados(:,2),'b');
scatter(ponto(1),ponto(2),'r');
drawCircle(ponto(1),ponto(2),raio)
hold off;
pause();



tx = ty = linspace (0, 5, 6)';
[xx, yy] = meshgrid (tx, ty);

tz=[];
for x=tx'
	row = [];
	for y=ty'
		z = u(dados,base,[x y]);
		row = [row z];
	end
	tz = [tz ; row];
end

tz
scatter3(dados(:,1),dados(:,2),dados(:,3));
mesh (tx, ty, tz);
pause();

exit();
