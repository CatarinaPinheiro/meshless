function weights =  GaussianWithRadius(dist,r)
	weights = [];
	c=100;
	for rr=r'
		if norm(dist) <= r
			exp1 = exp(-(norm(dist)/c)^2);
			exp2 = exp(-(r/c)^2);
			weight = ( exp1 - exp2 )/(1-exp2);
		else
			weight = 0;
		end

		weights = [weights ; weight];
	end
end

function W = W(data,point,r)
	W=[];
	for row = 1:rows(data)
		dat = data(row,:);
		leftZeroes = zeros(1,row-1);
		rightZeroes = zeros(1,size(data) - row);
		weight = GaussianWithRadius(dat(1:2)-point,r);
		newRow = [leftZeroes weight rightZeroes];
		W = [W ; newRow];
	end
end

function P = createBase(base,data)
	P=[];
	for dat=data'
		row = [];
		for b=base'
			command = ["x=" mat2str(dat(1)) "\ny=" mat2str(dat(2)) "\n" b'];
			row = [row eval(command)];
		end
		P = [P ; row];
	end
end

function coefficients = coefficients(data,P, x,r)
	B = P'*W(data,x,r);
	A = B*P;
	if(abs(det(A)) < 10^-6)
		error("determinante muito pequeno!");
	else
		coefficients = inv(A)*B*data(:,3);
	end
end

function r = getRadius(data,point,m)
	r = [];
	distances = [];
	for p = point'
		for dat=data'
			distances = [distances;norm(point'-dat(1:2))];
		end
		distances = sort(distances);
		r = [r;distances(m)];
	end

end

function u = u(data,base,point)
	m = size(base)(1);
	while true
		try
			r = getRadius(data,point,m);
			P = createBase(base,data);
			c = coefficients(data,P,point,r);
			p = createBase(base,point);
		catch
			m++
			continue;
		end
		break;
	end
	u = p*c;
end
