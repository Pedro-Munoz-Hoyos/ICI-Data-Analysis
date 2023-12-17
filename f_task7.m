function [smpl_skew,smpl_kurt] = f_task7(u_smpl,fluctuations,smpl_std,x_smpl)

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

        smpl_kurt(i,1)=smpl_skew(i,1)+((a^4)/size(fluctuations,1));
        smpl_kurt(i,2)=smpl_skew(i,2)+((b^4)/size(fluctuations,1));
        smpl_kurt(i,3)=smpl_skew(i,3)+((c^4)/size(fluctuations,1));
    end
end

figure;
subplot(2,1,1);
plot(x_smpl,smpl_skew(:,1));
subplot(2,1,2);
plot(x_smpl,smpl_kurt(:,1));

figure;
subplot(2,1,1);
plot(x_smpl,smpl_skew(:,2));
subplot(2,1,2);
plot(x_smpl,smpl_kurt(:,2));

figure;
subplot(2,1,1);
plot(x_smpl,smpl_skew(:,3));
subplot(2,1,2);
plot(x_smpl,smpl_kurt(:,3));


fig=figure;
for k=1:length(x_smpl)
histogram(u_smpl(:,k),100);
title(k);
refresh(fig);
pause(1/20);
end

end

