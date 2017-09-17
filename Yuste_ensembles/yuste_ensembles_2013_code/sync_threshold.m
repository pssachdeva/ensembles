function [syn_thr_005,thr_r_mat,p_mat] = sync_threshold(x)

% SYNC_THRESHOLD: shuffles inter-spike-interval of data x 1000 times to
% find a threshold for significant number of cells activer per frame
% corresponding p<0.05
% syn_thr_005 = sync_threshold(x)
% where
% x is foopsilogical
% syn_thr_005 is a threshold

% 2012 by Jae-eun K. Miller
% modified 2014

[ncell len]=size(x);
nshuffle = 1000;
shuffled=ones(ncell,len,nshuffle);
thr_r_mat = zeros(nshuffle,1);
p_mat = zeros(nshuffle,1);
for i = 1:nshuffle
    shuffled(:,:,i) = shuffle(x,'isi');
    numactive = sum(shuffled(:,:,i),1)';
    sort_num = sort(numactive);
    sort_num2 = roundn(sort_num,-5);
    dif = diff(sort_num2);
    idx = find(dif) + 1; % find idx when numactive changes
    pvalues = ones(size(idx))-idx./len; % probability of getting numactive
    pidx = find(pvalues<0.05); % find numactive corresponding p<0.05
    if isempty(pidx) % if no numactive with p<0.05, then find highest numactive
        thr_r_mat(i) = sort_num(idx(end));
        p_mat(i) = pvalues(end);
    elseif pvalues(pidx(1))<0.0001 % if p is too small then find previous numactive value
        thr_r_mat(i) = sort_num(idx(pidx(1)-1));
        p_mat(i) = pvalues(pidx(1)-1);
    else
        thr_r_mat(i) = sort_num(idx(pidx(1)));
        p_mat(i) = pvalues(pidx(1));
    end
end
syn_thr_005 = mean(thr_r_mat);
save('syn_thr_005_vs2','syn_thr_005','thr_r_mat','p_mat')