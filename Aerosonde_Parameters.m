%% FDI FOR THE LATERAL DIRECTIONAL MODEL OF AEROSONDE AIRCRAFT
close all;clear ;
clc;
%% State Space Model
A=[-0.64 1.51 -22.95 9.78 0
    -4.19 -20.63 9.93 0 0
    0.68 -2.68 -1.04 0 0
    0 1.00 0 0 0
    0 0 1.00 0 0];

B=[-1.25 3.19
    -109.84 1.98
    -4.33 -20.17
    0 0
    0 0];
C=[0.04 0 0 0 0
    0 1 0 0 0
    0 0 1 0 0
    0 0 0 1 0
    0 0 0 0 1];
D=zeros(5,2);
sys=ss(A,B,C,D);
t=0:100;
%% Adding Disturbances and Faults
amp=15;
E=amp*ones(5,2); %%disturbance matrix including uncertainties
disp('please input the fault time:');
t_fault=input('simulation start time=0s, end time=10s:');
disp('please input the fault type:');
fault_type=input('1=abrupt fault ,2= incipient fault,3=intermittent fault:');
%% Left Eigen Structure Assignment Method
rnk=rank(C*E);%%check
if (rnk<length(A))
    temp=C*E;
    W=null(temp');
    W=W';
    lhs=W*C;
    l=lhs';
    lambda=[-11.5397 -19.4274 -2.0692 -0.9755 -0.4240];
    P=-inv(lambda(length(A))*eye(length(A))-A')*C';%subspace span
    for j=2:length(A)
        ll=P(:,j)+P(:,j-1);%computing eigenvector from subspace
    end

    l(:,length(A))=ll;
    for i=1:length(A)
        P=-(inv(lambda(i)*eye(length(A))-A'))*C';
        w(:,i)=inv(P)*l(:,i);
    end
    %%check if li in span of P
     for i=1:length(A)
        P=-(inv(lambda(i)*eye(length(A))-A'))*C';
        proj_l(:,i)=P*w(:,i);   
     end
     res=proj_l-l;
end

%% %% Observer Design
L=(w*inv(l))';
 
%% LQR
%for no fault conditions
Q=[50000000         0         0         0         0
   0    10000000         0         0         0
   0         0    10000000         0         0
   0         0         0    10000000         0
   0         0         0         0    10000000];
R=0.2*eye(2);
[K,ric,eig_new] = lqr(A,B,Q,R);
%for abrupt fault
Qab=[1000000         0         0         0         0
   0    1000000         0         0         0
   0         0    1000000         0         0
   0         0         0    1000000         0
   0         0         0         0    1000000];
Rab=0.2*eye(2);
[Kab,ricab,eig_new_ab] = lqr(A,B,Qab,Rab);
%for incipient fault
Qinc=[1e10         0         0         0         0
   0    1e10         0         0         0
   0         0   1e10        0         0
   0         0         0    1e10         0
   0         0         0         0    1e10];
Rinc=0.2*eye(2);
[Kinc,ric_inc,eig_new_inc] = lqr(A,B,Qinc,Rinc);
%for intermittent fault
Qint=[1e8         0         0         0         0
   0    1e8         0         0         0
   0         0    1e8         0         0
   0         0         0    1e8         0
   0         0         0         0    1e8];
Rint=0.2*eye(2);
[Kint,ricint,eig_new_int] = lqr(A,B,Qint,Rint);
%% FTC
  model = 'thesis_lqg';
  load_system(model)
  sim(model)
%% Plots
figure;
% plot(r_fault,'linewidth',1.2,'color','k');
plot(r_fault,'linewidth',1.2);
xlabel('Time(s)');
ylabel('Residual Signal,r(t)');
title('');
figure;
% plot(yhat_out,'linewidth',1.2,'color','k');
plot(yhat_out,'linewidth',1.2);
%magnify;
xlabel('Time(s)');
ylabel('LQG Output,y(t)');
title('');
magnify;
