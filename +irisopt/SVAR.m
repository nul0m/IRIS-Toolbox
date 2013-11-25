function Def = SVAR()
% SVAR  [Not a public function] Default options for SVAR class functions.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

outputformat = { ...
    'output','auto',@(x) any(strcmpi(x,{'auto','dbase','tseries','array'})), ...
    };

Def.sort = [...
    outputformat, { ...
    'progress',false,@islogicalscalar, ...
    }];

Def.SVAR = [ ...
    outputformat, { ...
    'maxiter',0,@(x) isnumericscalar(x) && x >= 0, ...
    'method','chol',@(x) any(strcmpi(x,{'chol','qr','svd','householder'})), ...
    'ndraw',0,@(x) isnumericscalar(x) && x >= 0, ...
    'reorder,ordering',[],@(x) isempty(x) || isnumeric(x) || iscellstr(x), ...
    'progress',false,@islogicalscalar, ...
    'backorderresiduals,backorderresidual,reorderresiduals,reorderresidual',true,@islogical, ...
    'rank',Inf,@isnumericscalar, ...
    'std',1,@isnumericscalar, ...
    'test','',@ischar, ...
    }];

end