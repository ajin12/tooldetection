video_num = 3; % CHANGE
dir = strcat('/Users/AmyJin/Documents/ComputerVisionProject/Surgical Video Analysis/Videos/Video', int2str(video_num), '/');
i = 1;
num_annot = 1;
list_tools = {'grasper' 'maryland' 'electrocautery' 'scissors' 'suction' 'unidentified'};
frame_increment = [794 983 1055 853 334 913 609 929 684 515];

for index = 1:50
    fprintf('Annotating frame %d...\n', index);
    if video_num < 10
        video_index = strcat('0', int2str(video_num));
    else
        video_index = int2str(video_num);
    end
    if i < 10
        filename = strcat(video_index, '_frame000', int2str(i), '.jpg');
    elseif i < 100
        filename = strcat(video_index, '_frame00', int2str(i), '.jpg');
    elseif i < 1000
        filename = strcat(video_index, '_frame0', int2str(i), '.jpg');
    else
        filename = strcat(video_index, '_frame', int2str(i), '.jpg');
    end
    fprintf('%s\n', filename);
    im = imread(strcat(dir,filename));
    [height, width, depth] = size(im);
    im_size = [width, height, depth];
    imshow(im);
    
    num_tools = input('How many tools are in the frame? ');
    if num_tools==0
        coord = [0, 0, width, height];
        annot3(num_annot) = struct('frame', filename, ... % CHANGE
                                   'coord', coord, ...
                                   'size', im_size, ...
                                   'class', 0);
        num_annot = num_annot+1;
    else
        for ind = 1:num_tools
            [x,y] = ginput(2); % Click the top-left and the bottom-right corner of the object(s)
            if ((x(2)-x(1)) <= 0) || ((y(2)-y(1)) <= 0)
                fprintf('Please redraw the bounding box.\n');
                [x,y] = ginput(2);
            end
            rectangle('Position', [x(1), y(1), x(2)-x(1), y(2)-y(1)],'EdgeColor','r', 'LineWidth', 2);
            coord = [round(x(1)), round(y(1)), round(x(2)), round(y(2))];
            class = input('What surgical tool is it? ');
            annot3(num_annot) = struct('frame', filename, ... % CHANGE
                                       'coord', coord, ...
                                       'size', im_size, ...
                                       'class', class);
            num_annot = num_annot+1;
        end
    end
    i = i + floor(frame_increment(video_num)/50); % Uniformly sampling 50 frames per video
end
if video_num < 10
    chole_video_num = 'chole0';
end
annot_filename = strcat(chole_video_num, int2str(video_num), '_annot.txt');
writetable(struct2table(annot3), strcat('/Users/AmyJin/Documents/ComputerVisionProject/Surgical Video Analysis/Annotations/', annot_filename)) % CHANGE

% VISUALIZATION %
% rectangle('Position', [x(1), y(1), x(2)-x(1), y(2)-y(1)],'EdgeColor','r', 'LineWidth', 2);