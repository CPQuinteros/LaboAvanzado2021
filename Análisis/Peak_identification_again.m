% clear all;
% close all;
% clc;

%% Upload raw file, define variables of interest, and plot the I-t

load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Run144.txt
% sample designation = YF092 (STO/LSMO/HZO/Ti/Au)
% experimental conditions = Run144 (~ -5V)
t = Run144(:,1); 
IB = Run144(:,3);
sIB = smooth(IB);
ssIB = smooth(IB,'sgolay',2);
mIB = -1*Run144(:,3);
%IA = -1*Run144(:,6);
DeltaV = Run144(:,5)-Run144(:,2);

% for i = 1:size(Run144(:,1))
%     DeltaV(i) = Run144(i,5)-Run144(i,2);
%     t(i) = Run144(i,1);
%    if DeltaV(i) > 4.9
%        IB(i) = Run144(i,3);
%        mIB(i) = -1*Run144(i,3);
%    else
%        IB(i) = 0;
%        mIB(i) = 0;
%    end
% end

figure(1);

plot(t,IB,'DisplayName','local minima'); 

xlabel('Time (sec)')
ylabel('Measured Current (A)')
title('STO/LSMO/HZO/Ti/Au / -6 V / th = 1.10^{-4} A')
grid

hold on
plot(t,mIB,'DisplayName','local maxima')
%legend('IB','mIB')
legend


%% Find, save, and plot the local extremes

th = 1e-4;
findpeaks(ssIB,t,'MinPeakProminence',th,'Annotate','extents')
[pks,locs,w,p] = findpeaks(IB,t,'MinPeakProminence',th);
A_p = [pks(2:size(w,1)-1) locs(2:size(w,1)-1) w(2:size(w,1)-1) p(2:size(w,1)-1)];
% A_p = [pks(1:size(w,1)-1) locs(1:size(w,1)-1) w(1:size(w,1)-1)
% p(1:size(w,1)-1)]; %for Mart's meas
hold on
findpeaks(mIB,t,'MinPeakProminence',th,'Annotate','extents')
[pks_m,locs_m,w_m,p_m] = findpeaks(mIB,t,'MinPeakProminence',th);
A_m = [pks_m(1:size(w_m,1)-2) locs_m(1:size(w_m,1)-2) w_m(1:size(w_m,1)-2) p_m(1:size(w_m,1)-2)];
% A_m = [pks_m(2:size(w_m,1)) locs_m(2:size(w_m,1)) w_m(2:size(w_m,1))
% p_m(2:size(w_m,1))]; %for Mart's meas

A = [A_p;A_m];
writematrix(A,'Sta_Run144_th1em4.txt','Delimiter','tab')

%% 

figure(2);

scatter(A_p(:,3)./10^(-6),A_p(:,4)./10^(-4),'DisplayName','local minima');
hold on
scatter(A_m(:,3)./10^(-6),A_m(:,4)./10^(-4),'filled','DisplayName','local maxima');

ylabel('Prominence (10^{-4} A)')
xlabel('Width (\mus)')
grid
legend
title('STO/LSMO/HZO/Ti/Au / -6 V / th = 1.10^{-4} A')

%% I-t plot with all local extremes (minima and maxima merged)

figure(3);

plot(t,IB,'k','DisplayName','IB'); %mIB for Mart's meas %IB for CQ's meas
hold on
plot(A_p(:,2),A_p(:,1),'r.');%-1*A_p for Mart's meas %A_p for CQ's meas
hold on
plot(A_m(:,2),-1*A_m(:,1),'r.');%A_m for Mart's meas %-1*A_m for CQ's meas

xlabel('Time (sec)')
ylabel('Measured Current (A)')
title('STO/LSMO/HZO/Ti/Au / -6 V / th = 1.10^{-4} A')
grid

%% 

figure(4);

