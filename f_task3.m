function [smpl_avg,smpl_std,fluctuations,TKE,TKE_avg] = f_task3(u_smpl,v_smpl,w_smpl,x_smpl,nu,u_t)

smpl_avg=zeros(size(u_smpl,2),3);
for i=1:size(u_smpl,2)
    smpl_avg(i,1)=mean(u_smpl(:,i));
    smpl_avg(i,2)=mean(v_smpl(:,i));
    smpl_avg(i,3)=mean(w_smpl(:,i));
end

smpl_std=zeros(size(u_smpl,2),3); % Equivalent to the Root-mean square velocity fluctuations
fluctuations=zeros(size(u_smpl,1),size(u_smpl,2),3);
TKE=zeros(size(u_smpl,1),size(u_smpl,2));
TKE_avg=zeros(size(u_smpl,2),1);
for i=1:size(u_smpl,2)
    for j=1:size(u_smpl,1)
        fluctuations(j,i,1)=u_smpl(j,i)-smpl_avg(i,1);
        fluctuations(j,i,2)=v_smpl(j,i)-smpl_avg(i,2);
        fluctuations(j,i,3)=w_smpl(j,i)-smpl_avg(i,3);
        
        smpl_std(i,1)=smpl_std(i,1)+((fluctuations(j,i,1)^2)/size(u_smpl,1));
        smpl_std(i,2)=smpl_std(i,2)+((fluctuations(j,i,2)^2)/size(v_smpl,1));
        smpl_std(i,3)=smpl_std(i,3)+((fluctuations(j,i,3)^2)/size(w_smpl,1));

        TKE(j,i)=0.5*((fluctuations(j,i,1)^2)+(fluctuations(j,i,2)^2)+(fluctuations(j,i,3)^2));
        TKE_avg(i)=TKE_avg(i)+TKE(j,i)/size(u_smpl,1);
    end
    smpl_std(i,1)=sqrt(smpl_std(i,1));
    smpl_std(i,2)=sqrt(smpl_std(i,2));
    smpl_std(i,3)=sqrt(smpl_std(i,3));
end

figure;
subplot(3,1,1);
plot(x_smpl,smpl_avg(:,1)/u_t);
xlim([x_smpl(1) x_smpl(end)]);
subplot(3,1,2);
plot(x_smpl,smpl_avg(:,2)/u_t);
xlim([x_smpl(1) x_smpl(end)]);
subplot(3,1,3);
plot(x_smpl,smpl_avg(:,3)/u_t);
xlim([x_smpl(1) x_smpl(end)]);

figure;
subplot(2,1,1);
plot(x_smpl*u_t/nu,smpl_std(:,1)/u_t,"LineStyle","--","Color","b");
hold on;
plot(x_smpl*u_t/nu,smpl_std(:,2)/u_t,"LineStyle","-.","Color","r");
hold on;
plot(x_smpl*u_t/nu,smpl_std(:,3)/u_t,"k");
hold off;
xlim([x_smpl(1)*u_t/nu x_smpl(end)*u_t/nu]);
subplot(2,1,2);
plot(x_smpl*u_t/nu,TKE_avg);
xlim([x_smpl(1)*u_t/nu x_smpl(end)*u_t/nu]);


figure;
semilogx(x_smpl*u_t/nu,smpl_avg(:,3)/u_t);
hold on;
semilogx(x_smpl*u_t/nu,x_smpl*u_t/nu,"LineStyle","--","Color","b");
hold on;
semilogx(x_smpl*u_t/nu,2.5*log(x_smpl*u_t/nu)+5.5,"LineStyle","--","Color","r");
hold off;
xlim([x_smpl(1)*u_t/nu x_smpl(end)*u_t/nu]);
ylim([0 20]);


% fig=figure;
% for k=1:length(t_smpl)
% plot(x_smpl,TKE(k,:));
% title(t_smpl(k));
% refresh(fig);
% pause(1/20);
% end

end

