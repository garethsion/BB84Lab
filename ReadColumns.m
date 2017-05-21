% File: ReadColumns.m
% Author: Jeroen Elzerman <elzerman@phys.ethz.ch>
% Date: 02.03.2009
% This function opens a data file and reads certain columns into a column
% matrix

function data = ReadColumns(FileName,NHEADER,Ncolumns,varargin)

if isempty(varargin)
    n=1;
else
    n = cell2mat(varargin);                                                               % array with column numbers to be read from data file
end

format = '';                                                                    % make format string corresponding to correct number of columns in original data
for i = 1:Ncolumns
    if isempty(find(n==i))
        format = [format,'%*f'];
    else
        format = [format,'%f'];
    end
end

fid = fopen(char(strcat(FileName)),'r');
data = textscan(fid,format,'headerLines',NHEADER,'commentStyle',{'TRACE', ':'});
fclose(fid);