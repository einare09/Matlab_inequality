clc
close all
clear all


%set path
if isunix
    Pat = '../../runs/';
else
    Pat = '..\..\runs\';
end
%for saving figures - Define path to figure folder
%FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\',num2str(RunNumbers(1)),'-',num2str(RunNumbers(end)));
%current_folder = cd;
%mkdir(FigPat);
%Define parameters
AlphaBeta = {'a10b25','a10b30','a10b40','a20b25','a20b30','a20b40','a30b25','a30b30','a30b40'};
%Define RunNumbers

for iii = 1:length(AlphaBeta)
    
end