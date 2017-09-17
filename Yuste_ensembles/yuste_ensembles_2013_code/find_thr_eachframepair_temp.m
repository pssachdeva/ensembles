% load foopsilogical

tic;
trace = foopsilogical;
[ncell, ~] = size(trace);
nshuffle = 5000; %50000;
mat = zeros(ncell,ncell);
for m = 1:ncell
    mat(1:m,m) = 1;
end
shuffled1 = zeros(ncell,nshuffle);
thr_r_mat = zeros(ncell,ncell);
p_mat = zeros(ncell,ncell);
for j = 1:ncell-1
    for k = j:ncell
        for i = 1:nshuffle
            shuffled1(:,i) = shuffle(mat(:,j),'cell');
        end
        r = corr(shuffled1,mat(:,k));
        sortr = sort(r);
        sortr2 = roundn(sortr,-5);
        dif = diff(sortr2);
        idx = find(dif) + 1; % find idx when r changes
        pvalues = ones(size(idx))-idx./nshuffle; % probability of getting r
        pidx = find(pvalues<0.05); % find r corresponding p<0.05
        if isempty(pidx) % if no r with p<0.05, then find highest r
        thr_r_mat(j,k) = sortr(idx(end)); 
        p_mat(j,k) = pvalues(end);   
        elseif pvalues(pidx(1))<0.0001 % if p is too small then find previous r value
        thr_r_mat(j,k) = sortr(idx(pidx(1)-1));
        p_mat(j,k) = pvalues(pidx(1)-1);
        else       
        thr_r_mat(j,k) = sortr(idx(pidx(1)));
        p_mat(j,k) = pvalues(pidx(1));
        end
    end
end
thr_r_mat2 = thr_r_mat;
for count = 1:ncell
    thr_r_mat2(count:end,count) = thr_r_mat(count,count:end);
end 
toc;
save('thr_r_mat_eachframepair_bootstrap_005_50k_temp','thr_r_mat2','p_mat')


