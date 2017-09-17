% This code finds 1) spon_surrogate synframes and evoked synframes that are 
% significantly correlated as number of frames to be compared increases. 
% This also perform same analysis for the shuffled data where activity is
% randomly shuffled across cells in a given synframe. 

% load 
% 1.foopsilogical (evoked)
% -> rename them to foopsilogical_evoked 
% 2. sync_events_005 
% -> rename to synframes_evoked
% 2.count_repeat_spatialpatterns(evoked) & exch_shuffled_saveall (spon)
% -> rename them to ea_rep02,...08
% 3.sigcorr_synframes_thr_for_eachframepair
% -> rename sig_cc_synframes_unique to ea_rep01
% 4. thr_r_mat_eachframepair_bootstrap_005_50k_temp

% id_sa_ea_rep02 is frame indices (in foopsilogical) of spon synframes and
% evoked synframes that are correlated (p<0.05).

% 2013 by Jae-eun K. Miller

tic;

iter = 8;  %change each time

nshuffle = 1;
nrep = 7;

sa_srep01 = sa_srep01(nshuffle*(iter-1)+1:nshuffle*(iter),1);
sa_srep02 = sa_srep02(nshuffle*(iter-1)+1:nshuffle*(iter),1);
sa_srep03 = sa_srep03(nshuffle*(iter-1)+1:nshuffle*(iter),1);
sa_srep04 = sa_srep04(nshuffle*(iter-1)+1:nshuffle*(iter),1);
shuffled_spon = shuffled_spon(:,:,nshuffle*(iter-1)+1:nshuffle*(iter));

