clear;
clc; 
close all;

% Probname = {'ME', 'INV', 'OP'};
Probname = {'Asia_Pacific_ex_Japan_ME', 'Europe_ME', 'Global_ex_US_ME', 'Global_ME', 'Japan_ME', 'North_America_ME'}; 
% Probname = {'Asia_Pacific_ex_Japan_OP', 'Europe_OP', 'Global_ex_US_OP', 'Global_OP', 'Japan_OP', 'North_America_OP'};
% Probname = {'Asia_Pacific_ex_Japan_INV', 'Europe_INV', 'Global_ex_US_INV', 'Global_INV', 'Japan_INV', 'North_America_INV'};

nprob = length(Probname);
Problist = [1:nprob];

for di = 1:length(Problist) 
    
    %% load data
    probID = Problist(di);
    name = Probname{probID};
    load(strcat('./data/', Probname{Problist(di)},'.mat'));
    [n, d] = size(data);
    lambda = 5e-7;
    
    %% Method
    [obj_AGD, opt_val] = AGD(data, n, d, lambda);
    obj_AGD = max(1e-5, obj_AGD - opt_val); 
        
    [ind_SCGD, obj_SCGD] = SCGD(data, n, d, lambda); 
    obj_SCGD = max(1e-5, obj_SCGD - opt_val);
    tmp = min(length(find(obj_SCGD>1e-5))+1, length(obj_SCGD)); 
    obj_SCGD = obj_SCGD(1:tmp);  
    ind_SCGD = ind_SCGD(1:tmp);
    
    [ind_ASC_PG, obj_ASC_PG] = ASC_PG(data, n, d, lambda); 
    obj_ASC_PG = max(1e-5, obj_ASC_PG - opt_val);
    tmp = min(length(find(obj_ASC_PG>1e-5))+1, length(obj_ASC_PG)); 
    obj_ASC_PG = obj_ASC_PG(1:tmp);  
    ind_ASC_PG = ind_ASC_PG(1:tmp);
    
    [ind_VRSC_PG, obj_VRSC_PG] = VRSC_PG(data, n, d, lambda); 
    obj_VRSC_PG = max(1e-5, obj_VRSC_PG - opt_val);
    tmp = min(length(find(obj_VRSC_PG>1e-5))+1, length(obj_VRSC_PG)); 
    obj_VRSC_PG = obj_VRSC_PG(1:tmp);  
    ind_VRSC_PG = ind_VRSC_PG(1:tmp);
    
    [ind_ASCVRG, obj_ASCVRG] = ASCVRG(data, n, d, lambda); 
    obj_ASCVRG = max(1e-5, obj_ASCVRG - opt_val);
    tmp = min(length(find(obj_ASCVRG>1e-5))+1, length(obj_ASCVRG)); 
    obj_ASCVRG = obj_ASCVRG(1:tmp);  
    ind_ASCVRG = ind_ASCVRG(1:tmp);  
    
    figure; 
    semilogy(ind_ASCVRG, obj_ASCVRG, '-', 'LineWidth', 4); 
    hold on;
    semilogy(ind_VRSC_PG, obj_VRSC_PG, '--', 'LineWidth', 4); 
    semilogy(ind_ASC_PG, obj_ASC_PG, '--', 'LineWidth', 4);
    semilogy(ind_SCGD, obj_SCGD, '--', 'LineWidth', 4);
    semilogy(0:1:10, obj_AGD, '--', 'Linewidth', 4); 
    hold off;
    legend('ASCVRG', 'VRSC-PG', 'ASC-PG', 'SCGD', 'AGD', 'Location','southwest');
    
    set(gca,'FontSize',20);
    xlabel('#grad/n');
    xlim([0 10]); 
    ylabel('Objective Gap in Log-Scale');
    title([regexprep(name, '_', ' '), ',  n=', num2str(n), ', d=', num2str(d)]); 
end