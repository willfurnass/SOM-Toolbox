function vis_show_gui_comp(h, indx, action,varargin)

%VIS_SHOW_GUI_COMP is a subfunction of SOM_SHOW_GUI.
%
%  vis_show_gui_comp(handle, indx, action, varargin)
%
%  Input arguments:
%     handle    (struct) 
%     indx     (scalar)
%     action    (string)
%     varargin  (varies)
% 
% See also  SOM_SHOW_GUI.

% Copyright (c) 2000 by Roman Feldman and Juha Vesanto
% Contributed to SOM Toolbox on August 22nd, 2000
% http://www.cis.hut.fi/projects/somtoolbox/
 
% Version 2.0beta roman 160800 juuso 220800

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    MAIN                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

udata = get(h,'UserData');
plot_array = udata.plot_array;
l = length(plot_array);

 %%%%%%
% init %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%

if (strcmp(action,'init'))

  %---  color vars  ---
    fig_color = [0.8 0.8 0.8];
    bg_color1 = [0.701960784313725 0.701960784313725 0.701960784313725];
    bg_color2 = [0.9 0.9 0.9];
  %---  object position vars (in pixels) ---
    % calculations based on case 'comp'
    %% hint text
    hint_dist1 = 98.17-(61.27+36.9);   % hint text lower edge and next lower frame upper edge
    hint_dist2 = 123-(98.17+18.45);    % figure upper edge and hint text upper edge
    %% general
    dist1 = 67.42-61.27;               % general distance between frame edge and object in frame
    %% frame + ok / cancel
    frames_dist = 61.27-(8.38+36.9);
    frames_dist2 = 8.38;
    f_fr = [7.9 8.38 216.2 36.9];      % final frame
    ok_pb = [17.1 15.76 75.9 22.14];
    cancel_pb = [139 15.76 75.9 22.14];
    %% objects
    hint_txt = [230 18.45];           % hint text width and height
    interp_cb = [98.9 24.6];
    title_txt = [35 hint_txt(2)];
    title_edit_h =  23.083;
    var_pop = interp_cb;
    list_lt = [130 130];
    calc_txt = [list_lt(1) hint_txt(2)];
    useall_pb = [50 interp_cb(2)];

  if (length(indx) > 1)
    errordlg({'Same options for multiple subplots', ...
              'not yet available'},'Error in SOM_VIS: options');
    return;

  elseif (isempty(plot_array(1).args))
    errordlg({'Try to select subplot first'}, ...
              'Error in SOM_VIS: options');
    return;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % 'comp'
  %
  elseif (strncmp('comp',plot_array(indx).args{1},4))
    old_fig_n = watchon;
    W = 230; H = 123;
    units = get(h,'units');
    set(h,'units','pixels');
    fp = get(h,'Position');
    fig_pos = [(fp(1)+fp(3)) ...
               (fp(2)+fp(2)+fp(4)/2-H/2) ...
               W ...
               H];
    o1 = sum(f_fr([2 4]))+frames_dist;
    o2 = o1+dist1;
    o3 = 2*dist1+interp_cb(2);
    o4 = o1+o3+hint_dist1;
    hint_text_pos = [1 o4 hint_txt];
    frame1_pos = [f_fr(1) o1 f_fr(3) o3];
    interp_pos = [ok_pb(1) o2 interp_cb];
    frame2_pos = f_fr;
    ok_pos = ok_pb;
    cancel_pos = cancel_pb;
    
    fig_h = figure( ...
      'Units','pixels', ...
      'Position', fig_pos, ...
      'Color',fig_color, ...
      'NumberTitle','off', ...
      'Name','component', ...
      'MenuBar','none', ...
      'Visible','off');

    set( ...
    uicontrol( ...                                                            %% hint
      'Units','pixels', ...
      'BackgroundColor',fig_color, ...
      'HorizontalAlignment','center', ...
      'Position',hint_text_pos, ...
      'String','Options for component plane', ...
      'Style','text'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame1_pos, ...
      'Style','frame'),'units','normalized');

    pr = udata.property{indx};
    chkb_h =  uicontrol( ...                                                  %% interpolated
      'Units','pixels', ...
      'HorizontalAlignment','center', ...
      'Position',interp_pos, ...
      'Style','checkbox', ...
      'String','interpolated', ...
      'Value',pr{1});
    set(chkb_h,'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame2_pos, ...
      'Style','frame'),'units','normalized');

    s = ['vis_show_gui_comp(', ...
         mat2str(h), ',', mat2str(indx), ...
         ',''comp'',' mat2str(fig_h) ')'];
    set( ...
    uicontrol( ...                                                            %% OK
      'Units','pixels', ...
      'Position',ok_pos, ...
      'String','OK', ...
      'Callback',s),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% Cancel
      'Units','pixels', ...
      'Position',cancel_pos, ...
      'String','Cancel', ...
      'Callback',['close(' mat2str(fig_h) ')']),'units','normalized');

    watchoff(old_fig_n);
    tmp_udata = [chkb_h];
    set(fig_h,'units','normalized', ...
	      'Visible','on', ...
              'UserData',tmp_udata, ...
              'handlevisibility','off');

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % 'umat'
  %
  elseif (strncmp('umat',plot_array(indx).args{1},4))
    old_fig_n = watchon;
    W = 230; H = 335.893;
    units = get(h,'units');
    set(h,'units','pixels');
    fp = get(h,'Position');
    fig_pos = [(fp(1)+fp(3)) ...
               (fp(2)+fp(2)+fp(4)/2-H/2) ...
               W ...
               H];
    o1 = sum(f_fr([2 4]))+frames_dist;
    o2 = o1+dist1;
    o3 = 2*dist1+list_lt(2)+calc_txt(2);
    o4 = o2+list_lt(2);
    o5 = sum(cancel_pb([1 3]))-useall_pb(1);
    o6 = o2+o3/2-useall_pb(2)/2;
    o7 = o1+o3+frames_dist2;
    o8 = 2*dist1+interp_cb(2);
    o9 = o7+dist1;
    o10 = o7+o8+frames_dist2;;
    o11 = 2*dist1+max(title_edit_h,title_txt(2));
    o12 = W-(title_txt(1)+2*ok_pb(1));
    o13 = o10+dist1+(title_edit_h-title_txt(2))/2;
    o14 = o10+dist1;
    if title_txt(2)>title_edit_h,
      o13 = o10+dist1;
      o14 = o13+(title_edit_h-title_txt(2))/2;
    end
    o15 = ok_pb(1)+title_txt(1);
    o16 = o10+o11+hint_dist1;
    hint_text_pos = [1 o16 hint_txt];
    frame1_pos = [f_fr(1) o10 f_fr(3) o11];
    title_text_pos = [ok_pb(1) o13 title_txt];
    title_pos = [o15 o14 o12 title_edit_h];
    frame2_pos = [f_fr(1) o7 f_fr(3) o8];
    interp_pos = [ok_pb(1) o9 interp_cb];
    frame3_pos = [f_fr(1) o1 f_fr(3) o3];
    list_text_pos = [ok_pb(1) o4 calc_txt];
    list_pos = [ok_pb(1) o2 list_lt];
    use_all_pos = [o5 o6 useall_pb];
    frame4_pos = f_fr;
    ok_pos = ok_pb;
    cancel_pos = cancel_pb;

    fig_h = figure( ...
      'Units','pixels', ...
      'Position', fig_pos, ...
      'Color',fig_color, ...
      'NumberTitle','off', ...
      'Name','U-matrix', ...
      'MenuBar','none', ...
      'Visible','off');

    set( ...
    uicontrol( ...                                                            %% hint
      'Units','pixels', ...
      'BackgroundColor',fig_color, ...
      'HorizontalAlignment','center', ...
      'Position',hint_text_pos, ...
      'String','Options for U-matrix', ...
      'Style','text'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame1_pos, ...
      'Style','frame'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% title
      'Units','pixels', ...
      'Position',title_text_pos, ...
      'BackgroundColor',bg_color1, ...
      'HorizontalAlignment','left', ...
      'Style','text', ...
      'String','Title'),'units','normalized');

    pr = udata.property{indx};
    ed_h =  uicontrol( ...                                                    %% [edit]
      'Units','pixels', ...
      'Position',title_pos, ...
      'FontSize',12, ...
      'Style','edit', ...
      'String',pr{2}, ...
      'BackgroundColor',bg_color2);
    set(ed_h,'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame2_pos, ...
      'Style','frame'),'units','normalized');

    chkb_h =  uicontrol( ...                                                  %% interpolated
      'Units','pixels', ...
      'Position',interp_pos, ...
      'Style','checkbox', ...
      'String','interpolated', ...
      'Value',pr{1});
    set(chkb_h,'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame3_pos, ...
      'Style','frame'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% calculated from
      'Units','pixels', ...
      'BackgroundColor',bg_color1, ...
      'HorizontalAlignment','left', ...
      'Position',list_text_pos, ...
      'String','calculated from', ...
      'Style','text'),'units','normalized');

    list1_h = uicontrol( ...                                                  %% [listbox]
      'Units','pixels', ...
      'BackgroundColor',bg_color2, ...
      'Position',list_pos, ...
      'String',udata.sM.comp_names, ...
      'Style','listbox', ...
      'Max',2, ...
      'Value',pr{3});
    set(list1_h,'units','normalized');

    s = ['tmp=get(' mat2str(fig_h) ',''userdata'');set(tmp(3),''value'',' ...
         mat2str(1:length(udata.sM.comp_names)) ');'];
    set( ...
    uicontrol( ...                                                            %% Use all
      'Units','pixels', ...
      'Position',use_all_pos, ...
      'String','Use all', ...
      'Callback',s),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame4_pos, ...
      'Style','frame'),'units','normalized');

    s = ['vis_show_gui_comp(' ...
         mat2str(h) ',' mat2str(indx) ...
         ',''umat'',' mat2str(fig_h) ')'];
    set( ...
    uicontrol( ...                                                            %% OK
      'Units','pixels', ...
      'Position',ok_pos, ...
      'String','OK', ...
      'Callback',s),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% Cancel
      'Units','pixels', ...
      'Position',cancel_pos, ...
      'String','Cancel', ...
      'Callback',['close(' mat2str(fig_h) ')']),'units','normalized');

    watchoff(old_fig_n);
    tmp_udata = [chkb_h ed_h list1_h];
    set(fig_h,'units','normalized', ...
	      'Visible','on', ...
              'UserData', tmp_udata, ...
              'handlevisibility','off');

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % 'color'
  %
  elseif (strncmp('color',plot_array(indx).args{1},5))
    old_fig_n = watchon;
    W = 230; H = 212.043;
    units = get(h,'units');
    set(h,'units','pixels');
    fp = get(h,'Position');
    fig_pos = [(fp(1)+fp(3)) ...
               (fp(2)+fp(2)+fp(4)/2-H/2) ...
                W ...
                H];
    o1 = sum(f_fr([2 4]))+frames_dist;
    o2 = o1+dist1;
    o3 = 2*dist1+var_pop(2);
    o4 = o1+o3+frames_dist2;
    o5 = o4+dist1;
    o6 = 2*dist1+interp_cb(2);
    o7 = o4+o6+frames_dist2;
    o8 = 2*dist1+max(title_edit_h,title_txt(2));
    o9 = W-(title_txt(1)+2*ok_pb(1));
    o10 = o7+dist1+(title_edit_h-title_txt(2))/2;
    o11 = o7+dist1;
    if title_txt(2)>title_edit_h,
      o10 = o7+dist1;
      o11 = o10+(title_edit_h-title_txt(2))/2;
    end
    o12 = ok_pb(1)+title_txt(1);
    o13 = o7+o8+hint_dist1;
    hint_text_pos = [1 o13 hint_txt];
    frame1_pos = [f_fr(1) o7 f_fr(3) o8];
    title_text_pos = [ok_pb(1) o10 title_txt];
    title_pos = [o12 o11 o9 title_edit_h];
    frame2_pos = [f_fr(1) o4 f_fr(3) o6];
    interp_pos = [ok_pb(1) o5 interp_cb];
    frame3_pos = [f_fr(1) o1 f_fr(3) o3];
    popup_pos = [ok_pb(1) o2 var_pop];
    frame4_pos = f_fr;
    ok_pos = ok_pb;
    cancel_pos = cancel_pb;
        
    fig_h = figure( ...
      'Units','pixels', ...
      'Position',fig_pos, ...
      'Color',fig_color, ...
      'NumberTitle','off', ...
      'Name','color plane', ...
      'MenuBar','none', ...
      'Visible','off');

    set( ...
    uicontrol( ...                                                            %% hint
      'Units','pixels', ...
      'BackgroundColor',fig_color, ...
      'HorizontalAlignment','center', ...
      'Position',hint_text_pos, ...
      'String','Options for colorplane', ...
      'Style','text'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame1_pos, ...
      'Style','frame'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% title
      'Units','pixels', ...
      'Position',title_text_pos, ...
      'HorizontalAlignment','left', ...
      'Style','text', ...
      'String','Title'),'units','normalized');

    pr = udata.property{indx};
    ed_h =  uicontrol( ...                                                    %% [edit]
      'Units','pixels', ...
      'Position',title_pos, ...
      'FontSize',12, ...
      'Style','edit', ...
      'String',pr{2}, ...
      'BackgroundColor',bg_color2);
    set(ed_h,'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame2_pos, ...
      'Style','frame'),'units','normalized');

    chkb_h =  uicontrol(  ...                                                 %% interpolated
      'Units','pixels', ...
      'Position',interp_pos, ...
      'Style','checkbox', ...
      'String','interpolated', ...
      'Value',pr{1});
    set(chkb_h,'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame3_pos, ...
      'Style','frame'),'units','normalized');

    popup1_h = uicontrol( ...                                                 %% [popup]
      'Units','pixels', ...
      'Max',2, ...
      'Min',1, ...
      'Position',popup_pos, ...
      'String',pr{3}, ...
      'Style','popupmenu', ...
      'Value',pr{4});
    s = ['tmp=get(' mat2str(fig_h) ',''userdata'');' ...
         'vis_show_gui_tool([tmp(3) 6],''popup_select'');' ...
         'u=get(' mat2str(h) ',''UserData'');' ...
         'v=' mat2str(indx) ';' ...
         'pr=u.property{v};' ...
         'pr{3}=get(tmp(3),''string'');' ...
         'pr{4}=get(tmp(3),''value'');' ...
         'u.property{v}=pr;' ...
         'set(' mat2str(h) ',''userdata'',u)'];
    set(popup1_h,'units','normalized', ...
                 'Callback',s);

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame4_pos, ...
      'Style','frame'),'units','normalized');

    s = ['vis_show_gui_comp(', ...
         mat2str(h), ',', mat2str(indx), ...
         ',''color'',' mat2str(fig_h) ')'];
    set( ...
    uicontrol( ...                                                            %% OK
      'Units','pixels', ...
      'Position',ok_pos, ...
      'String','OK', ...
      'Callback',s),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% Cancel
      'Units','pixels', ...
      'Position',cancel_pos, ...
      'String','Cancel', ...
      'Callback',['close(' mat2str(fig_h) ')']),'units','normalized');

    watchoff(old_fig_n);
    tmp_udata = [chkb_h ed_h popup1_h];
    set(fig_h,'units','normalized', ...
	      'Visible','on', ...
              'UserData', tmp_udata, ...
              'handlevisibility','off');

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % 'empty'
  %
  elseif (strncmp('empty',plot_array(indx).args{1},5))
    old_fig_n = watchon;
    W = 230; H = 121.483;
    units = get(h,'units');
    set(h,'units','pixels');
    fp = get(h,'Position');
    fig_pos = [(fp(1)+fp(3)) ...
               (fp(2)+fp(2)+fp(4)/2-H/2) ...
               W ...
               H]; 
    o1 = sum(f_fr([2 4]))+frames_dist;
    o2 = 2*dist1+max(title_edit_h,title_txt(2));
    o3 = 2*dist1+interp_cb(2);
    o4 = W-(title_txt(1)+2*ok_pb(1));
    o5 = o1+dist1+(title_edit_h-title_txt(2))/2;
    o6 = o1+dist1;
    if title_txt(2)>title_edit_h,
      o5 = o1+dist1;
      o6 = o5+(title_edit_h-title_txt(2))/2;
    end
    o7 = ok_pb(1)+title_txt(1);
    o8 = o1+o2+hint_dist1;
    hint_text_pos = [1 o8 hint_txt];
    frame1_pos = [f_fr(1) o1 f_fr(3) o3];
    title_text_pos = [ok_pb(1) o5 title_txt];
    title_pos = [o7 o6 o4 title_edit_h];
    frame2_pos = f_fr;
    ok_pos = ok_pb;
    cancel_pos = cancel_pb;
    
    fig_h = figure( ...
      'Units','pixels', ...
      'Position', fig_pos, ...
      'Color',fig_color, ...
      'NumberTitle','off', ...
      'Name','empty plane', ...
      'MenuBar','none', ...
      'Visible','off');

    set( ...
    uicontrol( ...                                                            %% hint
      'Units','pixels', ...
      'BackgroundColor',fig_color, ...
      'HorizontalAlignment','center', ...
      'Position',hint_text_pos, ...
      'String','Options for empty plane', ...
      'Style','text'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame1_pos, ...
      'Style','frame'),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% title
      'Units','pixels', ...
      'Position',title_text_pos, ...
      'HorizontalAlignment','left', ...
      'Style','text', ...
      'String','Title'),'units','normalized');

    pr = udata.property{indx};
    ed_h =  uicontrol( ...                                                    %% [edit]
      'Units','pixels', ...
      'Position',title_pos, ...
      'Style','edit', ...
      'FontSize',12, ...
      'String',pr{1}, ...
      'BackgroundColor',bg_color2);
    set(ed_h,'units','normalized');

    set( ...
    uicontrol( ...                                                            %% [frame]
      'Units','pixels', ...
      'Position',frame2_pos, ...
      'Style','frame'),'units','normalized');

    s = ['vis_show_gui_comp(', ...
         mat2str(h) ',' mat2str(indx), ...
         ',''empty'',' mat2str(fig_h) ')'];
    set( ...
    uicontrol( ...                                                            %% OK
      'Units','pixels', ...
      'Position',ok_pos, ...
      'String','OK', ...
      'Callback',s),'units','normalized');

    set( ...
    uicontrol( ...                                                            %% Cancel
      'Units','pixels', ...
      'Position',cancel_pos, ...
      'String','Cancel', ...
      'Callback',['close(' mat2str(fig_h) ')']),'units','normalized');

    watchoff(old_fig_n);
    tmp_udata = [ed_h];
    set(fig_h,'units','normalized', ...
	      'Visible','on', ...
              'UserData', tmp_udata, ...
              'handlevisibility','off');

  end

 %%%%%%
