function Def = nnet()
% optim  [Not a public function] Default options for nnet package.
%
% Backend IRIS function.
% No help provided.

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

%--------------------------------------------------------------------------

Def = struct();

validTransferFn = @(x) any(strcmpi(x,{'sigmoid','linear','step','tanh'})) ;

Def.nnet = { ...
    'HiddenTransfer', 'sigmoid', @(x) iscellstr(x) || validTransferFn(x), ...
    'InputTransfer', 'sigmoid', validTransferFn, ...
    'OutputTransfer', 'sigmoid', validTransferFn, ...
    'Type', 'feedforward', @(x) any(strcmpi(x,{'feedforward'})), ...
    'initBias,bias', 0, @(x) isnumericscalar(x) || isfunc(x), ...
    'initWeight,initWeights,weights', @(x) 2*rand()-1, @(x) isnumericscalar(x) || isfunc(x), ...
    'initTransfer,transfer,hyperparams', 1, @(x) isnumericscalar(x) || isfunc(x), ...
    } ;

Def.estimate = { ...
    'optimset',{},@(x) isempty(x) || isstruct(x) || (iscell(x) && iscellstr(x(1:2:end))), ...
    'solver,optimiser,optimizer','fmin',@(x) (ischar(x) && isanychari(x,{'fmin','lsqnonlin','pso'})), ...
    'Norm',@(x) norm(x,2), @isfunc, ...
    } ;

end


