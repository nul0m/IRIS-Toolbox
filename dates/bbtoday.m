function Dat = bbtoday()
% bbtoday  IRIS serial date number for current bi-month.
%
% Syntax
% =======
%
%     Dat = bbtoday()
%
% Output arguments
% =================
%
% * `Dat` [ numeric ]  - IRIS serial date number for current bi-month.
%
% Description
% ============
%
% Example
% ========
%

% -IRIS Toolbox.
% -Copyright (c) 2007-2014 IRIS Solutions Team.

%--------------------------------------------------------------------------

[year,month] = datevec(now());
Dat = bb(year,1+floor((month-1)/2));

end