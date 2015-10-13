clc
close all
clear all

%set counter
counter = 0;
%load data
load('DATA_MS.mat')
%for saving figures - Define path to figure folder
FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\MultipleSeeds');
current_folder = cd;
mkdir(FigPat);
%Define parameters
AlphaBeta = {'a10b25','a20b25','a30b25','a10b30','a20b30','a30b30','a10b40','a20b40','a30b40'};
SelectedAB = [1,7,3,9];
%Define RunNumbers

for iii = 1:length(SelectedAB)
    
    %set colors for plots
    colori = {'k';'b';'g';'r';'y';'m';'--k';'--b';'--g'};
    %coloridased = {'--k';'--b';'--g';'--r';'--y';'--m'};
    coloridotted = {':k';':b';':g';':r';':y';':m';'-.k';'-.b';'-.g'};
    
    %set font size and select colors
    font_sz = 12;
    line_wdt = 1.5;
    counter = counter + 1;
    colore = colori{counter};
    %coloredased = coloridased{counter};
    coloredotted = coloridotted{counter};
    colore2 = colori{counter};
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
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP_MS_mean(SelectedAB(iii),:),colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[0 50000])
    legend(AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Real GDP')
    hold off
    
    subplot(2,1,2);hold on; grid on; box on
    plot(XVector_year,Unemployment_MS_mean(SelectedAB(iii),:),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('Employment','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend(AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Unemployment')
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
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
    plot(XVector_year,Mortgages_CAP_MS_mean(SelectedAB(iii),:),colore)
    plot(XVector_year,Mortgages_nonCAP_MS_mean(SelectedAB(iii),:),coloredotted)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgage share of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(AlphaBeta(SelectedAB(1:iii)),AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Mortgages: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2);hold on; grid on; box on;
    plot(XVector_year,Mortgages_CAP_MS_mean(SelectedAB(iii),:)./Total_num_capitalists(iii),colore)
    plot(XVector_year,Mortgages_nonCAP_MS_mean(SelectedAB(iii),:)./Total_num_noncapitalists(iii),coloredotted)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgages of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(AlphaBeta(SelectedAB(1:iii)),AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Mortgages: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
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
    plot(XVector_year,DI_CAP_MS_mean(SelectedAB(iii),:),colore)
    plot(XVector_year,DI_nonCAP_MS_mean(SelectedAB(iii),:),coloredotted)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Disposable Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(AlphaBeta(SelectedAB(1:iii)),AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Disposable Income: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year,DI_CAP_MS_mean(SelectedAB(iii),:)./Total_num_capitalists(iii),colore)
    plot(XVector_year,DI_CAP_MS_mean(SelectedAB(iii),:)./Total_num_noncapitalists(iii),coloredotted)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(AlphaBeta(SelectedAB(1:iii)),AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Disposable Income: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
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
    plot(XVector_year,HU_CAP_MS_mean(SelectedAB(iii),:),colore)
    plot(XVector_year,HU_nonCAP_MS_mean(SelectedAB(iii),:),coloredotted)
    xlabel('years','fontsize',font_sz)
    ylabel('Housing Units of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(AlphaBeta(SelectedAB(1:iii)),AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Housing Units: Cap vs. NonCap')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year,HU_CAP_MS_mean(SelectedAB(iii),:)./Total_num_capitalists(iii),colore)
    plot(XVector_year,HU_nonCAP_MS_mean(SelectedAB(iii),:)./Total_num_noncapitalists(iii),coloredotted)
    xlabel('years','fontsize',font_sz)
    ylabel('Housing Units of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    %legend(AlphaBeta(SelectedAB(1:iii)),AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Housing Units: Cap vs. NonCap')
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_HousingUnits','.pdf'))
    cd(current_folder);
    end
     %% Figure 5: Economy: Gini Index
            
    figure(5);
    set(gcf,'Name','Gini Index')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_year,GINI_netto_MS_mean(SelectedAB(iii),:),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    legend(AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(XVector_year,GINI_gross_MS_mean(SelectedAB(iii),:),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    plot(XVector_year(1:12:end),GINI_DI_MS_mean(SelectedAB(iii),1:12:end),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index DI','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 6: Real Estate Market Financing
    figure(6); hold on; grid on; box on
    set(gcf,'Name','REmarket: Financing')
    plot(XVector_year,Mortgages_CAP_MS_mean(SelectedAB(iii),:)+Mortgages_nonCAP_MS_mean(SelectedAB(iii),:),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend(AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    title('Household mortgages')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if iii == length(SelectedAB)
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
    plot(XVector_month(13:end),InflationPrice_MS_mean(SelectedAB(iii),:),colore)
    ylabel('Price inflation','fontsize',font_sz)
    %set(gca,'xtick',[0:12:300],'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    subplot(3,1,2); hold on; grid on
    plot(XVector_month(13:end),InflationWages_MS_mean(SelectedAB(iii),:),colore)
    ylabel('Wage inflation','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on, box on
    plot(XVector_month(13:end),InflationHousing_MS_mean(SelectedAB(iii),:),colore)
    ylabel('Housing inflation','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
    cd(FigPat);
    saveas(gcf,strcat('Inflation_Prices_Wages_Housing','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 8: Real Housing Price
    
    RealHousingPrice = HousingPrices_MS_mean(SelectedAB(iii),1:4:end)./Inflation_MS_mean(SelectedAB(iii),:);
    
    figure(8); hold on; grid on
    set(gcf,'Name','REmarket: Housing price Transactions Housing stock')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on
    plot(XVector_month,RealHousingPrice,colore)
    ylabel('Real housing price','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector_quarter,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    subplot(2,1,2); hold on; grid on
    plot(XVector_month,HousingPrices_MS_mean(SelectedAB(iii),1:4:end),colore)
    ylabel('Nominal housing price','fontsize',font_sz)
    %set(gca,'xtick',visualization_vector_quarter,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
    cd(FigPat);
    saveas(gcf,strcat('Real_Nominal_Housing_Price','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 9: Economy: Gini Index yearly
    j = 0;
    for k=1:Num_years     
        GINI_net_y(k) = mean(GINI_netto_MS_mean(SelectedAB(iii),j+1:j+Num_weeks_in_year));
        GINI_gross_y(k) = mean(GINI_gross_MS_mean(SelectedAB(iii),j+1:j+Num_weeks_in_year));
        GINI_DI_y(k) = mean(GINI_DI_MS_mean(SelectedAB(iii),j+1:j+Num_weeks_in_year));
        j = j + Num_weeks_in_year;
    end
    
    figure(9);
    set(gcf,'Name','Gini Index')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(GINI_net_y,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    legend(AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(GINI_gross_y,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    plot(GINI_DI_y,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index DI','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index_yearly','.pdf'))
    cd(current_folder);
    end
    
     %% Figure 10: Economy: Gini Index speed of change
    
    GINI_net_d = diff(GINI_net_y);
    GINI_gross_d = diff(GINI_gross_y);
    GINI_DI_d = diff(GINI_DI_y);
    
    figure(10);
    set(gcf,'Name','Gini Index')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(GINI_net_d,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    legend(AlphaBeta(SelectedAB(1:iii)),'Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(GINI_gross_d,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    plot(GINI_DI_d,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index DI','fontsize',font_sz)
    hold off
    
    %file save pdf
    if iii == length(SelectedAB)
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
    plot(XVector_year,BankMortgageBlocked_MS_mean(SelectedAB(iii),:),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    title('Households mortgages rejected','fontsize',font_sz)
    plot(XVector_year,HHMortgageRejected_MS_mean(SelectedAB(iii),:),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf   
    if iii == length(SelectedAB)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Financial_Constraints','.pdf'))
    cd(current_folder);
    end
    
end