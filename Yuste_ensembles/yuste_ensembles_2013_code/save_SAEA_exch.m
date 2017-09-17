%%
all_id_sa01_ea02_rep03 = id_sa01_ea02_rep03;
all_id_sa02_ea01_rep03 = id_sa02_ea01_rep03;
all_id_sa02_ea03_rep05 = id_sa02_ea03_rep05;
all_id_sa03_ea02_rep05 = id_sa03_ea02_rep05;
all_id_sa03_ea04_rep07 = id_sa03_ea04_rep07;
all_id_sa04_ea03_rep07 = id_sa04_ea03_rep07;
all_id_sa_ea_rep02 = id_sa_ea_rep02;
all_id_sa_ea_rep04 = id_sa_ea_rep04;
all_id_sa_ea_rep06 = id_sa_ea_rep06;
all_id_sa_ea_rep08 = id_sa_ea_rep08;
all_unirep_EA = unirep_EA;
all_unirep_SA = unirep_SA;

%%
all_id_sa01_ea02_rep03 = [all_id_sa01_ea02_rep03;id_sa01_ea02_rep03];
all_id_sa02_ea01_rep03 = [all_id_sa02_ea01_rep03;id_sa02_ea01_rep03];
all_id_sa02_ea03_rep05 = [all_id_sa02_ea03_rep05;id_sa02_ea03_rep05];
all_id_sa03_ea02_rep05 = [all_id_sa03_ea02_rep05;id_sa03_ea02_rep05];
all_id_sa03_ea04_rep07 = [all_id_sa03_ea04_rep07;id_sa03_ea04_rep07];
all_id_sa04_ea03_rep07 = [all_id_sa04_ea03_rep07;id_sa04_ea03_rep07];
all_id_sa_ea_rep02 = [all_id_sa_ea_rep02;id_sa_ea_rep02];
all_id_sa_ea_rep04 = [all_id_sa_ea_rep04;id_sa_ea_rep04];
all_id_sa_ea_rep06 = [all_id_sa_ea_rep06;id_sa_ea_rep06];
all_id_sa_ea_rep08 = [all_id_sa_ea_rep08;id_sa_ea_rep08];
all_unirep_EA = [all_unirep_EA;unirep_EA];
all_unirep_SA = [all_unirep_SA;unirep_SA];

%%
id_sa01_ea02_rep03 = all_id_sa01_ea02_rep03;
id_sa02_ea01_rep03 = all_id_sa02_ea01_rep03;
id_sa02_ea03_rep05 = all_id_sa02_ea03_rep05;
id_sa03_ea02_rep05 = all_id_sa03_ea02_rep05;
id_sa03_ea04_rep07 = all_id_sa03_ea04_rep07;
id_sa04_ea03_rep07 = all_id_sa04_ea03_rep07;
id_sa_ea_rep02 = all_id_sa_ea_rep02;
id_sa_ea_rep04 = all_id_sa_ea_rep04;
id_sa_ea_rep06 = all_id_sa_ea_rep06;
id_sa_ea_rep08 = all_id_sa_ea_rep08;
unirep_EA = all_unirep_EA;
unirep_SA = all_unirep_SA;

%%
save('count_SAEA_exch_shuffled_60','id_sa_ea_rep02',...
    'id_sa01_ea02_rep03','id_sa02_ea01_rep03','id_sa_ea_rep04',...
    'id_sa02_ea03_rep05','id_sa03_ea02_rep05','id_sa_ea_rep06',...
    'id_sa03_ea04_rep07','id_sa04_ea03_rep07','id_sa_ea_rep08',...
    'unirep_EA','unirep_SA')


