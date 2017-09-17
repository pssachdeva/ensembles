function synframes = nactiveplot_foopsi(x)

% NACTIVEPLOT_FOOPSI: find a threshold for significant number of cells
% active per frame, namely high activity frames (p<0.05), and generate a 
% vector containing indices of high activity frames
% synframes = nactiveplot_foopsi(x)
% where
% x is foopsilogical
% synframes is indices of high activity frames
% See also: foopsilogical, sync_threshold

% 2012 by Jae-eun K. Miller

[~, len] = size(x);
fdur = input('frame duration: '); %0.246 or 0.328; 
t=0:fdur:len*fdur-fdur; 
nactive_precut = sum(x);
% syn_thr = sync_threshold(x);
% meanactive = round(syn_thr); 
meanactive = 3;
figure, bar(t,nactive_precut,'k'), xlim([0 len*fdur-fdur]), title('p<0.05'), xlabel('Time(sec)')
hold on 
plot(t,repmat(round(meanactive),[1 len]),'r') 
hold off
nactive_postcut = nactive_precut;
for i = 1:length(nactive_postcut)    
    if nactive_postcut(i) < round(meanactive)
        nactive_postcut(i) = 0;
    else
        nactive_postcut(i) = nactive_postcut(i);
    end
end
synframes = find(nactive_postcut);

% save('sync_events_005_foopsi','meanactive','synframes')
save('sync_events_vistim_005_foopsi','meanactive','synframes')
% save('sync_events_nat_005_foopsi','meanactive','synframes')
% save('sync_events_isi_005_foopsi','synframes')