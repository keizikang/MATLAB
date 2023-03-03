clear
close all
clc

% 두 점 (a, b), (c, d)의 좌표
a = 4;
b = 1.5;
c = 1.5;
d = 3;

% patch 색 pre-define
lightgreen = [144, 238, 144]/255;
lightblue = [169, 190, 228]/255;
lightorange = [247, 195, 160]/255;

% animation params.
anim_Nsteps = 30;

% create window
figure('WindowStyle','docked')
ax = axes;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XTick = [];
ax.YTick = [];

hold on
ax.XLim = [-.4, a+c+1];
ax.YLim = [-.4, b+d+1];

% create ad-bc patch
area = patch([0, a, a+c, c], [0, b, b+d, d], lightgreen);
p_ab = plot(a, b, 'ko', 'MarkerFaceColor', 'k');
p_cd = plot(c, d, 'ko', 'MarkerFaceColor', 'k');
p_ab.UserData = text(a+0.1, b, '(a, b)', 'FontSize',16);
p_cd.UserData = text(c+0.1, d-0.2, '(c, d)', 'FontSize',16);
area.UserData = text((a+c)/2-0.5, (b+d)/2, 'ad-bc', 'FontSize', 18);

keyboard

%% Is this really ad-bc?

area.UserData.String = 'ad-bc...?';

keyboard

%% fade out ad-bc

fadeinout(area, 0)
area.UserData.Visible = 'off';

keyboard

%% fade in ad block

rect_ad = patch([0, a, a, 0], [0, 0, d, d], lightblue, 'EdgeAlpha', 0, 'FaceAlpha', 0);
uistack(rect_ad, 'bottom');

fadeinout(rect_ad, 1, t_pause=0.003)
draw_gridline(rect_ad, ["23", "34"])
rect_ad.UserData = text(mean(rect_ad.XData), mean(rect_ad.YData), 'ad', 'FontSize', 20, 'HorizontalAlignment', 'center');

keyboard

%% fade-in bc block

rect_bc = patch([0, c, c, 0], [0, 0, b, b], lightorange, 'EdgeAlpha', 0, 'FaceAlpha', 0);

fadeinout(rect_bc, 1, t_pause=0.0035)
draw_gridline(rect_bc, ["23", "34"])
rect_bc.UserData = text(b/2, c/2, 'bc', 'FontSize', 20, 'HorizontalAlignment', 'center');

keyboard

%% slide ad block

patch_slide(rect_ad, ...
    [0, 0, 0, 0], [0, b, b, 0], t_pause=0.004)

draw_gridline(rect_ad, ["12", "34"])

keyboard

%% slide ad block

patch_slide(rect_ad, ...
    [0, 0, d/(d/c-b/a), d/(d/c-b/a)],...
    [0, 0, b/a*d/(d/c-b/a), b/a*d/(d/c-b/a)], t_pause=0.004)

draw_gridline(rect_ad, ["14", "23"])

keyboard

%% slide bc block

uistack(p_cd, 'top')
patch_slide(rect_bc, ...
    [0, 0, 0, 0], [d, d, d, d], t_pause=0.004)

draw_gridline(rect_bc, "34")
keyboard

%% slide bc block

patch_slide(rect_bc, ...
    [0, 0, a, a], [0, 0, 0, 0], t_pause=0.004)

draw_gridline(rect_bc, "23")

keyboard

%% slide bc block

patch_slide(rect_bc, ...
    [d/(d/c-b/a), 0, 0, d/(d/c-b/a)], ...
    [b/a*d/(d/c-b/a), 0, 0, b/a*d/(d/c-b/a)], t_pause=0.004)

keyboard

%% finalize: fade out ad, bc, and fade in ad-bc

rect_ad.UserData.Visible = 'off';
rect_bc.UserData.Visible = 'off';

fadeinout([rect_ad, rect_bc, area], [0, 0, 1])

area.UserData.String = 'ad-bc';
area.UserData.Visible = 'on';

%% functions

function fadeinout(objs, inout, options)
arguments
    objs
    inout % 1이면 fade-in, 0이면 fade-out
    options.anim_Nsteps = 30
    options.t_pause = 0.003
end

for alpha = linspace(0, 1, options.anim_Nsteps)
    for i = 1:length(objs)
        switch objs(i).Type
            case 'patch'
                objs(i).FaceAlpha = (inout(i)==1)*alpha + (inout(i)==0)*(1-alpha);
                objs(i).EdgeAlpha = (inout(i)==1)*alpha + (inout(i)==0)*(1-alpha);
            case 'constantline'
                objs(i).Alpha = (inout(i)==1)*alpha + (inout(i)==0)*(1-alpha);
        end                
        pause(options.t_pause)
    end
end

end

function patch_slide(obj, x_dist, y_dist, options)
arguments
    obj
    x_dist
    y_dist
    options.anim_Nsteps = 30
    options.t_pause = 0.003
end

dx = x_dist/options.anim_Nsteps;
dy = y_dist/options.anim_Nsteps;
for i=1:options.anim_Nsteps
    obj.XData = obj.XData + dx(:);
    obj.YData = obj.YData + dy(:);
    obj.UserData.Position(1) = mean(obj.XData);
    obj.UserData.Position(2) = mean(obj.YData);
    pause(options.t_pause)
end

end

function draw_gridline(patch, where)

ax = patch.Parent;
for i=1:length(where)
    v1 = str2double(where{i}(1));
    v2 = str2double(where{i}(2));
    x1 = patch.XData(v1);
    x2 = patch.XData(v2);
    y1 = patch.YData(v1);
    y2 = patch.YData(v2);
    if x1==x2
        xline(x1, 'k--')
    else
        fplot(@(x) (y2-y1)/(x2-x1)*(x-x1)+y1, [ax.XLim(1), ax.XLim(2)], 'k--')
    end
end

end
