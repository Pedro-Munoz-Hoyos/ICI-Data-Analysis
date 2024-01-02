function [F_FFT,U_FFT] = f_task6(u_smpl,u_avg,t_smpl)

% Obtains the Fourier transformation of the wall-normal velocity field at 
% x=0.06 m, processed accordingly for obtaining the energy spectrum.
T_rate=t_smpl(2)-t_smpl(1);
F_FFT=0:1/t_smpl(end):(1/T_rate)/2;
U_FFT=abs(fft(u_smpl(:,34)))/length(t_smpl);
U_FFT(2:end)=U_FFT(2:end)*2;
% -------------------------------------------------------------------------
% Obtains the wavenumbers using Taylor's frozen turbulence hypotheses
waveNumb=(2*pi*F_FFT/u_avg(34));
% -------------------------------------------------------------------------
% Plots the pre-multiplied spectrum in Semilogx representation
figure;
semilogx(F_FFT,U_FFT(1:length(F_FFT)),"LineStyle","-","Color","k","LineWidth",1.25);
xlim([F_FFT(1) F_FFT(end)]);

% Styling
xlabel("f");
ylabel("E_{uu}(f)");
box on;
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
% Plots the pre-multiplied spectrum in loglog representation
figure;
loglog(F_FFT,U_FFT(1:length(F_FFT)),"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
loglog(F_FFT(380:18000),(waveNumb(380:18000).^(-5/3))*1000,"LineStyle","--","Color","r","LineWidth",1.25);
hold off;
xlim([F_FFT(1) F_FFT(end)]);

% Styling
xlabel("f");
ylabel("E_{uu}(f)");
box on;
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
% Hanning window
u_smpl_HW=hann(length(t_smpl)).*u_smpl(:,34);
U_FFT_HW=abs(fft(u_smpl_HW))/length(t_smpl);
U_FFT_HW(2:end)=U_FFT_HW(2:end)*2;
figure;
loglog(F_FFT,U_FFT(1:length(F_FFT)),"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
loglog(F_FFT,U_FFT_HW(1:length(F_FFT)),"LineStyle","-","Color","b","LineWidth",1.25);
hold on;
loglog(F_FFT(380:18000),(waveNumb(380:18000).^(-5/3))*1000,"LineStyle","--","Color","r","LineWidth",1.25);
hold off;
xlim([F_FFT(1) F_FFT(end)]);

% Styling
xlabel("f");
ylabel("E_{uu}(f)");
box on;
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
% Triangular window
u_smpl_TW=flattopwin(length(t_smpl)).*u_smpl(:,34);
U_FFT_TW=abs(fft(u_smpl_TW))/length(t_smpl);
U_FFT_TW(2:end)=U_FFT_TW(2:end)*2;
figure;
loglog(F_FFT,U_FFT(1:length(F_FFT)),"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
loglog(F_FFT,U_FFT_TW(1:length(F_FFT)),"LineStyle","-","Color","b","LineWidth",1.25);
hold on;
loglog(F_FFT(380:18000),(waveNumb(380:18000).^(-5/3))*1000,"LineStyle","--","Color","r","LineWidth",1.25);
hold off;
xlim([F_FFT(1) F_FFT(end)]);

% Styling
xlabel("f");
ylabel("E_{uu}(f)");
box on;
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
% -------------------------------------------------------------------------
% Moving averaging filtering
type = 'linear';
windowSize = 10;
U_FFT_MA = movmean(U_FFT,windowSize);

figure;
loglog(F_FFT,U_FFT(1:length(F_FFT)),"LineStyle","-","Color","k","LineWidth",1.25);
hold on;
loglog(F_FFT,U_FFT_MA(1:length(F_FFT)),"LineStyle","-","Color","b","LineWidth",1.25);
hold on;
loglog(F_FFT(380:18000),(waveNumb(380:18000).^(-5/3))*1000,"LineStyle","--","Color","r","LineWidth",1.25);
hold off;
xlim([F_FFT(1) F_FFT(end)]);

% Styling
xlabel("f");
ylabel("E_{uu}(f)");
box on;
fontname(gca,"Times New Roman")
set(gcf,'color','w');
set(gca,'XMinorTick','on','YMinorTick','on');
ax = gca;
ax.LineWidth = 1.2;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
end

