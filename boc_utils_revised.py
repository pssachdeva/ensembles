import numpy as np
import pandas as pd
import os
import sys
import h5py
import matplotlib.pyplot as plt

def cre_2_layer(cre_line):
    '''Returns the layer associated with a given Cre line. 

    Parameters
    ----------
    cre_line:
        string detailing the specific Cre line.

    Returns
    -------
    unspecified variable:
        the specific layer associated with a given Cre line. 
    '''
    if cre_line == 'Cux2-CreERT2':
        return 'Layer 2/3 & 4'
    elif cre_line == 'Emx1-IRES-Cre':
        return 'Pan excitatory expression'
    elif cre_line == 'Nr5a1-Cre':
        return 'Layer 4'
    elif cre_line == 'Rbp4-Cre_KL100':
        return 'Layer 5'
    elif cre_line == 'Rorb-IRES2-Cre':
        return 'Layer 4'
    elif cre_line == 'Scnn1a-Tg3-Cre':
        return 'Layer 4'
    else:
        return ValueError('Cre line not found.')

def get_experiment_ids(boc, file_name = None, targeted_structures = None, imaging_depths = None, cre_lines = None, transgenic_lines = None, include_failed = False):
    '''Returns the experiment ids for experiments that satisfy a variety of constraints.

    Parameters
    ----------
    file_name:
        File name to save/read the experiment containers.  If file_name is None,
        the file_name will be pulled out of the manifest.  If caching
        is disabled, no file will be saved. Default is None.

    targeted_structures:
        List of structure acronyms.  Must be in the list returned by
        BrainObservatoryCache.get_all_targeted_structures().

    imaging_depths:
        List of imaging depths.  Must be in the list returned by
        BrainObservatoryCache.get_all_imaging_depths().

    cre_lines:
        List of cre lines.  Must be in the list returned by
        BrainObservatoryCache.get_all_cre_lines().

    transgenic_lines:
        List of transgenic lines. Must be in the list returned by
        BrainObservatoryCache.get_all_cre_lines() or.
        BrainObservatoryCache.get_all_reporter_lines().

    include_failed: boolean
        Whether or not to include failed experiment containers.
    
    Returns
    -------
    exp_ids:
        a list of experiment ids
    '''
    # TODO: handle error case (perhaps as an exception)
    exps = boc.get_experiment_containers(file_name = file_name, targeted_structures = targeted_structures, imaging_depths = imaging_depths, cre_lines = cre_lines, transgenic_lines = transgenic_lines, include_failed = include_failed)
    exps_df = pd.DataFrame(exps)
    exp_ids = exps_df['id'].values
    return exp_ids

def get_exp_container_dataframe(boc, exp_container_id):
    '''Creates a pandas dataframe for a single experimental container.
    
    Parameters
    ---------- 
    boc:
        BrainObservatoryCache variable 

    exp_container: 
        the experimental container id for one mouse
    
    Returns
    ------- 
    expt_container_df: 
        dataframe for all experimental data corresponding to a single experimental container id
    '''
    # grab the session info for the given experiment 
    exp_session_info = boc.get_ophys_experiments(experiment_container_ids=[exp_container_id]) 
    # create data frame of experimental sessions in our container
    exp_session_df = pd.DataFrame(exp_session_info) 
    return exp_session_df

def get_session_ids(boc, exp_list):
    '''Extracts the session ids for a given list of experiment container ids.

    Parameters
    ----------

    boc:
        BrainObservatoryCache variable 

   	exp_list: 
        a list of experimental containers ids for the mice of interest
    
    Returns
    ------- 
    session_ids: 
        a dictionary whose keys are experiment container ids and corresponding values are dictionaries pairing session type [A,B,C/C2] with session ID
    
    NOTE: C and C2 are mutually exclusive options. Mice run before 09/2016 at the Allen are run on procedure C.
    After this date, an additional sparse noise stimuli is added to the session and it is renamed session C2 for all future mice
    '''
    # create empty dictionary using the experiment container ids
    session_ids = {exp_id : {} for exp_id in exp_list}
    # extract the session metadata for all experiments
    exp_session_info = boc.get_ophys_experiments(experiment_container_ids=exp_list)
    # iterate over the sessions
    for session in exp_session_info:
    	# grab the experiment container id, session type, and session id
    	exp_id = session['experiment_container_id']
    	## TODO(?): rename session_id_C2 to session_id_C (although this may not be necessary)
        if session['session_type'] == 'three_session_A':
            session_type = 'session_A'
        elif session['session_type'] == 'three_session_B':
            session_type = 'session_B'
        else:
            session_type = 'session_C'
    	session_id = session['id']
    	# toss the session id into the corresponding dictionary
    	session_ids[exp_id][session_type] = session_id
    return session_ids

