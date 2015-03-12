%clc
clear all
close all

Simulation.DurationInQuarters = 100;

BudgetConstraints_grid = [0.25];
RandomSeeds_grid = [832090]; %default seed 832040
CapitalistProb_grid = [0.05,0.1,0.12,0.14,0.15];
UseIndexedMortgages_grid = [0];
CapitalistConsumptionBudget = 0.25; %one value only

SimulationRunPar.RunNumber = 832190;

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