unirep_EA = zeros(nshuffle,nrep);
unirep_SA = zeros(nshuffle,nrep);
id_sa_ea_rep02 = cell(nshuffle,1);
id_sa01_ea02_rep03 = cell(nshuffle,1);
id_sa02_ea01_rep03 = cell(nshuffle,1);
id_sa_ea_rep04 = cell(nshuffle,1);
id_sa02_ea03_rep05 = cell(nshuffle,1);
id_sa03_ea02_rep05 = cell(nshuffle,1);
id_sa_ea_rep06 = cell(nshuffle,1);
id_sa03_ea04_rep07 = cell(nshuffle,1);
id_sa04_ea03_rep07 = cell(nshuffle,1);
id_sa_ea_rep08 =cell(nshuffle,1);
for counter=1:nshuffle
    foopsilogical_spon = shuffled_spon(:,:,counter);    
    %rep02
    count = 1;
    sa_ea_rep02 = [];
    sa_srep01_tem = sa_srep01{counter};
    for i = 1:length(sa_srep01_tem)
        for j = 1:length(ea_rep01)
            r = corr(foopsilogical_spon(:,sa_srep01_tem(i,:)),foopsilogical_evoked(:,ea_rep01(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep01_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep01(j,:)))))) < size(sa_srep01_tem,2)^2
                continue
            else
                sa_ea_rep02(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    id_sa_ea_rep02{counter} = [sa_srep01_tem(sa_ea_rep02(:,1),:),ea_rep01(sa_ea_rep02(:,2),:)];
    
    %rep03
    count = 1;
    sa01_ea02_rep03 = [];
    sa_srep02_tem = sa_srep02{counter};
    for i = 1:length(sa_srep01_tem)
        for j = 1:length(ea_rep02)
            r = corr(foopsilogical_spon(:,sa_srep01_tem(i,:)),foopsilogical_evoked(:,ea_rep02(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep01_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep02(j,:)))))) < size(sa_srep01_tem,2)*size(ea_rep02,2)
                continue
            else
                sa01_ea02_rep03(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa01_ea02_rep03)
        id_sa01_ea02_rep03{counter} = [sa_srep01_tem(sa01_ea02_rep03(:,1),:),ea_rep02(sa01_ea02_rep03(:,2),:)];
    else
        id_sa01_ea02_rep03{counter} = [];
    end
    
    count = 1;
    sa02_ea01_rep03 = [];
    for i = 1:length(sa_srep02_tem)
        for j = 1:length(ea_rep01)
            r = corr(foopsilogical_spon(:,sa_srep02_tem(i,:)),foopsilogical_evoked(:,ea_rep01(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep02_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep01(j,:)))))) < size(sa_srep02_tem,2)*size(ea_rep01,2)
                continue
            else
                sa02_ea01_rep03(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa02_ea01_rep03)
        id_sa02_ea01_rep03{counter} = [sa_srep02_tem(sa02_ea01_rep03(:,1),:),ea_rep01(sa02_ea01_rep03(:,2),:)];
    else
        id_sa02_ea01_rep03{counter} = [];
    end
    id_rep03 = [id_sa01_ea02_rep03; id_sa02_ea01_rep03];
    
    %rep04
    count = 1;
    sa_ea_rep04 = [];
    sa_srep02_tem = sa_srep02{counter};
    for i = 1:length(sa_srep02_tem)
        for j = 1:length(ea_rep02)
            r = corr(foopsilogical_spon(:,sa_srep02_tem(i,:)),foopsilogical_evoked(:,ea_rep02(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep02_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep02(j,:)))))) < size(sa_srep02_tem,2)^2
                continue
            else
                sa_ea_rep04(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa_ea_rep04)
        id_sa_ea_rep04{counter} = [sa_srep02_tem(sa_ea_rep04(:,1),:),ea_rep02(sa_ea_rep04(:,2),:)];
    else
        id_sa_ea_rep04{counter} = [];
    end
    
    %rep05
    count = 1;
    sa02_ea03_rep05 = [];
    sa_srep03_tem = sa_srep03{counter};
    for i = 1:length(sa_srep02_tem)
        for j = 1:length(ea_rep03)
            r = corr(foopsilogical_spon(:,sa_srep02_tem(i,:)),foopsilogical_evoked(:,ea_rep03(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep02_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep03(j,:)))))) < size(sa_srep02_tem,2)*size(ea_rep03,2)
                continue
            else
                sa02_ea03_rep05(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa02_ea03_rep05)
        id_sa02_ea03_rep05{counter} = [sa_srep02_tem(sa02_ea03_rep05(:,1),:),ea_rep03(sa02_ea03_rep05(:,2),:)];
    else
        id_sa02_ea03_rep05{counter} = [];
    end

    count = 1;
    sa03_ea02_rep05 = [];
    for i = 1:length(sa_srep03_tem)
        for j = 1:length(ea_rep02)
            r = corr(foopsilogical_spon(:,sa_srep03_tem(i,:)),foopsilogical_evoked(:,ea_rep02(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep03_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep02(j,:)))))) < size(sa_srep03_tem,2)*size(ea_rep02,2)
                continue
            else
                sa03_ea02_rep05(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa03_ea02_rep05)
        id_sa03_ea02_rep05{counter} = [sa_srep03_tem(sa03_ea02_rep05(:,1),:),ea_rep02(sa03_ea02_rep05(:,2),:)];
    else
        id_sa03_ea02_rep05{counter} = [];
    end
    id_rep05 = [id_sa02_ea03_rep05; id_sa03_ea02_rep05];
    
    %rep06
    count = 1;
    sa_ea_rep06 = [];
    sa_srep03_tem = sa_srep03{counter};
    for i = 2270:length(sa_srep03_tem)   %1:length(sa_srep03_tem)
        for j = 1:length(ea_rep03)
            r = corr(foopsilogical_spon(:,sa_srep03_tem(i,:)),foopsilogical_evoked(:,ea_rep03(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep03_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep03(j,:)))))) < size(sa_srep03_tem,2)^2
                continue
            else
                sa_ea_rep06(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa_ea_rep06)
        id_sa_ea_rep06{counter} = [sa_srep03_tem(sa_ea_rep06(:,1),:),ea_rep03(sa_ea_rep06(:,2),:)];
    else
        id_sa_ea_rep06{counter} = [];
    end
    
    %rep07
    count = 1;
    sa03_ea04_rep07 = [];
    sa_srep03_tem = sa_srep03{counter};
    sa_srep04_tem = sa_srep04{counter};
    for i = 1:length(sa_srep03_tem)
        for j = 1:length(ea_rep04)
            r = corr(foopsilogical_spon(:,sa_srep03_tem(i,:)),foopsilogical_evoked(:,ea_rep04(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep03_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep04(j,:)))))) < size(sa_srep03_tem,2)*size(ea_rep04,2)
                continue
            else
                sa03_ea04_rep07(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa03_ea04_rep07)
        id_sa03_ea04_rep07{counter} = [sa_srep03_tem(sa03_ea04_rep07(:,1),:),ea_rep04(sa03_ea04_rep07(:,2),:)];
    else
        id_sa03_ea04_rep07{counter} = [];
    end  
    
    count = 1;
    sa04_ea03_rep07 = [];
    for i = 1:length(sa_srep04_tem)
        for j = 1:length(ea_rep03)
            r = corr(foopsilogical_spon(:,sa_srep04_tem(i,:)),foopsilogical_evoked(:,ea_rep03(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep04_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep03(j,:)))))) < size(sa_srep04_tem,2)*size(ea_rep03,2)
                continue
            else
                sa04_ea03_rep07(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa04_ea03_rep07)
        id_sa04_ea03_rep07{counter} = [sa_srep04_tem(sa04_ea03_rep07(:,1),:),ea_rep03(sa04_ea03_rep07(:,2),:)];
    else
        id_sa04_ea03_rep07{counter} = [];
    end
    id_rep07 = [id_sa03_ea04_rep07; id_sa04_ea03_rep07];
    
    %rep08
    count = 1;
    sa_ea_rep08 = [];
    sa_srep04_tem = sa_srep04{counter};
    for i = 1:length(sa_srep04_tem)
        for j = 1:length(ea_rep04)
            r = corr(foopsilogical_spon(:,sa_srep04_tem(i,:)),foopsilogical_evoked(:,ea_rep04(j,:)));
            if length(find(r> thr_r_mat2(sum(foopsilogical_spon(:,sa_srep04_tem(i,:))),...
                    sum(foopsilogical_evoked(:,ea_rep04(j,:)))))) < size(sa_srep04_tem,2)^2
                continue
            else
                sa_ea_rep08(count,:) = [i,j];
                count = count+1;
            end
        end
    end
    if ~isempty(sa_ea_rep08)
        id_sa_ea_rep08{counter} = [sa_srep04_tem(sa_ea_rep08(:,1),:),ea_rep04(sa_ea_rep08(:,2),:)];
    else
        id_sa_ea_rep08{counter} = [];
    end
    
    id_sa_ea_rep02_tem = id_sa_ea_rep02{counter};
    id_sa01_ea02_rep03_tem = id_sa01_ea02_rep03{counter};
    id_sa02_ea01_rep03_tem = id_sa02_ea01_rep03{counter};
    id_sa_ea_rep04_tem = id_sa_ea_rep04{counter};
    id_sa02_ea03_rep05_tem = id_sa02_ea03_rep05{counter};
    id_sa03_ea02_rep05_tem = id_sa03_ea02_rep05{counter};
    id_sa_ea_rep06_tem = id_sa_ea_rep06{counter};
    id_sa03_ea04_rep07_tem = id_sa03_ea04_rep07{counter};
    id_sa04_ea03_rep07_tem = id_sa04_ea03_rep07{counter};
    id_sa_ea_rep08_tem = id_sa_ea_rep08{counter};
    
    unique_SA_rep02 = length(unique(id_sa_ea_rep02_tem(:,1)));
    unique_EA_rep02 = length(unique(id_sa_ea_rep02_tem(:,2)));
    unique_SA_rep03 = length(unique([unique(id_sa01_ea02_rep03_tem(:,1));unique(id_sa02_ea01_rep03_tem(:,1:2))]));
    unique_EA_rep03 = length(unique([unique(id_sa01_ea02_rep03_tem(:,2:end));unique(id_sa02_ea01_rep03_tem(:,3:end))]));
    
    if ~isempty(id_sa_ea_rep04_tem)
        unique_SA_rep04 = length(unique(id_sa_ea_rep04_tem(:,1:2)));
        unique_EA_rep04 = length(unique(id_sa_ea_rep04_tem(:,3:4)));
    else
        unique_SA_rep04 = 0;
        unique_EA_rep04 = 0;
    end

    if ~isempty(id_sa02_ea03_rep05_tem)
        unique_SA_rep05_1 = unique(id_sa02_ea03_rep05_tem(:,1:2));
        unique_EA_rep05_1 = unique(id_sa02_ea03_rep05_tem(:,3:end));
    else
        unique_SA_rep05_1 = [];
        unique_EA_rep05_1 = [];
    end
    
    if size(unique_SA_rep05_1,2)>1
        unique_SA_rep05_1 = unique_SA_rep05_1';
    else
        unique_SA_rep05_1 = unique_SA_rep05_1;
    end
    if size(unique_EA_rep05_1,2)>1
        unique_EA_rep05_1 = unique_EA_rep05_1';
    else
        unique_EA_rep05_1 = unique_EA_rep05_1;
    end

    if ~isempty(id_sa03_ea02_rep05_tem)
        unique_SA_rep05_2 = unique(id_sa03_ea02_rep05_tem(:,1:3));
        unique_EA_rep05_2 = unique(id_sa03_ea02_rep05_tem(:,4:end));
    else
        unique_SA_rep05_2 = [];
        unique_EA_rep05_2 = [];
    end
    
    if size(unique_SA_rep05_2,2)>1
        unique_SA_rep05_2 = unique_SA_rep05_2';
    else
        unique_SA_rep05_2 = unique_SA_rep05_2;
    end
    if size(unique_EA_rep05_2,2)>1
        unique_EA_rep05_2 = unique_EA_rep05_2';
    else
        unique_EA_rep05_2 = unique_EA_rep05_2;
    end
    unique_SA_rep05 = length(unique([unique_SA_rep05_1;unique_SA_rep05_2]));
    unique_EA_rep05 = length(unique([unique_EA_rep05_1;unique_EA_rep05_2]));
   
    if ~isempty(id_sa_ea_rep06_tem)
        unique_SA_rep06 = length(unique(id_sa_ea_rep06_tem(:,1:3)));
        unique_EA_rep06 = length(unique(id_sa_ea_rep06_tem(:,4:6)));
    else
        unique_SA_rep06 = 0;
        unique_EA_rep06 = 0;
    end
    
    if ~isempty(id_sa03_ea04_rep07_tem)
        unique_SA_rep07_1 = unique(id_sa03_ea04_rep07_tem(:,1:3));
        unique_EA_rep07_1 = unique(id_sa03_ea04_rep07_tem(:,4:end));
    else
        unique_SA_rep07_1 = [];
        unique_EA_rep07_1 = [];
    end
    
    if size(unique_SA_rep07_1,2)>1
        unique_SA_rep07_1 = unique_SA_rep07_1';
    else
        unique_SA_rep07_1 = unique_SA_rep07_1;
    end
    if size(unique_EA_rep07_1,2)>1
        unique_EA_rep07_1 = unique_EA_rep07_1';
    else
        unique_EA_rep07_1 = unique_EA_rep07_1;
    end

    if ~isempty(id_sa04_ea03_rep07_tem)
        unique_SA_rep07_2 = unique(id_sa04_ea03_rep07_tem(:,1:4));
        unique_EA_rep07_2 = unique(id_sa04_ea03_rep07_tem(:,5:end));
    else
        unique_SA_rep07_2 = [];
        unique_EA_rep07_2 = [];
    end
    
    if size(unique_SA_rep07_2,2)>1
        unique_SA_rep07_2 = unique_SA_rep07_2';
    else
        unique_SA_rep07_2 = unique_SA_rep07_2;
    end
    if size(unique_EA_rep07_2,2)>1
        unique_EA_rep07_2 = unique_EA_rep07_2';
    else
        unique_EA_rep07_2 = unique_EA_rep07_2;
    end
    unique_SA_rep07 = length(unique([unique_SA_rep07_1;unique_SA_rep07_2]));
    unique_EA_rep07 = length(unique([unique_EA_rep07_1;unique_EA_rep07_2]));
    
    if ~isempty(id_sa_ea_rep08_tem)
        unique_SA_rep08 = length(unique(id_sa_ea_rep08_tem(:,1:4)));
        unique_EA_rep08 = length(unique(id_sa_ea_rep08_tem(:,5:8)));
    else
        unique_SA_rep08 = 0;
        unique_EA_rep08 = 0;
    end
    
    [~,nframes] = size(foopsilogical_evoked(:,synframes_evoked));
    uni02_EA = unique_EA_rep02/nframes*100;
    uni03_EA = unique_EA_rep03/nframes*100;
    uni04_EA = unique_EA_rep04/nframes*100;
    uni05_EA = unique_EA_rep05/nframes*100;
    uni06_EA = unique_EA_rep06/nframes*100;
    uni07_EA = unique_EA_rep07/nframes*100;
    uni08_EA = unique_EA_rep08/nframes*100;
    unirep_EA(counter,:) = [uni02_EA,uni03_EA,uni04_EA,uni05_EA,uni06_EA,uni07_EA,uni08_EA];
    
    [~,nframes] = size(foopsilogical_spon);
    uni02_SA = unique_SA_rep02/nframes*100;
    uni03_SA = unique_SA_rep03/nframes*100;
    uni04_SA = unique_SA_rep04/nframes*100;
    uni05_SA = unique_SA_rep05/nframes*100;
    uni06_SA = unique_SA_rep06/nframes*100;
    uni07_SA = unique_SA_rep07/nframes*100;
    uni08_SA = unique_SA_rep08/nframes*100;
    unirep_SA(counter,:) = [uni02_SA,uni03_SA,uni04_SA,uni05_SA,uni06_SA,uni07_SA,uni08_SA];
end
toc;
save(['count_SAEA_exch_', int2str(iter)],'id_sa_ea_rep02',...
    'id_sa01_ea02_rep03','id_sa02_ea01_rep03','id_sa_ea_rep04',...
    'id_sa02_ea03_rep05','id_sa03_ea02_rep05','id_sa_ea_rep06',...
    'id_sa03_ea04_rep07','id_sa04_ea03_rep07','id_sa_ea_rep08',...
    'unirep_EA','unirep_SA')



