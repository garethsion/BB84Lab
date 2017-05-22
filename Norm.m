%%% Since the detectors have different efficiencies, it is necessary to
%%% normalise the event counts such that we are dealing with the same sense
%%% of scale. This is done here by dividing the count in a particular
%%% channel by the total number of counts for each detector. 
norm_p1_ch1 = distribution_window(1,1)/sum(distribution_window(1,:));
norm_p2_ch1 = distribution_window(1,2)/sum(distribution_window(1,:));
norm_p3_ch1 = distribution_window(1,3)/sum(distribution_window(1,:));
norm_p4_ch1 = distribution_window(1,4)/sum(distribution_window(1,:));
norm_dist_1 = [norm_p1_ch1, norm_p2_ch1, norm_p3_ch1, norm_p4_ch1];

norm_p1_ch2 = distribution_window(2,1)/sum(distribution_window(2,:));
norm_p2_ch2 = distribution_window(2,2)/sum(distribution_window(2,:));
norm_p3_ch2 = distribution_window(2,3)/sum(distribution_window(2,:));
norm_p4_ch2 = distribution_window(2,4)/sum(distribution_window(2,:));
norm_dist_2 = [norm_p1_ch2, norm_p2_ch2, norm_p3_ch2, norm_p4_ch2];

norm_p1_ch3 = distribution_window(3,1)/sum(distribution_window(3,:));
norm_p2_ch3 = distribution_window(3,2)/sum(distribution_window(3,:));
norm_p3_ch3 = distribution_window(3,3)/sum(distribution_window(3,:));
norm_p4_ch3 = distribution_window(3,4)/sum(distribution_window(3,:));
norm_dist_3 = [norm_p1_ch3, norm_p2_ch3, norm_p3_ch3, norm_p4_ch3];

norm_p1_ch4 = distribution_window(4,1)/sum(distribution_window(4,:));
norm_p2_ch4 = distribution_window(4,2)/sum(distribution_window(4,:));
norm_p3_ch4 = distribution_window(4,3)/sum(distribution_window(4,:));
norm_p4_ch4 = distribution_window(4,4)/sum(distribution_window(4,:));
norm_dist_4 = [norm_p1_ch4, norm_p2_ch4, norm_p3_ch4, norm_p4_ch4];

normalised_distribution_window = [norm_dist_1; norm_dist_2; norm_dist_3;...
    norm_dist_4];
 %return normalised_distribion_window

% % %%% NRMALISE PHOTON EVENTS IN TIMING WINDOW %%%%%%%%%%%%%%%%%%%
% figure; bar(normalised_distribution_window)
% title(['NORMALISED WITH TIMING WINDOW: CH1 (dark blue),'...
%     'CH2 (light blue),CH3 (green), CH4 (yellow)']);
% xlabel(['Pulse level']);ylabel(['Normalised total counts in timing window']);
