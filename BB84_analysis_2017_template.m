clc;
close all;
clear all;


%%% LOAD DATA FROM FILE %%%%%%%%%%%%%%%%%%%
delta = 81E-12;
PathName = 'C:\Users\Gareth\Desktop\BB84Lab';
FileName = 'BB84finaldata.txt';
fid = fopen(char(strcat(FileName)),'r');
format = ['%f',' , ','%f'];
raw = textscan(fid,format,'headerLines',0,'commentStyle',{'TRACE', ':'});

%%% PROCESS DATA %%%%%%%%%%%%%%%%%%%
alltimes = raw{1};
allchannels = raw{2};
start = min(find(allchannels == 5));
stop = max(find(allchannels == 5));
times = alltimes(start:stop-1) - alltimes(1);
channels = allchannels(start:stop-1);

Nevents = length(times);
pulse = zeros(Nevents,1);
dt = zeros(Nevents,1);
counter = 0;
trigger = 0;
for k = 1:Nevents
    if channels(k) == 5
        counter = counter + 1;
        trigger = times(k);
    else
        dt(k) = times(k) - trigger;
    end
    pulse(k) = counter;
end
data = [times,channels,pulse,mod(pulse,4),dt];
ch1 = data(channels==1,:);
ch2 = data(channels==2,:);
ch3 = data(channels==3,:);
ch4 = data(channels==4,:);
ch5 = data(channels==5,:);
Nphotons = length(ch1)+length(ch2)+length(ch3)+length(ch4);
Npulses = length(ch5);

%%% PLOT TRIGGER EVENTS %%%%%%%%%%%%%%%%%%%
figure; plot(delta*ch5(:,1),[1:length(ch5)],'b');
title('Trigger events','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Trigger events','Fontsize',18);

%%% PLOT TIME BETWEEN TRIGGER EVENTS %%%%%%%%%%%%%%%%%%%
dt5 = ch5(:,1) - circshift(ch5(:,1),1);
dt5 = dt5(2:end);
figure;plot(delta*dt5,'.b');
title('Time jitter on trigger signal','Fontsize',18);
xlabel('Trigger index','Fontsize',18);
ylabel('Time between successive trigger events (s)','Fontsize',18);

%%% PLOT ALL PHOTON EVENTS %%%%%%%%%%%%%%%%%%%

%%% PLOT ARRIVAL TIMES OF PHOTON EVENTS RELATIVE TO TRIGGER %%%%%%%%%%%%%%%%%%%

%%% PLOT HISTOGRAMS OF ARRIVAL TIMES OF PHOTON EVENTS RELATIVE TO TRIGGER %%%%%%%%%%%%%%%%%%%

%%% PLOT PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE %%%%%%%%%%%%%%%%%%%

%%% PLOT HISTOGRAM OF PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE %%%%%%%%%%%%%%%%%%%

%%% ADD UP ALL PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE (WITHOUT SELECTING TIMING WINDOW) %%%%%%%%%%%%%%%%%%%

%%% NORMALISE ALL CHANNELS (SET MAX COUNT RATE TO PROBABILITY = 1) %%%%%%%%%%%%%%%%%%%

%%% ADD UP ALL PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE (SELECTING TIMING WINDOW) %%%%%%%%%%%%%%%%%%%
