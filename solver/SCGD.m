function [ind_val, obj_val] = SCGD(data, n, d, lambda)

% parameter
epoch  = 20;

% variable
x      = ones(d, 1)/d;
y      = ones(d+1, 1)/d;
z      = zeros(d, 1);

% main loop
maxiter   = n*epoch;
index     = zeros(maxiter+1, 1);
result    = zeros(maxiter, 1);
result(1) = (n-1)*norm(data*x)^2/(n*n) - mean(data*x) + lambda*sum(abs(x)); 

for i = 1:maxiter  
    % randomly sample a data point. 
    k     = unidrnd(n, 1); 
    r     = data(k, :);
    
    % stepsize.
    alpha = 1e-4/i^(3/4);
    beta  = 1e-4/i^(1/2);
    
    % gradient calculation. 
    dg    = [speye(d); -r];
    g     = [x; -r*x];
    y     = (1-beta)*y+beta*g; 
    tmp   = 2*[r 1]*y; 
    df    = [(tmp-1)*r'; tmp]; 
    
    tmpx  = x - alpha*dg'*df; 
    x     = sign(tmpx).*max(0, abs(tmpx)-lambda); 
    z     = z + x; 
    
    % record the information.
    index(i+1) = i/n;
    x_bar = z/i;
    result(i+1) = (n-1)*norm(data*x_bar)^2/(n*n) - mean(data*x_bar) + lambda*sum(abs(x_bar));
end
 
ind_val = index; 
obj_val = result;
end