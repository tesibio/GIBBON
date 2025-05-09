function [varargout]=patchNormalFix(varargin)

% function [F,L]=patchNormalFix(F,logicStart,waitbarOn)
% ------------------------------------------------------------------------
%
%
% Change log:
% 2019/03/29 KMM: Created
% 
% ------------------------------------------------------------------------

%% Parse input

switch nargin
    case 1
        F=varargin{1};
        logicStart=[];
        waitbarOn=0;
    case 2
        F=varargin{1};
        logicStart=varargin{2};
        waitbarOn=0;
    case 3
        F=varargin{1};
        logicStart=varargin{2};
        waitbarOn=varargin{3};
end

%%
if isempty(logicStart)
    logicStart=false(size(F,1),1);
    logicStart(1)=1;
elseif nnz(logicStart)==0    
    logicStart(1)=1;
end

if ~islogical(logicStart) 
    indGroup=logicStart;
    logicStart=false(size(F,1),1);
    logicStart(indGroup(:))=1;
end

if nnz(logicStart)>1
    %Check if start set is consistently oriented
    [F(logicStart,:),L]=patchNormalFix(F(logicStart,:));
    if any(L)
        warning('Start face set provided was not self-consistent, start set was fixed using first element');
    end
end

%%

[E_ind,E1,E2]=getEdgeSets(F);

if waitbarOn
    c=1;
    numSteps=size(F,1);
    hw=waitbar(c/numSteps,['Reorienting faces coherently...',num2str(round(100.*c/numSteps)),'%']);
end

L=false(size(F,1),1);
while 1

    logicFriends=any(ismember(E_ind,E_ind(logicStart,:)),2) & ~logicStart;    
    indCheck1=find(logicFriends,1);    
    indCheckEdge1=find(ismember(E_ind(indCheck1,:),E_ind(logicStart,:)),1);
    edgeCheck1= [E1(indCheck1,indCheckEdge1) E2(indCheck1,indCheckEdge1)];
    
    if isempty(indCheck1)
        break
    end
    
    logicCheckFriends=any(ismember(E_ind,E_ind(indCheck1,indCheckEdge1)),2) & logicStart;    
    indCheck2=find(logicCheckFriends,1);
    indCheckEdge2=find(E_ind(indCheck2,:)==E_ind(indCheck1,indCheckEdge1),1);
    edgeCheck2= [E1(indCheck2,indCheckEdge2) E2(indCheck2,indCheckEdge2)];

    if all(edgeCheck1==edgeCheck2)        
        F(indCheck1,:)=fliplr(F(indCheck1,:));                
        L(indCheck1)=1;
        [E_ind,E1,E2]=getEdgeSets(F);        
    end    
    logicStart(indCheck1)=1;        
    
    if waitbarOn
        c=nnz(logicStart);
        waitbar(c/numSteps,hw,['Reorienting faces coherently...',num2str(round(100.*c/numSteps)),'%']);
    end
end
if waitbarOn
    close(hw);
end

varargout{1}=F;
varargout{2}=L;

end

function [E_ind,E1,E2]=getEdgeSets(F)

E=patchEdges(F,0);
E_sort=sort(E,2);
E_ind=reshape(sub2ind([max(E_sort(:)) max(E_sort(:))],E_sort(:,1),E_sort(:,2)),[size(F,2),size(F,1)])';
E1=reshape(E(:,1),[size(F,2),size(F,1)])';
E2=reshape(E(:,2),[size(F,2),size(F,1)])';

end
%% 
% _*GIBBON footer text*_ 
% 
% License: <https://github.com/gibbonCode/GIBBON/blob/master/LICENSE>
% 
% GIBBON: The Geometry and Image-based Bioengineering add-On. A toolbox for
% image segmentation, image-based modeling, meshing, and finite element
% analysis.
% 
% Copyright (C) 2006-2023 Kevin Mattheus Moerman and the GIBBON contributors
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
