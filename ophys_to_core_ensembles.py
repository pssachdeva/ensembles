# -*- coding: utf-8 -*-
import os
import deconvolution.deconvolution_tools as dt
import numpy as np
import pandas as pd
import time as t
import sys
import define_ensembles as de
import h5py
import matplotlib.pyplot as plt
import networkx as nx
import EnsembleCorrelationFunctions as ecf
import matplotlib.pyplot as plt

def exp_to_ensembles(boc,ophys_experiment_id, stimulus, verbose=False):
    start_time = t.time()
    if verbose:
        dataset = boc.get_ophys_experiment_data(ophys_experiment_id=ophys_experiment_id)
        print str(dataset.number_of_cells) + ' Neurons in Experiment'
        plt.imshow(dataset.get_max_projection())
        plt.show()

    metadata = dataset.get_metadata()
    spikes, timestamps, spike_times, isis = dt.get_epoch_spiking_data(boc, ophys_experiment_id,num_std=5)

    if verbose:
        print('Spikes determined – ' + str(t.time()-start_time) +' elapsed')
        dt.plot_raster(spike_times[stimulus], title=str(ophys_experiment_id) + '_' +stimulus)

    info = []
    info.append(timestamps)
    info.append(spike_times)

    time, spktms, cellID = de.get_ensemble_info(info, stimulus)

    T = np.array([time[0],time[-1]])


    time_w_ensembles, ensembles, percent_ensembles, coactive_binned, coactive_surr_binned_tot = de.find_high_activity(
        spktms, T, dt=0.005, binsize=0.5, nsurr=1000, pval=0.05)

    if verbose:
        print('high frequency frames determined – ' + str(t.time()-start_time) +' elapsed')
        print 'Number of high frequency frames: ' + str(len(ensembles[1]))
        print 'Percent Ensembles: ' + str(percent_ensembles)

    ensemble_matrix, above_thresh_ensembles_boot, z_values_boot = ecf.correlations_between_ensembles(
        ensemble_array=ensembles,surr_num=200,percentile=95,verbose=verbose)

    if verbose:
        print('Ensemble matrix determined – ' + str(t.time()-start_time) +' elapsed')

    cliques = ecf.get_correlation_cliques(ensembles,above_thresh_ensembles_boot,verbose=verbose)

    # for i, clique in enumerate(cliques):
    #     if len(clique) > 5:
    #         clique.pop(i)

    CE_final = ecf.get_unique_core_ensembles(ensembles,cliques,100)

    CE_sorted_by_participation, CE_sorted_by_size, clique_summary, core_summary, percent_participation = ecf.summary_stats(
        ensembles,cliques,CE_final,verbose=verbose)

    if verbose:

        print('Core Ensembles determined – ' + str(t.time()-start_time) +' elapsed')


    return cliques, CE_final, CE_sorted_by_size, CE_sorted_by_participation, percent_participation, ensembles, cellID, metadata
