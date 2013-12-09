function C = speclatexcode(This)
% speclatexcode  [Not a public function] Produce LaTeX code for figure object.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

%--------------------------------------------------------------------------

C = '';

% Create a figure window, and update the property `This.handle`.
This = myplot(This);

% Create PDF
%------------
% Create PDf for figure handle and the latex command line.
% We need to pass in the top level report object's options that control
% orientation and paper size.
includeGraphics = '';
if ~isempty(This.handle) && ~isempty(get(This.handle,'children'))
    try
        rootOpt = getrootprop(This,'options');
        includeGraphics = mycompilepdf(This,rootOpt);
    catch Error
        try %#ok<TRYNC>
            close(This.handle);
        end
        utils.warning('report', ...
            ['Error creating figure ''%s''.\n', ...
            '\tMatlab says: %s'], ...
            This.title,Error.message);
        return
    end
end

% Close figure window or broadcast an open figure window event
%--------------------------------------------------------------
if ~isempty(This.handle)
    if This.options.close
        try %#ok<TRYNC>
            close(This.handle);
        end
    else
        % Broadcast an openFigureWindow event.
        notify(This,'openFigureWindow');
        if ~isempty(This.title)
            % If the figure stays open, add title.
            % TODO: Add also subtitle.
            grfun.ftitle(This.handle,This.title);
        end
    end
end

% Finish LaTeX code
%-------------------
C = [beginsideways(This),beginwrapper(This,7)];
C = [C,includeGraphics];
C = [C,finishwrapper(This),finishsideways(This)];
C = [C,footnotetext(This)];

end