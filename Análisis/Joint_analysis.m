clear all;
close all;
clc;

%% The script starts

% Mart's runs
% load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run68_th1em5.txt
% load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run69_th1em5.txt
% load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run72_th1em5.txt

load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run137_th1em4.txt
load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run138_th1em4.txt
load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run139_th1em4.txt
load C:\Users\cpqui\SOFTWARE\MATLAB-mix\Spikes\Sta_Run144_th1em4.txt

% sample designation = YF092 (STO/LSMO/HZO/Ti/Au)
% experimental conditions ~ -6 V

A1 = Sta_Run137_th1em4;
A2 = Sta_Run138_th1em4;
A3 = Sta_Run139_th1em4;
A4 = Sta_Run139_th1em4;
M = [A1;A2;A3;A4];

%% Histograms - full range and zoom-ins

figure(1);
%title('STO/LSMO/HZO/Ti/Au / -5 V / th = 1.10^{-5} A')

subplot(2,4,1);
hw = histogram(M(:,3)./10^(-6),50,'FaceColor','#EDB120');
xlabel('Width (\mus)')
ylabel('Counts')

subplot(2,4,2);
histogram(M(:,4)./10^(-4),50,'FaceColor','#4DBEEE')
xlabel('Prominence (10^{-4} A)')
ylabel('Counts')

subplot(2,4,3);
histogram(abs(M(:,1))./10^(-4),50,'FaceColor','#77AC30')
xlabel('Peaks (10^{-4} A)')
ylabel('Counts')

subplot(2,4,4);
hs = histogram((M(:,4)./(2*10^(-4))).*(M(:,3)./10^(-6)),50,'FaceColor','#A2142F');
xlabel('Size (10^{-10} A.s)')
ylabel('Counts')

rw = linspace(0,2,50);
subplot(2,4,5);
hwz = histogram(M(:,3)./10^(-6),rw,'FaceColor','#D95319');
xlabel('Width (\mus)')
ylabel('Counts')

rp = linspace(0,1.3,50);
subplot(2,4,6);
histogram(M(:,4)./10^(-4),rp,'FaceColor','#0072BD')
xlabel('Prominence (10^{-4} A)')
ylabel('Counts')

% ry = linspace(x1,x2,50);
% subplot(2,2,3);
% histogram(abs(M(:,1))./10^(-4),50,'FaceColor',)
% xlabel('Peaks (10^{-4} A)')
% ylabel('Counts')

rs = linspace(0,0.5,50);
subplot(2,4,8);
hsz = histogram((M(:,4)./(2*10^(-4))).*(M(:,3)./10^(-6)),rs,'FaceColor','#7E2F8E');
xlabel('Size (10^{-10} A.s)')
ylabel('Counts')

% %% 
% 
% figure(2);
% 
% scatter(M(:,3)./10^(-6),M(:,4)./10^(-4),'DisplayName','local extremes');
% 
% ylabel('Prominence (10^{-4} A)')
% xlabel('Width (\mus)')
% grid
% legend
% title('STO/LSMO/HZO/Ti/Au / -5 V / th = 1.10^{-5} A')

%%

figure(3);

scatter(log(M(:,3)./10^(-6)),log(M(:,3).*M(:,4)./(10^(-6)*10^(-4)*2)))
hold on

p = polyfit(log(M(:,3)./10^(-6)),log(M(:,3).*M(:,4)./(10^(-6)*10^(-4)*2)),1);
% x = linspace(min(log(M(:,3)./10^(-6))),max(log(M(:,3)./10^(-6))),size(yfit));

yfit = polyval(p,log(M(:,3)./10^(-6)));

plot(log(M(:,3)./10^(-6)),yfit)

xlabel('log_{10} width')
ylabel('log_{10} size')
grid
title('STO/LSMO/HZO/Ti/Au / -5 V / th = 1.10^{-5} A')

%% 

figure(4)

w_counts = hwz.Values;
w_bins = hwz.BinEdges;

s_counts = hsz.Values;
s_bins = hsz.BinEdges;

subplot(1,2,1);
scatter(log(w_bins(1:size(w_bins,2)-1)),log(w_counts),'filled');%,'#D95319')
xlabel('log (T/\mus)')
ylabel('log N')
grid

subplot(1,2,2);
scatter(log(s_bins(1:size(s_bins,2)-1)),log(s_counts),'filled');%,'#7E2F8E')
xlabel('log (S/10^{-10} A.s)')
ylabel('log N')
grid

% loglog(bins(1:size(bins,2)-1),counts,'ko')

% FT = fittype('(x.^k).*exp(x./n)');  % y = f(x)
% f0 = fit(bins(1:size(bins,2)-1),counts,FT);


%% 

% saveas(figure(1),'Statistics_YF092_by-Mart.fig')
% saveas(figure(1),'Statistics_YF092_by-Mart.png')
% saveas(figure(1),'Statistics_YF092_by-Mart.epsc')
% saveas(figure(2),'PromVsWidth_YF092_by-Mart.fig')
% saveas(figure(2),'PromVsWidth_YF092_by-Mart.png')
% saveas(figure(2),'PromVsWidth_YF092_by-Mart.epsc')