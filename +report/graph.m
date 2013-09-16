% graph  Add graph to figure.
%
% Syntax
% =======
%
%     P.graph(Caption,...)
%
% Input arguments
% ================
%
% * `P` [ struct ] - Report object created by the
% [`report.new`](report/new) function.
%
% * `Caption` [ char | cellstr ] - Title, or cell array with title and
% subtitle, displayed at the top of the graph.
%
% Options
% ========
%
% * `'axesOptions='` [ cell | *empty* ] - (Inheritable) Options executed
% by calling `set` on the axes handle before running `'postProcess='`.
%
% * `'dateFormat='` [ char | *`'YYYY:P'`* ] - (Inheritable) Date format
% string, see help on [`dat2str`](dates/dat2str).
%
% * `'dateTick='` [ numeric | *`Inf`* ] - (Inheritable) Date tick
% spacing.
%
% * `'legend='` [ *`false`* | `true` ] - (Inheritable) Add legend to
% the graph.
%
% * `'legendLocation='` [ char | *`'best'`* | `'bottom'`] - (Inheritable)
% Location of the legend box; see help on `legend` for values available.
%
% * `'postProcess='` [ char | *empty* ] - (Inheritable) String with
% Matlab commands executed after the graph has been drawn and styled;
% see Description.
%
% * `'preProcess='` [ char | *empty* ] - (Inheritable) String with
% Matlab commands executed before the graph has been drawn and styled;
% see Description.
%
% * `'range='` [ numeric | *`Inf`* ] - (Inheritable) Graph range.
%
% * `'rhsAxesOptions='` [ cell | *empty* ] - (Inheritable) Options executed
% by calling `set` on the RHS axes handle before running `'postProcess='`.
%
% * `'style='` [ struct | *empty* ] - (Inheritable) Apply this style
% structure to the graph and its children; see help on
% [`qstyle`](qreport/qstyle).
%
% * `'tight='` [ *`true`* | `false` ] - (Inheritable) Set the y-axis
% limits to the minimum and maximum of displayed data.
%
% * `'xLabel='` [ char | *empty* ] - Label the x-axis.
%
% * `'yLabel='` [ char | *empty* ] - Label the y-axis.
%
% * `'zeroLine='` [ `true` | *`false`* ] - (Inheritable) Add a
% horizontal zero line if zero is included on the y-axis.
%
% Generic options
% ================
%
% See help on [generic options](report/Contents) in report objects.
%
% Description
% ============
%
% The options `'preProcess='` and `'postProcess='` give you additional
% flexibility in customising the graphics style of the axes object. The
% values assigned to these options are expected to be strings with an
% executable Matlab command, or commands separated with semi-colons (as if
% typed on one line in the command window). The command can refer to the
% following variables:
%
% * `H` - a handle to the currently processed axes object.
% * `L` - a handle to the corresponding legend object; if no legend object
% exists for the axes `H`, `L` will be `NaN`.
%
% Example
% ========
%

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.