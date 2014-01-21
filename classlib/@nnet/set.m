function This = set(This,varargin)
% set  Change modifiable nnet object property.
%
% Syntax
% =======
%
%     M = set(M,Request,Value)
%     M = set(M,Request,Value,Request,Value,...)
%
% Input arguments
% ================
%
% * `M` [ nnet ] - Neural network model object.
%
% * `Request` [ char ] - Name of a modifiable neural network model object
% property that will be changed.
%
% * `Value` [ ... ] - Value to which the property will be set.
%
% Output arguments
% =================
%
% * `M` [ nnet ] - Neural network model object with the requested
% property or properties modified.
%
% Valid requests to neural network model objects
% ===============================================
%

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

pp = inputParser();
pp = pp.addRequired('This',@(x) isa(x,'nnet'));
pp = pp.addRequired('name',@iscellstr);
pp = pp.addRequired('value',@(x) length(x) == length(varargin(1:2:end-1)));
pp = pp.parse(This,varargin(1:2:end-1),varargin(2:2:end));

%--------------------------------------------------------------------------

% Body
varargin(1:2:end-1) = strtrim(varargin(1:2:end-1));
nArg = length(varargin);
found = true(1,nArg);
validated = true(1,nArg);
for iArg = 1 : 2 : nArg
	[found(iArg),validated(iArg)] = ...
		doSet(lower(varargin{iArg}),varargin{iArg+1});
end

% Report queries that are not modifiable model object properties.
if any(~found)
	utils.error('nnet', ...
		'This is not a modifiable neural network model object property: ''%s''.', ...
		varargin{~found});
end

% Report values that do not pass validation.
if any(~validated)
	utils.error('nnet', ...
		'The value for this property does not pass validation: ''%s''.', ...
		varargin{~validated});
end

% Subfunctions.

%**************************************************************************
	function [Found,Validated,iLayer] = doSet(UsrQuery,Value)
		
		Found = true;
		Validated = true;
		query = nnet.myalias(UsrQuery);
		
		if isfunc(Value) || isnumericscalar(Value)
			switch query
				case 'activation'
					xxLayerNodeLoop('activation',Value) ;
					
				case 'activationbounds'
					xxLayerNodeLoop('activationbounds',Value) ;
					
				case 'output'
					xxLayerNodeLoop('output',Value) ;
					
				case 'outputbounds'
					xxLayerNodeLoop('outputbounds',Value) ;
					
				case 'hyper'
					xxLayerNodeLoop('hyper',Value) ;
					
				case 'hyperbounds'
					xxLayerNodeLoop('hyperbounds',Value) ;
					
				case 'bounds'
					xxLayerNodeLoop('bounds',Value) ;
					
				case 'param'
					This = set( This, 'activation', Value ) ;
					This = set( This, 'output', Value ) ;
					This = set( This, 'hyper', Value ) ;
					
				case 'userdata'
					This = userdata( This, Value );
					
				otherwise
					Found = false;
					
			end
		else
			% Value is a vector
			switch query
				case 'activation'
					xxLayerNodeIndexLoop('ActivationParams','ActivationIndex',Value) ;
					
				case 'activationBounds'
					xxLayerNodeIndexLoop('ActivationBounds','ActivationIndex',Value) ;
					
				case 'output'
					xxLayerNodeIndexLoop('OutputParams','OutputIndex',Value) ;
					
				case 'outputBounds'
					xxLayerNodeIndexLoop('OutputBounds','OutputIndex',Value) ;
					
				case 'hyper'
					xxLayerNodeIndexLoop('HyperParams','HyperIndex',Value) ;

				case 'hyperBounds'
					xxLayerNodeIndexLoop('HyperBounds','HyperIndex',Value) ;

					
				case 'param'
					xxLayerNodeIndexLoop('ActivationParams','ActivationIndex',Value) ;
					xxLayerNodeIndexLoop('HyperParams','HyperIndex',Value,This.nActivationParams) ;
					xxLayerNodeIndexLoop('OutputParams','OutputIndex',Value,This.nActivationParams+This.nHyperParams) ;
					
				case 'bounds'
					xxLayerNodeIndexLoop('ActivationBounds','ActivationIndex',Value) ;
					xxLayerNodeIndexLoop('HyperBounds','HyperIndex',Value,This.nActivationParams) ;
					xxLayerNodeIndexLoop('OutputBounds','OutputIndex',Value,This.nActivationParams+This.nHyperParams) ;
					
				otherwise
					Found = false ;
					
			end
		end
		
	end % doSet().

	function xxLayerNodeLoop(str,Value)
		for iLayer = 1:This.nLayer+1
			for iNode = 1:numel(This.Neuron{iLayer})
				This.Neuron{iLayer}{iNode} ...
					= set( This.Neuron{iLayer}{iNode}, str, Value ) ;
			end
		end
	end

	function xxLayerNodeIndexLoop(name,indexName,Value,offset)
		if nargin<4
			offset = 0 ;
		end
		for iLayer = 1:This.nLayer+1
			for iNode = 1:numel(This.Neuron{iLayer})
				This.Neuron{iLayer}{iNode}.(name) ...
					= Value( This.Neuron{iLayer}{iNode}.(indexName) + offset ) ;
			end
		end
	end
end