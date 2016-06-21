clc
close all
clear all

warning off
%load data
load('DATA_MS_50000.mat')
%for saving figures - Define path to figure folder
FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\MultipleSeeds');
current_folder = cd;
mkdir(FigPat);
%Define parameters
AlphaBeta = {'a10b25','a30b25','a10b30','a30b30','a10b35','a30b35'};
SelectedAB = [1,2,3,4]; %Normally use this
%SelectedAB = [1,4,7,2,5,8,3,6,9]; %For different ordering of parameters
Legends_for_figs = {'\alpha=0.1,\beta=0.25','\alpha=0.3,\beta=0.25',...
    '\alpha=0.1,\beta=0.3','\alpha=0.3,\beta=0.3'...
    '\alpha=0.1,\beta=0.35','\alpha=0.3,\beta=0.35'};
Legends_for_figs_2 = {'\alpha=0.1,\beta=0.25','\alpha=0.3,\beta=0.25',...
    '\alpha=0.1,\beta=0.3','\alpha=0.3,\beta=0.3',...
    '\alpha=0.1,\beta=0.35','\alpha=0.3,\beta=0.35',...
    '\alpha=0.1,\beta=0.25','\alpha=0.3,\beta=0.25',...
    '\alpha=0.1,\beta=0.3','\alpha=0.3,\beta=0.3',...
    '\alpha=0.1,\beta=0.35','\alpha=0.3,\beta=0.35'};

%Legends_for_figs = {'\alpha=0.1,\beta=0.25','\alpha=0.2,\beta=0.25','\alpha=0.3,\beta=0.25',...
%    '\alpha=0.1,\beta=0.3','\alpha=0.2,\beta=0.3','\alpha=0.3,\beta=0.3'...
%    '\alpha=0.1,\beta=0.4','\alpha=0.2,\beta=0.4','\alpha=0.3,\beta=0.4'};
%Legends_for_figs_2 = {'\alpha=0.1,\beta=0.25','\alpha=0.2,\beta=0.25','\alpha=0.3,\beta=0.25',...
%    '\alpha=0.1,\beta=0.3','\alpha=0.2,\beta=0.3','\alpha=0.3,\beta=0.3',...
%    '\alpha=0.1,\beta=0.4','\alpha=0.2,\beta=0.4','\alpha=0.3,\beta=0.4',...
%    '\alpha=0.1,\beta=0.25','\alpha=0.2,\beta=0.25','\alpha=0.3,\beta=0.25',...
%    '\alpha=0.1,\beta=0.3','\alpha=0.2,\beta=0.3','\alpha=0.3,\beta=0.3',...
%    '\alpha=0.1,\beta=0.4','\alpha=0.2,\beta=0.4','\alpha=0.3,\beta=0.4'};
%Define RunNumbers
%% set colors for plots
%colori = {'k';'b';'g';'r';'y';'m';'--k';'--b';'--g'};
colori = {[204/255 0 0],[0 204/255 204/255],[204/255 204/255 0],[0 204/255 0],...
        [204/255 102/255 0],[0 0 204/255],[102/255 0 204/255],[204/255 0 102/255],[96/255 96/255 96/255]};
coloridotted = {':k';':b';':g';':r';':y';':m';'-.k';'-.b';'-.g'};

