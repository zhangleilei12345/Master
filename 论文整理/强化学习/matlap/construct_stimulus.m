function s = construct_stimulus(stim)
    
    % Create complete serial compound representation.创建完整的串行复合表示
    %
    % USAGE: s = construct_stimulus(stim)
    %
    % INPUTS:
    %   stim - structure containing the following fields:
    %           .trial_length - length of trial
    %           .onset [1 x D] - onset for each stimulus (relative to trial start, where 1 = trial start)
    %                            每次刺激的开始(相对于试验开始，1=试验开始)
    %           .dur [1 x D] - duration for each stimulus 时间对于每一个刺激
    %
    % OUTPUTS:
    %   s - [trial_length x D] stimulus timeseries
    %
    % Sam Gershman, June 2017
    
    D = length(stim.onset);
    s = zeros(stim.trial_length,D);
    for d = 1:D
        s(stim.onset(d):(stim.onset(d)+stim.dur(d)-1),d) = 1;
    end