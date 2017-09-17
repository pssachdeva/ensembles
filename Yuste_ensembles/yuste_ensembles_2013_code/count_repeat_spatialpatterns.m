% This code finds 1) synframes that are significantly correlated as number 
% of frames to be compared increases within a movie (either spon or evoked)
% This also perform same analysis for the shuffled data where activity is
% randomly shuffled across cells in a given synframe. 

% Before run, load foopsilogical, sigcorr_synframes_thr_for_eachframepair,


% rep02 is pairs of frames correlated; rep03 is triplets of frames
% correlated, etc. 

% 2012 by Jae-eun K. Miller
% 2013 modified by Jae-eun K. Miller

tic;
rep02_temp = sortrows(sig_cc_synframes_loc,1);
for i = 1:length(rep02_temp); if rep02_temp(i,2)<rep02_temp(i,1); rep02_temp(i,:)=NaN; end; end
rep02_temp(isnan(rep02_temp))=[];
rep02=reshape(rep02_temp,length(rep02_temp)/2,2);

nframe = length(foopsilogical); x = sig_cc_synframes_loc(:,2);
pos = zeros(nframe,1); for i = 1:nframe; pos(i)= length(find(x==i)); end % find total number of frames correlated to each frame
postemp=pos;
%rep03
postemp(postemp==1)=0; % keep frames with at least 2 other frames correlated
loc_rep03=find(postemp); % indices of frames with at least 2 other frames correlated
count=0;
rep03 = [];
for i = 1:length(loc_rep03)
    tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep03(i)),1); % all other frames correlated to a single frame
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep03(i) % only keep frames after the single frame to avoid overlapping
            continue
        else
            tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2);common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else            
            for k = 1:length(common)
                rep03(k+count,:) = [loc_rep03(i),tempframe(j),common(k)];
            end
            count = count + length(common);
        end
    end
end
% rep04
postemp(postemp==2)=0;
loc_rep04=find(postemp);
count=0;
rep04 = [];
for i = 1:length(loc_rep04)
    tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep04(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep04(i)
            continue
        else
            tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2);common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        rep04(l+count,:) = [loc_rep04(i),tempframe(j),common(k),commonrep04(l)];
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
rep05 = [];
for i = 1:length(loc_rep05)
    tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep05(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep05(i)
            continue
        else
            tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        tempframe4 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep04(l)),1);
                        commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
                        commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
                        if isempty(commonrep05)
                            continue
                        else
                            for m = 1:length(commonrep05)
                                rep05(m+count,:) = [loc_rep05(i),tempframe(j),common(k),commonrep04(l),commonrep05(m)];
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
rep06 = [];
for i = 1:length(loc_rep06)
    tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep06(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep06(i)
            continue
        else
            tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        tempframe4 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep04(l)),1);
                        commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
                        commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
                        if isempty(commonrep05)
                            continue
                        else
                            for m = 1:length(commonrep05)
                                tempframe5 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep05(m)),1);
                                commoncell3 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5};
                                commonrep06 = intersect2(commoncell3); commonrep06(commonrep06<commonrep05(m))=[];
                                if isempty(commonrep06)
                                    continue
                                else
                                    for n = 1:length(commonrep06)
                                        rep06(n+count,:) = [loc_rep06(i),tempframe(j),common(k),commonrep04(l),commonrep05(m),commonrep06(n)];
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
rep07 = [];
for i = 1:length(loc_rep07)
    tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep07(i)),1);
    for j = 1:length(tempframe)
        if tempframe(j)<loc_rep07(i)
            continue
        else
            tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
        end
        common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
        if isempty(common)
            continue
        else
            for k = 1:length(common)
                tempframe3 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == common(k)),1);
                commoncell = {tempframe,tempframe2,tempframe3};
                commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
                if isempty(commonrep04)
                    continue
                else
                    for l = 1:length(commonrep04)
                        tempframe4 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep04(l)),1);
                        commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
                        commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
                        if isempty(commonrep05)
                            continue
                        else
                            for m = 1:length(commonrep05)
                                tempframe5 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep05(m)),1);
                                commoncell3 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5};
                                commonrep06 = intersect2(commoncell3); commonrep06(commonrep06<commonrep05(m))=[];
                                if isempty(commonrep06)
                                    continue
                                else
                                    for n = 1:length(commonrep06)
                                        tempframe6 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep06(n)),1);
                                        commoncell4 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6};
                                        commonrep07 = intersect2(commoncell4); commonrep07(commonrep07<commonrep06(n))=[];
                                        if isempty(commonrep07)
                                            continue
                                        else
                                            for o = 1:length(commonrep07)
                                                rep07(o+count,:) = [loc_rep07(i),tempframe(j),common(k),commonrep04(l),commonrep05(m),commonrep06(n),commonrep07(o)];
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
save('count_repeat_spatialpatterns_thr_for_eachframepair','rep02','rep03','rep04','rep05','rep06','rep07')
toc;