% comp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%
elseif (strcmp(action,'comp'))
  tmp_h = get(varargin{1},'UserData');
  v = get(tmp_h,'Value');
  pr = udata.property{indx};
  if (v)
    v = 'compi';
    pr{1} = 1;
  else
    v = 'comp';
    pr{1} = 0;
  end
  plot_array(indx).args{1} = v;
  udata.plot_array = plot_array;
  udata.property{indx} = pr;
  set(h,'UserData',udata);
  close(varargin{1});

 %%%%%%
% umat %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%
elseif (strcmp(action,'umat'))
  tmp_h = get(varargin{1},'UserData');
  v = get(tmp_h(1),'Value');
  pr = udata.property{indx};
  if (v)
    v = 'umati';
    pr{1} = 1;
  else
    v = 'umat';
    pr{1} = 0;
  end
  plot_array(indx).args{1} = v;

  s = get(tmp_h(2),'String');
  v = get(tmp_h(3),'Value');  % userdata
  plot_array(indx).string = s;
  if strcmp(s,'U-matrix')
    plot_array(indx).args{2} = v;
  else
    plot_array(indx).args{2} = {v s};
  end
  pr{2} = s;
  pr{3} = v;
  udata.plot_array = plot_array;
  udata.property{indx} = pr;
  set(h,'UserData',udata);
  set(udata.h(1),'String',{plot_array(:).string});
  close(varargin{1});

 %%%%%%%
