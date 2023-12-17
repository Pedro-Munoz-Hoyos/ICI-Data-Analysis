function [dwdx_avg,w_smpl_avg_anl,dwdx_avg_anl,u_t] = f_task5(w_smpl_avg,x_smpl,nu)

% -------------------------------------------------------------------------
dwdx_avg=gradient(w_smpl_avg)./gradient(x_smpl);
u_t=sqrt(nu*dwdx_avg(1));
% -------------------------------------------------------------------------
w_smpl_avg_anl=poly2sym(polyfit(x_smpl,w_smpl_avg,22));
dwdx_avg_anl=diff(w_smpl_avg_anl);
% -------------------------------------------------------------------------
syms x
anl_int=double(subs(w_smpl_avg_anl,x,x_smpl(end)))-double(subs(w_smpl_avg_anl,x,x_smpl(1)));

% GRID CONVERGENCE ANALYSIS
% step 1
r21=2;
r32=2;

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
   
% step 3
lambda=abs((num_int_coarse-num_int_mid)/(num_int_mid-num_int_fine));
p=abs(log(lambda))/log(r21);

% step 4 (RICHARDSON EXTRAPOLATION)
num_int_21=((r21^p)*num_int_fine-num_int_mid)/((r21^p)-1); 
num_int_32=((r32^p)*num_int_mid-num_int_coarse)/((r32^p)-1); 

% step 5
err_21=abs((num_int_fine-num_int_mid)/num_int_fine);
err_32=abs((num_int_mid-num_int_coarse)/num_int_mid);

GCI_21=125*err_21/((r21^p)-1);% In (%)
GCI_32=125*err_32/((r32^p)-1);% In (%)

% step 6
AR=(r21^p)*GCI_21/GCI_32;

% step 7
GCI_s=1;
r_s=(GCI_s/GCI_32)^(1/p); % r_s with respect to the coarse grid

end

