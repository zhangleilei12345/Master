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
    
    % initialization ��ʼ��
    [N,D] = size(X);
    w = zeros(D,1);         % weights
    X = [X; zeros(1,D)];    % add buffer at end �������ӻ���
    
    % parameters ����  ��nargin �������������
    if nargin < 3 || isempty(param); param = struct('c',1,'s',1,'q',0.01); end  
    C = param.c*eye(D); % prior variance ֮ǰ�ķ���
    s = param.s;        % observation noise variance �۲���������
    Q = param.q*eye(D); % transition noise variance ������������
    
    % run Kalman filter ���п������˲���
    for n = 1:N
        
        h = X(n,:);                 % stimulus features �̼�����
        rhat = h*w;                 % reward prediction ����Ԥ��
        dt = r(n) - rhat;           % prediction error  Ԥ�����
        C = C + Q;                  % a priori covariance ����Э����
        P = h*C*h'+s;               % residual covariance ʣ���Э����
        K = C*h'/P;                 % Kalman gain      ����������
        w = w + K*dt;               % weight update  Ȩ�ظ���
        C = C - K*h*C;              % posterior covariance update Э��������
        
        % store results �洢���
        model(n) = struct('w',w,'C',C,'K',K,'dt',dt,'rhat',rhat);
        
    end