% color %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%
elseif (strcmp(action,'color'))
  tmp_h = get(varargin{1},'UserData'); % tmp_h =  [chkb_h ed_h popup1_h];

  v = get(tmp_h(1),'Value');
  pr = udata.property{indx};
  if (v)
    v = 'colori';
    pr{1} = 1;
  else
    v = 'color';
    pr{1} = 0;
  end
  plot_array(indx).args{1} = v;

  v = get(tmp_h(3),'Value');
  s = get(tmp_h(3),'string');
  if v>5 && ~strcmp(s{v},'-variable-'),
    m = evalin('base',s{v});
  elseif ~strcmp(s{v},'-variable-'),
    m = som_colorcode(udata.sM,s{v});
  end
  plot_array(indx).args{2} = m;
  pr{3} = s;
  s = get(tmp_h(2),'String');
  plot_array(indx).string = s;
  if ~strcmp(s,'Color code')
    plot_array(indx).args{2} = ...
        {plot_array(indx).args{2} s};
  end
  pr{2} = s;
  pr{4} = v;
  udata.plot_array = plot_array;
  udata.property{indx} = pr;
  set(h,'UserData',udata);
  set(udata.h(1),'String',{plot_array(:).string});
  close(varargin{1});

 %%%%%%%
% empty %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%
elseif (strcmp(action,'empty'))
  pr = udata.property{indx};
  tmp_h = get(varargin{1},'UserData');
  s = get(tmp_h,'String');
  pr{1} = s;
  plot_array(indx).string = s;
  plot_array(indx).args{2} = s;
  udata.plot_array = plot_array;
  udata.property{indx} = pr;
  set(h,'UserData',udata);
  set(udata.h(1),'String',{plot_array(:).string});
  close(varargin{1});

else

end



