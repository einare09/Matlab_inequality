%clc
clear all
close all

Simulation.DurationInQuarters = 100;

BudgetConstraints_grid = [0.25,0.30,0.40];
RandomSeeds_grid = [832250]; %default seed 832040
CapitalistProb_grid = [0.1,0.2,0.3];
UseIndexedMortgages_grid = [0];
CapitalistConsumptionBudget = 0.25; %one value only
SimulationRunPar.GovPolicyRatio = 0.55; %one value only
PowerLawAlpha = Inf; %one value only - Inf is equal to uniform dist
SimulationRunPar.RunNumber = 832490;

warning off

for i = 1:numel(RandomSeeds_grid)
    SimulationRunPar.RandomSeed = RandomSeeds_grid(i);
    for j = 1:numel(BudgetConstraints_grid)
        SimulationRunPar.BudgetConstraint = BudgetConstraints_grid(j);
        for k = 1:numel(CapitalistProb_grid)
            SimulationRunPar.CapitalistProb = CapitalistProb_grid(k);
            for g = 1:numel(UseIndexedMortgages_grid)
                SimulationRunPar.UseIndexedMortgages = UseIndexedMortgages_grid(g);
                SimulationRunPar.RunNumber = SimulationRunPar.RunNumber + 1;
            
                fprintf('\r run: %d RandomSeed: %d BudgetConstraint: %f CapitalistProb: %f',...
                    SimulationRunPar.RunNumber,SimulationRunPar.RandomSeed,...
                    SimulationRunPar.BudgetConstraint,SimulationRunPar.CapitalistProb)
                            
                ICEACE_initialization_multiple
                ICEACE_simulation_multiple
            
                clear Households Banks CsrtFirms Government CentralBank Firms Fund
                clear REmarket TimeConstants PriceIndices NrAgents
                
                
                
            end
        end
    end
end
%% Define SimulationRunPar.RunNumbers
SimulationRunPar.NrRuns = length(BudgetConstraints_grid)*length(RandomSeeds_grid)*...
    length(CapitalistProb_grid)*length(UseIndexedMortgages_grid);
SimulationRunPar.RunNumbers = [1+SimulationRunPar.RunNumber-SimulationRunPar.NrRuns:SimulationRunPar.RunNumber];
%% data gathering
ICEACE_data_gathering_multiple
%% Define SimulationRunPar.RunNumbers again
SimulationRunPar.NrRuns = length(BudgetConstraints_grid)*length(RandomSeeds_grid)*...
    length(CapitalistProb_grid)*length(UseIndexedMortgages_grid);
SimulationRunPar.RunNumbers = [1+SimulationRunPar.RunNumber-SimulationRunPar.NrRuns:SimulationRunPar.RunNumber];
%% delete files
ICEACE_files_deleting_multiple 
%% Clear all data                
clear all