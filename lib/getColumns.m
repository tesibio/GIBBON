function [varargout]=getColumns(V)

% function [varargout]=getColumns(V)
% ------------------------------------------------------------------------
% This function simply outputs each colum in V as a seperate vector. For
% instance if V represents 3 colums of data e.g. X, Y and Z coordinates
% then one could use [X,Y,Z]=getColumns(V);
%
%
% Kevin Mattheus Moerman
% kevinmoerman@hotmail.com
% 2013/13/08
%------------------------------------------------------------------------

%%

varargout = mat2cell(V,size(V,1),ones(size(V,2),1));
 
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
