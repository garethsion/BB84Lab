clc;
close all;
clear all;

%%% LOAD DATA FROM FILE %%%%%%%%%%%%%%%%%%%
delta = 81E-12;
FileName = 'BB84finaldata.txt';
%[PathName,FileName] = OpenFileUI(DefaultPath);
fid = fopen(char(strcat(FileName)),'r');
%format = ['%d64',' , ','%d64'];
format = ['%f',' , ','%f'];
raw = textscan(fid,format,'headerLines',0,'commentStyle',{'TRACE', ':'});

%%% PROCESS DATA %%%%%%%%%%%%%%%%%%%
alltimes = raw{1};
allchannels = raw{2};
start = min(find(allchannels == 5));
stop = max(find(allchannels == 5));
times = alltimes(start:stop-1) - alltimes(1);
channels = allchannels(start:stop-1);
% times_before = alltimes(1:start-1);
% tbefore = delta*(times_before(end) - times_before(1));
% channels_before = allchannels(1:start-1);

t5 = times(channels==5,:);
t1 = times(channels==1,:)-t5(1);
t2 = times(channels==2,:)-t5(1);
t3 = times(channels==3,:)-t5(1);
t4 = times(channels==4,:)-t5(1);
t5 = t5-t5(1);
Nevents = length(times);

pulse = zeros(Nevents,1);
dt = zeros(Nevents,1);
%dt(find(dt==0)) = NaN;
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
figure;plot(delta*ch5(:,1),[1:length(ch5)],'b');
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

%%% PLOT HISTOGRAM OF TIME BETWEEN TRIGGER EVENTS %%%%%%%%%%%%%%%%%%%
bins = (-10:10) + round(mean(dt5),0);
h5 = hist(dt5,bins); 
figure;plot(delta*bins,h5,'-ob');
title('Histogram of time between successive trigger pulses','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Number of events','Fontsize',18);

%%% PLOT ALL PHOTON EVENTS %%%%%%%%%%%%%%%%%%%
figure;plot(delta*ch1(:,1),[1:length(ch1)],'.b');
hold on;
plot(delta*ch2(:,1),[1:length(ch2)],'.r');
plot(delta*ch3(:,1),[1:length(ch3)],'.g');
plot(delta*ch4(:,1),[1:length(ch4)],'.m');
hold off;
title(['Photon detection events on channels 1 - 4 (',num2str(Nphotons),' total)'],'Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Photon detection events','Fontsize',18);

%%% PLOT ARRIVAL TIMES OF PHOTON EVENTS RELATIVE TO TRIGGER %%%%%%%%%%%%%%%%%%%
figure;plot(delta*ch1(:,5),[1:length(ch1)],'.b');
hold on;
plot(delta*ch2(:,5),[1:length(ch2)],'.r');
plot(delta*ch3(:,5),[1:length(ch3)],'.g');
plot(delta*ch4(:,5),[1:length(ch4)],'.m');
hold off;
title(['Photon detection events on channels 1 - 4 (',num2str(Nphotons),' total)'],'Fontsize',18);
xlabel('Time after trigger (s)','Fontsize',18);
ylabel('Photon detection events','Fontsize',18);

%%% PLOT HISTOGRAMS OF ARRIVAL TIMES OF PHOTON EVENTS RELATIVE TO TRIGGER %%%%%%%%%%%%%%%%%%%
bins = (1:2:max(ch1(:,5)))';
h1 = hist(ch1(:,5),bins); 
h2 = hist(ch2(:,5),bins); 
h3 = hist(ch3(:,5),bins); 
h4 = hist(ch4(:,5),bins); 
figure;plot(delta*bins,h1,'-ob');
hold on;
plot(delta*bins,h2,'-or');
plot(delta*bins,h3,'-og');
plot(delta*bins,h4,'-om');
title('Histogram of photon detection times relative to trigger pulses','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Number of events','Fontsize',18);

%%% PLOT PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE %%%%%%%%%%%%%%%%%%%
ch1_0 = ch1(find(ch1(:,4)==0),5);
ch1_1 = ch1(find(ch1(:,4)==1),5);
ch1_2 = ch1(find(ch1(:,4)==2),5);
ch1_3 = ch1(find(ch1(:,4)==3),5);

ch2_0 = ch2(find(ch2(:,4)==0),5);
ch2_1 = ch2(find(ch2(:,4)==1),5);
ch2_2 = ch2(find(ch2(:,4)==2),5);
ch2_3 = ch2(find(ch2(:,4)==3),5);

ch3_0 = ch3(find(ch3(:,4)==0),5);
ch3_1 = ch3(find(ch3(:,4)==1),5);
ch3_2 = ch3(find(ch3(:,4)==2),5);
ch3_3 = ch3(find(ch3(:,4)==3),5);