% % rep08
% postemp(postemp==6)=0;
% loc_rep08=find(postemp);
% count=0;
% rep08 = [];
% for i = 1:length(loc_rep08)
%     tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep08(i)),1);
%     for j = 1:length(tempframe)
%         if tempframe(j)<loc_rep08(i)
%             continue
%         else
%             tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
%         end
%         common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
%         if isempty(common)
%             continue
%         else
%             for k = 1:length(common)
%                 tempframe3 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == common(k)),1);
%                 commoncell = {tempframe,tempframe2,tempframe3};
%                 commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
%                 if isempty(commonrep04)
%                     continue
%                 else
%                     for l = 1:length(commonrep04)
%                         tempframe4 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep04(l)),1);
%                         commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
%                         commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
%                         if isempty(commonrep05)
%                             continue
%                         else
%                             for m = 1:length(commonrep05)
%                                 tempframe5 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep05(m)),1);
%                                 commoncell3 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5};
%                                 commonrep06 = intersect2(commoncell3); commonrep06(commonrep06<commonrep05(m))=[];
%                                 if isempty(commonrep06)
%                                     continue
%                                 else
%                                     for n = 1:length(commonrep06)
%                                         tempframe6 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep06(n)),1);
%                                         commoncell4 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6};
%                                         commonrep07 = intersect2(commoncell4); commonrep07(commonrep07<commonrep06(n))=[];
%                                         if isempty(commonrep07)
%                                             continue
%                                         else
%                                             for o = 1:length(commonrep07)
%                                                 tempframe7 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep07(o)),1);
%                                                 commoncell5 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6,tempframe7};
%                                                 commonrep08 = intersect2(commoncell5); commonrep08(commonrep08<commonrep07(o))=[];
%                                                 if isempty(commonrep08)
%                                                     continue
%                                                 else
%                                                     for p = 1:length(commonrep08)
%                                                         rep08(p+count,:) = [loc_rep08(i),tempframe(j),common(k),commonrep04(l),commonrep05(m),commonrep06(n),commonrep07(o),commonrep08(p)];
%                                                     end
%                                                     count = count + length(commonrep08);
%                                                 end
%                                             end
%                                         end
%                                     end
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end    
% end
% % rep09
% postemp(postemp==7)=0;
% loc_rep09=find(postemp);
% count=0;
% rep09 = [];
% for i = 1:length(loc_rep09)
%     tempframe = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == loc_rep09(i)),1);
%     for j = 1:length(tempframe)
%         if tempframe(j)<loc_rep09(i)
%             continue
%         else
%             tempframe2 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == tempframe(j)),1);
%         end
%         common = intersect(tempframe,tempframe2); common(common<tempframe(j))=[];
%         if isempty(common)
%             continue
%         else
%             for k = 1:length(common)
%                 tempframe3 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == common(k)),1);
%                 commoncell = {tempframe,tempframe2,tempframe3};
%                 commonrep04 = intersect2(commoncell); commonrep04(commonrep04<common(k))=[];
%                 if isempty(commonrep04)
%                     continue
%                 else
%                     for l = 1:length(commonrep04)
%                         tempframe4 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep04(l)),1);
%                         commoncell2 = {tempframe,tempframe2,tempframe3,tempframe4};
%                         commonrep05 = intersect2(commoncell2); commonrep05(commonrep05<commonrep04(l))=[];
%                         if isempty(commonrep05)
%                             continue
%                         else
%                             for m = 1:length(commonrep05)
%                                 tempframe5 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep05(m)),1);
%                                 commoncell3 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5};
%                                 commonrep06 = intersect2(commoncell3); commonrep06(commonrep06<commonrep05(m))=[];
%                                 if isempty(commonrep06)
%                                     continue
%                                 else
%                                     for n = 1:length(commonrep06)
%                                         tempframe6 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep06(n)),1);
%                                         commoncell4 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6};
%                                         commonrep07 = intersect2(commoncell4); commonrep07(commonrep07<commonrep06(n))=[];
%                                         if isempty(commonrep07)
%                                             continue
%                                         else
%                                             for o = 1:length(commonrep07)
%                                                 tempframe7 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep07(o)),1);
%                                                 commoncell5 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6,tempframe7};
%                                                 commonrep08 = intersect2(commoncell5); commonrep08(commonrep08<commonrep07(o))=[];
%                                                 if isempty(commonrep08)
%                                                     continue
%                                                 else
%                                                     for p = 1:length(commonrep08)
%                                                         tempframe8 = sig_cc_synframes_loc(find(sig_cc_synframes_loc(:,2) == commonrep08(p)),1);
%                                                         commoncell6 = {tempframe,tempframe2,tempframe3,tempframe4,tempframe5,tempframe6,tempframe7,tempframe8};
%                                                         commonrep09 = intersect2(commoncell6); commonrep09(commonrep09<commonrep08(p))=[];
%                                                         if isempty(commonrep09)
%                                                             continue
%                                                         else
%                                                             for q = 1:length(commonrep09)
%                                                                 rep09(q+count,:) = [loc_rep09(i),tempframe(j),common(k),commonrep04(l),commonrep05(m),commonrep06(n),commonrep07(o),commonrep08(p),commonrep09(q)];
%                                                             end
%                                                             count = count + length(commonrep09);
%                                                         end
%                                                     end
%                                                 end
%                                             end
%                                         end
%                                     end
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%     end    
% end
