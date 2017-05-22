% clc;
% close all;
% clear all;

%%% LOAD DATA FROM FILE %%%%%%%%%%%%%%%%%%%
PathName = 'C:\Users\Gareth\Desktop\BB84Lab';
FileName = 'EOMscan.dat';
fid = fopen(char(strcat(FileName)),'r');
NHEADER = 49;
NLOOP0 = 1;
NPOINTS0 = 167;
NREAD = 4;
nREAD = [1,2,3,4,5];
data = ReadColumns(FileName,NHEADER,NLOOP0+NREAD,nREAD);

%%% PROCESS DATA %%%%%%%%%%%%%%%%%%%
data = cell2mat(data);
ntraces = floor(size(data,1)/NPOINTS0);
data = data(1:NPOINTS0*ntraces,:);     % remove last incomplete trace from data 
V = reshape(data(:,1),[NPOINTS0,ntraces]);
CH1 = reshape(data(:,2),[NPOINTS0,ntraces]); % Horizontal
CH2 = reshape(data(:,3),[NPOINTS0,ntraces]); % Vertical
CH3 = reshape(data(:,4),[NPOINTS0,ntraces]); % Left
CH4 = reshape(data(:,5),[NPOINTS0,ntraces]); % Right

%%% NORMALISE DATA %%%%%%%%%%%%%%%%%%%
amp1 = max(CH1(:)) - min(CH1(:));
amp2 = max(CH2(:)) - min(CH2(:));
amp3 = max(CH3(:)) - min(CH3(:));
amp4 = max(CH4(:)) - min(CH4(:));

CH1 = CH1./amp1
CH2 = CH2./amp2
CH3 = CH3./amp3
CH4 = CH4./amp4

CH1 = CH1- min(CH1(:))
CH2 = CH2- min(CH2(:))
CH3 = CH3- min(CH3(:))
CH4 = CH4 - min(CH4(:))

%%% SMOOTH DATA %%%%%%%%%%%%%%%%
V = mean(sort(V),2);

CH1(:,2) = flipud(CH1(:,2));
CH1(:,4) = flipud(CH1(:,4));
CH1 = mean(CH1,2);

CH2(:,2) = flipud(CH2(:,2));
CH2(:,4) = flipud(CH2(:,4));
CH2 = mean(CH2,2);

CH3(:,2) = flipud(CH3(:,2));
CH3(:,4) = flipud(CH3(:,4));
CH3 = mean(CH3,2);

CH4(:,2) = flipud(CH4(:,2));
CH4(:,4) = flipud(CH4(:,4));
CH4 = mean(CH4,2);

%%% PLOT EOM SCANS %%%%%%%%%%%%%%%%%%%
figure('Name', 'Normalised Data');
plot(V(:),CH1(:),'b', 'DisplayName', 'Horiztontal');
hold on;
plot(V(:),CH2(:),'r', 'DisplayName', 'Vertical');
plot(V(:),CH3(:),'g', 'DisplayName', 'Left');
plot(V(:),CH4(:),'m', 'DisplayName', 'Right');
h_legend = legend('show');
hold off;
title('EOM Scan Data - Normalised', 'FontSize', 30);
xlabel('EOM Voltage (V)', 'FontSize', 28);
ylabel('Normalised Photon Counts', 'FontSize', 28);
axis([-840, 820, 0, 1]);
set(h_legend,'FontSize',22);
set(gca,'fontsize',24)