ch4_0 = ch4(find(ch4(:,4)==0),5);
ch4_1 = ch4(find(ch4(:,4)==1),5);
ch4_2 = ch4(find(ch4(:,4)==2),5);
ch4_3 = ch4(find(ch4(:,4)==3),5);

figure;plot(delta*ch1_0,[1:length(ch1_0)],'.b');
hold on;
plot(delta*ch2_0,[1:length(ch2_0)],'.r');
plot(delta*ch3_0,[1:length(ch3_0)],'.g');
plot(delta*ch4_0,[1:length(ch4_0)],'.m');
hold off;
title('Photon detection during period 0 (H?)','Fontsize',18);
xlabel('Time after trigger (s)','Fontsize',18);
ylabel('Photon detection events','Fontsize',18);

figure;plot(delta*ch1_1,[1:length(ch1_1)],'.b');
hold on;
plot(delta*ch2_1,[1:length(ch2_1)],'.r');
plot(delta*ch3_1,[1:length(ch3_1)],'.g');
plot(delta*ch4_1,[1:length(ch4_1)],'.m');
hold off;
title('Photon detection during period 1 (L?)','Fontsize',18);
xlabel('Time after trigger (s)','Fontsize',18);
ylabel('Photon detection events','Fontsize',18);

figure;plot(delta*ch1_2,[1:length(ch1_2)],'.b');
hold on;
plot(delta*ch2_2,[1:length(ch2_2)],'.r');
plot(delta*ch3_2,[1:length(ch3_2)],'.g');
plot(delta*ch4_2,[1:length(ch4_2)],'.m');
hold off;
title('Photon detection during period 2 (V?)','Fontsize',18);
xlabel('Time after trigger (s)','Fontsize',18);
ylabel('Photon detection events','Fontsize',18);

figure;plot(delta*ch1_3,[1:length(ch1_3)],'.b');
hold on;
plot(delta*ch2_3,[1:length(ch2_3)],'.r');
plot(delta*ch3_3,[1:length(ch3_3)],'.g');
plot(delta*ch4_3,[1:length(ch4_3)],'.m');
hold off;
title('Photon detection during period 3 (R?)','Fontsize',18);
xlabel('Time after trigger (s)','Fontsize',18);
ylabel('Photon detection events','Fontsize',18);

%%% PLOT HISTOGRAM OF PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE %%%%%%%%%%%%%%%%%%%
bins = (1:2:12346)';            % group neighbouring time-bins together due to IDQ800 binning problem
h1_0 = hist(ch1_0,bins); 
h1_1 = hist(ch1_1,bins); 
h1_2 = hist(ch1_2,bins); 
h1_3 = hist(ch1_3,bins); 

h2_0 = hist(ch2_0,bins); 
h2_1 = hist(ch2_1,bins); 
h2_2 = hist(ch2_2,bins); 
h2_3 = hist(ch2_3,bins); 

h3_0 = hist(ch3_0,bins); 
h3_1 = hist(ch3_1,bins); 
h3_2 = hist(ch3_2,bins); 
h3_3 = hist(ch3_3,bins); 

h4_0 = hist(ch4_0,bins); 
h4_1 = hist(ch4_1,bins); 
h4_2 = hist(ch4_2,bins); 
h4_3 = hist(ch4_3,bins); 

figure;plot(delta*bins,h1_0,'-ob');
hold on;
plot(delta*bins,h2_0,'-or');
plot(delta*bins,h3_0,'-og');
plot(delta*bins,h4_0,'-om');
title('Histogram of photon detection events during period 0 (H?)','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Number of events','Fontsize',18);
%xlim([5.8E-7,6.1E-7]);

figure;plot(delta*bins,h1_1,'-ob');
hold on;
plot(delta*bins,h2_1,'-or');
plot(delta*bins,h3_1,'-og');
plot(delta*bins,h4_1,'-om');
title('Histogram of photon detection events during period 1 (L?)','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Number of events','Fontsize',18);
%xlim([5.8E-7,6.1E-7]);

figure;plot(delta*bins,h1_2,'-ob');
hold on;
plot(delta*bins,h2_2,'-or');
plot(delta*bins,h3_2,'-og');
plot(delta*bins,h4_2,'-om');
title('Histogram of photon detection events during period 2 (V?)','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Number of events','Fontsize',18);
%xlim([5.8E-7,6.1E-7]);

figure;plot(delta*bins,h1_3,'-ob');
hold on;
plot(delta*bins,h2_3,'-or');
plot(delta*bins,h3_3,'-og');
plot(delta*bins,h4_3,'-om');
title('Histogram of photon detection events during period 3 (R?)','Fontsize',18);
xlabel('Time (s)','Fontsize',18);
ylabel('Number of events','Fontsize',18);
%xlim([5.8E-7,6.1E-7]);

