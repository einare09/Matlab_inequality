clc
close all
clear all

counter = 0;

%Define RunNumbers
RunNumbers = [60011,60013,60015];%[40031,40033,40035];%[50171,50172,50173,50174,50175,50176];%[832821,832823,832824,832826,832827,832829];%301:303;
%for saving figures - Define path to figure folder
FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\',num2str(RunNumbers(1)),'-',num2str(RunNumbers(end)));
current_folder = cd;
mkdir(FigPat);
s=0; %for multiseed plotting in figure 37
for RunNumber = RunNumbers    
    colori = {'k';'b';'g';'r';'y';'m'};
    %colori_new = {[204/255 0 0],[0 204/255 204/255],[204/255 204/255 0],[0 204/255 0],...
    %    [204/255 102/255 0],[0 0 204/255],[102/255 0 204/255],[204/255 0 102/255],[96/255 96/255 96/255]};
    colori_new = {[0 0 0],[1 215/255 0],[220/255 20/255 60/255],[64/255 224/255 208/255],[50/255 205/255 50/255],[106/255 90/255 205/255]};

    coloridotted = {':k';':b';':g';':r';':y';':m'};
    coloridased = {'--k';'--b';'--g';'--r';'--y';'--m'};
    if isunix
        Pat = '../../runs/';
    else
        Pat = '..\..\runs\';
    end
    
    %Load data
    Filename = ['ICEACE_run',num2str(RunNumber),'_All','.mat'];
    load([Pat, Filename]);
    
    font_sz = 8;
    line_wdt = 2;
    counter = counter + 1;
    colore = colori{counter};
    coloredased = coloridased{counter};
    coloredotted = coloridotted{counter};
    colore2 = colori{counter};   
    colore_new = colori_new{counter};
    %SimulationFinalDay = d;
    %SimulationStartingDay = 12;
    %SimulationDurationInQuarters = 120;
    %SimulationFinalDay = 120*3*4+SimulationStartingDay;
    XVector_quarter = (1:(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInQuarter;
    XVector_year = (1:(SimulationFinalDay-SimulationStartingDay))/(TimeConstants.NrDaysInYear);
    XVector_month = (1:(SimulationFinalDay-SimulationStartingDay)/TimeConstants.NrDaysInMonth);
    Num_years = (SimulationFinalDay-SimulationStartingDay)./TimeConstants.NrDaysInYear;
    Num_quarters = (SimulationFinalDay-SimulationStartingDay)./TimeConstants.NrDaysInQuarter;
    Num_weeks_in_year = TimeConstants.NrMonthsInYear*TimeConstants.NrWeeksInMonth;
    quarters_visualization_step = 1;
    visualization_vector = (0:(quarters_visualization_step*TimeConstants.NrDaysInQuarter):(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInQuarter;
    visualization_vector_quarter = (0:(quarters_visualization_step*TimeConstants.NrDaysInQuarter):(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInYear;
    
    %collect parameters of the run 
    Params.(strcat('r',num2str(RunNumber))).Households.Parameters = Households.Parameters;
    Params.(strcat('r',num2str(RunNumber))).REmarket = REmarket;
    Params.(strcat('r',num2str(RunNumber))).TimeConstants = TimeConstants;
    Params.(strcat('r',num2str(RunNumber))).PriceIndices = PriceIndices;
    Params.(strcat('r',num2str(RunNumber))).SimulationRunPar = SimulationRunPar;
    
    CapitalistRatio = Params.(strcat('r',num2str(RunNumber))).Households.Parameters.IsCapitalistProb;
    
    %% Figure 1: Aggregate households and Firms Liquidity
    figure(1); hold on; grid on
    set(gcf,'Name','Households and Firms Liquidity')
    plot(XVector_year,sum(HouseholdsLiquidity,2),colore)
    plot(XVector_year,sum(FirmsLiquidity,2)+sum(CstrFirmsLiquidity,2),coloredased)
    xlabel('Years','fontsize',font_sz)
    title('Aggregate Liquidity','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Households','All Firms','Location','Best')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
        cd(FigPat);
        saveas(gcf,strcat('Households_Firms_Liquidity','.pdf'))
        cd(current_folder);        
    end
    
    %% Figure 2: Debts and Loans
    figure(2); hold on; grid on
    set(gcf,'Name','Firms and CstrFirms Total Debt')
    plot(XVector_year,sum(FirmsTotalDebts,2),colore)
    plot(XVector_year,sum(CstrFirmsTotalDebts,2),coloredased)
    %plot(XVector_year,sum(BanksTotalLoans,2),coloredotted)
    xlabel('quarters','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Aggregate debt and Loans','fontsize',font_sz)
    legend('Firms','CstrFirms','Location','Best')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Firms_CstrFirms_Total_Debt','.pdf'))
    cd(current_folder);
    end
    %% Figure 3: Iceace fundamental identity
    figure(3); hold on; grid on
    set(gcf,'Name','Banks balance sheet identity')
    plot(XVector_year,sum(BanksTotalLoans,2)+sum(BanksTotalMortgages,2)+sum(BanksLiquidity,2)-sum(HouseholdsLiquidity,2)-sum(FirmsLiquidity,2)-sum(BanksEquity,2)-sum(CentralBankDebt,2),'b') %-sum(BanksSavingsAccounts,2)
    xlabel('quarters','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Fundamental Iceace identity','fontsize',font_sz)
    legend('Constant = Banks Total Loans - Hoseuholds Liquidity - Firms Liquidity - Banks Equity - Central Bank Debt','Location','Best')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    %save figure as pdf
    if RunNumber == RunNumbers(end)
        cd(FigPat);
        saveas(gcf,strcat('Banks_balance_sheet_identity','.pdf'))
        cd(current_folder);
    end
    hold off
    
    %% Figure 4: Earnings
    figure(4); hold on; grid on
    set(gcf,'Name','Aggregate Earnings')
    plot(XVector_year,sum(HouseholdsLaborIncome,2),[':', colore])
    plot(XVector_year,sum(HouseholdsQuarterlyCapitalIncome,2),[':', colore],'linewidth',2)
    plot(XVector_year,sum(FirmsEarnings,2),colore)
    plot(XVector_year,sum(BanksEarnings,2),colore,'linewidth',2)
    xlabel('quarters','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Aggregate Earnings','fontsize',font_sz)
    legend('Firms','Banks','Location','Best')
    legend('Households Labor','Households Capital','Firms','Banks','Location','Best')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Aggregate_Earnings','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 5: Firms' Revenues
    figure(5); hold on; grid on
    set(gcf,'Name','Firms Revenues')
    plot(XVector_year,sum(FirmsRevenues,2),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Firms aggregate revenues','fontsize',font_sz)
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Firms_Revenues','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 6: Firms' Equity
    figure(6); hold on; grid on
    set(gcf,'Name','Firms Equity')
    plot(XVector_year,sum(FirmsEquity,2),colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Firms aggregate equity','fontsize',font_sz)
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    %file save pdf    
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Firms_Equity','.pdf'))
    cd(current_folder);
    end
    %% Figure 7: Central Bank Debt
    figure(7); hold on; grid on
    set(gcf,'Name','Banks:Central bank debt')
    %ylim([0, max(max(CentralBankDebt))*2])
    for b=1:NrAgents.Banks
        plot(XVector_year, CentralBankDebt(:,b), colore)
    end
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    title('Central Bank Debt','fontsize',font_sz)
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Banks_Central_bank_debt','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 8: Iceace check 2
    figure(8); hold on; grid on; box on
    set(gcf,'Name','Banks:Mortgages Loans Deposits')
    plot(XVector_year,sum(BanksTotalMortgages+BanksTotalLoans,2),colore)
    plot(XVector_year,sum(BanksDeposits,2),[':', colore])
    xlabel('quarters','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Mortgages +  Loans','Deposits','Location','Best')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Banks_Mortgages_Loans_Deposits','.pdf'))
    cd(current_folder);
    end
        
    %% Figure 9: Real Estate Market: Income and costs
    figure(9);
    set(gcf,'Name','REmarket: Income and costs')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    subplot(3,1,1); hold on; grid on; box on
    title('Avg income','fontsize',font_sz)
    plot(XVector_year, mean(HouseholdsLaborIncome,2), colore)
    plot(XVector_year, mean(HouseholdsQuarterlyCapitalIncome,2)/3, [':', colore], 'linewidth',2)
    TotalIncome_avg_tmp = mean(HouseholdsLaborIncome,2)+mean(HouseholdsQuarterlyCapitalIncome,2)/3;
    plot(XVector_year, TotalIncome_avg_tmp, colore, 'linewidth',2)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Labor','Capital','Total',font_sz,'Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    title('Avg Housing Expenses','fontsize',font_sz)
    plot(XVector_year, mean(HouseholdsHousingInterestPayment,2), colore)
    plot(XVector_year, mean(HouseholdsHousingPayment,2), [':', colore], 'linewidth',2)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Interests','Total','Location','Best')
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    title('Housing Expenses / Total Income','fontsize',font_sz)
    plot(XVector_year, mean(HouseholdsHousingInterestPayment,2)./TotalIncome_avg_tmp, colore)
    plot(XVector_year, mean(HouseholdsHousingPayment,2)./TotalIncome_avg_tmp, [':', colore], 'linewidth',2)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Interests / Total Income','Total / Total Income','Location','Best')
    hold off
    
    %file save pdf 
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Income_Costs','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 10: Real Estate Market Financing
    figure(10); hold on; grid on; box on
    set(gcf,'Name','REmarket: Financing')
    plot(XVector_year,sum(HouseholdsTotalMortgage,2),colore)
    %plot(XVector_year,sum(BanksTotalMortgages,2),[':', colore])
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend('Households Mortgages','Location','Best')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold off
    
    %file save pdf    
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Financing','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 11: Real Estate Market financial constraints
    figure(11); hold on; grid on; box on
    set(gcf,'Name','REmarket: financial comstraints')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    title('Banks mortgages blocked','fontsize',font_sz)
    plot(XVector_year,BanksMortgageBlocked,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    title('Households mortgages rejected','fontsize',font_sz)
    plot(XVector_year,HouseholdsMortgageRejected,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf   
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Financial_Constraints','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 12: Economy: Production and Unemployment
    figure(12);
    set(gcf,'Name','Economy: Production and Unemployment')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), Production(1:TimeConstants.NrDaysInMonth:end),colore2,'linewidth',line_wdt)
    ylabel('production','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(2,1,2); hold on; grid on, box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), 100*UnemployedWorkers(1:TimeConstants.NrDaysInMonth:end)/NrAgents.Households, colore2, 'linewidth',line_wdt)
    ylabel('unemployment rate (%)','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    %file save pdf 
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Production_Unemployment','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 13: Interest and Prices
    figure(13);
    set(gcf,'Name','REmarket: Interest and Prices')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), PriceIndex(1:TimeConstants.NrDaysInMonth:end),colore2,'linewidth',line_wdt)
    ylabel('price index','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(3,1,2); hold on; grid on, box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), WageIndex(1:TimeConstants.NrDaysInMonth:end), colore2, 'linewidth',line_wdt)
    ylabel('wage index','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(3,1,3); hold on; grid on, box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), CBRate(1:TimeConstants.NrDaysInMonth:end), colore2, 'linewidth',line_wdt)
    ylabel('central bank rate (%)','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Unemployment','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 14: Financial fragility indicators
    QuarterlyIncome = HouseholdsQuarterlyIncome + HouseholdsQuarterlyCapitalIncome;
    QuarterlyRatio = HouseholdsHousingPayment./QuarterlyIncome;
    
    figure(14);
    set(gcf,'Name','REmarket: Financial fragility indicators')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),mean(QuarterlyRatio(1:TimeConstants.NrDaysInMonth:end,:),2),colore2,'linewidth',line_wdt)
    ylabel('avg hous. exp / income','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(3,1,2); hold on; grid on, box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), HouseholdsMortgageRejected(1:TimeConstants.NrDaysInMonth:end)./HousingDemand(1:TimeConstants.NrDaysInMonth:end), colore, 'linewidth',line_wdt)
    ylabel('mortg. rejec. rate (%)','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(3,1,3); hold on; grid on, box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), HousingsNumFireSale(1:TimeConstants.NrDaysInMonth:end), colore2, 'linewidth',line_wdt)
    ylabel('# fire sales','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_Financial_fragility_indicators','.pdf'))
    cd(current_folder);    
    end
    
    %% Figure 15: Government
    figure(15);
    set(gcf,'Name','Government')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year,GovernmentLiquidity',colore)
    plot(XVector_year,GovernmentBalance',[':', colore])
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('quarters','fontsize',font_sz)
    legend('Liquidity','Balance','Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    plot(XVector_year,Government.UnempBenefitsPaid_sum,colore)
    plot(XVector_year,Government.GeneralBenefitsPaid_sum,colore)
    plot(XVector_year,GovernmentLaborTax,[':', colore])
    plot(XVector_year,GovernmentCapitalIncomeTax,['--', colore])
    %plot(XVector_year,GovernmentBonds,[':', colore2])
    %plot(XVector_year,GovernmentCapitalIncomeTax+GovernmentLaborTax, 'linewidth',2,'color',colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('quarters','fontsize',font_sz)
    legend('UnempBenefits','GeneralBenefits','LaborTax','CapitalTax','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Government_Liquidity_Balance_Income_Expenditure','.pdf'))
    cd(current_folder);    
    end
    
    %% Figure 16: Tax and benefits rates
    figure(16);hold on; grid on; box on
    set(gcf,'Name','Tax rates and Benefit ratios')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    plot(XVector_year,LaborTax,colore)
    plot(XVector_year,CapitalIncomeTax,[':', colore])
    plot(XVector_year,UnemploymentRatio,['--', colore])
    plot(XVector_year,BenefitRatio,['-.', colore])
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('quarters','fontsize',font_sz)
    legend('Labor Tax','Capital Income Tax','Unemployment ratio','Benefit ratio','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Government_TaxRate_BenefitRate','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 17: Real prices of housing
    figure(17); hold on; grid on
    set(gcf,'Name','REmarket: Housing price Transactions Housing stock')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    subplot(4,1,1); hold on; grid on
    plot(XVector_year, HousingPrices,colore)
    ylabel('Nominal housing price','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    InflationIndex(1) = 100;
    for t = 2:numel(Inflation)/TimeConstants.NrDaysInMonth
        InflationIndex(t) =  InflationIndex(t-1)*(1+Inflation(t*TimeConstants.NrDaysInMonth)/12);
    end
    
    subplot(4,1,2); hold on; grid on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),HousingPrices(1:TimeConstants.NrDaysInMonth:end)'./InflationIndex,colore)
    %plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),HousingPrices(1:TimeConstants.NrDaysInMonth:end)'./InflationIndexOld,'--g')
    ylabel('Real housing price','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    subplot(4,1,3); hold on; grid on, box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), HousingTransactions(1:TimeConstants.NrDaysInMonth:end), colore2, 'linewidth',line_wdt)
    ylabel('# transactions','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(4,1,4);hold on; grid on; box on;
    plot(XVector_year,sum(HouseholdsHousingAmount,2),colore)
    xlabel('years','fontsize',font_sz)
    ylabel('Aggregate Housing Stock','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('REmarket_HousingPrice_Transactions_HousingStock','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 18: Economy: RealGDP and Unemployment
    GDP = Production(1:TimeConstants.NrDaysInMonth:end).*PriceIndex(1:TimeConstants.NrDaysInMonth:end)...
        + (CstrProduction(1:TimeConstants.NrDaysInMonth:end)/12).*HousingPrices(1:TimeConstants.NrDaysInMonth:end);
    RealGDP = (100*GDP)./InflationIndex';
    figure(18);
    set(gcf,'Name','Economy: RealGDP and Unemployment')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), RealGDP,colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[0 50000])
    hold off
    
    subplot(2,1,2);hold on; grid on; box on
    plot(XVector_year,NrAgents.Households-UnemployedWorkers,colore)
    plot(XVector_year,sum(EmployeesVector(:,1:NrAgents.Firms),2),[':', colore])
    plot(XVector_year,sum(EmployeesVector(:,(NrAgents.Firms+1):(NrAgents.Firms+NrAgents.CstrFirms)),2),['--', colore])
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('Employment','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    legend('Total employed','CGP firms','Construction firms','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealGDP_Unemployment','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 19: Firms Bankruptcies
    figure(19)
    set(gcf,'Name','Firms: Bankruptcies')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1);hold on; grid on; box on
    set(gcf,'Name','No. insolvent Firms')
    plot(XVector_year,FirmsInsolvency,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('No insovent firms','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    subplot(2,1,2);hold on; grid on; box on
    set(gcf,'Name','No. illiquid Firms')
    plot(XVector_year,FirmsIlliquidity,colore)
    plot(XVector_year,CstrFirmsIlliquidity,[':', colore])
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('No illiquid firms','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Firms_Bankruptcies','.pdf'))
    cd(current_folder); 
    end
    
    %% Figure 20
    figure(20);hold on; grid on; box on
    set(gcf,'Name','Mortgage Writeoff')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    plot(XVector_year,[0;diff(sum(HouseholdsMortgagesWrittenOff,2))],colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('Mortgage writeoff','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Mortgage_writeoffs','.pdf'))
    cd(current_folder); 
    end
     
    %% Figure 21: Economy: Inflation
    
    PriceIndexInfl = PriceIndex(1:TimeConstants.NrDaysInMonth:end);
    WageIndexInfl = WageIndex(1:TimeConstants.NrDaysInMonth:end);
    HousingPricesInfl = HousingPrices(1:TimeConstants.NrDaysInMonth:end);
    
    InflationPrice   = ((PriceIndexInfl(13:end)-PriceIndexInfl(1:end-12))./PriceIndexInfl(1:end-12))*100;
    InflationWages   = ((WageIndexInfl(13:end)-WageIndexInfl(1:end-12))./WageIndexInfl(1:end-12))*100;
    InflationHousing = ((HousingPricesInfl(13:end)-HousingPricesInfl(1:end-12))./HousingPricesInfl(1:end-12))*100;
    
    figure(21);
    set(gcf,'Name','Economy: Inflation')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_month(13:end),InflationPrice,colore)
    %set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    ylabel('Prices Inflation','fontsize',font_sz)
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(XVector_month(13:end),InflationWages,colore)
    set(gca,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    ylabel('Wages Inflation','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    plot(XVector_month(13:end),InflationHousing,colore)
    set(gca,'fontsize',font_sz)
    xlabel('months','fontsize',font_sz)
    ylabel('Housing Prices Inflation','fontsize',font_sz)
    hold off
        
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_Inflation','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 22: Economy: Gini Index
    pop = ones(length(HouseholdsEquity(1,:)),1);
    %pop = [1:1:10];
    
    makeplot=0;
    for i=1:length(HouseholdsEquity(:,1))
        [g_netto(i),l_netto,a_netto] = gini(pop,HouseholdsEquity(i,:),makeplot);
        [g_lordo(i),l_lordo,a_lordo] = gini(pop,HouseholdsTotalAssets(i,:),makeplot);
        [g_mortgages(i),l_mortgages,a_mortgages] = gini(pop,HouseholdsTotalMortgage(i,:),makeplot);
    end
    
    figure(22);
    set(gcf,'Name','Gini Index')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_year(1:end),g_netto,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    set(gca,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Net','fontsize',font_sz)
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(XVector_year(1:end),g_lordo,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Gross','fontsize',font_sz)
    hold off
    
    subplot(3,1,3); hold on; grid on; box on
    plot(XVector_year(1:end),g_mortgages,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    ylabel('Gini Index Mortgages','fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_GINI_Index','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 23: Real wage
    PriceIndex100 = zeros(Num_quarters*3,1);
    PriceIndex100(1,1) = 100;
    
    for i=2:length(PriceIndex100)
        PriceIndex100(i,1) = PriceIndex100(i-1,1)+ PriceIndex100(i-1,1)*((PriceIndexInfl(i,1)-PriceIndexInfl(i-1,1))/PriceIndexInfl(i-1,1));
    end
    
    RealWage = 100*WageIndexInfl./PriceIndex100;
    RealBenefits = mean(HouseholdsBenefits,2);
    RealBenefits = RealBenefits(1:4:end);
    RealBenefits = 100*RealBenefits./PriceIndex100;
    RealDividends = sum(HouseholdsQuarterlyCapitalIncome,2)./(CapitalistRatio*NrAgents.Households);
    RealDividends = RealDividends(1:4:end);
    RealDividends = 100*RealDividends./PriceIndex100;
    
    figure(23);
    set(gcf,'Name','Real Wage, Dividends and Housing Price')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),RealWage,colore)
    xlabel('years','fontsize',font_sz)
    ylabel('Real Wage','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    hold off
    
    subplot(3,1,2); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),RealDividends,colore)
    xlabel('years','fontsize',font_sz)
    ylabel('Real Dividends','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    hold off
    subplot(3,1,3); hold on; grid on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),HousingPrices(1:TimeConstants.NrDaysInMonth:end)'./InflationIndex,colore)
    ylabel('Real housing price','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealWage_Dividends_HousingPrice','.pdf'))
    cd(current_folder);
    end
    
    %% Calculations for capitalists vs. Non-Capitalists Analysis
    Total_num_capitalists = NrAgents.Households*Households.Parameters.IsCapitalistProb;
    Total_num_noncapitalists = NrAgents.Households*(1-Households.Parameters.IsCapitalistProb);
        
    TotalHHEquity = sum(HouseholdsEquity,2);
    TotalHHEquity = TotalHHEquity(1:4:end);%*100./PriceIndex100;
    CapHHEquity = sum(HouseholdsEquity(:,1:1:Total_num_capitalists),2);
    CapHHEquity = CapHHEquity(1:4:end);%*100./PriceIndex100;
    RegHHEquity = sum(HouseholdsEquity(:,(Total_num_capitalists+1):1:NrAgents.Households),2);
    RegHHEquity = RegHHEquity(1:4:end);%*100./PriceIndex100;
    
    %% Figure 24: Cap vs NonCap Equity
    figure(24)    
    set(gcf,'Name','Equity')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1);hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),CapHHEquity./TotalHHEquity,colore)
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),RegHHEquity./TotalHHEquity,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Equity share of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,2);hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),CapHHEquity,colore)
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),RegHHEquity,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Equity of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    hold off
    
    subplot(3,1,3);hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),CapHHEquity./Total_num_capitalists,colore)
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),RegHHEquity./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Equity of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Equity','.pdf'))
    cd(current_folder);
    end
    
    %% Set Variables
    
    %Quarterly Income
    QuarterlyIncome_CAP = HouseholdsQuarterlyIncome(:,1:1:Total_num_capitalists) + HouseholdsQuarterlyCapitalIncome(:,1:1:Total_num_capitalists);
    QuarterlyRatio_CAP = HouseholdsHousingPayment(:,1:1:Total_num_capitalists)./QuarterlyIncome(:,1:1:Total_num_capitalists);
    QuarterlyIncome_nonCAP = HouseholdsQuarterlyIncome(:,Total_num_capitalists+1:1:end) + HouseholdsQuarterlyCapitalIncome(:,Total_num_capitalists+1:1:end);
    QuarterlyRatio_nonCAP = HouseholdsHousingPayment(:,Total_num_capitalists+1:1:end)./QuarterlyIncome(:,Total_num_capitalists+1:1:end);
    
    %Mortgages
    Mortgages_CAP = HouseholdsTotalMortgage(:,1:1:Total_num_capitalists);
    Mortgages_nonCAP = HouseholdsTotalMortgage(:,Total_num_capitalists+1:1:end);
    
    %Disposable Income
    DI_CAP = QuarterlyIncome_CAP - HouseholdsHousingPayment(:,1:1:Total_num_capitalists);
    DI_nonCAP = QuarterlyIncome_nonCAP - HouseholdsHousingPayment(:,Total_num_capitalists+1:1:end);
    
    %Housing Units
    HU_CAP = HouseholdsHousingAmount(:,1:1:Total_num_capitalists);
    HU_nonCAP = HouseholdsHousingAmount(:,Total_num_capitalists+1:1:end);
    
    %Liquidity
    LIQ_CAP = HouseholdsLiquidity(:,1:1:Total_num_capitalists);
    LIQ_nonCAP = HouseholdsLiquidity(:,Total_num_capitalists+1:1:end);
    
    %% Figure 25: Cap vs. NonCap: Households expenditure on housing
    figure(25);
    set(gcf,'Name','REmarket: Financial fragility indicators')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),mean(QuarterlyRatio_CAP(1:TimeConstants.NrDaysInMonth:end,:),2),colore,'linewidth',line_wdt)
    ylabel('avg hous. exp / income (capitalists)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    subplot(2,1,2); hold on; grid on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end),mean(QuarterlyRatio_nonCAP(1:TimeConstants.NrDaysInMonth:end,:),2),colore,'linewidth',line_wdt)
    ylabel('avg hous. exp / income (non-capitalists)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_HousingExpenditure','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 26: Cap vs. NonCap: Income share of households QI=Quarterly Income
    QI_Total = sum(QuarterlyIncome_CAP,2) + sum(QuarterlyIncome_nonCAP,2);
    QI_CAP = sum(QuarterlyIncome_CAP,2)./QI_Total;
    QI_nonCAP = sum(QuarterlyIncome_nonCAP,2)./QI_Total;
    QI_CAP_yearly = zeros(1,Num_years);
    QI_nonCAP_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year;
    for k=1:Num_years
       QI_CAP_yearly(k) = mean(QI_CAP(t1:t2));
       QI_nonCAP_yearly(k) = mean(QI_nonCAP(t1:t2));
       t1 = t1 + Num_weeks_in_year;
       t2 = t2 + Num_weeks_in_year;
    end
        
    figure(26)
    set(gcf,'Name','Share of Quarterly Income')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    hold on; grid on; box on
    plot(XVector_year(1:Num_weeks_in_year:end),QI_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),QI_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Income share of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)  
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_HousingExpenditure','.pdf'))
    cd(current_folder);
    end

    %% Figure 27: Cap vs. NonCap: Mortgage share of households M=Mortgages
    M_Total = sum(Mortgages_CAP,2) + sum(Mortgages_nonCAP,2);
    M_abs_CAP = sum(Mortgages_CAP,2);
    M_abs_nonCAP = sum(Mortgages_nonCAP,2);
    M_CAP = sum(Mortgages_CAP,2)./M_Total;
    M_nonCAP = sum(Mortgages_nonCAP,2)./M_Total;
    M_CAP_yearly = zeros(1,Num_years);
    M_nonCAP_yearly = zeros(1,Num_years);
    M_abs_CAP_yearly = zeros(1,Num_years);
    M_abs_nonCAP_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year;
    for k=1:Num_years
       M_abs_CAP_yearly(k) = mean(M_abs_CAP(t1:t2));
       M_abs_nonCAP_yearly(k) = mean(M_abs_nonCAP(t1:t2));
       M_CAP_yearly(k) = mean(M_CAP(t1:t2));
       M_nonCAP_yearly(k) = mean(M_nonCAP(t1:t2));
       t1 = t1 + Num_weeks_in_year;
       t2 = t2 + Num_weeks_in_year;
    end
    
    
    figure(27)
    set(gcf,'Name','Mortgages')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),M_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),M_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgage share of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,2);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),M_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),M_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgages of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,3);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),M_abs_CAP_yearly./Total_num_capitalists,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),M_abs_nonCAP_yearly./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Mortgages of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Mortgages','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 28: Cap vs. NonCap:Disposable Income D=Disposable Income
    DI_Total = sum(DI_CAP,2) + sum(DI_nonCAP,2);
    DI_abs_CAP = sum(DI_CAP,2);
    DI_abs_nonCAP = sum(DI_nonCAP,2);
    DI_CAP = sum(DI_CAP,2)./DI_Total;
    DI_nonCAP = sum(DI_nonCAP,2)./DI_Total;
    DI_CAP_yearly = zeros(1,Num_years);
    DI_nonCAP_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year;
    for k=1:Num_years
       DI_abs_CAP_yearly(k) = mean(DI_abs_CAP(t1:t2));
       DI_abs_nonCAP_yearly(k) = mean(DI_abs_nonCAP(t1:t2));
       DI_CAP_yearly(k) = mean(DI_CAP(t1:t2));
       DI_nonCAP_yearly(k) = mean(DI_nonCAP(t1:t2));
       t1 = t1 + Num_weeks_in_year;
       t2 = t2 + Num_weeks_in_year;
    end
    
    
    figure(28)
    set(gcf,'Name','Disposable Income')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),DI_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Disposable Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,3); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_CAP_yearly./Total_num_capitalists,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_nonCAP_yearly./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_DisposableIncome','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 29: Cap vs. NonCap: Housing units
    HU_Total = sum(HU_CAP,2) + sum(HU_nonCAP,2);
    HU_abs_CAP = sum(HU_CAP,2);
    HU_abs_nonCAP = sum(HU_nonCAP,2);
    HU_abs_CAP_yearly = zeros(1,Num_years);
    HU_abs_nonCAP_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year;
    for k=1:Num_years
       HU_abs_CAP_yearly(k) = mean(HU_abs_CAP(t1:t2));
       HU_abs_nonCAP_yearly(k) = mean(HU_abs_nonCAP(t1:t2));
       t1 = t1 + Num_weeks_in_year;
       t2 = t2 + Num_weeks_in_year;
    end
        
    figure(29)
    set(gcf,'Name','Housing Units')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),HU_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),HU_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Housing Units of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),HU_abs_CAP_yearly./Total_num_capitalists,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),HU_abs_nonCAP_yearly./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Housing Units of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_HousingUnits','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 30: Cap vs. NonCap: Liquidity
    LIQ_Total = sum(LIQ_CAP,2) + sum(LIQ_nonCAP,2);
    LIQ_abs_CAP = sum(LIQ_CAP,2);
    LIQ_abs_nonCAP = sum(LIQ_nonCAP,2);
    LIQ_CAP = sum(LIQ_CAP,2)./LIQ_Total;
    LIQ_nonCAP = sum(LIQ_nonCAP,2)./LIQ_Total;
    LIQ_CAP_yearly = zeros(1,Num_years);
    LIQ_nonCAP_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year;
    for k=1:Num_years
       LIQ_abs_CAP_yearly(k) = mean(LIQ_abs_CAP(t1:t2));
       LIQ_abs_nonCAP_yearly(k) = mean(LIQ_abs_nonCAP(t1:t2));
       LIQ_CAP_yearly(k) = mean(LIQ_CAP(t1:t2));
       LIQ_nonCAP_yearly(k) = mean(LIQ_nonCAP(t1:t2));
       t1 = t1 + Num_weeks_in_year;
       t2 = t2 + Num_weeks_in_year;
    end
    
    
    figure(30)
    set(gcf,'Name','Liquidity')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(3,1,1);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Liquidity of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,2); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Liquidity of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(3,1,3); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_CAP_yearly./Total_num_capitalists,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_nonCAP_yearly./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Liquidity of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Liquidity','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 31: Cap vs. NonCap: - Liquidity, disposable income and actual consumption (share)
    
    figure(31)
    set(gcf,'Name','Households: Share of Liquidity, Disposable Income')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Liquidity of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(2,1,2);hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),DI_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Share of Disposable Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Liquidity_DI_share','.pdf'))
    cd(current_folder);    
    end
    
    %% Figure 32: Cap vs. NonCap: - Liquidity, disposable income and actual consumption
    figure(32)
    set(gcf,'Name','Households: Liquidity, Disposable Income')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Liquidity of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Liquidity_DI','.pdf'))
    cd(current_folder);
    end
    
    %% Figure 33: Cap vs. NonCap: - Liquidity, disposable income and actual consumption (mean)
    figure(33)
    set(gcf,'Name','Households: Liquidity, Disposable Income (mean)')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_CAP_yearly./Total_num_capitalists,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),LIQ_abs_nonCAP_yearly./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Liquidity of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    subplot(2,1,2); hold on; grid on; box on;
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_CAP_yearly./Total_num_capitalists,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_nonCAP_yearly./Total_num_noncapitalists,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income of Households (mean)','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
   
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Liquidity_DI_mean','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 34: Cap vs. NonCap: - Mortgage to Equity ratio
    EQ_Total = sum(CapHHEquity,2) + sum(RegHHEquity,2);
    EQ_abs_CAP = sum(CapHHEquity,2);
    EQ_abs_nonCAP = sum(RegHHEquity,2);
    EQ_abs_CAP_yearly = zeros(1,Num_years);
    EQ_abs_nonCAP_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year/4;
    for k=1:Num_years
       EQ_abs_CAP_yearly(k) = mean(EQ_abs_CAP(t1:t2));
       EQ_abs_nonCAP_yearly(k) = mean(EQ_abs_nonCAP(t1:t2));
       t1 = t1 + Num_weeks_in_year/4;
       t2 = t2 + Num_weeks_in_year/4;
    end
    
    figure(34); hold on; grid on; box on;
    set(gcf,'Name','Households: Mortgage to Equity ratio')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])    
    plot(XVector_year(1:Num_weeks_in_year:end),M_abs_CAP_yearly./EQ_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),M_abs_nonCAP_yearly./EQ_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Leverage of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_Mortgages_Equity_ratio','.pdf'))
    cd(current_folder);  
    end
    
    
    % Figure 35: Cap vs. NonCap: - Income to Mortgages ratio
    figure(35); hold on; grid on; box on;
    set(gcf,'Name','Households: Disposable Income to Mortgages ratio')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])    
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_CAP_yearly./M_abs_CAP_yearly,colore)
    plot(XVector_year(1:Num_weeks_in_year:end),DI_abs_nonCAP_yearly./M_abs_nonCAP_yearly,coloredased)
    xlabel('years','fontsize',font_sz)
    ylabel('Disposable Income to Mortgages of Households','fontsize',font_sz)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    legend('Capitalists','Non-capitalists','Location','Best')
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Cap_vs_NonCap_DI_Mortgages_ratio','.pdf'))
    cd(current_folder);  
    end
    
    %% Figure 36: Economy: RealGDP and Unemployment
 
    RealGDP_yearly = zeros(1,Num_years);
    Unemployment_yearly = zeros(1,Num_years);
    t1 = 1;
    t2 = Num_weeks_in_year/4;
    for k=1:Num_years
       RealGDP_yearly(k) = mean(RealGDP(t1:t2));       
       t1 = t1 + Num_weeks_in_year/4;
       t2 = t2 + Num_weeks_in_year/4;
    end
    t1 = 1;
    t2 = Num_weeks_in_year;
    for k=1:Num_years
       Unemployment_yearly(k) = mean(100*UnemployedWorkers(t1:t2)/NrAgents.Households);  
       t1 = t1 + Num_weeks_in_year;
       t2 = t2 + Num_weeks_in_year;
    end
               
    figure(36);
    set(gcf,'Name','Economy: RealGDP and Unemployment')
    set(gcf,'PaperType','A4')
    set(gcf,'PaperPosition',[0,0,8.26,11.69])
    
    subplot(2,1,1); hold on; grid on; box on
    plot(XVector_year(1:Num_weeks_in_year:end), RealGDP_yearly,colore,'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[0 50000])
    hold off
    
    subplot(2,1,2);hold on; grid on; box on
    plot(XVector_year(1:Num_weeks_in_year:end),Unemployment_yearly,colore)
    set(gca,'xtick',visualization_vector,'fontsize',font_sz)
    ylabel('Unemployment rate (%)','fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    hold off
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealGDP_Unemployment_yearly','.pdf'))
    cd(current_folder);  
    end
    %% multiple seeds averaged for real GDP
    s=s+1;
    Real_GDP_multiseed(s,:) = RealGDP;
    
    if RunNumber == RunNumbers(end)
    Real_GDP_s = mean(Real_GDP_multiseed);
        
    figure(37);
    set(gcf,'Name','Economy: RealGDP and Unemployment')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperType','A5')
    set(gcf,'PaperPosition',[0,0,8.26,5.85])
    set(gcf,'PaperOrientation','landscape')
    
    hold on; box on
    plot(XVector_year(1:TimeConstants.NrDaysInMonth:end), Real_GDP_s,'Color',colori_new{1},'linewidth',line_wdt)
    ylabel('Real GDP','fontsize',font_sz)
    set(gca,'xtick',0:Num_years,'fontsize',font_sz)
    xlabel('years','fontsize',font_sz)
    set(gca,'xlim',[0 Num_years])
    set(gca,'ylim',[20000 50000])
    legend_handle = legend('\alpha=1,\beta=0.25','Location','SouthWest');
    set(legend_handle, 'Box', 'off')
    hold off
    end
    
    %file save pdf
    if RunNumber == RunNumbers(end)
    cd(FigPat);
    saveas(gcf,strcat('Economy_RealGDP_ThreeSeeds','.pdf'))
    cd(current_folder);  
    end
    
    %% Clear
    clear g_netto l_netto a_netto g_lordo l_lordo a_lordo Households Firms CstrFirms Banks Fund InflationIndex
end

%% save Params to file
P.Params = Params;
cd(FigPat);
save('Parameters.mat', '-struct', 'Params');
struct2xml(P,'Parameters.xml');
cd(current_folder);



