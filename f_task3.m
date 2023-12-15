function [smpl_avg,smpl_std] = f_task3(u_smpl,v_smpl,w_smpl,x_smpl)

smpl_avg=zeros(size(u_smpl,2),3);
for i=1:size(u_smpl,2)
    smpl_avg(i,1)=mean(u_smpl(:,i));
    smpl_avg(i,2)=mean(v_smpl(:,i));
    smpl_avg(i,3)=mean(w_smpl(:,i));
end

smpl_std=zeros(size(u_smpl,2),3);
for i=1:size(u_smpl,2)
    for j=1:size(u_smpl,1)
        smpl_std(i,1)=smpl_std(i,1)+(((u_smpl(j,i)-smpl_avg(i,1))^2)/size(u_smpl,1));
        smpl_std(i,2)=smpl_std(i,2)+(((v_smpl(j,i)-smpl_avg(i,2))^2)/size(v_smpl,1));
        smpl_std(i,3)=smpl_std(i,3)+(((w_smpl(j,i)-smpl_avg(i,3))^2)/size(w_smpl,1));
    end
    smpl_std(i,1)=sqrt(smpl_std(i,1));
    smpl_std(i,2)=sqrt(smpl_std(i,2));
    smpl_std(i,3)=sqrt(smpl_std(i,3));
end

figure;
subplot(2,1,1);
plot(x_smpl,smpl_avg(:,1));
subplot(2,1,2);
plot(x_smpl,smpl_std(:,1));

figure;
subplot(2,1,1);
plot(x_smpl,smpl_avg(:,2));
subplot(2,1,2);
plot(x_smpl,smpl_std(:,2));

figure;
subplot(2,1,1);
plot(x_smpl,smpl_avg(:,3));
subplot(2,1,2);
plot(x_smpl,smpl_std(:,3));

end

