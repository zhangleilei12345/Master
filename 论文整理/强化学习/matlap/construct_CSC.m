function x = construct_CSC(s) %构建CSC
    
    % Create complete serial compound representation.建完整的串行复合表示
    %
    % USAGE用法: x = construct_CSC(s) 
    %
    % INPUTS:
    %   s - stimulus timeseries (see construct_stimulus.m)
    %
    % OUTPUTS:
    %   x - [h x tritrial_lengtal_length*D] complete serial compound representation完整的系列化合物表征
    %
    % Sam Gershman, June 2017
    
    x = [];
    for d = 1:size(s,2)
        x = [x diag(s(:,d))];
    end