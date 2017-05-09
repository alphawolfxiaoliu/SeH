function [ param,P ] = doTrain_RS( D,param )
% doTrain_RS 
%  �� doTrain Ψһ�������ڣ�����������ķ�ʽ����ල����

D = D';

[M,N] = size(D);

params = init(D,param);

outer_loop_num = params.outer_loop_num;

result.iter=[];
result.loss=[];
result.time=[];

U = params.Uinit;
V = params.Vinit;

% tic;
for i = 1:outer_loop_num
    
    P = updateP(D,V,params);
    
    U = updateU(D,U,V,P,params);
    
    V = updateV_RS(D,U,V,P,params);


    fr = norm(D-U*V, 'fro');
    loss = 1.0 / sqrt(M*N) * fr;
    result.loss=[result.loss,loss];
    
    disp(['iter ', num2str(i), ':  loss = ', num2str(loss)]);
    
%     % ������ NaN ����ֹͣ
%     if isnan(loss)
%        break;
%     end
    
end



V = p1(V); % ��ֵ��
V = (V>0);
V = V';
param.V = V;

param.B = (V);




end

