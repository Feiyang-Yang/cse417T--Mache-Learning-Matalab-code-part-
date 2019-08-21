%Script that runs the set of necessary experiments. This is an example that
%you can use; you should change it as appropriate to answer the question to
%your satisfaction.

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

expt_data_mat = zeros(length(Q_f), length(N), length(var));

for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            %expt_data_mat(ii,jj,kk) = median(computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500));
            expt_data_mat(ii,jj,kk) = mean(computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500));
        end
    end
    fprintf('.');
end

%x=var , Variance of stochastic noise
%y=Eout(W10)- Eout(W2)
%N- Number of training examples fixed, here it is 120  
% Degree of true function varies here, Q_f=5, 10, 15, 20
F1=0:0.5:2;
Line_1=zeros(1,5);
Line_2=zeros(1,5);
Line_3=zeros(1,5);
Line_4=zeros(1,5);
for kkk=1:5
    Line_1(kkk)=expt_data_mat(1,3,kkk);
    Line_2(kkk)=expt_data_mat(2,3,kkk);
    Line_3(kkk)=expt_data_mat(3,3,kkk);
    Line_4(kkk)=expt_data_mat(4,3,kkk);
end
figure(1)
plot(F1,Line_1,'-*',F1,Line_2,'-x',F1,Line_3,'-o',F1,Line_4,'-+');
legend('Q_f=5','Q_f=10','Q_f=15','Q_f=20');

%X=N, Number of training examples
%y=Eout(W10)- Eout(W2)
%Q_f - Degree of true function fixed, here it is 20 
%Variance of stochastic noise varies here, var = 0:0.5:2
F2=40:40:120;
Line_5=expt_data_mat(4,:,1);
Line_6=expt_data_mat(4,:,2);
Line_7=expt_data_mat(4,:,3);
Line_8=expt_data_mat(4,:,4);
Line_9=expt_data_mat(4,:,5);
figure(2)
plot(F2,Line_5,'-*',F2,Line_6,'-x',F2,Line_7,'-o',F2,Line_8,'-+',F2,Line_9,'-D');
legend('var=0','var=0.5','var=1','var=1.5','var=2');

%x=Q_f , Degree of true function
%y=Eout(W10)- Eout(W2)
%variance fixed, here it is 1.5^(1/2)
%N=40,80,120 - Number of training examples vary here
F3=5:5:20;
Line_10=expt_data_mat(:,1,4);
Line_11=expt_data_mat(:,2,4);
Line_12=expt_data_mat(:,3,4);
figure(3)
plot(F3,Line_10,'-*',F3,Line_11,'-+',F3,Line_12,'-x');
legend('N=40','N=80','N=120');