function List = proplist(This)
% proplist  [Not a public function] List of all non-dependent properties of an object.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

if isstruct(This)
    List = fieldnames(This);
    return
end

% List of non-dependent object properties.
if ischar(This)
    mc = meta.class.fromName(This);
else
    mc = metaclass(This);
end
try
    inx = ~[mc.PropertyList.Dependent];
    List = {mc.PropertyList(inx).Name};
catch %#ok<CTCH>
    try
        % Compatibility with R2010b.
        p = [mc.Properties{:}];
        inx = ~[p.Dependent];
        List = {p.Name};
        List = List(inx);
    catch % Compatibility with Octave.
        List = [];
        prList = mc.PropertyList;
        for px = 1:length(prList)
          if ~prList{px}.Dependent
            List = [List, {prList{px}.Name}]; %#ok<AGROW>
          end
        end
    end
end

end