def get_dataset(boc, exp_list, session_type):
    '''Retrieve datasets of a specific session type for a list of experimental containers.

    Parameters
    ---------- 

    boc:
        BrainObservatoryCache variable 

    exp_list:
        list of experimental containers
    
    session_type: 
        choose from one of the following: ['session_A', 'session_B', or 'session_C']
 
    Returns
    -------
    datasets:
        dictionary whose keys are experiment container ids and values are the dataset object
    '''
    datasets = {}
    # grab the session ids
    session_ids = get_session_ids(boc, exp_list)
    # iterate over the experiment ids
    for exp in exp_list:
        # grab the dataset; oddly enough this function only takes one id at a time 
        dataset = boc.get_ophys_experiment_data(ophys_experiment_id=(session_ids[exp][session_type]))
        datasets[exp] = dataset

    return datasets

def get_epoch_table(datasets):
    '''Creates a dictionary whose keys are experiment container ids and values are the epoch table corresponding to that experiment. 
    
    Parameters
    ---------- 
    exps: 
        list of experimental containers
    
    datasets: 
        dataset varialbe attained from function get_dataset()
     
    Returns
    ------- 
    epoch_table: 
        list of epochs (stimulus type for session type A, B, or C) with start and stop frame numbers for each epoch
    '''
    epoch_table = {}
    # iterate over the sessions provided in the datasets
    for session_id in datasets:
        # extract the epoch table using the provided function
        epoch_table[session_id] = datasets[session_id].get_stimulus_epoch_table()
    return epoch_table

def create_delta_traces(datasets):
    '''Extracts the dFF traces, sorted by stimulus type, from a provided dictionary of NWB datasets.

    Parameters
    ----------
    datasets:
        a dictionary whose keys are session/experiment container ids and values are NWB dataset objects.

    Returns
    -------
    dff_by_exp:
        a nested dictionary. the main keys are the session ids from the datasets dictionary. each value
        is another dictionary, whose keys are the stimulus type for that session and values are the dFF traces
        corresponding to that stimulus. note that stimulus types were segmented over a given session: these dFF
        traces, therefore, are concatenated over the segmented trials. 
    '''
    # intialize the nested dictionary
    dff_by_exp = {}
    # iterate over the session ids in the datasets dictionary
    for session_id in datasets:
        # extract the epoch table corresponding to that session. we need this to know when stimuli started and stopped
        epoch_table = datasets[session_id].get_stimulus_epoch_table()
        # extract the dff traces
        _, dffs = datasets[session_id].get_dff_traces()
        # group the epoch table by stimulus type
        grouped = epoch_table.groupby('stimulus')
        dff_by_stim = {} # second dictionary, keys will be stimuli
        # iterate over the stimuli groups
        for stim, group in grouped:
            # grab the starting and ending times for each stimulus
            starts = group.start.values
            ends = group.end.values
            # create a list of indices for the stimulus by stringing together the starting and stopping times
            indices = np.concatenate([np.arange(start, ends[idx]) for idx, start in enumerate(starts)])
            # use our indices array to add the traces to the dictionary
            dff_by_stim[stim] = dffs[:, indices]
        # finally, add the dictionary to the nested dictionary
        dff_by_exp[session_id] = dff_by_stim
    return dff_by_exp

### TODO: go through functions below

def get_stim_dict(exps, datasets):
    """ Creates dictionary to determine timing of different images in natural scenes epoch
    INPUT:
        exps: list of experimental containers
        datasets: dataset varialbe attained from function get_dataset()
    OUTPUT:
        stim_dict: a dictionary where each value is an experimental container id
            each key is the frame numbers for individual images presented during natural scenes"""
    stim_dict={}
    for exp in exps:
        temp_exp_df=datasets[exp]
        stim_dict[exp]=temp_exp_df.get_stimulus_table(stimulus_name='natural_scenes')
    return stim_dict

