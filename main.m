source('data.m')
source('meshless.m')
source('draw.m')

tx = ty = linspace (0, 5, 5)';
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

hold on;
scatter3(dados(:,1),dados(:,2),dados(:,3));
mesh (tx, ty, tz);
pause();

exit();
