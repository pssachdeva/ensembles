function [thr_corrcoef_shuffled, meanr] = find_thr_corrcoef_shuffled(x,y)

% FIND_THR_CORRCOEF_SHUFFLED: calculate a threshold for significant 
% correlation between synframes(p<0.05) by shuffling synframes by randomly 
% choosing active cells in each frame while preserving the total number of 
% active cells per synframe. 
% [thr_corrcoef_shuffled, meanr] = find_thr_corrcoef_shuffled(x,y)
% where
% x is foopsilogical
% y is synframes

% Before run, load foopsilogical, synframes

% 2012 by Jae-eun K. Miller

x = x(:,y);
[ncell nframe]=size(x);
nshuffle = 1000;
shuffled=ones(ncell,nframe);
thr_corr = ones(1,nshuffle);
meanr = ones(1,nshuffle);
zscore = 1.96; % corresponds to P<0.05
% zscore = 2.58; % corresponds to P<0.01
% threshold = 0.025;
for i = 1:nshuffle
    shuffled(:,:) = shuffle(x,'cell');
    r = corr(shuffled);
    for j=1:nframe
        r(j,j)=NaN;
    end
    r(isnan(r)) = [];
    %     figure, hist(r), xlim([-1 1])
    %     sortedr = sort(r,2,'descend');
    %     len_r = length(r);   %(lastframe-1)*lastframe*0.5;
    %     thr_corr(i) = sortedr(round(threshold*len_r));
    thr_corr(i) = std(r)*zscore + mean(r);
    meanr(i) = mean(r);
end
close all;
thr_corrcoef_shuffled = mean(thr_corr);
meanr = mean(meanr);
save('thr_corrcoef_shuffled','thr_corrcoef_shuffled')