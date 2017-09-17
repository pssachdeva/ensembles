% This code find repeated patterns from shuffled data using 'exchange'. 

% Load 'foopsilogical','thr_r_mat_eachframepair_005_50k','sync_events_005'.

% Also see: FIND_THR_EACHFRAMPAIR

tic;
nshuffle = 100;
nrep = 6;
fper = zeros(nshuffle,nrep);
synframemat = foopsilogical(:,synframes);
[ncells, nframes] = size(synframemat);
shuffled = zeros(ncells, nframes, nshuffle);
sa_srep01 = cell(nshuffle,1);
sa_srep02 = cell(nshuffle,1);
sa_srep03 = cell(nshuffle,1);
sa_srep04 = cell(nshuffle,1);
sa_srep05 = cell(nshuffle,1);
sa_srep06 = cell(nshuffle,1);
sa_srep07 = cell(nshuffle,1);

for counter=1:nshuffle
shuffled(:,:,counter) = shuffle(synframemat,'exchange');
r = corrcoef(shuffled(:,:,counter)); for i=1:nframes; r(i,i)=NaN; end
[rows,cols]=find(r>=threshold2); % use thr calculated for each pair
loc_r = [rows, cols];

%rep01
sa_srep01{counter} = unique(loc_r);

%rep02
sa_srep02{counter} = loc_r;  
nframe = length(shuffled(:,:,counter));  shuffled_x = loc_r(:,2); 
pos = zeros(nframe,1); for i = 1:nframe; pos(i)= length(find(shuffled_x==i)); end
postemp=pos;

%rep03
postemp(postemp==1)=0;
loc_rep03=find(postemp);
count=0;
sa_srep03{counter} = [];
for i = 1:length(loc_rep03)
    tempframe = loc_r(find(loc_r(:,2) == loc_rep03(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep03(i)
            continue
        else
            tempframe2 = loc_r(find(loc_r(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2);common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else            
            for k = 1:length(common)
                sa_srep03{counter}(k+count,:) = [loc_rep03(i),tempframe(j),common(k)];
            end
            count = count + length(common);
        end
    end
end

% rep04
postemp(postemp==2)=0;
loc_rep04=find(postemp);
count=0;
sa_srep04{counter} = [];
for i = 1:length(loc_rep04)
    tempframe = loc_r(find(loc_r(:,2) == loc_rep04(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep04(i)
            continue
        else
            tempframe2 = loc_r(find(loc_r(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2);common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = loc_r(find(loc_r(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        sa_srep04{counter}(l+count,:) = [loc_rep04(i),tempframe(j),common(k),commonrep04(l)];
                    end
                    count = count + length(commonrep04);
                end
            end
        end
    end
end

% rep05
postemp(postemp==3)=0;
loc_rep05=find(postemp);
count=0;
sa_srep05{counter} = [];
for i = 1:length(loc_rep05)
    tempframe = loc_r(find(loc_r(:,2) == loc_rep05(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep05(i)
            continue
        else
            tempframe2 = loc_r(find(loc_r(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = loc_r(find(loc_r(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        tempframe4 = loc_r(find(loc_r(:,2) == commonrep04(l)),1);
                        commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
                        commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
                        if isempty(commonrep05)
                            continue
                        else
                            for m = 1:length(commonrep05)
                                sa_srep05{counter}(m+count,:) = [loc_rep05(i),tempframe(j),common(k),commonrep04(l),commonrep05(m)];
                            end
                            count = count + length(commonrep05);
                        end
                    end
                end
            end
        end
    end
end

% rep06
postemp(postemp==4)=0;
loc_rep06=find(postemp);
count=0;
sa_srep06{counter} = [];
for i = 1:length(loc_rep06)
    tempframe = loc_r(find(loc_r(:,2) == loc_rep06(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep06(i)
            continue
        else
            tempframe2 = loc_r(find(loc_r(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = loc_r(find(loc_r(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        tempframe4 = loc_r(find(loc_r(:,2) == commonrep04(l)),1);
                        commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
                        commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
                        if isempty(commonrep05)
                            continue
                        else
                            for m = 1:length(commonrep05)
                                tempframe5 = loc_r(find(loc_r(:,2) == commonrep05(m)),1);
                                commoncell3 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5};
                                commonrep06 = intersect2(commoncell3); commonrep06(commonrep06<commonrep05(m))=[];
                                if isempty(commonrep06)
                                    continue
                                else
                                    for n = 1:length(commonrep06)
                                        sa_srep06{counter}(n+count,:) = [loc_rep06(i),tempframe(j),common(k),commonrep04(l),commonrep05(m),commonrep06(n)];
                                    end
                                    count = count + length(commonrep06);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% rep07
postemp(postemp==5)=0;
loc_rep07=find(postemp);
count=0;
sa_srep07{counter} = [];
for i = 1:length(loc_rep07)
    tempframe = loc_r(find(loc_r(:,2) == loc_rep07(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep07(i)
            continue
        else
            tempframe2 = loc_r(find(loc_r(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = loc_r(find(loc_r(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        tempframe4 = loc_r(find(loc_r(:,2) == commonrep04(l)),1);
                        commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
                        commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
                        if isempty(commonrep05)
                            continue
                        else
                            for m = 1:length(commonrep05)
                                tempframe5 = loc_r(find(loc_r(:,2) == commonrep05(m)),1);
                                commoncell3 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5};
                                commonrep06 = intersect2(commoncell3); commonrep06(commonrep06<commonrep05(m))=[];
                                if isempty(commonrep06)
                                    continue
                                else
                                    for n = 1:length(commonrep06)
                                        tempframe6 = loc_r(find(loc_r(:,2) == commonrep06(n)),1);
                                        commoncell4 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6};
                                        commonrep07 = intersect2(commoncell4); commonrep07(commonrep07<commonrep06(n))=[];
                                        if isempty(commonrep07)
                                            continue
                                        else
                                            for o = 1:length(commonrep07)
                                                sa_srep07{counter}(o+count,:) = [loc_rep07(i),tempframe(j),common(k),commonrep04(l),commonrep05(m),commonrep06(n),commonrep07(o)];
                                            end
                                            count = count + length(commonrep07);
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

fper02 = length(unique(sa_srep02{counter}))/nframes*100;
fper03 = length(unique(sa_srep03{counter}))/nframes*100;
fper04 = length(unique(sa_srep04{counter}))/nframes*100;
fper05 = length(unique(sa_srep05{counter}))/nframes*100;
fper06 = length(unique(sa_srep06{counter}))/nframes*100;
fper07 = length(unique(sa_srep07{counter}))/nframes*100;
fper(counter,:) = [fper02,fper03,fper04,fper05,fper06,fper07];
end
toc;
shuffled_spon = shuffled;
save('count_repeat_patterns_exch_shuffled_for_eachpair_100_saveall',...
    'sa_srep01','sa_srep02','sa_srep03','sa_srep04','shuffled_spon','fper')

