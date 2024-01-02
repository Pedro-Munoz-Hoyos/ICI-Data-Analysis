function [smpl_avg,smpl_std,fluctuations] = f_task3(u_smpl,v_smpl,w_smpl,xplus,u_t)

% Obtains the mean of the instantaneous velocity field
smpl_avg=zeros(size(u_smpl,2),3);
for i=1:size(u_smpl,2)
    smpl_avg(i,1)=mean(u_smpl(:,i));
    smpl_avg(i,2)=mean(v_smpl(:,i));
    smpl_avg(i,3)=mean(w_smpl(:,i));
end
% -------------------------------------------------------------------------
% Obtains the standard deviation and fluctuating velocity field
smpl_std=zeros(size(u_smpl,2),3);
fluctuations=zeros(size(u_smpl,1),size(u_smpl,2),3);
for i=1:size(u_smpl,2)
    for j=1:size(u_smpl,1)
        fluctuations(j,i,1)=u_smpl(j,i)-smpl_avg(i,1);
        fluctuations(j,i,2)=v_smpl(j,i)-smpl_avg(i,2);
        fluctuations(j,i,3)=w_smpl(j,i)-smpl_avg(i,3);
        
        smpl_std(i,1)=smpl_std(i,1)+((fluctuations(j,i,1)^2)/size(u_smpl,1));
        smpl_std(i,2)=smpl_std(i,2)+((fluctuations(j,i,2)^2)/size(v_smpl,1));
        smpl_std(i,3)=smpl_std(i,3)+((fluctuations(j,i,3)^2)/size(w_smpl,1));
    end
    smpl_std(i,1)=sqrt(smpl_std(i,1));
    smpl_std(i,2)=sqrt(smpl_std(i,2));
    smpl_std(i,3)=sqrt(smpl_std(i,3));
end
% -------------------------------------------------------------------------
% LOADS DATA FROM THE LITERATURE
% -------------------------------------------------------------------------
% KIMs DATA
u_d_Kim=csvread("Literature/u_fluc_Kim.txt");
v_d_Kim=csvread("Literature/v_fluc_Kim.txt");
w_d_Kim=csvread("Literature/w_fluc_Kim.txt");
wm_d_Kim=csvread("Literature/w_mean_Kim.txt");

% Kreps DATA
u_d_Krep=csvread("Literature/u_fluc_Krep.txt");
v_d_Krep=csvread("Literature/v_fluc_Krep.txt");
w_d_Krep=csvread("Literature/w_fluc_Krep.txt");
wm_d_Krep=csvread("Literature/w_mean_Krep.txt");
% -------------------------------------------------------------------------
% PLOTING SECTION
% -------------------------------------------------------------------------
figure;
plot(xplus,smpl_std(:,1)/u_t,"LineStyle","--","Color","k","LineWidth",1.25);
hold on;
plot(u_d_Kim(:,1),u_d_Kim(:,2),"o","Color","k","LineWidth",1.25);
hold on;
plot(u_d_Krep(:,1),u_d_Krep(:,2),"*","Color","k","LineWidth",1.25);
hold off;
xlim([xplus(1) 80]);
xlabel("x^+");
ylabel("\sigma_u");

% Styling
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.1f'))
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
figure;
plot(xplus,smpl_std(:,2)/u_t,"LineStyle","-.","Color","k","LineWidth",1.25);
hold on;
plot(v_d_Kim(:,1),v_d_Kim(:,2),"o","Color","k","LineWidth",1.25);
hold on;
plot(v_d_Krep(:,1),v_d_Krep(:,2),"*","Color","k","LineWidth",1.25);
hold off;
xlim([xplus(1) 80]);
xlabel("x^+");
ylabel("\sigma_v");

% Styling
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.1f'))
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
figure;
plot(xplus,smpl_std(:,3)/u_t,"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
plot(w_d_Kim(:,1),w_d_Kim(:,2),"o","Color","k","LineWidth",1.25);
hold on;
plot(w_d_Krep(:,1),w_d_Krep(:,2),"*","Color","k","LineWidth",1.25);
hold off;
xlim([xplus(1) 80]);
xlabel("x^+");
ylabel("\sigma_w");

% Styling
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.1f'))
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
figure;
semilogx(xplus,smpl_avg(:,3)/u_t,"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
semilogx(wm_d_Kim(:,1),wm_d_Kim(:,2),"o","Color","k","LineWidth",1.25);
hold on;
semilogx(wm_d_Krep(:,1),wm_d_Krep(:,2),"*","Color","k","LineWidth",1.25);
hold on;
semilogx(xplus(1:37),xplus(1:37),"LineStyle","--","Color","k","LineWidth",1.25);
hold on;
semilogx(xplus(30:end),2.9*log(xplus(30:end))+4.3,"LineStyle","--","Color","k","LineWidth",1.25);
hold off;
xlim([xplus(1) xplus(end)]);
ylim([0 20]);
yticks([0.0 5.0 10.0 15.0 20.0]);
xlabel("x^+");
ylabel("w^+");

% Styling
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.1f'))
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
figure;
scatter(fluctuations(:,42,3),fluctuations(:,42,1),[],"+","MarkerEdgeColor","k","LineWidth",1.25);
hold on;
xline(0,"Color","k","LineWidth",1.2);
hold on;
yline(0,"Color","k","LineWidth",1.2);
hold off;
xlim([-0.6 0.6]);
ylim([-0.3 0.3]);
xticks([-0.6 0 0.6]);
yticks([-0.3 0 0.3]);
xlabel("w");
ylabel("u");
box on;

% Styling
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.1f'))
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
end