scatter(A_p(:,2)./10^(-6),A_p(:,4)./10^(-4))
hold on
scatter(A_m(:,2)./10^(-6),A_m(:,4)./10^(-4),'filled')
grid
ylabel('Prominence (10^{-4} A)')
xlabel('time (10^{-6} s)')
legend('local minima','local maxima')
title('STO/LSMO/HZO/Ti/Au / -6 V / th = 1.10^{-4} A')

%% Histograms

figure(5);
%title('STO/LSMO/HZO/Ti/Au / -6 V / th = 1.10^{-4} A')

subplot(2,2,1);
histogram(A(:,3)./10^(-6),50)
% histfit(A(:,3)./10^(-6),50,'gp')
% pd_width = fitdist(A(:,3)./10^(-6),'gp')
xlabel('Width (\mus)')
ylabel('Counts')

subplot(2,2,2);
histogram(A(:,4)./10^(-4),50)
% histfit(A(:,4)./10^(-4),50,'gp')
% pd_prom = fitdist(A(:,4)./10^(-4),'gp')
xlabel('Prominence (10^{-4} A)')
ylabel('Counts')

subplot(2,2,3);
histogram(A(:,3)./10^(-6),50,'Normalization','cdf')
% histfit(A(:,3)./10^(-6),50,'Normalization','cdf')
xlabel('Width (\mus)')
ylabel('Accumulated normalized counts')

subplot(2,2,4);
histogram(A(:,4)./10^(-4),50,'Normalization','cdf')
% histfit(A(:,4)./10^(-4),50,'Normalization','cdf')
xlabel('Prominence (10^{-4} A)')
ylabel('Accumulated normalized counts')

%% 

figure(6);
%title('STO/LSMO/HZO/Ti/Au / -6 V / th = 1.10^{-4} V')

subplot(1,2,1);
histogram(A(:,3)./10^(-6),50)
% histfit(A(:,3)./10^(-6),50,'gp')%'beta')
% pd_width = fitdist(A(:,3)./10^(-6),'gp');%'beta')
xlabel('Width (\mus)')
ylabel('Counts')

subplot(1,2,2);
histogram((A(:,4)./(2*10^(-4))).*(A(:,3)./10^(-6)),50)
% histfit(A(:,4)./10^(-4),50,'gp')%'beta')
% pd_prom = fitdist(A(:,4)./10^(-4),'gp');%'beta')
xlabel('Size (10^{-10} A.s)')
ylabel('Counts')

%% Save the plots

% saveas(figure(1),'It-w-max-min_Run144_th1em4.png')
% saveas(figure(1),'It-w-max-min_Run144_th1em4.epsc')
% saveas(figure(1),'It-w-max-min_Run144_th1m4.fig')
% saveas(figure(2),'PromVsWidth_Run144_th1m4.png')
% saveas(figure(2),'PromVsWidth_Run144_th1m4.epsc')
% saveas(figure(2),'PromVsWidth_Run144_th1m4.fig')
% saveas(figure(3),'It-w-extremes_Run144_th1m4.png')
% saveas(figure(3),'It-w-extremes_Run144_th1m4.epsc')
% saveas(figure(3),'It-w-extremes_Run144_th1m4.fig')
% saveas(figure(4),'Run144_th1m4_Prominence-vs-time_MaxAndMin.png')
% saveas(figure(4),'Run144_th1m4_Prominence-vs-time_MaxAndMin.epsc')
% saveas(figure(4),'Run144_th1m4_Prominence-vs-time_MaxAndMin.fig')
% saveas(figure(5),'Run144_th1m4_ProminenceAndWidth_Hist.png')
% saveas(figure(5),'Run144_th1m4_ProminenceAndWidth_Hist.epsc')
% saveas(figure(5),'Run144_th1m4_ProminenceAndWidth_Hist.fig')
% saveas(figure(6),'Run144_th1m4_WidthAndSize_Hist.png')
% saveas(figure(6),'Run144_th1m4_WidthAndSize_Hist.epsc')
% saveas(figure(6),'Run144_th1m4_WidthAndSize_Hist.fig')