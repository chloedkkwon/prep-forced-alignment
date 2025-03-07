% Written by Chloe D. Kwon (chloe.dkkwon@gmail.com)
% March 7, 2025
% Creates a grid based on a matlab struct object

function [] = write_grid(filename, T)
    fid = fopen(filename, 'w');
    if fid == -1
        error('Cannot open file for writing: %s', filename);
    end
    
    fprintf(fid, 'File type = "ooTextFile"\n');
    fprintf(fid, 'Object class = "TextGrid"\n\n');
    fprintf(fid, '%.6f\n%.6f\n', T(1).xmin, T(1).xmax);  % xmin and xmax
    fprintf(fid, '<exists>\n');
    fprintf(fid, '%d\n', length(T));  % Number of tiers

    % Loop through each tier and write its information
    for i = 1:length(T)
        fprintf(fid, '"%s"\n', T(i).class);  % Tier class (IntervalTier)
        fprintf(fid, '"%s"\n', T(i).name);   % Tier name
        fprintf(fid, '%.6f\n%.6f\n', T(i).xmin, T(i).xmax); % xmin and xmax
        fprintf(fid, '%d\n', T(i).intervals);  % Number of intervals

        for j = 1:T(i).intervals
            xmin_interval = T(i).xmin + (j - 1) * (T(i).xmax - T(i).xmin) / T(i).intervals;
            xmax_interval = T(i).xmin + j * (T(i).xmax - T(i).xmin) / T(i).intervals;
            fprintf(fid, '%.6f\n%.6f\n""\n', xmin_interval, xmax_interval);  % Empty label
        end
    end

    fclose(fid);
    fprintf('TextGrid saved to %s\n', filename);
end