for iii = SelectedAB
    
    %set font size and select colors
    font_sz = 8;
    line_wdt = 2;
    colore = colori{iii};
    %coloredased = coloridased{counter};
    coloredotted = coloridotted{iii};
    colore2 = colori{iii};
    %Simulation duration
    TimeConstants.NrMonthsInQuarter = 3;    % Number of Months in 1 Quarter
    TimeConstants.NrMonthsInYear = TimeConstants.NrMonthsInQuarter*4;
    TimeConstants.NrDaysInWeek = 1;         % Number of days in one week
    TimeConstants.NrWeeksInMonth = 4;       % Number of weeks in one month
    TimeConstants.NrWeeksInQuarter = TimeConstants.NrWeeksInMonth*TimeConstants.NrMonthsInQuarter;
    TimeConstants.NrDaysInMonth = TimeConstants.NrDaysInWeek*TimeConstants.NrWeeksInMonth; % Number of days in one month
    TimeConstants.NrDaysInQuarter = TimeConstants.NrMonthsInQuarter*TimeConstants.NrDaysInMonth;
    TimeConstants.NrDaysInYear = TimeConstants.NrDaysInQuarter*4;
    SimulationStartingDay = 12;
    SimulationDurationInQuarters = 100;
    SimulationFinalDay = SimulationStartingDay + SimulationDurationInQuarters*TimeConstants.NrDaysInQuarter;
    SimulationDurationInDays = SimulationDurationInQuarters*TimeConstants.NrDaysInQuarter;
    %set visualization vectors
    XVector_quarter = (1:(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInQuarter;
    XVector_year = (1:(SimulationFinalDay-SimulationStartingDay))/(TimeConstants.NrDaysInYear);
    XVector_month = (1:(SimulationFinalDay-SimulationStartingDay)/TimeConstants.NrDaysInMonth);
    Num_years = (SimulationFinalDay-SimulationStartingDay)./TimeConstants.NrDaysInYear;
    Num_quarters = (SimulationFinalDay-SimulationStartingDay)./TimeConstants.NrDaysInQuarter;
    Num_weeks_in_year = TimeConstants.NrMonthsInYear*TimeConstants.NrWeeksInMonth;
    Num_weeks_in_quarter = Num_weeks_in_year/4;
    quarters_visualization_step = 1;
    visualization_vector = (0:(quarters_visualization_step*TimeConstants.NrDaysInQuarter):(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInQuarter;
    visualization_vector_quarter = (0:(quarters_visualization_step*TimeConstants.NrDaysInQuarter):(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInYear;
    
    %% Figure 1: Economy: RealGDP and Unemployment
    figure(1)
    set(gcf,'Name','Economy: RealGDP and Unemployment')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[20000 50000])
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    title('Real GDP')
    hold off
    
    subplot(2,1,2);hold on; grid on; box on
    plot(XVector_year,Unemployment_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('Unemployment','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'ylim',[0 0.15])
    title('Unemployment')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealGDP_Unemployment','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 2: Cap vs. NonCap: Mortgage share of households M=Mortgages    
    figure(2)
    set(gcf,'Name','Mortgages')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year,Mortgages_CAP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Mortgages_nonCAP_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgage share of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    title('Mortgages: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2);hold on; grid on; box on;
    plot(XVector_year,Mortgages_CAP_MS_mean((iii),:)./Total_num_capitalists(iii),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Mortgages_nonCAP_MS_mean((iii),:)./Total_num_noncapitalists(iii),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgages of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Mortgages: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Mortgages','.pdf'))
    cd(current_folder);
    end
    
    
    %% Figure 3: Cap vs. NonCap:Disposable Income D=Disposable Income
    figure(3)
    set(gcf,'Name','Disposable Income')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1);hold on; grid on; box on;
    plot(XVector_year,DI_CAP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,DI_nonCAP_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Disposable Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    title('Disposable Income: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year,DI_CAP_MS_mean(iii,:)./Total_num_capitalists(iii),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,DI_CAP_MS_mean(iii,:)./Total_num_noncapitalists(iii),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Disposable Income: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_DisposableIncome','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 4: Cap vs. NonCap: Housing units        
    figure(4)
    set(gcf,'Name','Housing Units')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1);hold on; grid on; box on;
    plot(XVector_year,HU_CAP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,HU_nonCAP_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Housing Units of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Housing Units: Cap vs. NonCap')
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year,HU_CAP_MS_mean(iii,:)./Total_num_capitalists(iii),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,HU_nonCAP_MS_mean(iii,:)./Total_num_noncapitalists(iii),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Housing Units of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(Legends_for_figs(SelectedAB),Legends_for_figs(SelectedAB),'Location','Best')
    title('Housing Units: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_HousingUnits','.pdf'))
    cd(current_folder);
    end
     %% Figure 5: Economy: Gini Index
            
    figure(5);
    set(gcf,'Name','Gini Index')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(4,1,1); hold on; grid on; box on
    plot(XVector_year,GINI_netto_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(4,1,2); hold on; grid on; box on
    plot(XVector_year,GINI_gross_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(4,1,3); hold on; grid on; box on
    plot(XVector_year(1:12:end),GINI_DI_MS_mean(iii,1:12:end),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index DI','fontsize',font_sz)
    hold off
    
    subplot(4,1,4); hold on; grid on; box on
    plot(XVector_year(1:12:end),GINI_QI_MS_mean(iii,1:12:end),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index QI','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 6: Real Estate Market Financing
    figure(6); hold on; grid on; box on
    set(gcf,'Name','REmarket: Financing')
    plot(XVector_year,Mortgages_CAP_MS_mean(iii,:)+Mortgages_nonCAP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    title('Household mortgages')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Financing','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 7: Price, wage and housing Inflation
    figure(7); hold on; grid on
    set(gcf,'Name','REmarket: Housing price Transactions Housing stock')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on
    plot(XVector_month(13:end),InflationPrice_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Price inflation','fontsize',font_sz)
    %set(gca,'xtick',[0:12:300],'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on
    plot(XVector_month(13:end),InflationWages_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Wage inflation','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on, box on
    plot(XVector_month(13:end),InflationHousing_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Housing inflation','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Inflation_Prices_Wages_Housing','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 8: Real Housing Price
    
    RealHousingPrice = HousingPrices_MS_mean(iii,1:4:end)./Inflation_MS_mean(iii,:);
    
    figure(8); hold on; grid on
    set(gcf,'Name','REmarket: Housing price Transactions Housing stock')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on
    plot(XVector_month,RealHousingPrice,'Color',colore,'linewidth',line_wdt)
    ylabel('Real housing price','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector_quarter,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on
    plot(XVector_month,HousingPrices_MS_mean(iii,1:4:end),'Color',colore,'linewidth',line_wdt)
    ylabel('Nominal housing price','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector_quarter,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Real_Nominal_Housing_Price','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 9: Economy: Gini Index yearly
    j = 0;
    for k=1:Num_years     
        GINI_net_y(k) = mean(GINI_netto_MS_mean(iii,j+1:j+Num_weeks_in_year));
        GINI_gross_y(k) = mean(GINI_gross_MS_mean(iii,j+1:j+Num_weeks_in_year));
        GINI_DI_y(k) = mean(GINI_DI_MS_mean(iii,j+1:j+Num_weeks_in_year));
        GINI_QI_y(k) = mean(GINI_QI_MS_mean(iii,j+1:j+Num_weeks_in_year));
        j = j + Num_weeks_in_year;
    end
    
    figure(9);
    set(gcf,'Name','Gini Index yearly')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(4,1,1); hold on; grid on; box on
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(4,1,2); hold on; grid on; box on
    plot(GINI_gross_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(4,1,3); hold on; grid on; box on
    plot(GINI_DI_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index DI','fontsize',font_sz)
    hold off
    
    subplot(4,1,4); hold on; grid on; box on
    plot(GINI_QI_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index QI','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index_yearly','.pdf'))
    cd(current_folder);
    end
    
     %% Figure 10: Economy: Gini Index speed of change
    
    GINI_net_d = diff(GINI_net_y);
    GINI_gross_d = diff(GINI_gross_y);
    GINI_DI_d = diff(GINI_DI_y);
    GINI_QI_d = diff(GINI_QI_y);
    
    figure(10);
    set(gcf,'Name','Gini Index delta')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    subplot(2,1,1); hold on; grid off; box on
    plot(GINI_net_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net Wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
%     subplot(4,1,2); hold on; grid on; box on
%     plot(GINI_gross_d,'Color',colore,'linewidth',line_wdt)
%     set(gca,'xtick',visualization_vector,'fontsize',font_sz)
%     xlabel('years','fontsize',font_sz)
%     ylabel('Gini Index Gross','fontsize',font_sz)
%     hold off
%     
%     subplot(4,1,3); hold on; grid on; box on
%     plot(GINI_DI_d,'Color',colore,'linewidth',line_wdt)
%     set(gca,'xtick',visualization_vector,'fontsize',font_sz)
%     xlabel('years','fontsize',font_sz)
%     ylabel('Gini Index DI','fontsize',font_sz)
%     hold off
    
    subplot(2,1,2); hold on; grid off; box on
    plot(GINI_QI_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Quarterly Income','fontsize',font_sz)
    set(gca,'ylim',[-0.05 0.05])
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index_delta','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 11: Real Estate Market financial constraints
    figure(11); hold on; grid on; box on
    set(gcf,'Name','REmarket: financial comstraints')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    title('Banks mortgages blocked','fontsize',font_sz)
    plot(XVector_year,BankMortgageBlocked_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    title('Households mortgages rejected','fontsize',font_sz)
    plot(XVector_year,HHMortgageRejected_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Financial_Constraints','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 12: Central bank interest rates
    figure(12); hold on; grid on; box on
    set(gcf,'Name','REmarket: Central Bank interest rate')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    title('Central Bank interest rate','fontsize',font_sz)
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),CBInterestRate_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    %file save pdf   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Central_Bank_interest_rate','.pdf'))
    cd(current_folder);
    end
    
    %% Gini index yearly - only net
    figure(13);hold on; grid off; box on;
    set(gcf,'Name','Gini Index yearly')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii <=3
    subplot(3,1,1)
    hold on; grid off; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii >3 && iii <=6    
    subplot(3,1,2)
    hold on; grid off; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii>6
    subplot(3,1,3)
    hold on; grid off; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    end
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Gini_Index_yearly_net','.pdf'))
    cd(current_folder);
    end
    
    %% Taxes and benefits
    figure(14);hold on; grid on; box on
    set(gcf,'Name','Government and Policy')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_year,Liq_Gov_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Balance_Gov_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Liq and Balance','fontsize',font_sz)
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(XVector_year,UnempBenefitsPaid_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,GeneralBenefitsPaid_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Benefits','fontsize',font_sz)
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    plot(XVector_year,LaborTaxRate_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,CapitalIncomeTaxRate_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Tax rates','fontsize',font_sz)
    hold off
    
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Government_Policy','.pdf'))
    cd(current_folder);
    end
    
    %% Firms debt, liquidity, EBIT and Equity
    figure(15);hold on; grid on; box on
    set(gcf,'Name','Firms and CstrFirms Balance sheet and EBIT')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(4,1,1); hold on; grid on; box on
    plot(XVector_year,Debt_Firms_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Debt_CstrFirms_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Debt','fontsize',font_sz)
    hold off
    
    subplot(4,1,2); hold on; grid on; box on
    plot(XVector_year,Liq_Firms_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Liq_CstrFirms_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Liquidity','fontsize',font_sz)
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    hold off
    
    subplot(4,1,3); hold on; grid on; box on
    plot(XVector_year,EBIT_Firms_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,EBIT_CstrFirms_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('EBIT','fontsize',font_sz)
    hold off
    
    subplot(4,1,4); hold on; grid on; box on
    plot(XVector_year,Eq_Firms_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Eq_CstrFirms_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Equity','fontsize',font_sz)
    hold off
    
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Firms_CstrFirms_Debt_Liq_EBIT_Eq','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 16: Banks balance sheet
    figure(16); hold on; grid on; box on
    set(gcf,'Name','Banks: Balance sheet')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(4,1,1); hold on; grid on; box on
    plot(XVector_year,TA_Banks_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Total Assets','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(4,1,2); hold on; grid on; box on
    plot(XVector_year,CBDebt_Banks_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('CB Debt','fontsize',font_sz)
    hold off
    
    subplot(4,1,3); hold on; grid on; box on
    plot(XVector_year,Eq_Banks_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Equity','fontsize',font_sz)
    hold off
    
    subplot(4,1,4); hold on; grid on; box on
    plot(XVector_year,Loans_Banks_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Loans','fontsize',font_sz)
    hold off
    
    %file save pdf   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Banks_Balance_Sheet','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 17: Banks EBIT and Retained earnings
    figure(17); hold on; grid on; box on
    set(gcf,'Name','Banks: EBIT and Retained Earnings')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year,EBIT_Banks_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('EBIT','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    plot(XVector_year,RE_Banks_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Retained Earnings','fontsize',font_sz)
    hold off
    
    %file save pdf   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Banks_EBIT_RetainedEarnings','.pdf'))
    cd(current_folder);
    end
    
     %% Figure 18: Economy: RealGDP and Unemployment
    figure(18); hold on; grid on; box on
    set(gcf,'Name','Economy: RealGDP and debt')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[20000 50000])
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    title('Real GDP')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    plot(XVector_year,Mortgages_CAP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,Mortgages_nonCAP_MS_mean(iii,:),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgage share of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealGDP','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 19: Banks EBIT and Retained earnings
    figure(19); hold on; grid on; box on
    set(gcf,'Name','Housing market: Fire sales and writeoffs')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year,FireSales_HH_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Fire sales','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    plot(XVector_year,HH_MortgagesWrittenOff_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgage writoffs','fontsize',font_sz)
    hold off
    
    %file save pdf   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('HousingMarket_FireSales_Writeoffs','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 20: Cap vs. NonCap: Debt-to-Income
    figure(20)
    set(gcf,'Name','Households: Equity')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year(1:4:end),(CapHHEquity_MS_mean(iii,:))./(RegHHEquity_MS_mean(iii,:)),'Color',colore,'linewidth',line_wdt) %XVector_year(5:4:end),
    %plot(XVector_year(13:12:end),diff(RegHHEquity_MS_mean(iii,3:3:end)),'Color',colore,'linestyle',':','linewidth',line_wdt) %XVector_year(5:4:end),
    xlabel('years','fontsize',font_sz)
    ylabel('Equity of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %set(gca,'YLim',[0 250000])
    set(gca,'XLim',[0 25])
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    title('Equity: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2);hold on; grid on; box on;
    plot(XVector_year(13:12:end),diff(CapHHEquity_MS_mean(iii,3:3:end))./Total_num_capitalists(iii),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year(13:12:end),diff(RegHHEquity_MS_mean(iii,3:3:end))./Total_num_noncapitalists(iii),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Equity of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'YLim',[0 500])
    title('Equity: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Equity','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 21: Cap vs. NonCap:Quarterly Income Q=Quarterly Income
    
    Economy_total_QI = QuarterlyIncome_CAP_MS_mean(iii,:) + QuarterlyIncome_nonCAP_MS_mean(iii,:);
    
    figure(21)
    set(gcf,'Name','Quarterly Income')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1);hold on; grid on; box on;
    plot(XVector_year,QuarterlyIncome_CAP_MS_mean(iii,:)./Economy_total_QI,'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,QuarterlyIncome_nonCAP_MS_mean(iii,:)./Economy_total_QI,'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Quarterly Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    f=0;
    for v = 1:length(SelectedAB)
        f=f+1;
        vect_for_legend(f) = SelectedAB(v);        
        f=f+1;
        vect_for_legend(f) = SelectedAB(v)+length(AlphaBeta);
    end
    clear f
    legend(Legends_for_figs_2(vect_for_legend),'Location','Best')
    title('Quarterly Income: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year,QuarterlyIncome_CAP_MS_mean(iii,:)./Total_num_capitalists(iii),'Color',colore,'linewidth',line_wdt)
    plot(XVector_year,QuarterlyIncome_nonCAP_MS_mean(iii,:)./Total_num_noncapitalists(iii),'Color',colore,'linestyle',':','linewidth',line_wdt)
    xlabel('years','fontsize',font_sz)
    ylabel('Quarterly Income of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Quarterly Income: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_QuarterlyIncome','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 22: Debt to GDP
    Mortgages_monthly = Mortgages_CAP_MS_mean(iii,1:TimeConstants.NrDaysInMonth:end) + Mortgages_nonCAP_MS_mean(iii,1:TimeConstants.NrDaysInMonth:end);
    Loans_monthly = Debt_Firms_MS_mean(iii,1:TimeConstants.NrDaysInMonth:end) + Debt_CstrFirms_MS_mean(iii,1:TimeConstants.NrDaysInMonth:end);
    
    figure(22);hold on; grid on; box on
    set(gcf,'Name','Economy: Debt-to-RealGDP')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])

    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), (Loans_monthly + Mortgages_monthly),'Color',colore,'linewidth',line_wdt) %./RealGDP_MS_mean(iii,:)
    ylabel('Debt-to-GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    title('Debt-to-GDP')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealGDP_Unemployment','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 23: Debt service to Income
    DSTI = (QuarterlyRatio_CAP_MS_mean(iii,:) + QuarterlyRatio_nonCAP_MS_mean(iii,:))./(QuarterlyIncome_CAP_MS_mean(iii,:) + QuarterlyIncome_nonCAP_MS_mean(iii,:));
    DSTI_CAP = QuarterlyRatio_CAP_MS_mean(iii,:)./QuarterlyIncome_CAP_MS_mean(iii,:);
    DSTI_nonCAP = QuarterlyRatio_nonCAP_MS_mean(iii,:)./QuarterlyIncome_nonCAP_MS_mean(iii,:);
    
    figure(23);hold on; grid off; box on
    set(gcf,'Name','Economy: Debt-Service-to-Income')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    subplot(2,1,1); hold on; grid off; box on;
    plot(XVector_year, DSTI,'Color',colore,'linewidth',line_wdt)
    ylabel('DSTI all households','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
    subplot(2,1,2); hold on; grid off; box on;
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    %plot(XVector_year, DSTI_CAP,'Color',colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_DSTI','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 24: Mortgages
    RealMortgages = Mortgages_monthly;%(100*(Mortgages_monthly))./Inflation_MS_mean(iii,:);
    
    
    figure(24);hold on; grid off; box on
    set(gcf,'Name','Mortgages')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    subplot(2,1,1); hold on; grid off; box on;
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealMortgages,'Color',colore,'linewidth',line_wdt)
    ylabel('Mortgages in real terms','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
    subplot(2,1,2); hold on; grid off; box on;
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Real_Mortgages_GDP','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 25
    figure(25);hold on; grid off; box on
    set(gcf,'Name','Real GDP')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[0 50000])
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','SouthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Real_GDP','.pdf'))
    cd(current_folder);  
    end
    
end

