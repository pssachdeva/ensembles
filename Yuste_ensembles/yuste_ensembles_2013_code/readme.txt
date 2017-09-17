1. Run foopsilogical -> generate binary trace (1, active; 0, inactive)
—> Use foopsilogical for spontaneous exp, but use foopsilogical only during stimulus for evoked exp. 

2. Run nactiveplot_foopsi -> generate synframes (a vector contains indices of high activity frames)

3. Run script “find_thr_eachframepair_temp” -> generate a template of thresholds for any possible pairs of high activity frames to find pairs with a significant correlation. 
Need only one temp per experiment. 

4. Run script “cons_thr_eachframepair_using_temp” ->  construct a threshold matrix for a significant correlation in each movie. 

5. Run script “find_sig_corr_synframes_thr_for_eachpair” ->  find pairs of frame with significant correlation.

6. Run script “conut_repeat_spatialpatterns” ->  find synframes that are significantly correlated as the number of frames to be compared increases from 2 to 8.

7. Run script “conut_repeat_spatialpatterns_exch_shuffle_save1000” ->  do the same with surrogate data sets using exchange shuffle.

———————

8. Run script “count_repeat_patterns_SA_EA_2_8” -> find spon synframes and evoked synframes that are significantly correlated (r>0.3) as the number of frames to be compared increases from 2 to 8. 

9. Run script “count_repeat_patterns_SA_EA_exch_shuffled” -> do the same with surrogate data sets using exchange shuffle. 