function [F_FFT,U_FFT] = f_task6(u_smpl,t_smpl)

T_rate=t_smpl(2)-t_smpl(1);
F_FFT=0:1/t_smpl(end):1/T_rate;

U_FFT=abs(fft(u_smpl(:,34)))/length(t_smpl);
U_FFT(2:end)=U_FFT(2:end)*2;

figure;
loglog(F_FFT,U_FFT);
%hold on;

% ------------------------- WINDOWING -------------------------------------
% Hann window
% u_smpl_HW=hann(length(t_smpl)).*u_smpl(:,34);
% U_FFT_HW=abs(fft(u_smpl_HW))/length(t_smpl);
% U_FFT_HW(2:end)=U_FFT_HW(2:end)*2;
% loglog(F_FFT,U_FFT_HW,"--r");
% hold on;

% % Hamming window
% u_smpl_HM=hamming(length(t_smpl)).*u_smpl(:,34);
% U_FFT_HM=abs(fft(u_smpl_HM))/length(t_smpl);
% U_FFT_HM(2:end)=U_FFT_HM(2:end)*2;
% loglog(F_FFT,U_FFT_HM,"--g");
% hold on;
% 
% % Chebyshev window
% u_smpl_CW=chebwin(length(t_smpl)).*u_smpl(:,34);
% U_FFT_CW=abs(fft(u_smpl_CW))/length(t_smpl);
% U_FFT_CW(2:end)=U_FFT_CW(2:end)*2;
% loglog(F_FFT,U_FFT_CW,"--b");
% hold on;
% 
% % Triangular window
% u_smpl_TW=barthannwin(length(t_smpl)).*u_smpl(:,34);
% U_FFT_TW=abs(fft(u_smpl_TW))/length(t_smpl);
% U_FFT_TW(2:end)=U_FFT_TW(2:end)*2;
% loglog(F_FFT,U_FFT_TW,"--k");
% hold on;

% ------------------------- FILTERING -------------------------------------
% Moving averaging filtering
% windowSize = 100; 
% b = (1/windowSize)*ones(1,windowSize);
% a = 1;
% 
% u_smpl_MA = filter(b,a,u_smpl(:,34));
% U_FFT_MA=abs(fft(u_smpl_MA))/length(t_smpl);
% U_FFT_MA(2:end)=U_FFT_MA(2:end)*2;
% 
% loglog(F_FFT,U_FFT_MA,"--k");
% hold on;

% Lowpass filtering
%lowpass(u_smpl(:,34),0.1,1/T_rate);
% u_smpl_LF=lowpass(u_smpl(:,34),0.1,1/T_rate);
% U_FFT_LF=abs(fft(u_smpl_LF))/length(t_smpl);
% U_FFT_LF(2:end)=U_FFT_LF(2:end)*2;
% loglog(F_FFT,U_FFT_LF,"--b");
% hold off;


end

