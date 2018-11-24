function x = construct_CSC(s) %����CSC
    
    % Create complete serial compound representation.�������Ĵ��и��ϱ�ʾ
    %
    % USAGE�÷�: x = construct_CSC(s) 
    %
    % INPUTS:
    %   s - stimulus timeseries (see construct_stimulus.m)
    %
    % OUTPUTS:
    %   x - [h x tritrial_lengtal_length*D] complete serial compound representation������ϵ�л��������
    %
    % Sam Gershman, June 2017
    
    x = [];
    for d = 1:size(s,2)
        x = [x diag(s(:,d))];
    end