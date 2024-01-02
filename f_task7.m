function [smpl_skew,smpl_kurt, R] = f_task7(u_smpl,w_smpl,fluctuations,smpl_std,xplus)

% Obtains the skewness and kurtosis of the velocity field
smpl_skew=zeros(size(fluctuations,2),3);
smpl_kurt=zeros(size(fluctuations,2),3);
for i=1:size(fluctuations,2)
    for j=1:size(fluctuations,1)        
        a=fluctuations(j,i,1)/smpl_std(i,1);
        b=fluctuations(j,i,2)/smpl_std(i,2);
        c=fluctuations(j,i,3)/smpl_std(i,3);

        smpl_skew(i,1)=smpl_skew(i,1)+((a^3)/size(fluctuations,1));
        smpl_skew(i,2)=smpl_skew(i,2)+((b^3)/size(fluctuations,1));
        smpl_skew(i,3)=smpl_skew(i,3)+((c^3)/size(fluctuations,1));

        smpl_kurt(i,1)=smpl_kurt(i,1)+((a^4)/size(fluctuations,1));
        smpl_kurt(i,2)=smpl_kurt(i,2)+((b^4)/size(fluctuations,1));
        smpl_kurt(i,3)=smpl_kurt(i,3)+((c^4)/size(fluctuations,1));
    end
end
% -------------------------------------------------------------------------
% LOADS DATA FROM THE LITERATURE
% -------------------------------------------------------------------------
% KIMs DATA
uskew_d_Kim=csvread("Literature/u_skew_Kim.txt");
ukurt_d_Kim=csvread("Literature/u_kurt_Kim.txt");

% KREPs DATA
uskew_d_Krep=csvread("Literature/u_skew_Krep.txt");
ukurt_d_Krep=csvread("Literature/u_kurt_Krep.txt");
% -------------------------------------------------------------------------
% PLOTING SECTION
% -------------------------------------------------------------------------
figure;
plot(xplus,smpl_skew(:,1),"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
plot(uskew_d_Kim(:,1),uskew_d_Kim(:,2),"o","Color","k","LineWidth",1.25);
hold on;
plot(uskew_d_Krep(:,1),uskew_d_Krep(:,2),"*","Color","k","LineWidth",1.25);
hold off;
xlim([xplus(1) 100]);
xlabel("x^+");
ylabel("S");

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
plot(xplus,smpl_kurt(:,1),"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
plot(ukurt_d_Kim(:,1),ukurt_d_Kim(:,2),"o","Color","k","LineWidth",1.25);
hold on;
plot(ukurt_d_Krep(:,1),ukurt_d_Krep(:,2),"*","Color","k","LineWidth",1.25);
hold off;
xlim([xplus(1) 100]);
xlabel("x^+");
ylabel("K");

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
% Probability density function represented as an histogram at x=0.06 m
figure;
histogram(u_smpl(:,34),60,"FaceColor","w","LineWidth",1.25);
xlabel("U");
ylabel("N");

% Styling
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
% Pearson's correlation coefficient at x=0.06 m
R = corrcoef(u_smpl(:,34),w_smpl(:,34));
end

