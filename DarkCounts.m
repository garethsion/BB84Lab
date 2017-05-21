times_before = alltimes(1:start-1);
tbefore = delta*(times_before(end) - times_before(1));
channels_before = allchannels(1:start-1);

%%% CALCULATE DARK COUNT RATE FOR EACH DETECTOR %%%%%%%%%%%%%%%%%%%
DarkCounts1 = 81E-12*(times_before(channels_before == 1) - alltimes(1));N1 = length(DarkCounts1);
DarkCounts2 = 81E-12*(times_before(channels_before == 2) - alltimes(1));N2 = length(DarkCounts2);
DarkCounts3 = 81E-12*(times_before(channels_before == 3) - alltimes(1));N3 = length(DarkCounts3);
DarkCounts4 = 81E-12*(times_before(channels_before == 4) - alltimes(1));N4 = length(DarkCounts4);
% DarkCounts1 = times(channels_after == 1);N1 = length(DarkCounts1)
% DarkCounts2 = times(channels_after == 2);N2 = length(DarkCounts2)
% DarkCounts3 = times(channels_after == 3);N3 = length(DarkCounts3)
% DarkCounts4 = times(channels_after == 4);N4 = length(DarkCounts4)
figure;plot(DarkCounts1,1:N1,'.b');hold on;
plot(DarkCounts2,1:N2,'.r');
plot(DarkCounts3,1:N3,'.g');
plot(DarkCounts4,1:N4,'.m');hold off;
