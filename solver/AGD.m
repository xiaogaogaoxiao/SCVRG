function [obj_val, opt_val] = AGD(data, n, d, lambda)

% parameter
epoch  = 5000;  
Data   = data'*data;
alpha  = 0.01/eigs(Data,1); 

% variable
x      = ones(d, 1)/d;
y      = ones(d, 1)/d;
t      = 1;
result = zeros(epoch+1, 1);
result(1) = (n-1)*norm(data*x)^2/(n*n) - mean(data*x) + lambda*sum(abs(x));  

for i=1:epoch
    
    % main loop
    x_pre  = x; 
    t_pre  = t; 
    tmp    = y-alpha*(2*(n-1)*Data*y/n^2-sum(data,1)'/n);
    x      = sign(tmp).*max(0, abs(tmp)-lambda); 
    t      = (1+sqrt(1+4*t^2))/2;
    y      = x+(t_pre-1)*(x-x_pre)/t;
    
    % record the information.
    result(i+1) = (n-1)*norm(data*x)^2/(n*n) - mean(data*x) + lambda*sum(abs(x));   
end

opt_val = result(end); 
obj_val = result(1:11);  
end
