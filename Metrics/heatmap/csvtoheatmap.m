%%need to change frame size for new dataset and enter filename
clear all; close all;
%% Import CSV file and process to export one score only
filename = 'low_annot.csv';
T = csvimport (filename);
%% Define frame size
width = 491;
length = 351;
heat = zeros(length, width);
%%Get the heatmap matrix
[m, n] = size(T);
for i = 2:m 
    k = 0;
    for j=1:n
         cell = strcmp (T{i,j},'');
        if cell == 0
            k = k+1;
         end
    end
%calculate number of tools on the same frame    
    p = (k-3)/5;
    for nt = 1:p
        xmin = max(1, round(str2num(char(T(i,(2+(nt-1)*4+1))))));
        ymin = max(1, round(str2num(char(T(i,(2+(nt-1)*4+2))))));
        xmax = min(width, round(str2num(char(T(i,(2+(nt-1)*4+3))))));
        ymax = min(length, round(str2num(char(T(i,(2+(nt-1)*4+4))))));
        for x = xmin:xmax
            for y = ymin:ymax
                heat(y, x) = heat(y, x) +1;
            end
        end
    end                
end
%%plot heatmap
colormap('hot');
imagesc(heat);
colorbar;
                               