def get_responsivity_status(exp_list, cell_specimens, session_type):
    """ Creates a dictionary cell_categories
        Value=exp container id
        keys= dictionaries for different categories of responsivity
    
    Parameters
    ----------
    exp_list: 
        list of experimental container ids
    
    cell_specimens:
        DataFrame for all cell related information, obtained from the Brain Observatory cache
    
    session_type: 
        choose from one of the following: 'session_A', 'session_B', or 'session_C'
    
    Returns
    -------
    cell_categories: 
        dictionary of dictionaries indicating responsivity profiles
    """
    ns_nor_ = {}
    sg_nor_ = {}
    dg_nor_ = {}
    nor_ = {}
    all_ = {}

    for exp in exp_list:
        #Isolate cells for experimental container id
        expt_container_id = exp
        specimens = cell_specimens[(cell_specimens['experiment_container_id']==expt_container_id)]
        all_[exp] = specimens['cell_specimen_id']
    
        #Totally non-responsive cells
        isnor = ((specimens.p_dg > 0.05) | (specimens.peak_dff_dg < 3)) & ((specimens.p_sg > 0.05) | (specimens.peak_dff_sg < 3)) & ((specimens.p_ns > 0.05) | (specimens.peak_dff_ns < 3)) & (specimens.rf_chi2_lsn > 0.05)
        nor = specimens[isnor] 
        nor_[exp] = nor['cell_specimen_id']
    
        #Non-responsive to ns
        if session_type == 'session_B':
            isepochnor = ((specimens.p_ns > 0.05) | (specimens.peak_dff_ns < 3))
            ns_nor = specimens[~isnor & isepochnor]
            ns_nor_[exp] = ns_nor['cell_specimen_id']
    
        #Non-responsive to dg
        if session_type == 'session_A':
            isepochnor = ((specimens.p_dg > 0.05) | (specimens.peak_dff_dg < 3))
            dg_nor = specimens[~isnor & isepochnor]
            dg_nor_[exp] = dg_nor['cell_specimen_id']
    
        #Non-responsive to sg
        if session_type == 'session_B':
            isepochnor = ((specimens.p_sg > 0.05) | (specimens.peak_dff_sg < 3))
            sg_nor = specimens[~isnor & isepochnor]
            sg_nor_[exp] = sg_nor['cell_specimen_id']

    if session_type=='session_A':
        cell_categories={'nor_' : nor_, 'all_' : all_, 'dg_nor_' : dg_nor_}
    if session_type=='session_B':
        cell_categories={'nor_' : nor_, 'ns_nor_' : ns_nor_, 'sg_nor_' : sg_nor_, 'all_' : all_}
    if session_type=='session_C':
        cell_categories={'nor_' : nor_, 'all_' : all_}
    return cell_categories

def get_cell_indices(exps, datasets):
    """Creates a dictionary with values as exp container ids
        keys are a dictionary containing cell ids paired with cell indices
        INPUT:
            exps: list of experimental containers
            datasets: dataset varialbe attained from function get_dataset()
        OUTPUT:
            Dictionary, cell_indices_by_expcontainer, pairing cell indices with cell ids"""
    cell_indices_by_expcontainer={}
    
    for exp in exps:
    
        # Create dictionary for id to index map for each exp container
        specimen_index_map = {}
    
        # Get cell specimen ids for session B
        specimens_lis=datasets[exp].get_cell_specimen_ids()
    
        #Get cell indices for session B
        specimen_id_temp=datasets[exp].get_cell_specimen_indices(specimens_lis)
    
        # Create map
        specimen_index_map.update({spid: spind for spid, spind in zip(specimens_lis, specimen_id_temp)})
    
        # Update exp container with id to index map
        cell_indices_by_expcontainer[exp]=specimen_index_map
        
    return cell_indices_by_expcontainer

