function Def = VAR()
% VAR  [Not a public function] Default options for VAR class functions.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

outputFmt = { ...
    'output','auto',@(x) any(strcmpi(x,{'auto','dbase','tseries','array'})), ...
    };

applyFilter = { ...
    'applyto',Inf,@(x) isnumeric(x) || islogical(x) || isequal(x,':') || iscellstr(x), ...
    'filter','',@ischar, ...
    };

tolerance = { ...
    'tolerance',getrealsmall(),@(isArg)is.numericscalar(isArg), ...
    };

output = { ...
    'output','namedmat',@(x) ischar(x) && any(strcmpi(x,{'namedmat','numeric'})), ...
    };

Def.acf = { ...
    applyFilter{:}, ...
    output{:}, ...
    'nfreq',256,@(isArg)is.numericscalar(isArg), ...
    'order',0,@(isArg)is.numericscalar(isArg), ...
    'progress',false,@(isArg)is.logicalscalar(isArg), ...
    }; %#ok<*CCAT>

Def.demean = { ...
   };

Def.estimate = [ ...
    outputFmt, { ...
    'a',[],@isnumeric, ...
    'bvar',[],@(x) isempty(x) || isa(x,'BVAR.bvarobj'), ...
    'c',[],@isnumeric, ...
    'diff',false,@(isArg)is.logicalscalar(isArg), ...
    'g',[],@isnumeric, ...
    'order',1,@(x) isnumeric(x) && numel(1) == 1, ...
    'cointeg',[],@isnumeric, ...
    'comment','',@(x) ischar(x) || isequal(x,Inf), ...
    'constraints,constraint','',@(x) ischar(x) || iscellstr(x) || isnumeric(x), ...
    'constant,const,constants',true,@(isArg)is.logicalscalar(isArg), ...
    'covparameters,covparameter,covparam',false,@(isArg)is.logicalscalar(isArg), ...
    'eqtnbyeqtn',false,@(isArg)is.logicalscalar(isArg), ...
    'maxiter',1,@(isArg)is.numericscalar(isArg), ...
    'mean',[],@(x) isempty(x) || isnumeric(x), ...
    'progress',false,@(isArg)is.logicalscalar(isArg), ...
    'schur',true,@(isArg)is.logicalscalar(isArg), ...
    'stdize',false,@(isArg)is.logicalscalar(isArg), ...
    'tolerance',1e-5,@(isArg)is.numericscalar(isArg), ...
    'timeweights',[],@(x) isempty(x) || isa(x,'tseries'), ...
    'ynames,yname',{},@iscellstr, ...
    'enames,ename',{},@iscellstr, ...
    'warning',true,@(isArg)is.logicalscalar(isArg), ...
    ...
    'fixedeffect',false,@(isArg)is.logicalscalar(isArg), ...
    'groupweights',[],@(x) isempty(x) || isnumeric(x), ...
    }];

Def.filter = { ...
    'ahead',1,@(x) isnumeric(x) || x == round(x) || x >= 1, ...
    'cross',true,@(x) is.logicalscalar(x) || (is.numericscalar(x) && x >=0 && x <= 1), ...
    'deviation,deviations',false,@(isArg)is.logicalscalar(isArg), ...
    'meanonly',false,@(isArg)is.logicalscalar(isArg), ...
    'omega',[],@isnumeric, ...
    'output','smooth',@ischar, ...    
    };

Def.fmse = { ...
    output{:}, ...
    }; %#ok<CCAT1>

Def.forecast = { ...
    outputFmt{:},  ...
    'cross',true,@(x) is.logicalscalar(x) || (is.numericscalar(x) && x >=0 && x <= 1), ...
    'dboverlay,dbextend',false,@(isArg)is.logicalscalar(isArg), ...
    'deviation,deviations',false,@(isArg)is.logicalscalar(isArg), ...
    'meanonly',false,@(isArg)is.logicalscalar(isArg), ...
    'omega',[],@isnumeric, ...
    'returninstruments,returninstrument',true,@(isArg)is.logicalscalar(isArg), ...
    'returnresiduals,returnresidual',true,@(isArg)is.logicalscalar(isArg), ...
    };

Def.integrate = { ...
    'applyto',Inf,@(x) isnumeric(x) || islogical(x), ...
    };

Def.isexplosive = [ ...
    tolerance, ...
    ];

Def.isstationary = [ ...
    tolerance, ...
    ];


Def.portest = { ...
    'level',0.05,@(x) is.numericscalar(x) && x > 0 && x < 1, ...
    };

Def.resample = { ...
    outputFmt{:}, ...
    'deviation,deviations',false,@(isArg)is.logicalscalar(isArg), ...   
    'method','montecarlo',@(x) is.func(x) ...
    || (ischar(x) && any(strcmpi(x,{'montecarlo','bootstrap'}))), ...
    'progress',false,@(isArg)is.logicalscalar(isArg), ...
    'randomise,randomize',false,@(isArg)is.logicalscalar(isArg), ...
    'wild',false,@(isArg)is.logicalscalar(isArg), ...
    };

Def.simulate = { ...
    outputFmt{:}, ...
    'contributions,contribution',false,@(isArg)is.logicalscalar(isArg), ...
    'deviation,deviations',false,@(isArg)is.logicalscalar(isArg), ...
    'returnresiduals,returnresidual',true,@(isArg)is.logicalscalar(isArg), ...
    };

Def.sprintf = { ...
    'constant,constants,const',true,@(isArg)is.logicalscalar(isArg), ...
    'decimal',[], @(x) isempty(x) || is.numericscalar(x), ...
    'declare',false,@(isArg)is.logicalscalar(isArg), ...
    'enames,ename',[],@(x) isempty(x) || iscellstr(x) || is.func(x), ...
    'format','%+.16g',@ischar, ...
    'hardparameters,hardparameter',true,@(isArg)is.logicalscalar(isArg), ...
    'tolerance',getrealsmall(),@(isArg)is.numericscalar(isArg), ...
    'ynames,yname',[],@(x) isempty(x) || iscellstr(x), ...
    };

Def.response = { ...
    'presample',false,@(isArg)is.logicalscalar(isArg), ...
    'select',Inf,@(x) isequal(x,Inf) || islogical(x) || isnumeric(x) || ischar(x) || iscellstr(x), ...
    };

Def.VAR = { ...
    'userdata',[],true, ...
    };

Def.xsf = { ...
    applyFilter{:}, ...
    'progress',false,@(isArg)is.logicalscalar(isArg), ...
    };

end