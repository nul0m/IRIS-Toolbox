function Def = SVAR()
% SVAR  [Not a public function] Default options for SVAR class functions.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

outputFmt = { ...
    'output','auto',@(x) isanystri(x,{'auto','dbase','tseries','array'}), ...
    };

if false % ##### MOSW
    matrixFmt = { ...
        'MatrixFmt','namedmat', ...
        @(x) ischar(x) && isanystri(x,{'namedmat','plain','numeric'}), ...
        };
else
    matrixFmt = { ...
        'MatrixFmt','plain', ...
        @(x) ischar(x) && isanystri(x,{'plain','numeric'}), ...
        };
end

Def.sort = [...
    outputFmt, { ...
    'progress',false,@islogicalscalar, ...
    }];

Def.SVAR = [ ...
    outputFmt, { ...
    'maxiter',0,@(x) isnumericscalar(x) && x >= 0, ...
    'method','chol',@(x) isanystri(x,{'chol','qr','svd','householder'}), ...
    'ndraw',0,@(x) isnumericscalar(x) && x >= 0, ...
    'reorder,ordering',[],@(x) isempty(x) || isnumeric(x) || iscellstr(x), ...
    'progress',false,@islogicalscalar, ...
    'backorderresiduals,backorderresidual,reorderresiduals,reorderresidual', ...
    true,@islogical, ...
    'rank',Inf,@isnumericscalar, ...
    'std',1,@isnumericscalar, ...
    'test','',@ischar, ...
    }];

Def.fevd = { ...
    matrixFmt{:}, ...
    }; %#ok<CCAT1>

end
