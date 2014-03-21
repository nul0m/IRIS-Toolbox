classdef graphobj < report.genericobj
    
    methods
        
        function This = graphobj(varargin)
            This = This@report.genericobj(varargin{:});
            This.childof = {'figure'};
            This.default = [This.default, { ...
                'axesoptions',{},@(x) iscell(x) && iscellstr(x(1:2:end)),true, ...
                'rhsaxesoptions',{},@(x) iscell(x) && iscellstr(x(1:2:end)),true, ...
                'dateformat',irisget('plotdateformat'),@(varargin)is.plotdateformat(varargin),true, ...
                'datetick',Inf,@isnumeric,true, ...
                'grid',true,@(isArg)is.logicalscalar(isArg),true, ... Obsolete, use style.
                'highlight',[],@(x) isnumeric(x) ...
                || (iscell(x) && all(cellfun(@isnumeric,x))),true, ... Obsolete, use highlight object.
                'legend',false,@(x) islogical(x) || isnumeric(x),true, ...
                'legendlocation','Best',@ischar,true, ...
                'preprocess','',@(x) isempty(x) || ischar(x),true, ...
                'postprocess','',@(x) isempty(x) || ischar(x),true, ...
                'range',Inf,@isnumeric,true, ...
                'style',[],@(x) isempty(x) || isstruct(x),true, ...
                'tight',true,@islogical,true, ...
                'xlabel','',@ischar,true, ...
                'ylabel','',@ischar,true, ...
                'zlabel','',@ischar,true, ...
                'zeroline',false,@islogical,true, ...
                }];
        end
        
        function [This,varargin] = specargin(This,varargin)
        end
        
        function Ax = subplot(This,R,C,I,varargin) %#ok<INUSL>
            Ax = subplot(R,C,I,varargin{:});
        end
        
        varargout = plot(varargin)
        
    end
    
end