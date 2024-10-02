clear; close all;
Mean=[0.001079891	0.001348925	0.00078912]';
V=[0.000342863	0.000201025	0.000212131
0.000201025	0.000347879	0.000233271
0.000212131	0.000233271	0.000407167];
Ones=ones(size(Mean));
invV=inv(V);
A=Ones'*invV*Mean;
B=Mean'*invV*Mean;
C=Ones'*invV*Ones;
D=B*C-A^2;
g=(B*(invV*Ones)-A*(invV*Mean))/D;
h=(-A*(invV*Ones)+C*(invV*Mean))/D;
w=@(R) g+h*R;
Variance=@(R) (C*R.^2-2*A*R+B)/D;
figure(1)
R=linspace(min(Mean)-0.001,max(Mean)+0.001,100);
plot(sqrt(Variance(R)),R);
xlabel('Standard Deviation'); ylabel('Return');
hold on
plot(sqrt(1/C),A/C,'o')
legend('Frontiera','MVP')
% hold on
% plot(...)
% text(.... 'tg','FontSize', 11, 'HorizontalAlignment', 'left');

