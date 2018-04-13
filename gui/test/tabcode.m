function [] = tabcode()
%TABCODE Summary of this function goes here
%   Detailed explanation goes here


% h = uitabgroup();
% t1 = uitab(h, 'title', 'Panel 1');
% a = axes('parent', t1); surf(peaks);
% t2 = uitab(h, 'title', 'Panel 2');
% closeb = uicontrol(t2, 'String', 'Close Me', ...
%          'Position', [180 200 200 60], 'Call', 'close(gcbf)');
 
f = figure;
data = {'..',true,'clustering coef','sparicity,0.5','linear','ttest'};
colnames = {'Directory', 'Threashold', 'FE Method','Parameters','Kernel','Feature Selection'};
t = uitable(f,'data',data, 'ColumnName', colnames, ...
           'Position', [120 120 560 200]);
t.ColumnEditable = true;
end

