function [dwdx_avg,w_smpl_avg_anl,dwdx_avg_anl,u_t] = f_task5(w_smpl_avg,x_smpl,nu)

% -------------------------------------------------------------------------
% Obtains the mean streamwise wall-normal gradient
dwdx_avg=gradient(w_smpl_avg)./gradient(x_smpl);

% Obtains the streamwise friction velocity
u_t=sqrt(nu*dwdx_avg(1));
% -------------------------------------------------------------------------
% Obtains the analytical functions to conduct the grid convergence analysis
w_smpl_avg_anl=poly2sym(polyfit(x_smpl,w_smpl_avg,22));
dwdx_avg_anl=diff(w_smpl_avg_anl);
syms x
anl_int=double(subs(w_smpl_avg_anl,x,x_smpl(end)))-double(subs(w_smpl_avg_anl,x,x_smpl(1)));
% -------------------------------------------------------------------------
% GRID CONVERGENCE ANALYSIS
% step 1
r21=2;
r32=2;
% -------------------------------------------------------------------------
% step 2
dx_coarse=(x_smpl(end)-x_smpl(1))/(100-1);
x_coarse=x_smpl(1):dx_coarse:x_smpl(end);
y_coarse=double(subs(dwdx_avg_anl,x,x_coarse));
num_int_coarse=sum(y_coarse)*dx_coarse;

dx_mid=dx_coarse/r32;
x_mid=x_smpl(1):dx_mid:x_smpl(end);
y_mid=double(subs(dwdx_avg_anl,x,x_mid));
num_int_mid=sum(y_mid)*dx_mid;

dx_fine=dx_mid/r21;
x_fine=x_smpl(1):dx_fine:x_smpl(end);
y_fine=double(subs(dwdx_avg_anl,x,x_fine));
num_int_fine=sum(y_fine)*dx_fine;
% -------------------------------------------------------------------------   
% step 3
lambda=abs((num_int_coarse-num_int_mid)/(num_int_mid-num_int_fine));
p=abs(log(lambda))/log(r21);
% -------------------------------------------------------------------------
% step 4 (RICHARDSON EXTRAPOLATION)
num_int_21=((r21^p)*num_int_fine-num_int_mid)/((r21^p)-1); 
num_int_32=((r32^p)*num_int_mid-num_int_coarse)/((r32^p)-1); 
% -------------------------------------------------------------------------
% step 5
err_21=abs((num_int_fine-num_int_mid)/num_int_fine);
err_32=abs((num_int_mid-num_int_coarse)/num_int_mid);

GCI_21=125*err_21/((r21^p)-1);% In (%)
GCI_32=125*err_32/((r32^p)-1);% In (%)
% -------------------------------------------------------------------------
% step 6
AR=(r21^p)*GCI_21/GCI_32;
% -------------------------------------------------------------------------
% step 7
GCI_s=1;
r_s=(GCI_s/GCI_32)^(1/p); % r_s with respect to the coarse grid
% -------------------------------------------------------------------------
% PLOTS THE CONVERGENCE OF THE ERROR
N=10;
nv=[];
err=[];
for i=1:100
    dx_conv=(x_smpl(end)-x_smpl(1))/(N*i-1);
    x_conv=x_smpl(1):dx_conv:x_smpl(end);
    y_conv=double(subs(dwdx_avg_anl,x,x_conv));
    num_int_conv=sum(y_conv)*dx_conv;

    nv(i)=N*i;
    err(i)=abs(anl_int-num_int_conv)*100/anl_int;
end
% -------------------------------------------------------------------------
% PLOTING SECTION
% -------------------------------------------------------------------------
figure;
loglog(nv,err,"LineStyle","-","Color","k","LineWidth",1.25);
xlabel("N");
ylabel("\epsilon (%)")
xlim([10 1000])
% -------------------------------------------------------------------------
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