%%% ADD UP ALL PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE (WITHOUT SELECTING TIMING WINDOW) %%%%%%%%%%%%%%%%%%%
sum0_total = [sum(h1_0),sum(h2_0),sum(h3_0),sum(h4_0)];
sum1_total = [sum(h1_1),sum(h2_1),sum(h3_1),sum(h4_1)];
sum2_total = [sum(h1_2),sum(h2_2),sum(h3_2),sum(h4_2)];
sum3_total = [sum(h1_3),sum(h2_3),sum(h3_3),sum(h4_3)];
distribution_total = [sum0_total',sum1_total',sum2_total',sum3_total'];
figure;bar(distribution_total');
title(['NO TIMING WINDOW: H (dark blue), V (light blue), L (green), R (yellow)']);xlabel(['Pulse level']);ylabel(['Total counts in entire pulse section']);

%%% ADD UP ALL PHOTON EVENTS IN SPECIFIC SECTIONS OF PULSE (SELECTING TIMING WINDOW) %%%%%%%%%%%%%%%%%%%
[Nmax,imax1] = max(h1_0);
[Nmax,imax2] = max(h2_0);
[Nmax,imax3] = max(h3_0);
[Nmax,imax4] = max(h4_0);
width = 15;
sum0_window = [sum(h1_0(imax1-width:imax1+width)),sum(h2_0(imax2-width:imax2+width)),sum(h3_0(imax3-width:imax3+width)),sum(h4_0(imax4-width:imax4+width))];
sum1_window = [sum(h1_1(imax1-width:imax1+width)),sum(h2_1(imax2-width:imax2+width)),sum(h3_1(imax3-width:imax3+width)),sum(h4_1(imax4-width:imax4+width))];
sum2_window = [sum(h1_2(imax1-width:imax1+width)),sum(h2_2(imax2-width:imax2+width)),sum(h3_2(imax3-width:imax3+width)),sum(h4_2(imax4-width:imax4+width))];
sum3_window = [sum(h1_3(imax1-width:imax1+width)),sum(h2_3(imax2-width:imax2+width)),sum(h3_3(imax3-width:imax3+width)),sum(h4_3(imax4-width:imax4+width))];
distribution_window = [sum0_window',sum1_window',sum2_window',sum3_window'];
figure;bar(distribution_window');
title(['WITH TIMING WINDOW: H (dark blue), V (light blue), L (green), R (yellow)']);xlabel(['Pulse level']);ylabel(['Total counts in timing window']);

% %sum1 = [sum(h1_0(655:692)),sum(h1_1(655:692)),sum(h1_2(655:692)),sum(h1_3(655:692))];
% sum1 = [sum(h1_0(592:629)),sum(h1_1(592:629)),sum(h1_2(592:629)),sum(h1_3(592:629))];
% sum2 = [sum(h2_0(704:741)),sum(h2_1(704:741)),sum(h2_2(704:741)),sum(h2_3(704:741))];
% sum3 = [sum(h3_0(531:556)),sum(h3_1(531:556)),sum(h3_2(531:556)),sum(h3_3(531:556))];
% sum4 = [sum(h4_0(525:550)),sum(h4_1(525:550)),sum(h4_2(525:550)),sum(h4_3(525:550))];
% distribution = [sum1;sum2;sum3;sum4];
% 
% clock = times(channels==8);
% ch1 = times(channels==1) - clock(1);
% ch2 = times(channels==2) - clock(1);
% ch3 = times(channels==3) - clock(1);
% ch4 = times(channels==4) - clock(1);
% clock = clock - clock(1);
% 
% total1 = length(ch1);
% total2 = length(ch2);
% total3 = length(ch3);
% total4 = length(ch4);
% total = total1 + total2 + total3 + total4;
% deltat = double(clock-circshift(clock,1));
% bins_selection = (min(deltat(2:end)):max(deltat(2:end)));

% figure;plot(delta*clock,'.b');
% title(['Arrival times of counter pulses as measured by IDQ box timer']);xlabel(['Event index']);ylabel(['Arrival time of counter pulses (s)']);
% figure;plot(delta*deltat(2:end),'.b');
% title(['Distribution of counter pulses']);xlabel(['Event index']);ylabel(['Time between successive counter pulses (s)']);
% figure:plot(delta*bins_selection,hist(deltat(2:end),bins_selection),'oB');
% title(['Jitter on counter pulses']);xlabel(['Time between successive counter pulses (s)']);ylabel(['Number of events']);
% figure;plot(delta*ch1,(1:total1)','.r');hold on;plot(delta*ch2,(1:total2),'.y');hold off;
% title(['Channel 1 (red) and channel 2 (yellow)']);xlabel(['Detection counter time (s)']);ylabel(['Detection counter index']);
% figure;plot(delta*ch3,(1:total3),'.g');hold on;plot(delta*ch4,(1:total4),'.b');hold off;
% title(['Channel 3 (green) and channel 4 (blue)']);xlabel(['Detection counter time (s)']);ylabel(['Detection counter index']);

% figure;hold on;
% plot(1E9*delta*bins,h1,'oR');plot(1E9*delta*bins,h2,'oM');plot(1E9*delta*bins,h3,'oG');plot(1E9*delta*bins,h4,'oB');
% hold off;xlim([40,60]);%ylim([0,max(h1)]);
% title(['Detection events: ch1 (red), ch2 (magenta), ch3 (green), ch4 (blue)']);xlabel(['Time (ns)']);ylabel(['Number of events']);
% 
% figure;hold on;
% plot(1E9*delta*bins,h1_0,'oR');plot(1E9*delta*bins,h1_1,'oM');plot(1E9*delta*bins,h1_2,'oG');plot(1E9*delta*bins,h1_3,'oB');
% hold off;xlim([48,51]);%ylim([0,max(h1)]);
% title(['CHANNEL1: Detection events: level0 (red), level1 (magenta), level2 (green), level3 (blue)']);xlabel(['Time (ns)']);ylabel(['Number of events']);
% 
% figure;hold on;
% plot(1E9*delta*bins,h2_0,'oR');plot(1E9*delta*bins,h2_1,'oM');plot(1E9*delta*bins,h2_2,'oG');plot(1E9*delta*bins,h2_3,'oB');
% hold off;xlim([57,60]);%ylim([0,max(h1)]);
% title(['CHANNEL2: Detection events: level0 (red), level1 (magenta), level2 (green), level3 (blue)']);xlabel(['Time (ns)']);ylabel(['Number of events']);
% 
% figure;hold on;
% plot(1E9*delta*bins,h3_0,'oR');plot(1E9*delta*bins,h3_1,'oM');plot(1E9*delta*bins,h3_2,'oG');plot(1E9*delta*bins,h3_3,'oB');
% hold off;xlim([43,45]);%ylim([0,max(h1)]);
% title(['CHANNEL3: Detection events: level0 (red), level1 (magenta), level2 (green), level3 (blue)']);xlabel(['Time (ns)']);ylabel(['Number of events']);
% 
% figure;hold on;
% plot(1E9*delta*bins,h4_0,'oR');plot(1E9*delta*bins,h4_1,'oM');plot(1E9*delta*bins,h4_2,'oG');plot(1E9*delta*bins,h4_3,'oB');
% hold off;xlim([42.5,44.5]);%ylim([0,max(h1)]);
% title(['CHANNEL4: Detection events: level0 (red), level1 (magenta), level2 (green), level3 (blue)']);xlabel(['Time (ns)']);ylabel(['Number of events']);
% 
% figure;bar(distribution);
% title(['Regular sequence: level1 (dark blue), level2 (light blue), level3 (yellow), level4 (brown)']);xlabel(['Channel number']);ylabel(['Total counts in detection window (2 or 3 ns)']);
% 
% figure;bar(distribution');
% title(['Regular sequence: ch1 (dark blue), ch2 (light blue), ch3 (yellow), ch4A (brown)']);xlabel(['Pulse level']);ylabel(['Total counts in detection window (2 or 3 ns)']);

% %%% CALCULATE DARK COUNT RATE FOR EACH DETECTOR %%%%%%%%%%%%%%%%%%%
% DarkCounts1 = 81E-12*(times_before(channels_before == 1) - alltimes(1));N1 = length(DarkCounts1);
% DarkCounts2 = 81E-12*(times_before(channels_before == 2) - alltimes(1));N2 = length(DarkCounts2);
% DarkCounts3 = 81E-12*(times_before(channels_before == 3) - alltimes(1));N3 = length(DarkCounts3);
% DarkCounts4 = 81E-12*(times_before(channels_before == 4) - alltimes(1));N4 = length(DarkCounts4);
% % DarkCounts1 = times(channels_after == 1);N1 = length(DarkCounts1)
% % DarkCounts2 = times(channels_after == 2);N2 = length(DarkCounts2)
% % DarkCounts3 = times(channels_after == 3);N3 = length(DarkCounts3)
% % DarkCounts4 = times(channels_after == 4);N4 = length(DarkCounts4)
% figure;plot(DarkCounts1,1:N1,'.b');hold on;
% plot(DarkCounts2,1:N2,'.r');
% plot(DarkCounts3,1:N3,'.g');
% plot(DarkCounts4,1:N4,'.m');hold off
