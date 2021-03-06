function [C,S] = datconsecutive(D)
% datconsecutive  [Not a public function] Group dates into uninterrupted ranges.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

if isempty(D)
    C = {};
    S = {};
    return
end

%**************************************************************************

D = D(:).';
C = {[]};
for idate = D
    if isempty(C{end}) ...
            || datdiff(idate,C{end}(end)) == 1
        C{end}(end+1) = idate;
    else
        C{end+1} = idate; %#ok<AGROW>
    end
end
if nargout == 1
    return
end

S = cell(size(C));
for i = 1 : length(C)
    if length(C{i}) == 1
        S{i} = dat2char(C{i});
    else
        S{i} = [dat2char(C{i}(1)),':', ...
            dat2char(C{i}(end))];
    end
end

end