% This code 1)calculate correlation coefficients btw high activity frames 
% using the Pearson correlation, and 2)find pairs of frames with significant 
% correlation (see FIND_THR_EACHFRAMEPAIR_TEMP).

% Before run, load synframes,foopsilogical,thr_r_eachframepair_005_50K

% sig_cc_synframes_loc is indices for pairs of frames with significant 
% correlation
% sig_cc_synframemat is foopsilogical traces including only synframes 
% that are significantly correlated with one other synframes.

% See also: FIND_THR_EACHFRAMEPAIR_TEMP 

% 2013 by Jae-eun K. Miller

synframemat = foopsilogical(:,synframes);
[~, nframes] = size(synframemat);
r = corr(synframemat); 
for i = 1:nframes;  r(i,i)=NaN;  end
[rows,cols] = find(r>=threshold2); % from thr_r_eachframepair_005_50K
loc_r = [rows, cols];
unique_loc_r = unique(loc_r);
sig_cc_synframes_loc = synframes(loc_r);
sig_cc_synframes_unique = synframes(unique_loc_r)';
sig_cc_synframemat = foopsilogical(:,sig_cc_synframes_unique);
r_num = r; r_num(isnan(r_num)) = []; meanr = nanmean(r_num);
x = -1:.01:1;
[frq bin] = hist(r_num,x);
figure, hist(r_num,x), xlim([-1 1])

save('sigcorr_synframes_thr_for_eachframepair','sig_cc_synframes_loc','sig_cc_synframes_unique',...
    'sig_cc_synframemat','meanr')

