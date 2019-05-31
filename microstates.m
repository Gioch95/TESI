
%% Define the basic parameters
% This is for vision analyzer data and may need adjustments
clear all
close all
clc

%LowCutFilter  =  2;
%HighCutFilter = 20;
%FilterCoefs   = 2000;

% For already saved and filtered EEG-lab data
 ReadVision = false;
 FilterTheData = false;
% for "fresh" vision analyzer data:
%ReadVision = true;
%FilterTheData = true;

% These are the paramters for the fitting based on GFP peaks only
FitPars = struct('nClasses',4,'lambda',1,'b',20,'PeakFit',true, 'BControl',true,'Rectify',false,'Normalize',false);

% Define the parameters for clustering
ClustPars = struct('MinClasses',3,'MaxClasses',8,'GFPPeaks',true,'IgnorePolarity',true,'MaxMaps',500,'Restarts',5', 'UseAAHC',false,'Normalize',false);

% This is the path were all the output will go
SavePath   = 'C:\Users\gioiachiodi\Documents\MATLAB\Microstates\';

if SavePath == 0
    return
end

% Here, we collect the EEG data (one folder per group)
nGroups = 2;
GroupDirArray{1}= 'C:\Users\gioiachiodi\Documents\MATLAB\FNSZedf\';
GroupDirArray{2}= 'C:\Users\gioiachiodi\Documents\MATLAB\GNSZedf\';

%for Group = 1:nGroups
    %GroupDirArray{Group} = uigetdir([],sprintf('Path to the data of group %i (Vision Analyzer data)',Group)); %#ok<SAGROW>
    
    %if GroupDirArray{Group} == 0
     %   return
    %end
%end
%% Read the data

eeglabpath = fileparts(which('eeglab.m'));
DipFitPath = fullfile(eeglabpath,'plugins','dipfit2.3');

eeglab

AllSubjects = [];

for Group = 1:nGroups
    GroupDir = GroupDirArray{Group};
    
    GroupIndex{Group} = []; %#ok<SAGROW>
    
    if ReadVision == true
        DirGroup = dir(fullfile(GroupDir,'*.vhdr'));
    else
        DirGroup = dir(fullfile(GroupDir,'*.edf'));
    end

    FileNamesGroup = {DirGroup.name}';
    %FileNamesGroup = DirGroup.name;
    % Read the data from the group 
    for f = 1:length(DirGroup)%numel(FileNamesGroup)
        if ReadVision == true
            tmpEEG = pop_fileio(fullfile(GroupDir,FileNamesGroup{f}));   % Basic file read
            tmpEEG = eeg_RejectBABadIntervals(tmpEEG);   % Get rid of bad intervals
            setname = strrep(FileNamesGroup{f},'.vhdr',''); % Set a useful name of the dataset
            [ALLEEG, tmpEEG, CURRENTSET] = pop_newset(ALLEEG, tmpEEG, 0,'setname',FileNamesGroup{f},'gui','off'); % And make this a new set
            tmpEEG=pop_chanedit(tmpEEG, 'lookup',fullfile(DipFitPath,'standard_BESA','standard-10-5-cap385.elp')); % Add the channel positions
        else
           
           tmpEEG=pop_biosig(strcat(GroupDir,FileNamesGroup{f}));
           tmpEEG=pop_chanedit(tmpEEG, 'lookup','C:\\Users\\gioiachiodi\\Documents\\MATLAB\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp','load',{'C:\\Users\\gioiachiodi\\Documents\\MATLAB\\Tesi\\myloc.ced' 'filetype' 'autodetect'});
            [ALLEEG, tmpEEG, CURRENTSET] = pop_newset(ALLEEG, tmpEEG, 0,'gui','off'); % And make this a new set
        end

        tmpEEG = pop_reref(tmpEEG, []); % Make things average reference
        if FilterTheData == true
            tmpEEG = pop_eegfiltnew(tmpEEG, LowCutFilter,HighCutFilter, FilterCoefs, 0, [], 0); % And bandpass-filter 2-20Hz
        end
        tmpEEG.group = sprintf('Group_%i',Group); % Set the group (will appear in the statistics output)
        [ALLEEG,EEG,CURRENTSET] = eeg_store(ALLEEG, tmpEEG, CURRENTSET); % Store the thing
        GroupIndex{Group} = [GroupIndex{Group} CURRENTSET]; % And keep track of the group
        AllSubjects = [AllSubjects CURRENTSET]; %#ok<AGROW>
    end
    
end

eeglab redraw
   
%% Cluster the stuff

% Loop across all subjects to identify the individual clusters
for i = 1:numel(AllSubjects ) 
    EEG = eeg_retrieve(ALLEEG,AllSubjects(i)); % the EEG we want to work with
    fprintf(1,'Clustering dataset %s (%i/%i)\n',EEG.setname,i,numel(AllSubjects )); % Some info for the impatient user
    EEG = pop_FindMSTemplates(EEG, ClustPars); % This is the actual clustering within subjects
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, AllSubjects (i)); % Done, we just need to store this
end

