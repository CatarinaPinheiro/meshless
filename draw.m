function drawCircle(x,y,r)
	t = linspace(0,2*pi,100)'; 
	circsx = r.*cos(t) + x; 
	circsy = r.*sin(t) + y; 
	plot(circsx,circsy); 
end
