clc
close all
clear all

counter = 0;

%Define RunNumbers
RunNumbers = [832313,832316,832319];
%for saving figures - Define path to figure folder
FigPat = strcat('C:\Users\Iceace\Dropbox\Phd\Inequality\',num2str(RunNumbers(1)),'-',num2str(RunNumbers(end)));
current_folder = cd;
mkdir(FigPat);

for RunNumber = RunNumbers
    %set counter
    counter = counter + 1;
    
    %Load data
    if isunix
        Pat = '../../runs/';
    else
        Pat = '..\..\runs\';
    end
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
    Inflation_MS(counter,:) = InflationIndex;
    
    %Real GDP
    GDP = Production(1:TimeConstants.NrDaysInMonth:end).*PriceIndex(1:TimeConstants.NrDaysInMonth:end)...
        + (CstrProduction(1:TimeConstants.NrDaysInMonth:end)/12).*HousingPrices(1:TimeConstants.NrDaysInMonth:end);
    RealGDP = (100*GDP)./InflationIndex';
    RealGDP_MS(counter,:) = RealGDP;
    
    %Unemployment
    Unemployment_MS(counter,:) = UnemployedWorkers./NrAgents.Households;
    
    
    
    
    
end


% for i = 1:length(RunNumbers) 
%     
%     colori = {'k';'b';'g';'r';'y';'m'};
%     coloridased = {'--k';'--b';'--g';'--r';'--y';'--m'};
%     coloridotted = {':k';':b';':g';':r';':y';':m'};
%     if isunix
%         Pat = '../../runs/';
%     else
%         Pat = '..\..\runs\';
%     end
%     
%     
%     font_sz = 12;
%     line_wdt = 1.5;
%     counter = counter + 1;
%         colore = colori{counter};
%     coloredased = coloridased{counter};
%     coloredotted = coloridotted{counter};
%     colore2 = colori{counter};    
%     %SimulationFinalDay = d;
%     %SimulationStartingDay = 12;
%     %SimulationDurationInQuarters = 120;
%     %SimulationFinalDay = 120*3*4+SimulationStartingDay;
%     XVector_quarter = (1:(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInQuarter;
%     XVector_year = (1:(SimulationFinalDay-SimulationStartingDay))/(TimeConstants.NrDaysInYear);
%     XVector_month = (1:(SimulationFinalDay-SimulationStartingDay)/TimeConstants.NrDaysInMonth);
%     Num_years = (SimulationFinalDay-SimulationStartingDay)./TimeConstants.NrDaysInYear;
%     Num_quarters = (SimulationFinalDay-SimulationStartingDay)./TimeConstants.NrDaysInQuarter;
%     Num_weeks_in_year = TimeConstants.NrMonthsInYear*TimeConstants.NrWeeksInMonth;
%     quarters_visualization_step = 1;
%     visualization_vector = (0:(quarters_visualization_step*TimeConstants.NrDaysInQuarter):(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInQuarter;
%     visualization_vector_quarter = (0:(quarters_visualization_step*TimeConstants.NrDaysInQuarter):(SimulationFinalDay-SimulationStartingDay))/TimeConstants.NrDaysInYear;
% end