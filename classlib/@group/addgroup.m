function G = addgroup(G,GroupName,GroupContents)
% addgroup  Add measurement variable or shock grouping to group object.
%
% Syntax
% =======
%
%     G = addgroup(G,GroupName,GroupContents)
%
% Input arguments
% ================
%
% * `G` [ group ] - Group object.
%
% * `GroupName` [ char ] - Group name.
%
% * `GroupContents` [ cell ] - Cell array containing names of shocks or
%   measurement variables to be included in the group.
%
% Output arguments
% =================
%
% * `G` [ group ] - Group object.
%
% Description
% ============
%
% Example
% ========
%

% -IRIS Toolbox.
% -Copyright (c) 2007-2013 IRIS Solutions Team.

pp = inputParser();
pp.addRequired('G',@(x) isa(x,'group'));
pp.addRequired('GroupName',@ischar);
pp.addRequired('GroupContents',@(x) iscell(x) || ischar(x) );
pp.parse(G,GroupName,GroupContents);

if ischar(GroupContents)
    GroupContents = {GroupContents} ;
end

xxChkType() ;
switch G.type
    case 'shock'
        thisList = G.eList ;
    case 'measurement'
        thisList = G.yList ;
    otherwise
        utils.error('group:addgroup','Unable to determine group type.') ;
end

% Name filter.
fGroupContents = cell(0,1) ;
for iCont = 1:numel(GroupContents)
    ind = strfun.matchindex(thisList,GroupContents{iCont}) ;
    fGroupContents(end+1:end+sum(ind)) = thisList(ind) ;
end
GroupContents = fGroupContents ;

ind = strcmpi(G.groupNames,GroupName) ;
if any(ind)
    % Group already exists, modify
    G.groupNames{ind} = GroupName ;
    G.groupContents{ind} = GroupContents ;
else
    % Add new group
    G.groupNames = [G.groupNames, GroupName] ;
    G.groupContents = [G.groupContents, {GroupContents}] ;
end
xxChkUnique() ;


    function [iGroup,iCont]=xxChkUnique()
        count = zeros(1,numel(thisList)) ;
        for iGroup = 1:numel(G.groupNames)
            for iCont = 1:numel(G.groupContents{iGroup})
                ind = strcmp(thisList,G.groupContents{iGroup}{iCont}) ;
                count = count + ind ;
            end
        end
        for iCont = 1:numel(G.otherGroup)
            ind = strcmp(thisList,G.otherGroup{iCont}) ;
            count = count + ind ;
        end
        if any(count>1)
            utils.error('group','Some shocks are assigned to multiple groups: %s',thisList{count>1}) ;
        end
    end

    function [iCont]=xxChkType()
        if isempty(G.type)
            % assign a type
            for iCont = 1:numel(GroupContents)
                if any(strfun.matchindex(G.eList,GroupContents{iCont}))
                    G.type = 'shock' ;
                    xxChkType() ;
                    return ;
                end
                if any(strfun.matchindex(G.yList,GroupContents{iCont}))
                    G.type = 'measurement' ;
                    xxChkType() ;
                    return ;
                end
            end
        else
            % check consistency
            switch G.type
                case 'shock'
                    thisList = G.yList ;
                case 'measurement'
                    thisList = G.eList ;
            end
            for iCont = 1:numel(GroupContents)
                if any(strcmp(thisList,GroupContents{iCont}))
                    utils.error('group','Group type %s is inconsistent with proposed grouping.',G.type) ;
                end
            end
        end
    end

end


