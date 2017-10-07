source('data.m')
source('meshless.m')
source('draw.m')
graphics_toolkit("gnuplot")

tx = ty = linspace (0, 16, 16)';
[xx, yy] = meshgrid (tx, ty);
tz=[];
for y=ty'
	row = [];
	for x=tx'
		z = u(dados,base,[x y]);
		row = [row z];
	end
	tz = [tz ; row];
end

for point=dados'
  point
  calc = [point(1:2) u(dados,base,point(1:2))]
  dif = (calc - point)(3) 
end

hold on;
scatter3(dados(:,1),dados(:,2),dados(:,3));
mesh (tx, ty, tz);
pause();

exit();
