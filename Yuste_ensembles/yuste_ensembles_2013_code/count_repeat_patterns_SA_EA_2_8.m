% This code finds 1) spon synframes and evoked synframes that are 
% significantly correlated as number of frames to be compared increases. 
% This also perform same analysis for the shuffled data where activity is
% randomly shuffled across cells in a given synframe. 

% load 
% 1.foopsilogical (both spon and evoked; in case of grating, 
% trunc_foopsilogical_4ori<-only apply jaeeun's data)
% -> rename them to foopsilogical_spon & foopsilogical_evoked

% 2.count_repeat_spatialpatterns (both spon and evoked)
% -> rename them to sa_rep02,...08 & ea_rep02,...04 

% 3.sigcorr_synframes_thr_for_eachframepair
% -> rename sig_cc_synframes_unique to sa_rep01 or ea_rep01

% 4. thr_r_mat_eachframepair_bootstrap_005_50k_temp

% id_sa_ea_rep02 is frame indices (in foopsilogical) of spon synframes and
% evoked synframes that are correlated (p<0.05).

% 2012 by Jae-eun K. Miller

tic;
%rep02
count = 1;
sa_ea_rep02 = [];
for i = 1:length(sa_rep01)
    for j = 1:length(ea_rep01)
        r = corr(foopsilogical_spon(:,sa_rep01(i,:)),foopsilogical_evoked(:,ea_rep01(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep01(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep01(j,:)))))) < size(sa_rep01,2)^2
            continue
        else
            sa_ea_rep02(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa_ea_rep02 = [sa_rep01(sa_ea_rep02(:,1),:),ea_rep01(sa_ea_rep02(:,2),:)];

%rep03
count = 1;
sa01_ea02_rep03 = [];
for i = 1:length(sa_rep01)
    for j = 1:length(ea_rep02)
        r = corr(foopsilogical_spon(:,sa_rep01(i,:)),foopsilogical_evoked(:,ea_rep02(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep01(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep02(j,:)))))) < size(sa_rep01,2)*size(ea_rep02,2)
            continue
        else
            sa01_ea02_rep03(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa01_ea02_rep03 = [sa_rep01(sa01_ea02_rep03(:,1),:),ea_rep02(sa01_ea02_rep03(:,2),:)];

count = 1;
sa02_ea01_rep03 = [];
for i = 1:length(sa_rep02)
    for j = 1:length(ea_rep01)
        r = corr(foopsilogical_spon(:,sa_rep02(i,:)),foopsilogical_evoked(:,ea_rep01(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep02(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep01(j,:)))))) < size(sa_rep02,2)*size(ea_rep01,2)
            continue
        else
            sa02_ea01_rep03(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa02_ea01_rep03 = [sa_rep02(sa02_ea01_rep03(:,1),:),ea_rep01(sa02_ea01_rep03(:,2),:)];

%rep04
count = 1;
sa_ea_rep04 = [];
for i = 1:length(sa_rep02)
    for j = 1:length(ea_rep02)
        r = corr(foopsilogical_spon(:,sa_rep02(i,:)),foopsilogical_evoked(:,ea_rep02(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep02(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep02(j,:)))))) < size(sa_rep02,2)^2
            continue
        else
            sa_ea_rep04(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa_ea_rep04 = [sa_rep02(sa_ea_rep04(:,1),:),ea_rep02(sa_ea_rep04(:,2),:)];

%rep05
count = 1;
sa02_ea03_rep05 = [];
for i = 1:length(sa_rep02)
    for j = 1:length(ea_rep03)
        r = corr(foopsilogical_spon(:,sa_rep02(i,:)),foopsilogical_evoked(:,ea_rep03(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep02(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep03(j,:)))))) < size(sa_rep02,2)*size(ea_rep03,2)
            continue
        else
            sa02_ea03_rep05(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa02_ea03_rep05 = [sa_rep02(sa02_ea03_rep05(:,1),:),ea_rep03(sa02_ea03_rep05(:,2),:)];

count = 1;
sa03_ea02_rep05 = [];
for i = 1:length(sa_rep03)
    for j = 1:length(ea_rep02)
        r = corr(foopsilogical_spon(:,sa_rep03(i,:)),foopsilogical_evoked(:,ea_rep02(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep03(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep02(j,:)))))) < size(sa_rep03,2)*size(ea_rep02,2)
            continue
        else
            sa03_ea02_rep05(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa03_ea02_rep05 = [sa_rep03(sa03_ea02_rep05(:,1),:),ea_rep02(sa03_ea02_rep05(:,2),:)];

%rep06
count = 1;
sa_ea_rep06 = [];
for i = 1:length(sa_rep03)
    for j = 1:length(ea_rep03)
        r = corr(foopsilogical_spon(:,sa_rep03(i,:)),foopsilogical_evoked(:,ea_rep03(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep03(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep03(j,:)))))) < size(sa_rep03,2)^2
            continue
        else
            sa_ea_rep06(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa_ea_rep06 = [sa_rep03(sa_ea_rep06(:,1),:),ea_rep03(sa_ea_rep06(:,2),:)];

%rep07
count = 1;
sa03_ea04_rep07 = [];
for i = 1:length(sa_rep03)
    for j = 1:length(ea_rep04)
        r = corr(foopsilogical_spon(:,sa_rep03(i,:)),foopsilogical_evoked(:,ea_rep04(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep03(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep04(j,:)))))) < size(sa_rep03,2)*size(ea_rep04,2)
            continue
        else
            sa03_ea04_rep07(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa03_ea04_rep07 = [sa_rep03(sa03_ea04_rep07(:,1),:),ea_rep04(sa03_ea04_rep07(:,2),:)];

count = 1;
sa04_ea03_rep07 = [];
for i = 1:length(sa_rep04)
    for j = 1:length(ea_rep03)
        r = corr(foopsilogical_spon(:,sa_rep04(i,:)),foopsilogical_evoked(:,ea_rep03(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep04(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep03(j,:)))))) < size(sa_rep04,2)*size(ea_rep03,2)
            continue
        else
            sa04_ea03_rep07(count,:) = [i,j];
            count = count+1;
        end
    end
end
id_sa04_ea03_rep07 = [sa_rep04(sa04_ea03_rep07(:,1),:),ea_rep03(sa04_ea03_rep07(:,2),:)];

%rep08
count = 1;
sa_ea_rep08 = [];
for i = 1:length(sa_rep04)
    for j = 1:length(ea_rep04)
        r = corr(foopsilogical_spon(:,sa_rep04(i,:)),foopsilogical_evoked(:,ea_rep04(j,:)));
        if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_rep04(i,:))),...
                sum(foopsilogical_evoked(:,ea_rep04(j,:)))))) < size(sa_rep04,2)^2
            continue
        else
            sa_ea_rep08(count,:) = [i,j];
            count = count+1;
        end
    end
end
if ~isempty(sa_ea_rep08)
id_sa_ea_rep08 = [sa_rep04(sa_ea_rep08(:,1),:),ea_rep04(sa_ea_rep08(:,2),:)];
else
id_sa_ea_rep08 = [];
end
toc;

save('count_SAEA_patterns_thr_for_eachpair_2_8','sa_ea_rep02','id_sa_ea_rep02',...
    'sa_ea_rep04','id_sa_ea_rep04','sa_ea_rep06','id_sa_ea_rep06','sa_ea_rep08',...
    'id_sa_ea_rep08','id_sa01_ea02_rep03','id_sa02_ea01_rep03',...
    'id_sa02_ea03_rep05','id_sa03_ea02_rep05','id_sa03_ea04_rep07','id_sa04_ea03_rep07') 




