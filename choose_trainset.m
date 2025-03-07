% Written by Chloe D. Kwon (chloe.dkkwon@gmail.com)
% March 7, 2025
% Randomly selects a ntrain amount of training data, copies the files to a training folder

function [] = choose_trainset(audio_dir, grid_dir, train_dir, ntrain)
dbstop if error

train_audio = fullfile(train_dir, 'audio'); 
train_grid = fullfile(train_dir, 'grid'); 

if ~exist(train_dir, 'dir'), mkdir(train_dir); end
if ~exist(train_audio, 'dir'), mkdir(train_audio); end
if ~exist(train_grid, 'dir'), mkdir(train_grid); end

audio_files = struct2table(dir(fullfile(audio_dir, '*.wav'))); 
nfiles = height(audio_files);

if ntrain > nfiles
    error('ntrain (%d) is greater than the number of available audio files (%d).', ntrain, nfiles);
end

% Generate a unique random permutation of indices
random_indices = randperm(nfiles, ntrain);

for i = 1:ntrain
    random_train = audio_files(random_indices(i), :); 
    
    selected_audio = fullfile(audio_dir, random_train.name{1}); 
    selected_grid = fullfile(grid_dir, replace(random_train.name{1}, '.wav', '.TextGrid')); 

    copy_audio = fullfile(train_audio, random_train.name{1}); 
    copy_grid = fullfile(train_grid, replace(random_train.name{1}, '.wav', '.TextGrid'));
    
    copyfile(char(selected_audio), char(copy_audio));
    copyfile(char(selected_grid), char(copy_grid));
end



end
