clc
close all
clear all


%set path
if isunix
    Pat = '../../runs/';
else
    Pat = '..\..\runs\';
end
%for saving figures - Define path to figure folder
%FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\',num2str(RunNumbers(1)),'-',num2str(RunNumbers(end)));
%current_folder = cd;
%mkdir(FigPat);
%Define parameters
AlphaBeta = {'a10b25','a20b25','a30b25','a10b30','a20b30','a30b30','a10b40','a20b40','a30b40'};
%Define RunNumbers

for iii = 1:length(AlphaBeta)
%set run numbers to use
RunNumbers(iii,:) = 832310+iii:10:832520+iii;
%set counter
counter = 0;

    for RunNumber = RunNumbers(iii,:)
        %set counter
        counter = counter + 1;
    
    
        Filename = ['ICEACE_run',num2str(RunNumber),'_All','.mat'];
        load([Pat, Filename]);
        
        %collect parameters of the run 
        Params.(strcat('r',num2str(RunNumber))).Households.Parameters = Households.Parameters;
        Params.(strcat('r',num2str(RunNumber))).REmarket = REmarket;
        Params.(strcat('r',num2str(RunNumber))).TimeConstants = TimeConstants;
        Params.(strcat('r',num2str(RunNumber))).PriceIndices = PriceIndices;
        Params.(strcat('r',num2str(RunNumber))).SimulationRunPar = SimulationRunPar;
        CapitalistRatio = Params.(strcat('r',num2str(RunNumber))).Households.Parameters.IsCapitalistProb;
    
    
        %% Gather multiple vectors for various variables
    
        %Inflation
        InflationIndex(1) = 100;
        for t = 2:numel(Inflation)/TimeConstants.NrDaysInMonth
            InflationIndex(t) =  InflationIndex(t-1)*(1+Inflation(t*TimeConstants.NrDaysInMonth)/12);
        end
        Inflation_MS.(AlphaBeta{iii})(counter,:) = InflationIndex;
        HousingPrices_MS.(AlphaBeta{iii})(counter,:) = HousingPrices;
        
        PriceIndexInfl = PriceIndex(1:TimeConstants.NrDaysInMonth:end);
        WageIndexInfl = WageIndex(1:TimeConstants.NrDaysInMonth:end);
        HousingPricesInfl = HousingPrices(1:TimeConstants.NrDaysInMonth:end);
    
        InflationPrice_MS.(AlphaBeta{iii})(counter,:)   = ((PriceIndexInfl(13:end)-PriceIndexInfl(1:end-12))./PriceIndexInfl(1:end-12))*100;
        InflationWages_MS.(AlphaBeta{iii})(counter,:)   = ((WageIndexInfl(13:end)-WageIndexInfl(1:end-12))./WageIndexInfl(1:end-12))*100;
        InflationHousing_MS.(AlphaBeta{iii})(counter,:) = ((HousingPricesInfl(13:end)-HousingPricesInfl(1:end-12))./HousingPricesInfl(1:end-12))*100;
        
        %Real GDP
        GDP = Production(1:TimeConstants.NrDaysInMonth:end).*PriceIndex(1:TimeConstants.NrDaysInMonth:end)...
            + (CstrProduction(1:TimeConstants.NrDaysInMonth:end)/12).*HousingPrices(1:TimeConstants.NrDaysInMonth:end);
        RealGDP = (100*GDP')./InflationIndex;
        RealGDP_MS.(AlphaBeta{iii})(counter,:) = RealGDP;
        %Unemployment
        Unemployment_MS.(AlphaBeta{iii})(counter,:) = UnemployedWorkers./NrAgents.Households;        
        %Calculations for capitalists vs. Non-Capitalists Analysis
        Total_num_capitalists = NrAgents.Households*Households.Parameters.IsCapitalistProb;
        Total_num_noncapitalists = NrAgents.Households*(1-Households.Parameters.IsCapitalistProb);
        %Equity
        TotalHHEquity = sum(HouseholdsEquity,2);
        TotalHHEquity_MS.(AlphaBeta{iii})(counter,:) = TotalHHEquity(1:4:end);%*100./PriceIndex100;
        CapHHEquity = sum(HouseholdsEquity(:,1:1:Total_num_capitalists),2);
        CapHHEquity_MS.(AlphaBeta{iii})(counter,:) = CapHHEquity(1:4:end);%*100./PriceIndex100;
        RegHHEquity = sum(HouseholdsEquity(:,(Total_num_capitalists+1):1:NrAgents.Households),2);
        RegHHEquity_MS.(AlphaBeta{iii})(counter,:) = RegHHEquity(1:4:end);%*100./PriceIndex100;
        %Quarterly Income
        QuarterlyIncome_CAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsQuarterlyIncome(:,1:1:Total_num_capitalists),2)...
            + sum(HouseholdsQuarterlyCapitalIncome(:,1:1:Total_num_capitalists),2);
        QuarterlyHousingPayment_CAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsHousingPayment(:,1:1:Total_num_capitalists),2);
        QuarterlyIncome_nonCAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsQuarterlyIncome(:,Total_num_capitalists+1:1:end),2)...
            + sum(HouseholdsQuarterlyCapitalIncome(:,Total_num_capitalists+1:1:end),2);
        QuarterlyHousingPayment_nonCAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsHousingPayment(:,Total_num_capitalists+1:1:end),2);
        %Mortgages
        Mortgages_CAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsTotalMortgage(:,1:1:Total_num_capitalists),2);
        Mortgages_nonCAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsTotalMortgage(:,Total_num_capitalists+1:1:end),2);
        %Disposable Income
        DI_CAP_MS.(AlphaBeta{iii})(counter,:) = QuarterlyIncome_CAP_MS.(AlphaBeta{iii})(counter,:) - QuarterlyHousingPayment_CAP_MS.(AlphaBeta{iii})(counter,:);
        DI_nonCAP_MS.(AlphaBeta{iii})(counter,:) = QuarterlyIncome_nonCAP_MS.(AlphaBeta{iii})(counter,:) - QuarterlyHousingPayment_nonCAP_MS.(AlphaBeta{iii})(counter,:);
        %Housing Units
        HU_CAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsHousingAmount(:,1:1:Total_num_capitalists),2);
        HU_nonCAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsHousingAmount(:,Total_num_capitalists+1:1:end),2);
        %Housing market
        BankMortgageBlocked_MS.(AlphaBeta{iii})(counter,:) = BanksMortgageBlocked;
        HHMortgageRejected_MS.(AlphaBeta{iii})(counter,:) = HouseholdsMortgageRejected;
        %Liquidity
        LIQ_CAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsLiquidity(:,1:1:Total_num_capitalists),2);
        LIQ_nonCAP_MS.(AlphaBeta{iii})(counter,:) = sum(HouseholdsLiquidity(:,Total_num_capitalists+1:1:end),2);
        %GINI Index
        QuarterlyIncome_for_gini = HouseholdsQuarterlyIncome + HouseholdsQuarterlyCapitalIncome - HouseholdsHousingPayment;
        pop = ones(length(HouseholdsEquity(1,:)),1);
        for g=1:length(HouseholdsEquity(:,1))
            g_netto(g) = gini(pop,HouseholdsEquity(g,:));
            g_gross(g) = gini(pop,HouseholdsTotalAssets(g,:));
            g_DI(g) = gini(pop,max(QuarterlyIncome_for_gini(g,:),0));
        end
        GINI_netto.(AlphaBeta{iii})(counter,:) = g_netto;
        GINI_gross.(AlphaBeta{iii})(counter,:) = g_gross;
        GINI_DI.(AlphaBeta{iii})(counter,:) = g_DI;
        %Firms
        Debt_Firms_MS.(AlphaBeta{iii})(counter,:) = sum(FirmsTotalDebts,2);
        Debt_CstrFirms_MS.(AlphaBeta{iii})(counter,:) = sum(CstrFirmsTotalDebts,2);
        Liq_Firms_MS.(AlphaBeta{iii})(counter,:) = sum(FirmsLiquidity,2);
        Liq_CstrFirms_MS.(AlphaBeta{iii})(counter,:) = sum(CstrFirmsLiquidity,2);
        
    end
    %Create timeseries fot mean of run numbers
    DATA.Inflation_MS_mean(iii,:) = mean(Inflation_MS.(AlphaBeta{iii}));
    DATA.HousingPrices_MS_mean(iii,:) = mean(HousingPrices_MS.(AlphaBeta{iii}));
    DATA.InflationPrice_MS_mean(iii,:) = mean(InflationPrice_MS.(AlphaBeta{iii}));
    DATA.InflationWages_MS_mean(iii,:) = mean(InflationWages_MS.(AlphaBeta{iii}));
    DATA.InflationHousing_MS_mean(iii,:) = mean(InflationHousing_MS.(AlphaBeta{iii}));
    DATA.RealGDP_MS_mean(iii,:) = mean(RealGDP_MS.(AlphaBeta{iii}));
    DATA.Unemployment_MS_mean(iii,:) = mean(Unemployment_MS.(AlphaBeta{iii}));
    DATA.TotalHHEquity_MS_mean(iii,:) = mean(TotalHHEquity_MS.(AlphaBeta{iii}));
    DATA.CapHHEquity_MS_mean(iii,:) = mean(CapHHEquity_MS.(AlphaBeta{iii}));
    DATA.RegHHEquity_MS_mean(iii,:) = mean(RegHHEquity_MS.(AlphaBeta{iii}));
    DATA.QuarterlyIncome_CAP_MS_mean(iii,:) = mean(QuarterlyIncome_CAP_MS.(AlphaBeta{iii}));
    DATA.QuarterlyRatio_CAP_MS_mean(iii,:) = mean(QuarterlyHousingPayment_CAP_MS.(AlphaBeta{iii}));
    DATA.QuarterlyIncome_nonCAP_MS_mean(iii,:) = mean(QuarterlyIncome_nonCAP_MS.(AlphaBeta{iii}));
    DATA.QuarterlyRatio_nonCAP_MS_mean(iii,:) = mean(QuarterlyHousingPayment_nonCAP_MS.(AlphaBeta{iii}));
    DATA.Mortgages_CAP_MS_mean(iii,:) = mean(Mortgages_CAP_MS.(AlphaBeta{iii}));
    DATA.Mortgages_nonCAP_MS_mean(iii,:) = mean(Mortgages_nonCAP_MS.(AlphaBeta{iii}));
    DATA.DI_CAP_MS_mean(iii,:) = mean(DI_CAP_MS.(AlphaBeta{iii}));
    DATA.DI_nonCAP_MS_mean(iii,:) = mean(DI_nonCAP_MS.(AlphaBeta{iii}));
    DATA.HU_CAP_MS_mean(iii,:) = mean(HU_CAP_MS.(AlphaBeta{iii}));
    DATA.HU_nonCAP_MS_mean(iii,:) = mean(HU_nonCAP_MS.(AlphaBeta{iii}));
    DATA.BankMortgageBlocked_MS_mean(iii,:) = mean(BankMortgageBlocked_MS.(AlphaBeta{iii}));
    DATA.HHMortgageRejected_MS_mean(iii,:) = mean(HHMortgageRejected_MS.(AlphaBeta{iii}));
    DATA.LIQ_CAP_MS_mean(iii,:) = mean(LIQ_CAP_MS.(AlphaBeta{iii}));
    DATA.LIQ_nonCAP_MS_mean(iii,:) = mean(LIQ_nonCAP_MS.(AlphaBeta{iii}));
    DATA.GINI_netto_MS_mean(iii,:) = mean(GINI_netto.(AlphaBeta{iii}));
    DATA.GINI_gross_MS_mean(iii,:) = mean(GINI_gross.(AlphaBeta{iii}));
    DATA.GINI_DI_MS_mean(iii,:) = mean(GINI_DI.(AlphaBeta{iii}));
    DATA.Total_num_capitalists(iii,:) = Total_num_capitalists;
    DATA.Total_num_noncapitalists(iii,:) = Total_num_noncapitalists;
    DATA.Debt_Firms_MS_mean(iii,:) = mean(Debt_Firms_MS.(AlphaBeta{iii}));
    DATA.Debt_CstrFirms_MS_mean(iii,:) = mean(Debt_CstrFirms_MS.(AlphaBeta{iii}));
    DATA.Liq_Firms_MS_mean(iii,:) = mean(Liq_Firms_MS.(AlphaBeta{iii}));
    DATA.Liq_CstrFirms_MS_mean(iii,:) = mean(Liq_CstrFirms_MS.(AlphaBeta{iii}));
end

save('DATA_MS.mat','-struct','DATA');
