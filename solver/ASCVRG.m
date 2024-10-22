function [ind_val, obj_val] = ASCVRG(data, n, d, lambda)

% parameter
epoch    = 20; 
Data     = data'*data; 
r_bar    = sum(data,1)'/n;
data_bar = 2*(n-1)*Data/n^2; 
eta      = 0.4/eigs(Data,1);
A        = 5; 
dg       = [speye(d); -r_bar']; 

% variable
x        = ones(d, 1)/d;
x_bar    = ones(d, 1)/d;

% main loop
k0        = 5;
maxiter   = n*epoch/5; 
S         = round(log(maxiter)/log(3/2))-1;
count     = 0;

index     = zeros(S, 1);
result    = zeros(S, 1);
result(1) = (n-1)*norm(data*x)^2/(n*n) - mean(data*x) + lambda*sum(abs(x));
 

for i=1:S     
    % gradient calculation.
    g_bar  = [x_bar; -r_bar'*x_bar];
    df_bar = data_bar*x_bar-r_bar; 
    y      = zeros(d, 1);
    
   for j=1:round(k0*(3/2)^(i-1))
        % randomly sample a data point. 
        k     = unidrnd(n, 1, A); 
        r     = sum(data(k, :),1)/A;
        g     = [x-x_bar; -r*(x-x_bar)] + g_bar;

        % gradient calculation. 
        l     = unidrnd(n, 1); 
        rl    = data(l, :); 
        df    = [(2*[rl 1]*g-1)*rl'; 2*[rl 1]*g] - [(2*[rl 1]*g_bar-1)*rl'; 2*[rl 1]*g_bar]; 
        
        alpha = eta*sqrt(n*epoch/(2*n*epoch-count));
        tmpx  = x - alpha*(dg'*df+df_bar); 
        x     = sign(tmpx).*max(0, abs(tmpx)-lambda); 
        y     = y + x;
        
        count = count + 1;
    end
    
    x_bar = y/(k0*(3/2)^(i-1));
    
    % record the information.
    index(i+1) = A*k0*(3/2)^i/n;
    result(i+1) = (n-1)*norm(data*x_bar)^2/(n*n) - mean(data*x_bar) + lambda*sum(abs(x_bar));
end 

ind_val = index; 
obj_val = result;
end