def get_interstim_traces_revised(boc, session_ids):
    '''Grabs the inter-stim calcium traces after drifting or static gratings for a set of session ids.
    
    Parameters
    ----------
    boc:
        BrainObservatoryCache variable

    session_ids:
        list of experimental session ids

    Returns
    -------
    traces:
        nested dictionary. the first key is the session id, as given given by session_ids. the corresponding
        value is another dictionary, whose keys indicate whether the inter-stim trace occurred after
        static or drifting gratings. the values are the calcium traces themselves. 
        note that session_C had no inter-stim traces after static/drifting gratings, so these sessions
        are left empty in the dictionary. 
    '''
    traces = {}
    # iterate over session ids
    for session_id in session_ids:
        # grab the dataset
        dataset = boc.get_ophys_experiment_data(ophys_experiment_id = session_id)
        # identify what kind of session (A, B, or C) the current session id is
        session_type = dataset.get_session_type()[-1]
        if session_type == 'A':
            # declare empty dictionary
            traces[session_id] = {}
            # deduce what the inter-stim period is; for A, it's right after the very first drifting gratings
            epoch_table = dataset.get_stimulus_epoch_table()
            interstim_interval = np.arange(epoch_table.iloc[0].end, epoch_table.iloc[1].start)
            ts, dffs = dataset.get_dff_traces()
            # place trace in the second layer of the nested dictionary
            traces[session_id]['drifting_gratings'] = dffs[:, interstim_interval]
            traces[session_id]['drifting_gratings_all'] = dffs[:,:]
            
        elif session_type == 'B':
            traces[session_id] = {}
            epoch_table = dataset.get_stimulus_epoch_table()
            # inter-stim interval after first static gratings
            interstim_interval_1 = np.arange(epoch_table.iloc[0].end, epoch_table.iloc[1].start)
            ts, dffs_1 = dataset.get_dff_traces()
            traces[session_id]['static_gratings_1'] = dffs_1[:, interstim_interval_1]
            traces[session_id]['static_gratings_1_all'] = dffs_1
            
            # inter-stim interval after second static gratings
            interstim_interval_2 = np.arange(epoch_table.iloc[4].end, epoch_table.iloc[5].start)
            ts, dffs_2 = dataset.get_dff_traces()
            traces[session_id]['static_gratings_2'] = dffs_2[:, interstim_interval_2]
            traces[session_id]['static_gratings_2_all'] = dffs_2
            
        else:
            # session C has no inter-stim interval right after drifting/static gratings
            traces[session_id] = ''
    return traces

def get_session_ids_list (exps, session_ids):
    '''Grabs the inter-stim calcium traces after drifting or static gratings for a set of session ids.
    
    Parameters
    ----------
    exps:
        list of experimental containers

    session_ids:
        list of experimental session ids

    Returns
    -------
    session_ids_list:
        list of session_ids with each of three session id types for each given exp containers. Session ids are not sorted by exp container. 
    '''
    session_ids_list=[]
    for exp in exps:
        for key, value in session_ids[exp].iteritems():
            session_ids_list.append(value)
    return session_ids_list

def get_stim_table(boc, session_ids_list):
    '''Creates a dictionary whose keys are experiment container ids and values are the epoch table corresponding to that experiment. 
    
    Parameters
    ---------- 
    exps: 
        list of experimental containers
    
    datasets: 
        dataset varialbe attained from function get_dataset()
     
    Returns
    ------- 
    stim_table= returns Dataframae of stimtable nested dictionary that maps stimulus types
    '''
    stim_table = {}
    for session_id in session_ids_list:
        stim_table[session_id]={}
        
        dataset = boc.get_ophys_experiment_data(ophys_experiment_id = session_id)
        
        session_type = dataset.get_session_type()[-1]
        
        if session_type == 'A':
            # extract the epoch table using the provided function
            stim_table[session_id]['drifting_gratings']=dataset.get_stimulus_table(stimulus_name='drifting_gratings')
        
        elif session_type == 'B':
            stim_table[session_id]['static_gratings']=dataset.get_stimulus_table(stimulus_name='static_gratings')
        
        else:
            # session C has no inter-stim interval right after drifting/static gratings
            continue
    stim_table=pd.DataFrame(stim_table)
    return stim_table