eeglab redraw

%% Now we combine the microstate maps across subjects and sort the mean

% First, we load a set of normative maps to orient us later
templatepath = fullfile(fileparts(which('eegplugin_Microstates.m')),'Templates');

EEG = pop_loadset('filename','Normative microstate template maps Neuroimage 2002.set','filepath',templatepath);
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); % And make this a new set

% And we have a look at it
NormativeTemplateIndex = CURRENTSET;
pop_ShowIndMSMaps(ALLEEG(NormativeTemplateIndex), 4); 
drawnow;
% Now we go into averaging within each group
for Group = 1:nGroups
    % The mean of group X
    EEG = pop_CombMSTemplates(ALLEEG, GroupIndex{Group}, 0, 0, sprintf('GrandMean Group %i',Group));
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, numel(ALLEEG),'gui','off'); % Make a new set
    [ALLEEG,EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % and store it
    GrandMeanIndex(Group) = CURRENTSET; % And keep track of it
end

% Now we want the grand-grand mean, based on the group means, if there is
% more than one group
if nGroups > 1
    EEG = pop_CombMSTemplates(ALLEEG, GrandMeanIndex, 1, 0, 'GrandGrandMean');
    [ALLEEG, ~, CURRENTSET] = pop_newset(ALLEEG, EEG, numel(ALLEEG)+1,'gui','off'); % Make a new set
    GrandGrandMeanIndex = CURRENTSET; % and keep track of it
else
    GrandGrandMeanIndex = GrandMeanIndex(1);
end

% We automatically sort the grandgrandmean based on a template from the literature
[ALLEEG,EEG] = pop_SortMSTemplates(ALLEEG, GrandGrandMeanIndex, 1, NormativeTemplateIndex);
[ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, GrandGrandMeanIndex);

% This should now be as good as possible, but we should look at it
pop_ShowIndMSMaps(EEG, 4, GrandGrandMeanIndex, ALLEEG); % Here, we go interactive to allow the user to put the classes in the canonical order

eeglab redraw


%% And we sort things out over means and subjects
% Now, that we have mean maps, we use them to sort the individual templates
% First, the sequence of the two group means has be adjusted based on the
% grand grand mean
if nGroups > 1
    ALLEEG = pop_SortMSTemplates(ALLEEG, GrandMeanIndex, 1, GrandGrandMeanIndex);
    [ALLEEG,EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % and store it
end

% Then, we sort the individuals based on their group means
for Group = 1:nGroups
    ALLEEG = pop_SortMSTemplates(ALLEEG, GroupIndex{Group}, 0, GrandMeanIndex(Group)); % Group 1
    [ALLEEG,EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET); % and store it
end

eeglab redraw

%% We eventually save things

for f = 1:numel(ALLEEG)
    EEG = eeg_retrieve(ALLEEG,f);
    fname = EEG.setname;
    pop_saveset( EEG, 'filename',fname,'filepath',SavePath);
end

%% Visualize some stuff to see if the fitting parameters appear reasonable

% Just a look at the first EEG
EEG = eeg_retrieve(ALLEEG,1); 
pop_ShowIndMSDyn([],EEG,0,FitPars);
pop_ShowIndMSMaps(EEG,FitPars.nClasses);
% And using the grand grand mean template
pop_QuantMSTemplates(ALLEEG, AllSubjects, 1, FitPars, GrandGrandMeanIndex, fullfile(SavePath,'ResultsFromGrandGrandMeanTemplate.xlsx'));

