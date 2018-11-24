function model = KRW(X,r,param)
    
    % Kalman Rescorla-Wagner model
    %
    % USAGE: model = KRW(X,r,[param])
    %
    % INPUTS:
    %   X - [N x D] matrix of stimulus features, where N is the number of
    %       timepoints, D is the number of features.
    %   r - [N x 1] vector of rewards
    %   param (optional) - parameter structure with the following fields:
    %                       .c - prior variance (default: 1)
    %                       .s - observation noise variance (default: 1)
    %                       .q - transition noise variance (default: 0.01)
    %
    % OUTPUTS:
    %   model - [1 x N] structure with the following fields for each timepoint:
    %           .w - [D x 1] posterior mean weight vector
    %           .C - [D x D] posterior weight covariance
    %           .K - [D x 1] Kalman gain (learning rates for each dimension)
    %           .dt - prediction error
    %           .rhat - reward prediction
    %
    % Sam Gershman, June 2017
    
    % initialization 初始化
    [N,D] = size(X);
    w = zeros(D,1);         % weights
    X = [X; zeros(1,D)];    % add buffer at end 在最后添加缓冲
    
    % parameters 参数  （nargin 输入参数个数）
    if nargin < 3 || isempty(param); param = struct('c',1,'s',1,'q',0.01); end  
    C = param.c*eye(D); % prior variance 之前的方差
    s = param.s;        % observation noise variance 观测噪声方差
    Q = param.q*eye(D); % transition noise variance 过渡噪声方差
    
    % run Kalman filter 运行卡尔曼滤波器
    for n = 1:N
        
        h = X(n,:);                 % stimulus features 刺激功能
        rhat = h*w;                 % reward prediction 奖励预测
        dt = r(n) - rhat;           % prediction error  预测误差
        C = C + Q;                  % a priori covariance 先验协方差
        P = h*C*h'+s;               % residual covariance 剩余的协方差
        K = C*h'/P;                 % Kalman gain      卡尔曼增益
        w = w + K*dt;               % weight update  权重更新
        C = C - K*h*C;              % posterior covariance update 协方差后更新
        
        % store results 存储结果
        model(n) = struct('w',w,'C',C,'K',K,'dt',dt,'rhat',rhat);
        
    end