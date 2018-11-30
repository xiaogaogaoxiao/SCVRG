clear;
clc; 
close all;

Probname = {'Asia_Pacific_ex_Japan_ME', 'Europe_ME', 'Global_ex_US_ME', 'Global_ME', 'Japan_ME', 'North_America_ME'};
% Probname = {'Asia_Pacific_ex_Japan_INV', 'Europe_INV', 'Global_ex_US_INV', 'Global_INV', 'Japan_INV', 'North_America_INV'};
% Probname = {'Asia_Pacific_ex_Japan_OP', 'Europe_OP', 'Global_ex_US_OP', 'Global_OP', 'Japan_OP', 'North_America_OP'};

nprob = length(Probname);
Problist = [1:nprob];

for di = 1:length(Problist)
    %% load data
    probID = Problist(di);
    name = Probname{probID};
    data = load(strcat(Probname{Problist(di)},'.txt'));
    
    data(:,1) = []; 
    
    [m, n] = size(data); 
    
    %% save
    save(strcat('./data/',Probname{Problist(di)},'.mat'),'data', '-v7.3'); 
    
    %% print procedure
    fprintf('%10s & %5d & %5d \\\\ \\hline \n', name, m, n);
end