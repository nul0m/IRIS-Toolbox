function C = cleanup(C,This)
% cleanup  [Not a public function] Remove all replacement codes belonging
% to a given fragileobj from a string.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

%--------------------------------------------------------------------------

ptn = ['[',regexppattern(This),']'];
C = regexprep(C,ptn,'');

end