%%% Single Photon Detectors %%%%%%%%%
%IDQuantique ID-100-SMF20-ULN
%Excelitas SPCM-AQRH-14-FC

IDQ_eff = 0.25; % IDQuantique single photon detector efficiency
EXC_eff = 0.65; % Excelitas single photon detector efficiency

%P_dark = n_dark * Delta_tau

%%% Calculate error in each pulse level %%%%%%%%%%
% In each pulse level, there should be varying percentages of photon counts
% at the detector based on which basis was prepared. Here, I compare the
% measured ratios to the expected

% Pulse Level 1 - a Vertically polarised photon is prepared, so we expect
% that H = 0%, V = 25%, L = 37.5%, R = 37.5%
pulse1_total = sum0_window(1) + sum1_window(1) + sum2_window(1)...
    + sum3_window(1);
pulse2_total = sum0_window(2) + sum1_window(2) + sum2_window(2)...
    + sum3_window(2);
pulse3_total = sum0_window(3) + sum1_window(3) + sum2_window(3)...
    + sum3_window(3);
pulse4_total = sum0_window(4) + sum1_window(4) + sum2_window(4)...
    + sum3_window(4);

pulse1_ch1_percentage = sum0_window(1)/pulse1_total;
pulse1_ch2_percentage = sum1_window(1)/pulse1_total;
pulse1_ch3_percentage = sum2_window(1)/pulse1_total;
pulse1_ch4_percentage = sum3_window(1)/pulse1_total;
pulse1_channels = [pulse1_ch1_percentage, pulse1_ch2_percentage,...
    pulse1_ch3_percentage, pulse1_ch4_percentage];
%sum(pulse1_channels(:))

pulse2_ch1_percentage = sum0_window(2)/pulse2_total;
pulse2_ch2_percentage = sum1_window(2)/pulse2_total;
pulse2_ch3_percentage = sum2_window(2)/pulse2_total;
pulse2_ch4_percentage = sum3_window(2)/pulse2_total;
pulse2_channels = [pulse2_ch1_percentage, pulse2_ch2_percentage,...
    pulse2_ch3_percentage, pulse2_ch4_percentage];
%sum(pulse2_channels(:))

pulse3_ch1_percentage = sum0_window(3)/pulse3_total;
pulse3_ch2_percentage = sum1_window(3)/pulse3_total;
pulse3_ch3_percentage = sum2_window(3)/pulse3_total;
pulse3_ch4_percentage = sum3_window(3)/pulse3_total;
pulse3_channels = [pulse3_ch1_percentage, pulse3_ch2_percentage,...
    pulse3_ch3_percentage, pulse3_ch4_percentage];
%sum(pulse3_channels(:))

pulse4_ch1_percentage = sum0_window(4)/pulse4_total;
pulse4_ch2_percentage = sum1_window(4)/pulse4_total;
pulse4_ch3_percentage = sum2_window(4)/pulse4_total;
pulse4_ch4_percentage = sum3_window(4)/pulse4_total;
pulse4_channels = [pulse4_ch1_percentage, pulse4_ch2_percentage,...
    pulse4_ch3_percentage, pulse4_ch4_percentage];
%sum(pulse4_channels(:))

pulse1_channels_ideal = [0, 25, 37.5, 37.5];
pulse2_channels_ideal = [50, 25, 0, 25];