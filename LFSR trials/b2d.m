function y = b2d(x) 
z = 2.^(length(x)-1:-1:0); 
y = sum(x.*z); 