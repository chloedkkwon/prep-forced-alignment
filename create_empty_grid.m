% Written by Chloe D. Kwon (chloe.dkkwon@gmail.com)
% March 7, 2025
% Creates empty grids for the files in audio_dir and outputs it to the grid_dir. 

function [] = create_empty_grid(audio_dir, grid_dir nword, nphone)

dbstop if error

if nargin <3
    nword = 3; % default number of words
    nphone = 10; % default number of phones
end 
if nargin <4, nphone = 10; end %default number of phones

% Display arguments for debugging
fprintf('Audio Directory: %s\n', audio_dir);
fprintf('Grid Directory: %s\n', grid_dir);
fprintf('Number of Words: %d\n', nword);
fprintf('Number of Phones: %d\n', nphone);

audio_files = dir(fullfile(audio_dir, '*.wav')); 
% Create an output grid folder if it doesn't exist already
if ~exist(grid_dir, 'dir'), mkdir(grid_dir); end

for i=1:length(audio_files)
    filname = audio_files(i).name; 
    [y, fs] = audioread(fullfile(audio_files(i).folder, filename));
    audio_dur = length(y) / fs; 

    [path, name, ext] = fileparts(filename); 
    grid_file = fullfile(grid_dir, [name '.TextGrid']); 

    T = struct(); 
    T(1).class = 'IntervalTier'; % tier type
    T(1).name = 'words'; % tier name
    T(1).xmin = 0; 
    T(1).xmax = audio_dur; 
    T(1).intervals = nword; % number of intervals

    T(2).class = 'IntervalTier';
    T(2).name = 'phones'; 
    T(2).xmin = 0; 
    T(2).xmax = audio_dur; 
    T(2).intervals = nphone; 
    
    xmin = 0; 
    xint = round(audio_dur / (T(1).intervals-1),1); 
    % Word boundary info goes here
    for w = 1:T(1).intervals
        T(1).INT(w).num = w; %tier index
        T(1).INT(w).xmin = xmin; 
    
        if j == T(w).intervals % final interval
            T(1).INT(w).xmax = T(1).xmax; 
        else
            T(1).INT(w).xmax = xmin + xint; 
        end
        T(1).INT(w).text = ''; 
         %T(1).INT(w).text = labels{w}; %add phone labels
     end

     % Phone boundary info goes here
     % phone_labels = {}; 
     word_dur = T(1).INT(j).xmax - T(1).INT(j).xmin; 
     phone_dur = word_dur / nphone;
     phone_xmin = T(1).INT(j).xmin; 
     k = 1;
     for p = 1:nphone
        T(2).INT(k).num = k; 
        T(2).INT(k).xmin = phone_xmin; 
        T(2).INT(k).xmax = phone_xmin + phone_dur; 
        T(2).INT(k).text = ''; 
        %T(2).INT(k).text = phone_labels{p};
        
        phone_xmin = phone_xmin + phone_dur; 
        k = k+1; 
     end
     
     write_grid(grid_file, T); 

end
    
end
