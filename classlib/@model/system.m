function [A,B,C,D,F,G,H,J,List,Nf,Derv] = system(This,varargin)
% system  System matrices before model is solved.
%
% Syntax
% =======
%
%     [A,B,C,D,F,G,H,J,List,Nf] = system(M)
%
% Input arguments
% ================
%
% * `M` [ model ] - Model object whose system matrices will be returned.
%
% Output arguments
% =================
%
% * `A`, `B`, `C`, `D`, `F`, `G`, `H` ,`J`  [ numeric ] - Matrices
% describing the unsolved system, see Description.
%
% * `List` [ cell ] - Lists of measurement variables, transition variables
% includint their auxiliary lags and leads, and shocks as they appear in
% the rows and columns of the system matrices.
%
% * `Nf` [ numeric ] - Number of non-predetermined (forward-looking)
% transition variables (multiplied by the first `Nf` columns of matrices
% `A` and `B`).
%
% Options
% ========
%
% * `'linear='` [ *`'auto'`* | `true` | `false` ] - Compute the model using
% a linear approach, i.e. differentiating around zero and not the currently
% assigned steady state.
%
% * `'select='` [ *`true`* | `false` ] - Automatically detect which
% equations need to be re-differentiated based on parameter changes from
% the last time the system matrices were calculated.
%
% Description
% ============
%
% The system before the model is solved has the following form:
%
%     A E[xf;xb] + B [xf(-1);xb(-1)] + C + D e = 0
%
%     F y + G xb + H + J e = 0
%
% where `E` is a conditional expectations operator, `xf` is a vector of
% non-predetermined (forward-looking) transition variables, `xb` is a
% vector of predetermined (backward-looking) transition variables, `y` is a
% vector of measurement variables, and `e` is a vector of transition and
% measurement shocks.
%
% Example
% ========
%

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

opt = passvalopt('model.system',varargin{:});

if ischar(opt.linear) && strcmpi(opt.linear,'auto')
    opt.linear = This.linear;
end

%--------------------------------------------------------------------------

nAlt = size(This.Assign,3);

% System matrices.
for iAlt = 1 : nAlt
    [Syst,~,Derv] = mysystem(This,iAlt,opt);
    F(:,:,iAlt) = full(Syst.A{1}); %#ok<*AGROW>
    G(:,:,iAlt) = full(Syst.B{1});
    H(:,1,iAlt) = full(Syst.K{1});
    J(:,:,iAlt) = full(Syst.E{1});
    A(:,:,iAlt) = full(Syst.A{2});
    B(:,:,iAlt) = full(Syst.B{2});
    C(:,1,iAlt) = full(Syst.K{2});
    D(:,:,iAlt) = full(Syst.E{2});
end

% Lists of measurement variables, backward-looking transition variables, and
% forward-looking transition variables.
List = { ...
    This.solutionvector{1}, ...
    myvector(This,This.systemid{2} + 1i), ...
    This.solutionvector{3}, ...
    };

% Number of forward-looking variables.
Nf = sum(imag(This.systemid{2}) >= 0);

end