def stim_to_key(epoch):
    """
    PARAMETER:
        epoch: either 'drifting_grating' OR 'static_gratings'
    
    OUTPUT:
        key name for pair_table dictionary from 'get_pair_table()' f(x) to reference delta traces for a given intertrail interval stim
        follow form: pair_table[session_id][dg_45_2_1] -- would reference the intertrial interval following 
        the first drifting gratings stimulus presentation with 45 degree direction and a 2 Hz frequency.
    """
    
    if epoch=='drifting_gratings':
        direction = raw_input("""What is the direction in degrees? 
        Choose from: 000; 045; 090; 135; 180; 225; 270; 315""")
        temporal_frequency= raw_input("""What is the temporal frequency in Hz? 
        Choose from: 01; 02; 04; 08; 15""")
        sequence_number= raw_input("""If known, what trial # of stimulus type does the interstimulus interval follow
        Use integer(s), if unknown hit return""")
        
        prime='[dg_' + str(direction) + '_' + str(temporal_frequency)+ '_'
    
        if sequence_number:
            output = prime + str(sequence_number)
        else:
            output = prime + '"INSERT TRIAL# HERE:1-n in integers"]'
        
        sequence_number=None
        return output
    
    if epoch=='static_gratings':
        num = raw_input("Static grating 1 or 2?")
        direction = raw_input("""What is the direction in degrees?
        Choose from: 000; 030; 060; 090; 120; 150""")
        spatial_frequency= raw_input("""What is the spatial frequency (cycles/degree, 2cm distance)?
        Choose from: 0.00; 0.02; 0.04; 0.08; 0.16; 0.32""")
        phase = raw_input("""What is the phase?
        Choose from: 0.00; 0.25; 0.50; 0.75""")
        sequence_number= raw_input("""If known, what trial # of stimulus type does the interstimulus interval follow
        Use integer(s), if unknown hit return""")
 

    
        prime='[sg' + str(num) + '_' + str(direction) + '_' + str(spatial_frequency)+ '_' + str(phase) + '_'
        if sequence_number:
            output = prime + str(sequence_number)
        else:
            output = prime + '"INSERT TRIAL# HERE:1-n in integers"]'
            
        return output
    
def key_to_stim(key):

    temp=[]
    key_letter_list=[]
    
    for letter in key:
        key_letter_list.append(letter)
        
    epoch = "".join(key_letter_list[1:4])
    
    direction = "".join(key_letter_list [5:8])
    
    #for letter in key_letter_list[8:len(key_letter_list)]:
    #    if letter!='_':
    #        temp.append(letter)
    #    else:
    #        break
    
    if key_letter_list[10]=='.':
        num= "".join(key_letter_list[2])
        spatial_frequency = "".join(temp)
        phase = "".join(key_letter_list[14:18])
        if len(key_letter_list)==21:
            sequence_number = key_letter_list[19]
        else:
            sequence_number = "".join(key_letter_list[19:-1])
        output = ("Epoch:%s; Direction:%s, Spatial frequency:%s, Phase:%s, Trial #:%s" % (epoch, direction, spatial_frequency, phase, sequence_number))
        return output
    else:
        temporal_frequency = "".join(temp)
        if len(key_letter_list)==13:
            sequence_number = key_letter_list[11]
        else:
            sequence_number = "".join(key_letter_list[11:-1])
        output = ("Epoch:%s; Direction:%s, Temporal frequency:%s, Trial #:%s" % (epoch, direction, temporal_frequency, sequence_number))
    return output
    
