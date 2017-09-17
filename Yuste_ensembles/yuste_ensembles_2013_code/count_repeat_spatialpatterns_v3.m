% This code finds 1) synframes that are significantly correlated as number 
% of frames to be compared increases within a movie (either spon or evoked)
% This also perform same analysis for the shuffled data where activity is
% randomly shuffled across cells in a given synframe. 

% Before run, load foopsilogical, sigcorr_synframes_thr_for_eachframepair,


% rep02 is pairs of frames correlated; rep03 is triplets of frames
% correlated, etc. 

% 2012 by Jae-eun K. Miller
% 2017 modified by Jae-eun K. Miller

tic;
rep02_temp = sortrows(sig_cc_synframes_loc,1);
for i = 1:length(rep02_temp); if rep02_temp(i,2)<rep02_temp(i,1); rep02_temp(i,:)=NaN; end; end
rep02_temp(isnan(rep02_temp))=[];
rep02=reshape(rep02_temp,length(rep02_temp)/2,2);

%rep03
idx1 = [];
idx1 = [1;find(diff(rep02(:,1)))+1];
rep03 = [];
for i = 1:length(idx1)
    pairs = [];
    pair_rep = [];
    temp = [];
    if length(find(rep02(:,1)==rep02(idx1(i),1))) < 2
        continue
    else
        pairs = combntns(rep02(find(rep02(:,1)==rep02(idx1(i),1)),2),2);
        pair_rep = intersect(pairs,rep02,'rows');
        temp = [repmat(rep02(idx1(i),1),[size(pair_rep,1),1]),pair_rep];
        rep03 = [rep03;temp];
    end
end

%rep04
idx1 = [];
idx1 = [1;find(diff(rep03(:,1)))+1];
rep04 = [];
for i = 1:length(idx1)
    if length(find(rep03(:,1)==rep03(idx1(i),1))) < 2
        continue
    else
        rep03_temp = [];
        rep03_temp = rep03(find(rep03(:,1)==rep03(idx1(i),1)),:);
        idx2 = [1;find(diff(rep03_temp(:,2)))+1];
        for j = 1:length(idx2)
            pairs = [];
            pair_rep = [];
            temp = [];
            pos = [];
            if length(find(rep03_temp(:,2)==rep03_temp(idx2(j),2))) < 2
                continue
            else
                pos = find(rep03_temp(:,2)==rep03_temp(idx2(j),2));
                pairs = combntns(rep03_temp(pos,3),2);
                pair_rep = intersect(pairs,rep02,'rows');
                temp = [repmat(rep03_temp(idx2(j),1:2),[size(pair_rep,1),1]),pair_rep];
                rep04 = [rep04;temp];
            end
        end
    end
end

%rep05
idx1 = [];
idx1 = [1;find(diff(rep04(:,1)))+1];
rep05 = [];
for i = 1:length(idx1)
    if length(find(rep04(:,1)==rep04(idx1(i),1))) < 2
        continue
    else
        rep04_temp = [];
        rep04_temp = rep04(find(rep04(:,1)==rep04(idx1(i),1)),:);
        idx2 = [];
        idx2 = [1;find(diff(rep04_temp(:,2)))+1];
        for j = 1:length(idx2)
            pairs = [];
            pair_rep = [];
            temp = [];
            pos = [];
            if length(find(rep04_temp(:,2)==rep04_temp(idx2(j),2))) < 2
                continue
            else
                rep04_temp2 = rep04_temp(find(rep04_temp(:,2)==rep04_temp(idx2(j),2)),:);
                idx3 = [];
                idx3 = [1;find(diff(rep04_temp2(:,3)))+1];
                for k = 1:length(idx3)
                    pairs = [];
                    pair_rep = [];
                    temp = [];
                    pos = [];
                    if length(find(rep04_temp2(:,3)==rep04_temp2(idx3(k),3))) < 2
                        continue
                    else
                        pos = find(rep04_temp2(:,3)==rep04_temp2(idx3(k),3));
                        pairs = combntns(rep04_temp2(pos,4),2);
                        pair_rep = intersect(pairs,rep02,'rows');
                        temp = [repmat(rep04_temp2(idx3(k),1:3),[size(pair_rep,1),1]),pair_rep];
                        rep05 = [rep05;temp];
                    end
                end
            end
        end
    end
end

save('count_repeat_spatialpatterns_thr_for_eachframepair','rep02','rep03','rep04','rep05')
toc;