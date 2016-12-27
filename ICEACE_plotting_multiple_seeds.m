clc
close all
clear all

warning off
%load data
load('DATA_MS_40002.mat') %var 40002
%for saving figures - Define path to figure folder
FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\MultipleSeeds');
current_folder = cd;
mkdir(FigPat);
%Define parameters
AlphaBeta = {'a10b25','a30b25','a10b30','a30b30','a10b35','a30b35'};
SelectedAB = [1,2,3,4,5,6]; %Normally use this
%SelectedAB = [1,3,5,2,4,6]; %For different ordering of parameters
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
%colori = {[204/255 0 0],[0 204/255 204/255],[204/255 204/255 0],[0 204/255 0],...
%        [204/255 102/255 0],[0 0 204/255],[102/255 0 204/255],[204/255 0 102/255],[96/255 96/255 96/255]};
colori = {[0 0 0],[1 215/255 0],[220/255 20/255 60/255],[64/255 224/255 208/255],[50/255 205/255 50/255],[106/255 90/255 205/255]};
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
    i = 0;
    for k=1:Num_years     
        GINI_net_y(k) = mean(GINI_netto_MS_mean(iii,j+1:j+Num_weeks_in_year));
        GINI_gross_y(k) = mean(GINI_gross_MS_mean(iii,j+1:j+Num_weeks_in_year));
        GINI_DI_y(k) = mean(GINI_DI_MS_mean(iii,j+1:j+Num_weeks_in_year));
        GINI_QI_y(k) = mean(GINI_QI_MS_mean(iii,j+1:j+Num_weeks_in_year));
        Real_GDP_y(k) = mean(RealGDP_MS_mean(iii,i+1:i+12));
        Unemployment_y(k) = mean(Unemployment_MS_mean(iii,i+1:i+12));
        GINI_Mortgages_y(k) = mean(GINI_mortgages_MS_mean(iii,j+1:j+Num_weeks_in_year));
        HousingPrice_y(k) = mean(HousingPrices_MS_mean(iii,j+1:j+Num_weeks_in_year));
        Dividends_y(k) = mean(CapitalIncome_MS_mean(iii,j+1:j+Num_weeks_in_year));
        Mortgages_y(k) = mean(Mortgages_CAP_MS_mean(iii,j+1:j+Num_weeks_in_year)+Mortgages_nonCAP_MS_mean(iii,j+1:j+Num_weeks_in_year));
        j = j + Num_weeks_in_year;
        i = i + 12;
    end
    
    figure(9);
    set(gcf,'Name','Gini Index yearly')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,2,1); hold on; grid on; box on
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    legend(Legends_for_figs(SelectedAB),'Location','Best')
    hold off
    
    subplot(3,2,2); hold on; grid on; box on
    plot(GINI_gross_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(3,2,3); hold on; grid on; box on
    plot(GINI_DI_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index DI','fontsize',font_sz)
    hold off
    
    subplot(3,2,4); hold on; grid on; box on
    plot(GINI_QI_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index QI','fontsize',font_sz)
    hold off
    
    subplot(3,2,5); hold on; grid on; box on
    plot(Real_GDP_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Real GDP','fontsize',font_sz)
    hold off
    
    subplot(3,2,6); hold on; grid on; box on
    plot(GINI_Mortgages_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('GINI index Mortgages','fontsize',font_sz)
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
    Real_GDP_d = diff(Real_GDP_y);
    
    figure(10);
    set(gcf,'Name','Gini Index delta')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    subplot(2,1,1); hold on; grid on; box on
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
    
    subplot(2,1,2); hold on; grid on; box on
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
    figure(13);hold on; grid on; box on;
    set(gcf,'Name','Gini Index yearly')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii <= 2
    subplot(3,1,1)
    hold on; grid on; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB(1:2)),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii > 2 && iii <= 4    
    subplot(3,1,2)
    hold on; grid on; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB(3:4)),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii > 4
    subplot(3,1,3)
    hold on; grid on; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB(5:6)),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    end
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Gini_Index_yearly_net_v1','.pdf'))
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
    
    figure(23);hold on; grid on; box on
    set(gcf,'Name','Economy: Debt-Service-to-Income')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year, DSTI,'Color',colore,'linewidth',line_wdt)
    ylabel('DSTI all households','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
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
    
    
    figure(24);hold on; grid on; box on
    set(gcf,'Name','Mortgages')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealMortgages,'Color',colore,'linewidth',line_wdt)
    ylabel('Mortgages in real terms','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend_handle = legend(Legends_for_figs(SelectedAB),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
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
    figure(25);hold on; grid on; box on
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
    
    
    %% Gini index yearly - only net
    figure(26);hold on; grid on; box on;
    set(gcf,'Name','Gini Index yearly')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1 || iii == 3 || iii == 5
    subplot(2,1,1)
    hold on; grid on; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([1,3,5])),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii == 2 || iii == 4 || iii == 6
    subplot(2,1,2)
    hold on; grid on; box on;
    plot(GINI_net_y,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[0 0.6])
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index - Net wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([2,4,6])),'Location','NorthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    end
   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Gini_Index_yearly_net_v2','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 27: Real GDP by alpha
    figure(27);hold on; grid on; box on;
    set(gcf,'Name','GDP yearly by alpha')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1 || iii == 3 || iii == 5
    subplot(2,1,1)
    hold on; grid on; box on;
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[20000 45000])
    xlabel('years','fontsize',font_sz)
    ylabel('Real GDP','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([1,3,5])),'Location','SouthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii == 2 || iii == 4 || iii == 6
    subplot(2,1,2)
    hold on; grid on; box on;
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(iii,:),'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    set(gca,'YLim',[20000 45000])
    xlabel('years','fontsize',font_sz)
    ylabel('Real GDP','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([2,4,6])),'Location','SouthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    end
   
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Real_GDP_v2','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 28: Economy: Gini Index speed of change
    
    figure(28);
    set(gcf,'Name','Gini Index delta')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1 || iii == 3 || iii == 5
    subplot(2,1,1); hold on; grid on; box on
    plot(GINI_net_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net Wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([1,3,5])),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    elseif iii == 2 || iii == 4 || iii == 6
    subplot(2,1,2); hold on; grid on; box on
    plot(GINI_net_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net Wealth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([2,4,6])),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index_net_delta','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 29: Economy: Gini Index speed of change
    
    figure(29);
    set(gcf,'Name','Gini Index delta')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1 || iii == 3 || iii == 5
    subplot(2,1,1); hold on; grid on; box on
    plot(GINI_QI_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Quarterly Income','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([1,3,5])),'Location','SouthEast');
    set(legend_handle, 'Box', 'off')
    set(gca,'ylim',[-0.06 0.06])
    hold off
    elseif iii == 2 || iii == 4 || iii == 6
    subplot(2,1,2); hold on; grid on; box on
    plot(GINI_QI_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Quarterly Income','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([2,4,6])),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    set(gca,'ylim',[-0.06 0.06])
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index_QI_delta','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 30: Cross correlation net wealth
    
    figure(30);
    set(gcf,'Name','CrossCorrelationNW')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(Real_GDP_y,GINI_net_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr real GDP and net wealth','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_net_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_net_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_net_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr real GDP and net wealth','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_net_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_net_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_real_GDP_NW','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 31: Cross correlation QI
    
    figure(31);
    set(gcf,'Name','CrossCorrelationQI')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(Real_GDP_y,GINI_QI_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr real GDP and Income','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_QI_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_QI_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_QI_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr real GDP and Income','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_QI_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(Real_GDP_y,GINI_QI_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_real_GDP_QI','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 32: Cross correlation QI
    
    figure(32);
    set(gcf,'Name','CrossCorrelationHP')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(Real_GDP_y,HousingPrice_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr real GDP and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(Real_GDP_y,HousingPrice_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(Real_GDP_y,HousingPrice_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(Real_GDP_y,HousingPrice_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr real GDP and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(Real_GDP_y,HousingPrice_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(Real_GDP_y,HousingPrice_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_real_GDP_HP','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 33: Cross correlation QI
    
    figure(33);
    set(gcf,'Name','CrossCorrelationDiv')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(Real_GDP_y,Dividends_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr real GDP and Capital Income','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(Real_GDP_y,Dividends_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(Real_GDP_y,Dividends_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(Real_GDP_y,Dividends_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr real GDP and Capital Income','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(Real_GDP_y,Dividends_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(Real_GDP_y,Dividends_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_real_GDP_CI','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 34: Debt service to Income
    
    figure(34);hold on; grid on; box on
    set(gcf,'Name','Economy: Debt-Service-to-Income')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1 || iii == 3 || iii == 5
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year, DSTI,'Color',colore,'linewidth',line_wdt)
    ylabel('DSTI - Households','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend_handle = legend(Legends_for_figs(SelectedAB([1,3,5])),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    hold off
    
    elseif iii == 2 || iii == 4 || iii == 6
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year, DSTI,'Color',colore,'linewidth',line_wdt)
    ylabel('DSTI - Households','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    legend_handle = legend(Legends_for_figs(SelectedAB([2,4,6])),'Location','SouthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_DSTI','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 35: Cross correlation NW and Div
    
    figure(35);
    set(gcf,'Name','CrossCorrelation NW Div')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(GINI_net_y,Dividends_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr Net Wealth and Capital Income','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(GINI_net_y,Dividends_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(GINI_net_y,Dividends_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(GINI_net_y,Dividends_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr Net Wealth and Capital Income','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(GINI_net_y,Dividends_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(GINI_net_y,Dividends_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_NW_CI','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 36: Cross correlation NW and HP
    
    figure(36);
    set(gcf,'Name','CrossCorrelation NW HP')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(GINI_net_y,HousingPrice_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr Net Wealth and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(GINI_net_y,HousingPrice_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(GINI_net_y,HousingPrice_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(GINI_net_y,HousingPrice_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr Net Wealth and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(GINI_net_y,HousingPrice_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(GINI_net_y,HousingPrice_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_NW_HP','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 37: Cross correlation real GDP and Mortgages
    
    figure(37);
    set(gcf,'Name','CrossCorrelation GDP Mort')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(Real_GDP_y,Mortgages_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr Net Wealth and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(Real_GDP_y,Mortgages_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(Real_GDP_y,Mortgages_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(Real_GDP_y,Mortgages_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr Net Wealth and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(Real_GDP_y,Mortgages_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(Real_GDP_y,Mortgages_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_GDP_Mort','.pdf'))
    cd(current_folder);
    end
   
    
    %% Figure 38: Economy: Real GDP speed of change
    Real_GDP_d = Real_GDP_d./Real_GDP_y(1:end-1);
    Real_GDP_sum_growth(iii) = sum(Real_GDP_d);
    
    figure(38);
    set(gcf,'Name','real GDP growth')
    %set(gcf,'PaperType','A4')
    %set(gcf,'PaperPosition',[0,0,8.26,11.69])
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1 || iii == 3 || iii == 5
    subplot(2,1,1); hold on; grid on; box on
    plot(Real_GDP_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Real GDP growth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([1,3,5])),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    %set(gca,'ylim',[-0.06 0.06])
    hold off
    elseif iii == 2 || iii == 4 || iii == 6
    subplot(2,1,2); hold on; grid on; box on
    plot(Real_GDP_d,'Color',colore,'linewidth',line_wdt)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Real GDP growth','fontsize',font_sz)
    legend_handle = legend(Legends_for_figs(SelectedAB([2,4,6])),'Location','NorthEast');
    set(legend_handle, 'Box', 'off')
    %set(gca,'ylim',[-0.06 0.06])
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Real_GDP_delta','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 39: Inequality by seeds real GDP QI
    
    figure(39);
    set(gcf,'Name','Inequality by seeds Real GDP QI')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(3,1,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_QI_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.1 0.1])
    set(AX(2),'Ytick',[-0.1:0.05:0.1])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(1))
    legend_handle = legend('Real GDP growth (l-axis)','Quarterly income GINI growth (r-axis)','Net wealth GINI growth');
    set(legend_handle, 'Box', 'off')
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 3
    subplot(3,1,2); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_QI_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.1 0.1])
    set(AX(2),'Ytick',[-0.1:0.05:0.1])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(3))
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 5
    subplot(3,1,3); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_QI_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.1 0.1])
    set(AX(2),'Ytick',[-0.1:0.05:0.1])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(5))
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Inequality_dynamics_by_seeds_GDP_QI_10','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 40: Inequality by seeds real GDP QI
    
    figure(40);
    set(gcf,'Name','Inequality by seeds Real GDP QI')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 2
    subplot(3,1,1); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_QI_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.1 0.1])
    set(AX(2),'Ytick',[-0.1:0.05:0.1])
    set(AX,'xlim',[1 24])
    title(Legends_for_figs(2))
    legend_handle = legend('Real GDP growth (l-axis)','Quarterly income GINI growth (r-axis)','Net wealth GINI growth');
    set(legend_handle, 'Box', 'off')
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 4
    subplot(3,1,2); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_QI_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.1 0.1])
    set(AX(2),'Ytick',[-0.1:0.05:0.1])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(4))
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 6
    subplot(3,1,3); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_QI_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.1 0.1])
    set(AX(2),'Ytick',[-0.1:0.05:0.1])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(6))
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Inequality_dynamics_by_seeds_GDP_QI_30','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 41: Inequality by seeds real GDP QI
    
    figure(41);
    set(gcf,'Name','Inequality by seeds Real GDP NW')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(3,1,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_net_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.01 0.05])
    set(AX(2),'Ytick',[-0.01:0.01:0.05])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(1))
    legend_handle = legend('Real GDP growth (l-axis)','Net wealth GINI growth (r-axis)','Net wealth GINI growth');
    set(legend_handle, 'Box', 'off')
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 3
    subplot(3,1,2); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_net_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.01 0.05])
    set(AX(2),'Ytick',[-0.01:0.01:0.05])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(3))
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 5
    subplot(3,1,3); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_net_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.01 0.05])
    set(AX(2),'Ytick',[-0.01:0.01:0.05])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(5))
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Inequality_dynamics_by_seeds_GDP_NW_10','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 42: Inequality by seeds real GDP QI
    
    figure(42);
    set(gcf,'Name','Inequality by seeds Real GDP NW')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 2
    subplot(3,1,1); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_net_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.01 0.05])
    set(AX(2),'Ytick',[-0.01:0.01:0.05])
    set(AX,'xlim',[1 24])
    title(Legends_for_figs(2))
    legend_handle = legend('Real GDP growth (l-axis)','Net wealth GINI growth (r-axis) ','Net wealth GINI growth');
    set(legend_handle, 'Box', 'off')
    ylabel('Growth rate','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    elseif iii == 4
    subplot(3,1,2); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_net_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.01 0.05])
    set(AX(2),'Ytick',[-0.01:0.01:0.05])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(4))
    xlabel('years','fontsize',font_sz)
    ylabel('Growth rate','fontsize',font_sz)
    hold off
    elseif iii == 6
    subplot(3,1,3); hold on; grid on; box on
    [AX,H1,H2] = plotyy(1:24,Real_GDP_d,1:24,GINI_net_d);
    set(H1,'Color',colori{1},'linewidth',line_wdt)
    set(H2,'Color',colori{3},'linewidth',line_wdt)
    set(AX(1),'ycolor',colori{1})
    set(AX(2),'ycolor',colori{3})
    set(AX(1),'ylim',[-0.3 0.3])
    set(AX(1),'Ytick',[-0.3:0.1:0.3])
    set(AX(2),'ylim',[-0.01 0.05])
    set(AX(2),'Ytick',[-0.01:0.01:0.05])
    set(AX,'xlim',[1 Num_years-1])
    title(Legends_for_figs(6))
    xlabel('years','fontsize',font_sz)
    ylabel('Growth rate','fontsize',font_sz)
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Inequality_dynamics_by_seeds_GDP_NW_30','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 43: Cross correlation real GDP and Unemployment
    
    figure(43);
    set(gcf,'Name','CrossCorrelation GDP Mort')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    if iii == 1
    subplot(2,3,1); hold on; grid on; box on
    title(Legends_for_figs(1))
    crosscorr(Real_GDP_y,Unemployment_y)
    title(Legends_for_figs(1))
    ylabel('Cross-Corr Net Wealth and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 3
    subplot(2,3,2); hold on; grid on; box on
    crosscorr(Real_GDP_y,Unemployment_y)
    title(Legends_for_figs(3))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 5
    subplot(2,3,3); hold on; grid on; box on
    crosscorr(Real_GDP_y,Unemployment_y)
    title(Legends_for_figs(5))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 2
    subplot(2,3,4); hold on; grid on; box on
    crosscorr(Real_GDP_y,Unemployment_y)
    title(Legends_for_figs(2))
    ylabel('Cross-Corr Net Wealth and Housing Price','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 4
    subplot(2,3,5); hold on; grid on; box on
    crosscorr(Real_GDP_y,Unemployment_y)
    title(Legends_for_figs(4))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    elseif iii == 6
    subplot(2,3,6); hold on; grid on; box on
    crosscorr(Real_GDP_y,Unemployment_y)
    title(Legends_for_figs(6))
    ylabel('','fontsize',font_sz)
    grid on
    hold off
    end
    
    %file save pdf
    if iii == SelectedAB(end)
    cd(FigPat);
    saveas(gcf,strcat('Cross_correlation_GDP_Unemp','.pdf'))
    cd(current_folder);
    end
    
    
end