def get_pair_table(boc, session_ids_list, stim_table, interstim_traces):
    pair_table={}
    for session_id in session_ids_list:
        pair_table[session_id]={}
        dataset = boc.get_ophys_experiment_data(ophys_experiment_id = session_id)
        
        if np.size(stim_table[session_id]['drifting_gratings'])>1:
            nanrows=(stim_table[session_id]['drifting_gratings']['orientation']).isnull()
            stim_table[session_id]['drifting_gratings']['nanrows']=nanrows
            curr=stim_table[session_id]['drifting_gratings'][(stim_table[session_id]['drifting_gratings']['nanrows']==False)]
            # start_timestamp=int(curr['start'][0])
            # end_timestamp=int(curr['end'][len(curr)])
            
            for i in curr.iterrows():
                name='dg_'
    
                direction=curr['orientation'][i[0]]
                direct=str(int(direction))
                if len(direct)==1:
                    direct='00'+ direct
                elif len(direct)==2:
                    direct='0'+ direct
                name = name + (direct + '_')
                
                tff=curr['temporal_frequency'][i[0]]
                tf=str(curr['temporal_frequency'][i[0]])
                if len(tf)==1:
                    direction='00'+str(tf)
                elif len(tf)==2:
                    direction='0'+str(tf)
                name = name + (str(tf) + '_')
                
                currtemp=curr[curr['orientation']==direction]
                currtemp=currtemp[currtemp['temporal_frequency']==tff]
                seq_nu=1
                for ii in currtemp.iterrows():
                    if currtemp['start'][i[0]] == currtemp['start'][ii[0]]:
                        seq_num=seq_nu
                    else:
                        seq_nu+=1
                        break
                name = name + (str(seq_nu))
                
                
                # curr_start=(curr['start'][i[0]])-start_timestamp
                start=(curr['start'][i[0]])
                end=curr['end'][i[0]]
                # rg=range(interstim_traces[session_id]['drifting_gratings_all'][start:end])
                # pair_table[session_id][name]=interstim_traces[session_id]['drifting_gratings_all'][:, (interstim_traces[session_id]['drifting_gratings_all']==rg)]
                pair_table[session_id][name]=interstim_traces[session_id]['drifting_gratings_all'][:, start:end]
            
        elif np.size(stim_table[session_id]['static_gratings'])>1:
            nanrows=(stim_table[session_id]['static_gratings']['orientation']).isnull()
            stim_table[session_id]['static_gratings']['nanrows']=nanrows
            curr=stim_table[session_id]['static_gratings'][(stim_table[session_id]['static_gratings']['nanrows']==False)]
               
            for i in curr.iterrows():
                name='sg_'
                
                direction=curr['orientation'][i[0]]
                direct=str(int(direction))
                if len(direct)==1:
                    direct='00'+ direct
                elif len(direct)==2:
                    direct='0'+ direct
                name = name + (direct + '_')
                
                sff=curr['spatial_frequency'][i[0]]
                sf=str(curr['spatial_frequency'][i[0]])
                name = name + (str(sf) + '_')
                
                phase=curr['phase'][i[0]]
                name = name + (str(phase) + '_')
                
                seq=curr[curr['orientation']==direction]
                currtemp=curr[curr['spatial_frequency']==sff]
                currtemp=currtemp[currtemp['phase']==phase]
                seq_nu=1
                for ii in currtemp.iterrows():
                    if currtemp['start'][i[0]] == currtemp['start'][ii[0]]:
                        seq_num=seq_nu
                    else:
                        seq_nu+=1
                        break
                name = name + (str(seq_nu))
                
                start=curr['start'][i[0]]
                end=curr['end'][i[0]]
                # rg=range(interstim_traces[session_id]['static_gratings_all'][start:end])
                # pair_table[session_id][name]=interstim_traces[session_id]['static_gratings_all'][:, (interstim_traces[session_id]['static_gratings_all']==rg)]
                sg1name=name[:2] + '1' + name[2:]
                sg2name=name[:2] + '2' + name[2:]
                pair_table[session_id][sg1name]=interstim_traces[session_id]['static_gratings_1_all'][:, start:end]
                pair_table[session_id][sg2name]=interstim_traces[session_id]['static_gratings_2_all'][:, start:end]
                
    return pair_table

def get_pair_table_index(boc, session_ids_list, stim_table, interstim_traces):
    pair_table={}
    for session_id in session_ids_list:
        pair_table[session_id]={}
        dataset = boc.get_ophys_experiment_data(ophys_experiment_id = session_id)
        
        
        if np.size(stim_table[session_id]['drifting_gratings'])>1:
            nanrows=(stim_table[session_id]['drifting_gratings']['orientation']).isnull()
            stim_table[session_id]['drifting_gratings']['nanrows']=nanrows
            curr=stim_table[session_id]['drifting_gratings'][(stim_table[session_id]['drifting_gratings']['nanrows']==False)]
            
            # start_timestamp=int(curr['start'][0])
            # end_timestamp=int(curr['end'][len(curr)])
            
            for i in curr.iterrows():
                name='dg_'
    
                direction=curr['orientation'][i[0]]
                direct=str(int(direction))
                if len(direct)==1:
                    direct='00'+ direct
                elif len(direct)==2:
                    direct='0'+ direct
                name = name + (direct + '_')
                
                tff=curr['temporal_frequency'][i[0]]
                tf=str(curr['temporal_frequency'][i[0]])
                if len(tf)==1:
                    direction='00'+str(tf)
                elif len(tf)==2:
                    direction='0'+str(tf)
                name = name + (str(tf))
                
                if name not in pair_table[session_id].keys():
                    pair_table[session_id][name]={}
                
                currtemp=curr[curr['orientation']==direction]
                currtemp=currtemp[currtemp['temporal_frequency']==tff]
                
                seq_nu=1
                for ii in currtemp.iterrows():
                    if currtemp['start'][i[0]] == currtemp['start'][ii[0]]:
                        seq_num = seq_nu
                        break
                        
                    else:
                        seq_nu+=1
                
                start=(curr['start'][i[0]])
                end=curr['end'][i[0]]
                
                pair_table[session_id][name][seq_num]=interstim_traces[session_id]['drifting_gratings_all'][:, start:end]
            
        elif np.size(stim_table[session_id]['static_gratings'])>1:
            nanrows=(stim_table[session_id]['static_gratings']['orientation']).isnull()
            stim_table[session_id]['static_gratings']['nanrows']=nanrows
            curr=stim_table[session_id]['static_gratings'][(stim_table[session_id]['static_gratings']['nanrows']==False)]
               
            for i in curr.iterrows():
                name='sg_'
                
                direction=curr['orientation'][i[0]]
                direct=str(int(direction))
                if len(direct)==1:
                    direct='00'+ direct
                elif len(direct)==2:
                    direct='0'+ direct
                name = name + (direct + '_')
                
                sff=curr['spatial_frequency'][i[0]]
                sf=str(curr['spatial_frequency'][i[0]])
                name = name + (str(sf) + '_')
                
                phase=curr['phase'][i[0]]
                name = name + (str(phase)) 
                
                seq=curr[curr['orientation']==direction]
                currtemp=curr[curr['spatial_frequency']==sff]
                currtemp=currtemp[currtemp['phase']==phase]
                
                seq_nu=1
                for ii in currtemp.iterrows():
                    if currtemp['start'][i[0]] == currtemp['start'][ii[0]]:
                        seq_num = seq_nu
                        break
                        
                    else:
                        seq_nu+=1
                
                start=curr['start'][i[0]]
                end=curr['end'][i[0]]
                
                sg1name=name[:2] + '1' + name[2:]
                sg2name=name[:2] + '2' + name[2:]
                if sg1name not in pair_table[session_id].keys():
                    pair_table[session_id][sg1name]={}
                if sg2name not in pair_table[session_id].keys():
                    pair_table[session_id][sg2name]={}
                
                pair_table[session_id][sg1name][seq_num]=interstim_traces[session_id]['static_gratings_1_all'][:, start:end]
                pair_table[session_id][sg2name][seq_num]=interstim_traces[session_id]['static_gratings_2_all'][:, start:end]
        
    return pair_table

