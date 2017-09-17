% contruct thr_matrix for significant correlation for each frame pair

% load foopsilogical, sync_events_005,
% thr_r_mat_eachframepair_bootstrap_temp (spon folder)

% Also see 'FIND_THR_EACHFRAMEPAIR_TEMP'

% 2013 by Jae-eun Miller

tic;
trace = foopsilogical(:,synframes);
nactive = sum(trace);
[~, nframe] = size(trace);
threshold = zeros(nframe, nframe);

for i = 1:nframe-1
    for j = i+1:nframe
        threshold(i,j) = thr_r_mat2(nactive(i), nactive(j));
    end
end

for c = 1:nframe
    threshold(c,c) = NaN;
end

threshold2 = threshold;
for c2 = 1:nframe
    threshold2(c2:end, c2) = threshold2(c2, c2:end);
end

save('thr_r_eachframepair_005_50k','threshold2')