def get_pop_vectors(boc, session_ids_list, pair_table_index):
    population_vectors={}
    for session_id in session_ids_list:
        population_vectors[session_id]={}
    
        for stim_type, value in pair_table_index[session_id].iteritems():
            population_vectors[session_id][stim_type]={}
        
            for sequence_num, cell_traces in pair_table_index[session_id][stim_type].iteritems():
                network = np.vstack(cell_traces)
                population_vectors[session_id][stim_type][sequence_num] = np.mean(network, axis=0)
    return population_vectors

def get_train_and_test_datasets(boc, session_ids_list, population_vectors):
    train_test={}
    
    train_test['dg_test_data']={}
    train_test['dg_train_data']={}
    train_test['sg_test_data']={}
    train_test['sg_train_data']={}
    
    for session_id in session_ids_list:
        train_test['dg_test_data'][session_id]={}
        train_test['dg_train_data'][session_id]={}
        train_test['sg_test_data'][session_id]={}
        train_test['sg_train_data'][session_id]={}
        for stim_type, trials in population_vectors[session_id].iteritems():
             
            if stim_type[0]=='d':
                x=1 #set an indexer for dividing
                #if stim_type not in train_test['dg_test_data'][session_id].keys():
                    #train_test['dg_test_data'][session_id][stim_type]=[]
                    #train_test['dg_train_data'][session_id][stim_type]=[]
                dgtrain=[]
                dgtest=[]
                    
                for index_num, X in trials.iteritems():
                    if (x%2)!=0:
                        dgtrain.append(X)
                    else:
                        dgtest.append(X)
                        
                    x+=1
                    train_test['dg_test_data'][session_id][stim_type]=dgtrain
                    train_test['dg_train_data'][session_id][stim_type]=dgtest
                    
            else:
                x=1 #set an indexer for dividing
                #if stim_type not in train_test['sg_test_data'][session_id].keys():
                    #train_test['sg_test_data'][session_id][stim_type]=p[]
                    #train_test['sg_train_data'][session_id][stim_type]=[]
                sgtrain=[]
                sgtest=[]
                for index_num, X in trials.iteritems():
                    if (x%2)!=0:
                        sgtrain.append(X)
                        
                    else:
                        sgtest.append(X)
                    x+=1
                    train_test['sg_test_data'][session_id][stim_type]=sgtrain
                    train_test['sg_train_data'][session_id][stim_type]=sgtest
       
    return train_test

